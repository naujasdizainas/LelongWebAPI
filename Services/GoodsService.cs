using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lelong.Models;
using System.Data.SqlClient;
using System.Data;

namespace Lelong.Services
{
    public class GoodsService
    {
        public static int PublishGoods(Goods goodsItem)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@UserId", Value =  goodsItem.UserId, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@Title", Value = goodsItem.Title, DbType = DbType.String },
                new SqlParameter { ParameterName = "@SubTitle", Value = goodsItem.Subtitle, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Condition", Value = goodsItem.Condition, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Guid", Value = goodsItem.Guid, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Price", Value = goodsItem.Price, DbType = DbType.Decimal },
                new SqlParameter { ParameterName = "@SalePrice", Value = goodsItem.SalePrice, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@Msrp", Value = goodsItem.Msrp, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@CostPrice", Value = goodsItem.CostPrice, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@SaleType", Value = goodsItem.SaleType, DbType = DbType.String },

                new SqlParameter { ParameterName = "@Category", Value = goodsItem.Category, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@StoreCategory", Value = goodsItem.StoreCategory, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@Brand", Value = goodsItem.Brand, DbType = DbType.String },
                new SqlParameter { ParameterName = "@ShipWithin", Value = goodsItem.ShipWithin, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@ModelSkuCode", Value = goodsItem.ModelSkuCode, DbType = DbType.String },
                new SqlParameter { ParameterName = "@State", Value = goodsItem.State, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Link", Value = goodsItem.Link, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Description", Value = goodsItem.Description, DbType = DbType.String },

                new SqlParameter { ParameterName = "@Video", Value = goodsItem.Video, DbType = DbType.String },
                new SqlParameter { ParameterName = "@VideoAlign", Value = goodsItem.VideoAlign, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Active", Value = goodsItem.Active, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@Weight", Value = goodsItem.Weight, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@Quantity", Value = goodsItem.Quantity, DbType = DbType.Int32 },

                new SqlParameter { ParameterName = "@ShippingPrice", Value = goodsItem.ShippingPrice, DbType = DbType.String },
                new SqlParameter { ParameterName = "@WhoPay", Value = goodsItem.WhoPay, DbType = DbType.String },
                new SqlParameter { ParameterName = "@ShippingMethod", Value = goodsItem.ShippingMethod, DbType = DbType.String },
                new SqlParameter { ParameterName = "@ShipToLocation", Value = goodsItem.ShipToLocation, DbType = DbType.String },
                new SqlParameter { ParameterName = "@PaymentMethod", Value = goodsItem.PaymentMethod, DbType = DbType.String },
                new SqlParameter { ParameterName = "@GstType", Value = goodsItem.GstType, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@OptionsStatus", Value = goodsItem.OptionsStatus, DbType = DbType.Int32 }
            };
            
            var result = SqlHelper.ExecuteScalarWithInputDataTable(new SqlConnection(Config.ConnectionString), CommandType.StoredProcedure, "[GoodsPublish_Insert]", SetGoodsPhotoTable(goodsItem.listPhoto), param);
            return int.Parse(result.ToString());
        }

        public static IEnumerable<Goods> GetSynedGoods()
        {
            
            DataSet dts = SqlHelper.ExecuteDataset(Config.ConnectionString, CommandType.StoredProcedure, "GetSynedGoods");

            var results = new List<Goods>();
            if (dts != null && dts.Tables[0] != null && dts.Tables[0].Rows.Count > 0)
            {
                results.AddRange(from DataRow dr in dts.Tables[0].Rows select ParseGoodsDataRow(dr));
            }

            return results;
        }
        public static Goods ParseGoodsDataRow(DataRow dr)
        {
            var goodsItem = new Goods();
            goodsItem.GoodPublishId = Convert.ToInt32(dr["GoodPublishId"]);
            
            return goodsItem;
        }

        private List<GoodsPhoto> GetListGoodsPhoto(string listGoodsId)
        {
            var param = new[]
            {
                new SqlParameter {ParameterName = "@listGoodsId",Value = listGoodsId,DbType = DbType.String}
            };
            DataSet dts = SqlHelper.ExecuteDataset(Config.ConnectionString, CommandType.StoredProcedure, "GetListGoodsPhoto", param);

            var results = new List<GoodsPhoto>();
            if (dts != null && dts.Tables[0] != null && dts.Tables[0].Rows.Count > 0)
            {
                results.AddRange(from DataRow dr in dts.Tables[0].Rows select ParseGoodsPhotoDatarow(dr));
            }

            return results;
        }

        private GoodsPhoto ParseGoodsPhotoDatarow(DataRow dr)
        {
            var goodsItem = new GoodsPhoto();
            goodsItem.GoodPublishId = Convert.ToInt32(dr["GoodPublishId"]);
            return goodsItem;
          
        }

        public static DataTable SetGoodsPhotoTable(List<GoodsPhoto> listGoodsPhoto)
        {
            DataTable table = new DataTable();
            table.Columns.Add("PhotoId", typeof(int));
            table.Columns.Add("GoodPublishId", typeof(int));
            table.Columns.Add("PhotoName", typeof(string));
            table.Columns.Add("PhotoUrl", typeof(string));
            table.Columns.Add("PhotoDescription", typeof(string));
            foreach (GoodsPhoto photo in listGoodsPhoto)
            {
                table.Rows.Add(photo);
            }
            return table;
        }
    }
}
