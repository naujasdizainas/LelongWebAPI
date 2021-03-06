﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Lelong.Services
{
    public static class Config
    {
        public static string ConnectionString => ConfigurationManager.ConnectionStrings["LeLongDB"].ToString();
        public static string LelongApiUrl => ConfigurationManager.AppSettings["LelongApiUrl"].ToString();
    }
}
