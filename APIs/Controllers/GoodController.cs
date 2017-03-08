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
            return Execute(session =>
            {
               return GoodsService.GetAll(session.User.UserId);
            });
        }

        [HttpGet]
        [Route("getlist")]
        public IList<Goods> GetListGoods([FromUri] List<string> guids)
        {
            return Execute (session => GoodsService.GetListGoods(guids, session.User.UserId)) ;
        }

        [HttpGet]
        [Route("selectById")]
        public Goods SelectById(int goodId)
        {
            return Execute(session => GoodsService.SelectById(goodId, session.User.UserId));
        }

        [HttpPost]
        [Route("publish")]
        // input: object GoodsData --> Return Id of Goods published.
        public int PublishGoods(Goods goodsItem)
        {
            return Execute(session =>
            {
                goodsItem.UserId = session.User.UserId;
                var goodsId = GoodsService.PublishGoods(goodsItem);
                return goodsId;
            });
           
        }

        [HttpPost]
        [Route("saveGoods")]
        // input: object GoodsData --> Return Id of Goods published.
        public int SaveGoods(Goods goodsItem)
        {
            return Execute(session =>
            {
                if (goodsItem.Guid == null)
                {
                    goodsItem.Guid = Guid.NewGuid().ToString();
                }
                
                goodsItem.UserId = session.User.UserId;
                var goodsId = GoodsService.PublishGoods(goodsItem);
                return goodsId;
            });

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

        [HttpDelete]
        [Route("deleteGoods")]
        public Boolean DeleteGoodsChild(string guid)
        {
            return Execute(session =>
            {
                return GoodsService.DeleteGoods(guid);
            });
        }
    }
}
