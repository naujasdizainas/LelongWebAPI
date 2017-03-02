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
                new SqlParameter { ParameterName = "@UserId", Value = (object)goodsItem.UserId ?? DBNull.Value, DbType = DbType.Int32 },
                new SqlParameter { ParameterName = "@Title", Value = (object)goodsItem.Title??DBNull.Value, DbType = DbType.String },
                new SqlParameter { ParameterName = "@SubTitle", Value = (object)goodsItem.Subtitle??DBNull.Value, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Condition", Value = (object)goodsItem.Condition??DBNull.Value, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Guid", Value = (object)goodsItem.Guid??DBNull.Value, DbType = DbType.String },
                new SqlParameter { ParameterName = "@Price", Value = (object)goodsItem.Price??DBNull.Value, DbType = DbType.Decimal },
                new SqlParameter { ParameterName = "@SalePrice", Value = (object)goodsItem.SalePrice??DBNull.Value, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@Msrp", Value = (object)goodsItem.Msrp??DBNull.Value, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@CostPrice", Value = (object)goodsItem.CostPrice??DBNull.Value, DbType = DbType.Double },
                new SqlParameter { ParameterName = "@SaleType", Value = (object)goodsItem.SaleType??DBNull.Value, DbType = DbType.String },

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
                new SqlParameter { ParameterName = "@OptionsStatus", Value = goodsItem.OptionsStatus, DbType = DbType.Int32 },
            };
            
            var result = SqlHelper.ExecuteScalarWithInputDataTable(new SqlConnection(Config.ConnectionString), CommandType.StoredProcedure, "GoodsPublish_Insert", SetGoodsPhotoTable(goodsItem.listPhoto), param);
            return int.Parse(result.ToString());
        }

        public static void DeleteGoods(string guid)
        {
            var param = new[]
            {
                new SqlParameter { ParameterName = "@Guid", Value = guid, DbType = DbType.String },
            };

            SqlHelper.ExecuteNonQuery(new SqlConnection(Config.ConnectionString), CommandType.StoredProcedure, "[GoodPublish_Delete]", param);
        }

        public static IList<Goods> GetListGoods(List<string> guids)
        {
            string listGuiId = guids[0].ToString();
            var param = new[]
            {
                new SqlParameter { ParameterName = "@ListGuid", Value = listGuiId, DbType = DbType.String },
            };
            DataSet dts = SqlHelper.ExecuteDataset(Config.ConnectionString, CommandType.StoredProcedure, "GoodsPublish_SelectByListGuid",param);

            var results = new List<Goods>();
            var tablePhoto = dts.Tables[1];

            if (dts != null && dts.Tables[0] != null && dts.Tables[0].Rows.Count > 0)
            {
                results.AddRange(from DataRow dr in dts.Tables[0].Rows select ParseGoodsDataRow(dr, tablePhoto));
            }

            return results;
        }
        public static Goods ParseGoodsDataRow(DataRow dr,DataTable tablePhoto)
        {
            var goodsItem = new Goods();
            goodsItem.GoodPublishId = Convert.ToInt32(dr["GoodPublishId"]);
            goodsItem.UserId = Convert.ToInt32(dr["UserId"]);
            goodsItem.Title = dr["Title"].ToString();
            goodsItem.Subtitle = dr["Subtitle"].ToString();
            goodsItem.Condition = dr["Condition"].ToString();
            goodsItem.Guid = dr["Guid"].ToString();
            goodsItem.Price = float.Parse(dr["Price"].ToString());
            goodsItem.SalePrice = float.Parse(dr["SalePrice"].ToString());
            goodsItem.Msrp = float.Parse(dr["Msrp"].ToString());
            goodsItem.CostPrice = float.Parse(dr["CostPrice"].ToString());
            goodsItem.SaleType = dr["SaleType"].ToString();

            var listPhoto = new List<GoodsPhoto>();
            listPhoto.AddRange (from DataRow drItem in tablePhoto.Rows
                            where drItem["GoodPublishId"].ToString().Contains(goodsItem.GoodPublishId.ToString())
                            select ParseGoodsPhotoDatarow(drItem));
            goodsItem.listPhoto = listPhoto;

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

        public static GoodsPhoto ParseGoodsPhotoDatarow(DataRow dr)
        {
            var goodsPhotoItem = new GoodsPhoto();
            goodsPhotoItem.PhotoId = Convert.ToInt32(dr["PhotoId"]);
            goodsPhotoItem.GoodPublishId = Convert.ToInt32(dr["GoodPublishId"]);
            goodsPhotoItem.PhotoName = dr["PhotoName"].ToString();
            goodsPhotoItem.PhotoUrl = dr["PhotoUrl"].ToString();
            goodsPhotoItem.PhotoDescription = dr["PhotoDescription"].ToString();
            return goodsPhotoItem;
        }

        public static DataTable SetGoodsPhotoTable(List<GoodsPhoto> listGoodsPhoto)
        {
            DataTable table = new DataTable();
            //table.Columns.Add("PhotoId", typeof(int));
            //table.Columns.Add("GoodPublishId", typeof(int));
            table.Columns.Add("PhotoName", typeof(string));
            table.Columns.Add("PhotoUrl", typeof(string));
            table.Columns.Add("PhotoDescription", typeof(string));
            foreach (GoodsPhoto photo in listGoodsPhoto)
            {
                DataRow newRow = table.NewRow();
                newRow["PhotoName"] = photo.PhotoName;
                newRow["PhotoUrl"] = photo.PhotoUrl;
                newRow["PhotoDescription"] = photo.PhotoDescription;

                table.Rows.Add(newRow);
            }
            return table;
        }
    }
}
