#!/usr/bin/env python3
import time
import curses
from curses import wrapper
import sys

# curses
# docs.python.org/3/howto/curses.html
# youtube.com/watch?v=JBE4OwdqzQ8&t=430s

argv = sys.argv[1:]
print(argv)
print(len(argv))
if len(argv) != 2:
    raise SystemExit("usage: minut seconds")
m, s = int(argv[0]), int(argv[1])


def main(stdcr):
    seconds = s + m * 60
    total = seconds
    curses.init_pair(1, curses.COLOR_RED, curses.COLOR_BLACK)
    red = curses.color_pair(1)
    while seconds:
        stdcr.clear()
        if seconds / total * 100 <= 20:
            stdcr.addstr(10, 40, f"{seconds // 60}:{seconds % 60}", red)
        else:
            stdcr.addstr(10, 40, f"{seconds // 60}:{seconds % 60}")
        time.sleep(1)
        seconds -= 1
        stdcr.refresh()


wrapper(main)
