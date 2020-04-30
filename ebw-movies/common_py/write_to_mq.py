import sys
import requests 
import json
import os

# python write_to_mq.py ${message_queue_name} ${file_name}

message_queue_name = sys.argv[1]
file_name = sys.argv[2]

client_id = os.environ['STEP_NAME']
api_root_url = os.environ['API_URL']
url = api_root_url + 'MessageQueue/Send'

print(url)

# defining a message to be sent to the MQ API 
data = {
    'Body': file_name,
    'Metadata': 'Meta',
    'ClientId': client_id,
    'Queue': message_queue_name
}

# sending post request and saving response as response object 
headers={'Content-type':'application/json', 'Accept':'application/json'}
result = requests.post(url = url, json=data, headers=headers) 

is_error = 'True'

if(result.status_code == 200):
    message = result.json() 
    is_error = message['isError']

print(is_error)

sys.exit(0)


