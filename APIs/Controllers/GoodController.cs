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
        [Route("getAll")]
        public IList<Goods> GetAllGoods()
        {
            return Execute(session => GoodsService.GetAll());
        }

        [HttpGet]
        [Route("getlist")]
        public IList<Goods> GetListGoods([FromUri] List<string> guids)
        {
            return Execute (session => GoodsService.GetListGoods(guids)) ;
        }

        [HttpPost]
        [Route("publish")]
        // input: object GoodsData --> Return Id of Goods published.
        public int PublishGoods(Goods goodsItem)
        {
            var goodsId = Execute(session => GoodsService.PublishGoods(goodsItem));
            return goodsId;
        }

        [HttpPut]
        [Route("delete")]
        public Boolean DeleteGoods(List<string> guids)
        {
            return Execute(session =>
            {
                foreach (var guid in guids)
                {
                    GoodsService.DeleteGoods(guid);
                }
                
                return true;
            });
        }
    }
}
