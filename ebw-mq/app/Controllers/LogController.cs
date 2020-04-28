using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ebw_mq.Models;
using ebw_mq.Data;

namespace ebw_mq.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LogController : ControllerBase
    {
        private readonly  ApplicationDbContext _dbContext;
        private readonly ILogger<LogController> _logger;

        public LogController(ILogger<LogController> logger, ApplicationDbContext dbContext)
        {
            _dbContext = dbContext;
            _logger = logger;
        }


        [HttpGet]
        public LogDataResult LogList(LogDataRequest logDataRequest){

            LogDataResult result = new LogDataResult {
                Page = logDataRequest.Page
            };

            try {
                var items = _dbContext.Logs.OrderByDescending(log => log.TimeStamp)
                                .Skip(logDataRequest.Page * logDataRequest.Size)
                                .Take(logDataRequest.Size)
                                .ToList();

                result.Success = true;
                result.Items = items;
                result.TotalItems = _dbContext.Logs.Count();
                
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception has accrued: {ex.Message}");
            }

            return result;
        }

        [HttpPost]
        public bool Log([FromBody]LogModel logModel)
        {
            bool result = false;
            try
            {
                _dbContext.Logs.Add(logModel);
                result = _dbContext.SaveChanges() > 0;
            
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception has accrued: {ex.Message}");
            }

            return result;
        }
    }
}
