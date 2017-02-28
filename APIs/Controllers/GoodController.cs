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
    [RoutePrefix("api/goods")]
    public class GoodController : ApiController
    {
        [HttpPost]
        [Route("public")]
        // input: object GoodsData --> Return Id of Goods published.
        public int PuplishGoods(Goods goodsItem)
        {
            var goodsId = GoodsService.PublishGoods(goodsItem);
            return goodsId;
        }

        [HttpPost]
        [Route("uploadImage")]
        public Boolean UploadImage(string goodsPublishedId,object fileData)
        {
            return true;
        }
    }
}
