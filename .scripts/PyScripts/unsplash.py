#! /usr/bin/python

import requests
from bs4 import BeautifulSoup
import os
import lxml
import random

def GetStoreLocation():
    home = os.path.expanduser("~")
    targetLocation = os.path.join(home, 'Walls/unsplash/')
    if not os.path.exists(targetLocation): 
        os.makedirs(targetLocation)
    return targetLocation

def GetImagesURLs(url):
    request = requests.get(url,allow_redirects = True)
    data = BeautifulSoup(request.text,'lxml')
    all_image=data.find_all('figure',itemprop="image")
    return all_image

def GetImages(url):
    targetLocation = GetStoreLocation()
    all_image = GetImagesURLs(url)
    count =0
    for i in all_image:
        url=i.find('a',rel="nofollow")
        if url != None:
            i_url = url['href']
            photo_bytes = requests.get(i_url,allow_redirects=True)
            with open(os.path.join(targetLocation, f'{count}3d.jpg'),'wb') as photo:
                photo.write(photo_bytes.content)
                count +=1

if __name__ == "__main__":
    topics = "3D,commics,StarWars,TMNT"
    topic = random.choice(topics.split(",")) 
    # print(topic)
    GetImages(f"https://unsplash.com/s/photos/{topic}")
    
