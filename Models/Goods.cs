using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lelong.Models
{
    public class Goods
    {
        // var goodsPublish="GoodPublishId integer primary key,UserId integer,Title text,Subtitle text,Guid text,SalePrice real,msrp real,costprice real,SaleType text,Category integer,StoreCategory integer,Brand text,ShipWithin integer,ModelSkuCode text,State text,";
        public int GoodPublishId { get; set; }
        public List<GoodsPhoto> listPhoto { get; set; }
        public int UserId { get; set; }
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public string Condition { get; set; }

        public string Guid { get; set; }
        public float SalePrice { get; set; }
        public float msrp { get; set; }
        public float costprice { get; set; }
        public string SaleType { get; set; }

    }
}
