using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;
using System;
using System.IO;

namespace WebApplication1
{
    public class Startup
    {
        public void Configure(IApplicationBuilder app)
        {
            app.Use(async (context, next) =>
            {
                var currentTime = DateTime.Now.ToString("HH:mm:ss");
                var logMessage = $"[{currentTime}] Request: {context.Request.Path}";

                // Log to file
                await File.AppendAllTextAsync("log.txt", logMessage + Environment.NewLine);

                // Log to standard output
                Console.WriteLine(logMessage);

                await next();
            });

            app.Run(async (context) =>
            {
                var currentTime = DateTime.Now.ToString("HH:mm:ss");
                var message = $"<html><head><style>body{{background-color: #f0f0f0;}}</style></head><body style='display: flex; justify-content: center; align-items: center; height: 100vh;'><div style='text-align: center;'><h1>Hello World!</h1><p style='color: #333;'>Current server time: {currentTime}</p></div></body></html>";
                await context.Response.WriteAsync(message);
            });
        }
    }
}