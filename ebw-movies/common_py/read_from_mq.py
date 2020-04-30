import sys
import requests 
import json

# python read_from_mq.py ${message_queue_name} 

message_queue_name = sys.argv[1]

client_id = os.environ['STEP_NAME']
api_root_url = os.environ['API_URL']
url = api_root_url + 'MessageQueue/Receive'

params = {
    "ClientId": client_id,
    "Queue": message_queue_name,
    "NumberOfMessages": 1
}

#read from the queue
headers={'Content-type':'application/json', 'Accept':'application/json'}
result = requests.get(url = url, json = params, headers=headers)

file_name = 'no'
if(result.status_code == 200):
    message = result.json() 
    if(len(message) > 0):
        file_name = message[0]['body']    

print(file_name)

sys.exit(0)

