# scrolller.py

# didnt' work
import requests
from bs4 import BeautifulSoup

url = "https://scrolller.com/" # url of the page
page = requests.get(url) # get the content of the page

soup = BeautifulSoup(page.content, 'html.parser') # parse the content
images = soup.find_all('img') # find all the images
print(images)
for img in images: # loop through the images and save them
    image_url = img['src']
    file_name = image_url.split('/')[-1] # get the file name
    r = requests.get(image_url) # download the image
    with open(f"/home/moises/Pictures/Scroller/{file_name}", 'wb') as f: # save the image
        f.write(r.content)



"""
Full screen view
class="fullscreen-view__entry-container"
fullscreen-view__media
gallery view
fullscreen-link
"""