
using Microsoft.EntityFrameworkCore;
using ebw_mq.Models;
using System;

namespace ebw_mq.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
       : base(options)
        {

        }
        public DbSet<LogModel> Logs { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            new LogMap(modelBuilder.Entity<LogModel>());
        }
    }
}