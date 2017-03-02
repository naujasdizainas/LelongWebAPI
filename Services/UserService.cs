﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lelong.Models;
using System.Data.SqlClient;
using System.Data;

namespace Lelong.Services
{
    public class UserService
    {
        public static int AddUser(User user)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@UserName", Value =  user.UserName, DbType = DbType.String },
                new SqlParameter { ParameterName = "@PassWord", Value = user.Password, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Access_Token", Value = user.AccessToken, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Refresh_Token", Value = user.RefreshToken, DbType = DbType.String },
                new SqlParameter { ParameterName = "@LoginAttempt", Value = user.LoginAttempt, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@MaxPostingAllow", Value = user.MaxPostingAllow, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@PostingAlready", Value = user.PostingAlready, DbType = DbType.Boolean },
                new SqlParameter { ParameterName = "@NumberOfPhotosAllow", Value = user.NumberOfPhotosAllow, DbType = DbType.Int32 }
            };
            
            var result = SqlHelper.ExecuteNonQuery(new SqlConnection(Config.ConnectionString), CommandType.StoredProcedure, "[usp_User_Ins]", param);
            return int.Parse(result.ToString());
        }

        public static User GetUserByUName(string userName)
        {
            return new User();
        }
    }
}
