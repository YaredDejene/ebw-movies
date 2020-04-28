
using System.Collections.Generic;

namespace ebw_mq.Models
{
    public class LogDataResult{
        public bool Success { get; set; }
        public int Page { get; set; }
        public long TotalItems { get; set; }
        public IEnumerable<LogModel> Items { get; set; }
        
    }

}