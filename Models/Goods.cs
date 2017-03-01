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
        
        public int UserId { get; set; }
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public string Condition { get; set; }

        public string Guid { get; set; }
        public float Price { get; set; }
        public float SalePrice { get; set; }
        public float Msrp { get; set; }
        public float CostPrice { get; set; }
        public string SaleType { get; set; }

        public int Category { get; set; }
        public int StoreCategory { get; set; }
        public string Brand { get; set; }
        public int ShipWithin { get; set; }
        public string ModelSkuCode { get; set; }
        public string State { get; set; }
        public string Link { get; set; }
        public string Description { get; set; }

        public string Video { get; set; }
        public string VideoAlign { get; set; }
        public int Active { get; set; }
        public int Weight { get; set; }
        public int Quantity { get; set; }

        public string ShippingPrice { get; set; }
        public string WhoPay { get; set; }
        public string ShippingMethod { get; set; }
        public string ShipToLocation { get; set; }
        public string PaymentMethod { get; set; }
        public int GstType { get; set; }
        public int OptionsStatus { get; set; }
        //public DateTime CreatedDate { get; set; }
        //public DateTime LastEdited { get; set; }
        //public DateTime LastSync { get; set; }

        public List<GoodsPhoto> listPhoto { get; set; }
    }
}
