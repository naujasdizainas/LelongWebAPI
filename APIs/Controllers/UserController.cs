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
    [RoutePrefix("api/user")]
    public class UserController : ApiController
    {
        [HttpPost]
        // input: object GoodsData --> Return Id of Goods published.
        public int Add(User user)
        {
            var userId = UserService.AddUser(user);
            return userId;
        }
        
    }
}
