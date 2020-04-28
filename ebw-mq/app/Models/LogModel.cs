
using System;
using System.Text.Json;

namespace ebw_mq.Models
{
    public class LogModel {
        public long Id { get; set; }
        public DateTime TimeStamp { get; set; } = DateTime.UtcNow;
        public string Level { get; set; }
        public string Machine { get; set; }
        public string Step { get; set; }
        public string FileProcessed { get; set; }
        public string Source { get; set; }
        public int? LineNumber { get; set; }
        public string Message { get; set; }
        public JsonDocument? Data { get; set; }
    }

}