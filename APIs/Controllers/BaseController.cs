using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Lelong.Models;
using Lelong.Services;


namespace APIs.Controllers
{
    public class BaseController : ApiController
    {
        public T Execute<T>(Func<LoginSession, T> func)
        {
            if (!Request.Headers.Contains("X-User-Context"))
                throw new Exception("Missing or Invalid Session. Please logout then login again.");
            var loginSession = Request.Headers.GetValues("X-User-Context").FirstOrDefault();
            var user = UserService.GetUserByUName(loginSession);
            if (user != null)
            {
                return func.Invoke(new LoginSession()
                {
                    User = user,
                    LoginTime = new DateTime()
                });
            }
            else
            {
                throw new Exception("Not authenticated.");
            }
        }

        public T Execute<T>(Func<T> func)
        {
            try
            {
                return func.Invoke();
            }
            catch (Exception ex)
            {
                var mesage = ex.InnerException != null
                ? (ex.InnerException.InnerException?.Message ?? ex.InnerException.Message)
                : ex.Message;
                throw new Exception(mesage);
            }
        }
    }
}
