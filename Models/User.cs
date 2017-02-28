using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lelong.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string AccessToken { get; set; }

        public string RefreshToken { get; set; }
        public int LoginAttempt { get; set; }
        public int MaxPostingAllow { get; set; }
        public bool PostingAlready { get; set; }
        public int NumberOfPhotosAllow { get; set; }

    }

    public class LoginSession
    {
        public User User { get; set; }
        public DateTime LoginTime { get; set; }
    }
}
