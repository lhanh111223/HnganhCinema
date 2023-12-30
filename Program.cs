using HnganhCinema.Data;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Razor;
using Microsoft.EntityFrameworkCore;
using System;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();
builder.Services.Configure<RazorViewEngineOptions>(options =>
{
    // /View/Controller/Action.cshtml
    // /MyView/Controller/Action.cshtml

    // {0} Ten action
    // {1} Ten controller
    // {2} ten Area

    options.ViewLocationFormats.Add("/MyView/{1}/{0}" + RazorViewEngine.ViewExtension);
    options.AreaViewLocationFormats.Add("");
});

//builder.Services.AddSingleton(typeof(ProductService), typeof(ProductService));
//builder.Services.AddSingleton(typeof(PlanetService), typeof(PlanetService));

builder.Services.AddDbContext<CinemaDbContext>(options =>
{
    string connectString = builder.Configuration.GetConnectionString("DefaultConnection");
    options.UseSqlServer(connectString);
});


// Dang ky Identity
builder.Services.AddIdentity<AppUser, IdentityRole>()
    .AddEntityFrameworkStores<CinemaDbContext>()
    .AddDefaultTokenProviders();

// Truy cap IdentityOptions
builder.Services.Configure<IdentityOptions>(options =>
{
    // Thiết lập về Password
    options.Password.RequireDigit = false; // Không bắt phải có số
    options.Password.RequireLowercase = false; // Không bắt phải có chữ thường
    options.Password.RequireNonAlphanumeric = false; // Không bắt ký tự đặc biệt
    options.Password.RequireUppercase = false; // Không bắt buộc chữ in
    options.Password.RequiredLength = 3; // Số ký tự tối thiểu của password
    options.Password.RequiredUniqueChars = 1; // Số ký tự riêng biệt

    // Cấu hình Lockout - khóa user
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(1); // Khóa 1 phút
    options.Lockout.MaxFailedAccessAttempts = 3; // Thất bại 3 lần thì khóa
    options.Lockout.AllowedForNewUsers = true;

    // Cấu hình về User.
    options.User.AllowedUserNameCharacters = // các ký tự đặt tên user
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+";
    options.User.RequireUniqueEmail = true;  // Email là duy nhất

    // Cấu hình đăng nhập.
    options.SignIn.RequireConfirmedEmail = true;            // Cấu hình xác thực địa chỉ email (email phải tồn tại)
    options.SignIn.RequireConfirmedPhoneNumber = false;     // Xác thực số điện thoại
    options.SignIn.RequireConfirmedAccount = true;
});


builder.Services.ConfigureApplicationCookie(options =>
{
    options.LoginPath = "/login/";
    options.LogoutPath = "/logout/";

    options.AccessDeniedPath = "/Identity/Account/AccessDenied";
});

builder.Services.AddAuthentication()
    .AddGoogle(options =>
    {
        options.ClientId = "54797487806-15ipr13bnutlvd57qbr9rqevv3nr3hvu.apps.googleusercontent.com";
        options.ClientSecret = "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";

        options.CallbackPath = "/login-with-google";
    });


builder.Services.AddOptions();
var mailsetting = builder.Configuration.GetSection("MailSettings");
builder.Services.Configure<MailSettings>(mailsetting);
builder.Services.AddSingleton<IEmailSender, SendMailService>();

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("ViewManageMenu", builder =>
    {
        builder.RequireAuthenticatedUser();
        builder.RequireRole("Administrator");
    });

});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

// URL: /{controller}/{action}/{id?}
// Abc/Xyz = > Controller: ABC, goi method Xyz
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapRazorPages();

//ContentRootPath = app.Environment.ContentRootPath;

app.UseStatusCodePages();

app.UseEndpoints(endpoints =>
{
    endpoints.MapGet("/sayhi", async (context) =>
    {
        await context.Response.WriteAsync($"Hello ASP.Net MVC {DateTime.Now}");
    });
    //endpoints.MapControllers
    //endpoints.MapControllerRoute
    //endpoints.MapDefaultControllersRoute
    //endpoints.MapAreaControllersRoute

    /*
        [AcceptVerb]
        [Route]
        [HttpGet]
        [HttpPost]
        [HttpPut]
        [HttpDelete]
        [HttpHead]
        [HttpPatch]
    */

    //endpoints.MapControllerRoute(
    //    name: "firstroute",
    //    pattern: "{url}/{id?}",
    //    defaults: new
    //    {
    //        controller = "First",
    //        action = "ViewProduct",
    //        id = 3
    //    },
    //    constraints: new
    //    {
    //        url = new StringRouteConstraint("xemsanpham")
    //    }
    //    );

    // Area

    endpoints.MapAreaControllerRoute(
        name: "product",
        pattern: "/{controller}/{action=Index}/{id?}",
        areaName: "ProductManage"
    );

    endpoints.MapRazorPages();
});

app.Run();