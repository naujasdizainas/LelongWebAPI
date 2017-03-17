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
        public List<String> listCurrentPhotoName { get; set; }
        public PublishGoodsResult()
        {
            listCurrentPhotoName = new List<string>();
            listGuidPublishFailed = new List<string>();
        }
    }
}
