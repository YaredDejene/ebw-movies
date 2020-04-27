import sys
import requests 
import json

# python write_to_mq.py ${mq_service_url} ${client_id} ${message_queue_name} ${file_name}

mq_service_url = sys.argv[1]
client_id = sys.argv[2]
message_queue_name = sys.argv[3]
file_name = sys.argv[4]

url = mq_service_url + 'MessageQueue/Send'

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

