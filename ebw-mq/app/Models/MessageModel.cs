
using System;
using KubeMQ.SDK.csharp.Queue;
using KubeMQ.SDK.csharp.Tools;

namespace ebw_mq.Models
{
    public class MessageModel {

        public MessageModel()
        {          
        }

        public MessageModel(Message message)
        {
            this.ClientID = message.ClientID;
            this.Queue = message.Queue;
            this.Body = Converter.FromUTF8(message.Body);
            this.Metadata = message.Metadata;
            this.Timestamp = Converter.FromUnixTime(message.Attributes.Timestamp);
            this.Sequence = message.Attributes.Sequence;
        }

        public string ClientID { get; set; }
        public string Queue { get; set; }
        public string Body { get; set; }
        public string Metadata { get; set; }
        public ulong Sequence { get; set; }
        public DateTime Timestamp { get; set; }

        public Message GetKubeMQMessage() {
            return new Message {
                ClientID = this.ClientID,
                Queue = this.Queue,
                Body = Converter.ToUTF8(this.Body),
                Metadata = this.Metadata
            };
        }
    }

}