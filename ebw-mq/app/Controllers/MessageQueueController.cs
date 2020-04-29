using System;
using System.Collections.Generic;
using ebw_mq.Models;
using Grpc.Core;
using KubeMQ.SDK.csharp.Queue;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Hosting;
using System.Linq;

namespace ebw_mq.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MessageQueueController : ControllerBase
    {
        private readonly ILogger<MessageQueueController> _logger;

        private readonly string KubeMQServerAddress;

        public MessageQueueController(ILogger<MessageQueueController> logger)
        {
            _logger = logger;
            KubeMQServerAddress = Environment.GetEnvironmentVariable("KUBE_MQ_CLUSTER");
        }

        [Route("Receive")]
        [HttpGet]
        public IEnumerable<MessageModel> ReceiveMessages(ReceiveMessageRequest messageRequest)
        {
            IEnumerable<MessageModel> messages = null;

            try
            {
                var queue = CreatreQueue(messageRequest.Queue, messageRequest.ClientID);
                var result = queue.ReceiveQueueMessages(messageRequest.NumberOfMessages);

                if (result.IsError)
                {
                    Console.WriteLine($"[Receiver]Received: message dequeue error, error:{result.Error}");
                }
                else
                {
                    Console.WriteLine($"[Sender]Received: {result.Messages.Count()} messages received.");
                    messages = result.Messages.Select(m => new MessageModel(m)).ToList();
                }

            }
            catch (RpcException rpcex)
            {
                Console.WriteLine($"rpc error: {rpcex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception has accrued: {ex.Message}");
            }

            return messages;
        }

        [Route("Send")]
        [HttpPost]
        public SendMessageResult SendMessage([FromBody]MessageModel messageRequest)
        {
            SendMessageResult result = null;
            try
            {
                var message = messageRequest.GetKubeMQMessage();
                var queue = CreatreQueue(message.Queue, message.ClientID);
                if (queue != null)
                {

                    result = queue.SendQueueMessage(message);
                    if (result.IsError)
                    {
                        Console.WriteLine($"[Sender]Sent:{message.Body} error, error:{result.Error}");
                    }
                    else
                    {
                        Console.WriteLine($"[Sender]Sent:{message.Body}");
                    }

                }

            }
            catch (RpcException rpcex)
            {
                Console.WriteLine($"rpc error: {rpcex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception has accrued: {ex.Message}");
            }

            return result;
        }

        private KubeMQ.SDK.csharp.Queue.Queue CreatreQueue(string queueName, string clientID)
        {
            try
            {
                return new KubeMQ.SDK.csharp.Queue.Queue(queueName, clientID, KubeMQServerAddress);
            }
            catch (System.Exception ex)
            {
                Console.WriteLine($"[Sender]Error while pinging to kubeMQ address:{ex.Message}");

                Console.WriteLine($"[Sender]Error while pinging to kubeMQ address:{KubeMQServerAddress}");
            }
            return null;
        }
    }
}
