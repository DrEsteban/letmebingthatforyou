using System;
using System.Net.Http;
using System.Text.Json.Nodes;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace Lmbtfy.Web;

public class UnsplashClient : IDisposable
{
    private readonly HttpClient _client;
    private readonly string _accessKey;

    public UnsplashClient(IHttpClientFactory factory, IConfiguration config)
    {
        _client = factory.CreateClient();
        _accessKey = config["UnsplashAccessKey"];
    }

    public async Task<string> GetRandomPhotoAsync(string category)
    {
        var response = await _client.GetAsync($"https://api.unsplash.com/photos/random?query={category}&client_id={_accessKey}&count=1&orientation=landscape");
        var content = JsonNode.Parse(await response.Content.ReadAsStringAsync()).AsArray();
        var obj = content[0].AsObject();
        var url = obj["urls"]["regular"].GetValue<string>();
        return url;
    }

    public void Dispose()
    {
        _client.Dispose();
    }
}
