using System.Net.Http;
using System.Threading.Tasks;
using Lmbtfy.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace Lmbtfy.Web.Controllers;

[Route("[controller]")]
public class HomeController : Controller
{
    private readonly HttpClient _client;

    public HomeController(IHttpClientFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Route("[action]")]
    public ActionResult About()
    {
        return View();
    }

    [Route("[action]")]
    public async Task<ActionResult> GenerateUrl(string q)
    {
        q = q.Replace(' ', '+');
        string path = $"https://{Request.Host.Value}/?q={q}";
        string tinyUrl = await GenerateTinyUrlAsync(path);

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

    protected Task<string> GenerateTinyUrlAsync(string realUrl)
    {
        return _client.GetStringAsync("https://tinyurl.com/api-create.php?url=" + realUrl);
    }
}
