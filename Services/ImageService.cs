﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lelong.Services
{
    public class ImageService
    {
        public static bool UpdateUrl(string urlPath, string imageName)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@Url", Value =  urlPath, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Name", Value =  imageName, DbType = DbType.String }
            };
            var result = SqlHelper.ExecuteNonQuery(Config.ConnectionString, CommandType.StoredProcedure, "GoodsPublishPhoto_Update_Url", param);
            return true;
        }
        public static string GetImageUrl(string imageName)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@Name", Value =  imageName, DbType = DbType.String }
            };
            var result = SqlHelper.ExecuteScalar(Config.ConnectionString, CommandType.StoredProcedure, "GoodsPublishPhoto_Get_Url", param);
            return result.ToString();
        }
    }
}
