using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ebw_mq.Models;

namespace ebw_mq.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LogController : ControllerBase
    {
        private readonly ILogger<LogController> _logger;

        public LogController(ILogger<LogController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public bool Log([FromBody]LogModel logModel)
        {
            bool result = null;
            try
            {

                //TODO: save log model to Message queue
            
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
    }
}
