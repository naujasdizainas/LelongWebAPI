using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lelong.Models
{
    public class PublishGoodsResult
    {
        public string message { get; set; }
        public List<String> listGuidPublishFailed { get; set; }
        public PublishGoodsResult()
        {
            listGuidPublishFailed = new List<string>();
        }
    }
}
