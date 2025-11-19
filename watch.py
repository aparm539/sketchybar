#!/usr/bin/env python3

"""
File watcher for sketchybar configuration
Automatically reloads sketchybar when config files are saved
"""

import os
import sys
import time
import subprocess
from pathlib import Path
from datetime import datetime

# Try to use watchdog if available, otherwise fall back to polling
HAS_WATCHDOG = False
FileSystemEventHandler = None
Observer = None

try:
    from watchdog.observers import Observer
    from watchdog.events import FileSystemEventHandler
    HAS_WATCHDOG = True
except ImportError:
    pass

CONFIG_DIR = Path.home() / ".config" / "sketchybar"
RELOAD_CMD = ["sketchybar", "--reload"]
POLL_INTERVAL = 0.5  # seconds

class SketchybarReloader:
    """Handler for file system events"""
    
    def __init__(self):
        self.last_reload = 0
        self.debounce_time = 0.3  # Debounce reloads (seconds)
    
    def on_modified(self, event):
        # Handle both watchdog events and simple file path strings
        if hasattr(event, 'is_directory') and event.is_directory:
            return
        
        filepath = event.src_path if hasattr(event, 'src_path') else str(event)
        
        # Only watch .lua files and sketchybarrc
        if not (filepath.endswith('.lua') or filepath.endswith('sketchybarrc')):
            return
        
        # Debounce: don't reload if we just reloaded recently
        now = time.time()
        if now - self.last_reload < self.debounce_time:
            return
        
        self.last_reload = now
        self.reload_sketchybar()
    
    def reload_sketchybar(self):
        timestamp = datetime.now().strftime('%H:%M:%S')
        print(f"\033[0;32m[{timestamp}] File changed, reloading sketchybar...\033[0m")
        try:
            subprocess.run(RELOAD_CMD, check=True, capture_output=True)
            print(f"\033[0;32m[{timestamp}] Reload successful\033[0m")
        except subprocess.CalledProcessError as e:
            print(f"\033[0;31m[{timestamp}] Reload failed: {e}\033[0m")
        except FileNotFoundError:
            print(f"\033[0;31m[{timestamp}] Error: sketchybar command not found\033[0m")
            sys.exit(1)

def watch_with_watchdog():
    """Use watchdog library for efficient file watching"""
    if not HAS_WATCHDOG:
        watch_with_polling()
        return
    
    # Create event handler class that inherits from FileSystemEventHandler
    class EventHandler(FileSystemEventHandler):
        def __init__(self):
            self.reloader = SketchybarReloader()
        
        def on_modified(self, event):
            self.reloader.on_modified(event)
    
    event_handler = EventHandler()
    observer = Observer()
    observer.schedule(event_handler, str(CONFIG_DIR), recursive=True)
    observer.start()
    
    print(f"\033[0;32mWatching {CONFIG_DIR} for changes...\033[0m")
    print("\033[1;33mPress Ctrl+C to stop\033[0m\n")
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

def watch_with_polling():
    """Fallback: poll for file changes"""
    print(f"\033[1;33mWarning: watchdog not installed, using polling (less efficient)\033[0m")
    print(f"Install watchdog for better performance: pip3 install watchdog")
    print(f"\033[0;32mWatching {CONFIG_DIR} for changes...\033[0m")
    print("\033[1;33mPress Ctrl+C to stop\033[0m\n")
    
    last_mtimes = {}
    
    # Initial scan
    for root, dirs, files in os.walk(CONFIG_DIR):
        for file in files:
            if file.endswith('.lua') or file == 'sketchybarrc':
                filepath = os.path.join(root, file)
                try:
                    last_mtimes[filepath] = os.path.getmtime(filepath)
                except OSError:
                    pass
    
    reloader = SketchybarReloader()
    
    try:
        while True:
            for root, dirs, files in os.walk(CONFIG_DIR):
                for file in files:
                    if file.endswith('.lua') or file == 'sketchybarrc':
                        filepath = os.path.join(root, file)
                        try:
                            current_mtime = os.path.getmtime(filepath)
                            if filepath in last_mtimes:
                                if current_mtime > last_mtimes[filepath]:
                                    reloader.on_modified(type('obj', (object,), {
                                        'is_directory': False,
                                        'src_path': filepath
                                    })())
                            last_mtimes[filepath] = current_mtime
                        except OSError:
                            pass
            time.sleep(POLL_INTERVAL)
    except KeyboardInterrupt:
        print("\n\033[0;32mStopped watching\033[0m")

def main():
    if not CONFIG_DIR.exists():
        print(f"\033[0;31mError: Config directory not found: {CONFIG_DIR}\033[0m")
        sys.exit(1)
    
    if HAS_WATCHDOG:
        watch_with_watchdog()
    else:
        watch_with_polling()

if __name__ == "__main__":
    main()

