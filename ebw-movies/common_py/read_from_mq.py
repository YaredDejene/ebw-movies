import sys
import requests 
import json

# python read_from_mq.py ${mq_service_url} ${client_id} ${message_queue_name} 

mq_service_url = sys.argv[1]
client_id = sys.argv[2]
message_queue_name = sys.argv[3]

url = mq_service_url + 'MessageQueue/Receive'

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

