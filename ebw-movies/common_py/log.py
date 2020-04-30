import sys
import requests 
import json
import socket
import os

# python log.py ${log_level} ${message} ${work_path} ${source} ${line_no}

log_level = sys.argv[1]
message = sys.argv[2]
work_path = sys.argv[3]
source = sys.argv[4]
line_no = sys.argv[5]

step_name = os.environ['STEP_NAME']
api_root_url = os.environ['API_URL']
url = api_root_url + 'Log'

# defining a message to be sent to the Log API 
log = {
    'Level': log_level,
    'Machine': socket.gethostname(),
    'Step': step_name,
    'FileProcessed': work_path,
    'Source': source,
    'LineNumber': line_no,
    'Message': message
}

# sending post request and saving response as response object 
headers={'Content-type':'application/json', 'Accept':'application/json'}
result = requests.post(url = url, json=log, headers=headers) 

if(result.status_code != 200):
    print("Error in logging, step: " + step_name + " work_path: " + work_path)

