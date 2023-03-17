#! /usr/bin/env python3

import os
for i in os.listdir():
    if i.endswith(".jpg") or i.endswith(".png"):
        new = i.replace("wallhaven-", "")
        os.rename(i,new)
