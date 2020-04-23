
namespace ebw_mq.Models
{
    public class ReceiveMessageRequest {
        public string ClientID { get; set; }
        public string Queue { get; set; }
        public int? NumberOfMessages { get; set; }
    }

}