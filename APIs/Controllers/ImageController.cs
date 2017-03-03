using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Lelong.Services;

namespace APIs.Controllers
{
    [System.Web.Http.RoutePrefix("api/image")]
    public class ImageController : BaseController
    {
        [System.Web.Http.HttpPost]
        [System.Web.Http.Route("upload")]
        [System.Web.Http.AllowAnonymous]
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
                                var filePath = HttpContext.Current.Server.MapPath("~/GoodsImage/" + folderName) + "/" + postedFile.FileName;
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

        [System.Web.Http.HttpGet]
        [System.Web.Http.Route("download")]
        public ActionResult DownloadImage(string photoName)
        {
            return Execute(session =>
            {
                var imagePath = ImageService.GetImageUrl(photoName);
                var image = Image.FromFile(imagePath);

                using (var ms = new MemoryStream())
                {
                    if (imagePath.Contains(".jpg"))
                    {
                        image.Save(ms, ImageFormat.Jpeg);
                        return new FileContentResult(ms.ToArray(), "image/jpeg");
                    }
                    else if (imagePath.Contains(".gif"))
                    {
                        image.Save(ms, ImageFormat.Gif);
                        return new FileContentResult(ms.ToArray(), "image/gif");
                    }
                    else if (imagePath.Contains(".png"))
                    {
                        image.Save(ms, ImageFormat.Png);
                        return new FileContentResult(ms.ToArray(), "image/png");
                    }
                    
                    return new FileContentResult(ms.ToArray(), "image/jpeg");
                }
            });
        }
    }
}