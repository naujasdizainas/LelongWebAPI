using System;
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
        public static bool UpdateUrl(string urlPath,string imageName)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@Url", Value =  urlPath, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Name", Value =  imageName, DbType = DbType.String }
            };

            var result = SqlHelper.ExecuteNonQuery(new SqlConnection(Config.ConnectionString), CommandType.StoredProcedure, "[GoodsPublish_Insert]", param);
            return true;
        }
    }
}
