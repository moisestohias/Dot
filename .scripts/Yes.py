#!/bin/env python3
import os
# from time import sleep
from pathlib import Path
from getpass import getpass
import requests
import json
import urllib.request as request

ConfigDir = os.path.expanduser("~/.config")
KEY_FILE = Path(ConfigDir) / "ChatGPT" / "APIKey"
def get_api_key():
    if not KEY_FILE.exists():
        api_key = getpass(prompt="Please enter your API secret key")
        KEY_FILE.parent.mkdir(parents=True, exist_ok=True)
        KEY_FILE.write_text(api_key)
    else:
        api_key = KEY_FILE.read_text()
    return api_key

settings = {
    'api_key': get_api_key(),
    'timeout': 10,
    'model': 'text-davinci-003',
    'temperature': 0.5,
    'max_tokens': 1024
}


def req():
    response = request_response()
    data = request_data()
    timeout = settings['timeout']
    try:
        text = request.urlopen(response, data=data, timeout=timeout).read().decode('utf-8')
        text = str(json.loads(text)['choices'][0]['text'])
        if len(text) == 0: text = '# No Response #'

    except Exception as e: text = '# Error: %s #' % str(e)
    return text

def request_response():
    return request.Request(
        url='https://api.openai.com/v1/completions',
        method='POST',
        headers=request_headers())

def request_headers():
    return {'Authorization': 'Bearer %s' % settings['api_key'], 'Content-Type': 'application/json'}

def request_data():
    return json.dumps({
        'prompt': prompt,
        'model': settings['model'],
        'temperature': settings['temperature'],
        'max_tokens': settings['max_tokens']
    }).encode()


# def run(): contents = request().replace('\\', '\\\\').replace('$', '\\$')

if __name__ == "__main__":
    prompt = "what is the population of Istanbule city?"
    resp = req().replace('\\', '\\\\').replace('$', '\\$')
    print(resp)

