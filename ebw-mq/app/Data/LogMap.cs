
using System;
using ebw_mq.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace ebw_mq.Data
{
    public class LogMap
    {

        public LogMap(EntityTypeBuilder<LogModel> entityBuilder)
        {
            entityBuilder.HasKey(x => x.Id);
            entityBuilder.ToTable("logs", "logging");

            entityBuilder.Property(x => x.Id).HasColumnName("id");
            entityBuilder.Property(x => x.TimeStamp).HasColumnName("log_timestamp");
            entityBuilder.Property(x => x.Level).HasColumnName("level");
            entityBuilder.Property(x => x.Machine).HasColumnName("machine");
            entityBuilder.Property(x => x.Step).HasColumnName("step");
            entityBuilder.Property(x => x.FileProcessed).HasColumnName("file_processed");
            entityBuilder.Property(x => x.Source).HasColumnName("source");
            entityBuilder.Property(x => x.LineNumber).HasColumnName("line_number");
            entityBuilder.Property(x => x.Message).HasColumnName("message");
            entityBuilder.Property(x => x.Data).HasColumnName("data");
        }

    }

}