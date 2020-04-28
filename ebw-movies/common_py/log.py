import sys
import requests 
import json
import socket

# python log.py ${step_name} ${work_path} ${log_level} ${message} ${source} ${line_no}

step_name = sys.argv[1]
work_path = sys.argv[2]
log_level = sys.argv[3]
message = sys.argv[4]
source = sys.argv[5]
line_no = sys.argv[6]

#TODO: Remove hard-coded value
log_service_url = "http://10.100.189.38:8080/"
url = log_service_url + 'Log'

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
result = requests.post(url = url, json=data, headers=headers) 

if(result.status_code != 200):
    print("Error in logging, step: " + step_name + " work_path: " + work_path)

