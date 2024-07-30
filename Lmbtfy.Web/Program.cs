using Lmbtfy.Web;
using Lmbtfy.Web.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();
builder.Services.AddHttpClient();
builder.Services.AddSingleton<UnsplashClient>();
builder.Services.AddMemoryCache();
builder.Services.AddTransient<IKeywordService, KeywordService>();
builder.Services.AddAntiforgery();

var app = builder.Build();

if (builder.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseHttpsRedirection();
    app.UseHsts();
}

app.UseStaticFiles();

app.UseRouting();
app.MapDefaultControllerRoute();

app.Run();