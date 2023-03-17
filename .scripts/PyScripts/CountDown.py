#!/usr/bin/env python3
import time
import sys
import os

# curses
# docs.python.org/3/howto/curses.html
# youtube.com/watch?v=JBE4OwdqzQ8&t=430s

argv = sys.argv[1:]
if len(argv) != 2:
    raise SystemExit("usage: minut seconds")
m, s = int(argv[0]), int(argv[1])


def main():
    seconds = s + m * 60
    total = seconds
    while seconds:
        os.system("clear")
        if seconds / total * 100 <= 20:
            print(f"{seconds // 60}:{seconds % 60}")
        else:
            print(f"{seconds // 60}:{seconds % 60}")
        time.sleep(1)
        seconds -= 1
if __name__ == "__main__":
    main()
