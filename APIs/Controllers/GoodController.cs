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
    public class GoodController : BaseController
    {
        [HttpGet]
        [Route("getlist")]
        public IList<Goods> GetListGoods(List<string> guids)
        {
            return null;
        }

        [HttpPost]
        [Route("publish")]
        // input: object GoodsData --> Return Id of Goods published.
        public int PuplishGoods(Goods goodsItem)
        {
            var goodsId = Execute(session => GoodsService.PublishGoods(goodsItem));
            return goodsId;
        }

        [HttpPut]
        [Route("delete")]
        public Boolean DeleteGoods(List<string> guids)
        {
            return true;
        }
    }
}
