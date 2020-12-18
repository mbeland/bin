#!/usr/bin/env python3
import requests


def my_range(start, end, step):
    while start <= end:
        yield start
        start += step


s = int(input("Start at? "))
ip = input("Target IP? ")

for x in my_range(s, 99, 2):
    r = requests.get(f'http://{ip}:8000/api/{x}')
    if r.status_code != 200:
        print(str(x) + " returned " + str(r.status_code))
        break
    elif r.text.split('"')[5] != 'Error. Key not valid!':
        print(str(x) + " = " + r.text)
        break

