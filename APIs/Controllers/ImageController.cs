using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using Lelong.Services;

namespace APIs.Controllers
{
    [RoutePrefix("api/image")]
    public class ImageController : BaseController
    {
        [HttpPost]
        [Route("upload")]
        [AllowAnonymous]
        public async Task<HttpResponseMessage> UploadImage(string guiIdGoods)
        {
            return Execute(session =>
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();
                try
                {
                    var httpRequest = HttpContext.Current.Request;
                    foreach (string file in httpRequest.Files)
                    {
                        HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created);
                        var postedFile = httpRequest.Files[file];
                        if (postedFile != null && postedFile.ContentLength > 0)
                        {
                            int MaxContentLength = 1024 * 1024 * 10; //Size = 10 MB  
                            IList<string> AllowedFileExtensions = new List<string> { ".jpg", ".gif", ".png" };
                            var extension = postedFile.FileName.Substring(postedFile.FileName.LastIndexOf('.')).ToLower();
                            if (!AllowedFileExtensions.Contains(extension))
                            {
                                var message = string.Format("Please Upload image of type .jpg,.gif,.png.");
                                dict.Add("error", message);
                                return Request.CreateResponse(HttpStatusCode.BadRequest, dict);
                            }
                            else if (postedFile.ContentLength > MaxContentLength)
                            {
                                var message = string.Format("Please Upload a file upto 10 mb.");
                                dict.Add("error", message);
                                return Request.CreateResponse(HttpStatusCode.BadRequest, dict);
                            }
                            else
                            {
                                // Create folder to image upload by guid of Goods
                                var folderName = guiIdGoods;
                                string imageFolderPatch = HttpContext.Current.Server.MapPath("~/GoodsImage/" + folderName);
                                if (!System.IO.Directory.Exists(imageFolderPatch))
                                {
                                    Directory.CreateDirectory(imageFolderPatch);
                                }
                                var filePath = HttpContext.Current.Server.MapPath("~/GoodsImage/" + folderName) + "/" + postedFile.FileName + extension;
                                postedFile.SaveAs(filePath);
                                // update photo Url in table goodsImage by fileName
                                ImageService.UpdateUrl(filePath, postedFile.FileName);
                            }
                        }
                        return Request.CreateErrorResponse(HttpStatusCode.Created, "Success"); ;
                    }
                    var res = string.Format("Please Upload a image.");
                    dict.Add("error", res);
                    return Request.CreateResponse(HttpStatusCode.NotFound, dict);
                }
                catch (Exception ex)
                {
                    dict.Add("error", ex.Message);
                    return Request.CreateResponse(HttpStatusCode.NotFound, dict);
                }
            });

        }

        [HttpGet]
        [Route("download")]
        public string DownloadImage(string photoName)
        {
            return Execute(session =>
            {
                var imageUrl = ImageService.GetImageUrl(photoName);
                return imageUrl;
            });
        }
    }
}