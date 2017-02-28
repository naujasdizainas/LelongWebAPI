using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lelong.Models
{
    public class GoodsPhoto
    {
        public int PhotoId { get; set; }
        public int GoodPublishId { get; set; }
        public string PhotoName { get; set; }
        public string PhotoUrl { get; set; }
        public string PhotoDescription { get; set; }

    }
}
