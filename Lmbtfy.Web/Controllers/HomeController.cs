using Lmbtfy.Web.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.IO;
using System.Net;

namespace Lmbtfy.Web.Controllers
{
    [Route("[controller]")]
    public class HomeController : Controller
    {
        public HomeController()
        {

        }

        [Route("[action]")]
        public ActionResult About()
        {
            return View();
        }

        [Route("[action]")]
        public ActionResult GenerateUrl(string q)
        {
            string path = $"https://{Request.Host.Value}/?q={q}";
            string tinyUrl = GenerateTinyUrl(path);

            return PartialView("_GenerateUrl", new GeneratedUrlModel { Url = path, TinyUrl = tinyUrl });
        }

        [Route("[action]")]
        [Route("/{**text}")]
        public ActionResult Index(string text, string q)
        {
            if (string.IsNullOrEmpty(q))
            {
                if (!string.IsNullOrEmpty(text))
                {
                    text = text.Replace('+', ' ')
                        .Replace('-', ' ')
                        .Replace('/', ' ')
                        .Replace('_', ' ');
                    return Redirect($"/?q={text}");
                }
                return View();
            }

            ViewBag.Question = q;
            return View("BingThis");
        }

        protected string GenerateTinyUrl(string realUrl)
        {
            // prepare the web page we will be asking for
            var request = (HttpWebRequest)WebRequest.Create("https://tinyurl.com/api-create.php?url=" + realUrl);

            // execute the request
            request.AllowAutoRedirect = false;
            var response = (HttpWebResponse)request.GetResponse();

            using (var sr = new StreamReader(response.GetResponseStream()))
            {
                return sr.ReadToEnd();
            }
        }
    }
}
