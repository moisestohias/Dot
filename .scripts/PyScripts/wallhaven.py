#! /usr/bin/env python3
"""
!Note: It's always good idea to provide some feedback to the user of what the script is doing.
How wallhaven.cc/api works?
    Each topic has an ID, eg; Rick and Morty=21622
    you can either query by topic, or by ID: eg
        + curl https://wallhaven.cc/api/v1/search?q=Rick%And%Morty
        + curl https://wallhaven.cc/api/v1/search?q=id:21622
    Each Image has tags, describing the topic.eg; Rick and morty, rick shanchez, morty smith, cartoon.
"""
import sys
import requests
import os
import random

colors = ('660000', '990000', 'cc0000', 'cc3333', 'ea4c88', '993399', '663399', '333399', '0066cc', '0099cc', '66cccc', '77cc33', '669900', '336600', '666600', '999900', 'cccc33', 'ffff00', 'ffcc33', 'ff9900', 'ff6600', 'cc6633', '996633', '663300', '000000', '999999', 'cccccc', 'ffffff', '424153')

def get_path(query, ratios="16x9", atleast='1920x1080',page=1, color=None):
    print("Getting wallpapers path ...")
    color = random.choice(colors) if color is None else color
    qr = f"q={query}&purity=100&ratios={ratios}&atleast={atleast}&page={page}&color={color}"
    print(f"https://wallhaven.cc/api/v1/search?{qr}")
    jresp = requests.get(f"https://wallhaven.cc/api/v1/search?{qr}").json()
    for i in jresp["data"]:
        yield i['path'], i['file_size']

def handlePath():
    PitcturesPath = f"{os.path.expanduser('~')}/Pictures/Walls"
    if not os.path.exists(PitcturesPath):
        raise OSError(f"No such file or directory {PitcturesPath!r}")
    # global WallVault
    WallVault = f"{PitcturesPath}/wallhaven"
    if not os.path.exists(WallVault): os.mkdir(WallVault)
    return WallVault

def get_image(query, ratios="16x9", atleast='1920x1080',page=1, color=None):
    WallVault = handlePath()
    print("Downloading wallpapers...")
    for p, file_size in get_path(query):
        imageID = p.split("-")[-1]
        if imageID in os.listdir(WallVault): continue
        print(f"Downloading: {imageID} size: {file_size/2**18:.2f}M" )
        with open(f"{WallVault}/{imageID}", "bw") as f:
            f.write(requests.get(p).content)
            # you can use urllib.request.urlopen(URL) instead


if __name__ == "__main__":
    topics = "Rick And Morty", "One Piece", "Dragon Ball", "Bojack Horseman"
    if len(sys.argv) != 2: topic = random.choice(topics).replace(" ", "%")
    else: topic = sys.argv[1]
    get_image(topic)
