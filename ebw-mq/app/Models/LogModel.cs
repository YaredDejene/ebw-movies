
using System;

namespace ebw_mq.Models
{
    public class LogModel {
        public DateTime TimeStamp { get; set; } = DateTime.UtcNow;
        public string Level { get; set; }
        public string Machine { get; set; }
        public string Step { get; set; }
        public string FileProcessed { get; set; }
        public string ErrorIn { get; set; }
        public string LineNumber { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
    }

}