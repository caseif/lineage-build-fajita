#!/usr/bin/env python3

import requests, json, sys

LINEAGE_OTA_BASE_URI = "https://download.lineageos.org/api/v1"

if len(sys.argv) != 3:
    raise ValueError('Device and OS version must be supplied')

device = sys.argv[1]
version = sys.argv[2]

headers = {
    'Cache-control': 'no-cache',
    'Content-type': 'application/json',
    'User-Agent': 'com.cyanogenmod.updater/2.3'
}

url = LINEAGE_OTA_BASE_URI + '/' + device + '/nightly/0'

resp = requests.get(url, headers=headers)

respJson = resp.json()

builds = respJson['response']

latest_build_url = None
latest_build_time = 0

for build in builds:
    build_ver = build['version']
    build_time = build['datetime']
    if build_ver == version and build_time > latest_build_time:
        latest_build_url = build['url']
        latest_build_time = build_time

if latest_build_url == None:
    raise RuntimeError('No suitable build found')

print(latest_build_url)
