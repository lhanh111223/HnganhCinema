using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using HnganhCinema.Models;
using HnganhCinema.Helper;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly RoleManager<IdentityRole> _roleManager;
    private readonly CinemaDbContext _context;
    private readonly AuthenticateHelper _auth;
    private readonly UserManager<AppUser> _userManager;

    public HomeController(ILogger<HomeController> logger, CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
    {
        _logger = logger;
        _context = context;
        _roleManager = roleManager;
        _auth = auth;
        _userManager = userManager;
    }

    public IActionResult Index()
    {
        var movies = _context.Movies.ToList();
        ViewBag.Movies = movies;

        // Lấy tất cả những Showtime có EndTime bé hơn thời điểm hiện tại và chuyển trạng thái thành Closed
        var ChangedShowtimeStatus = _context.Showtimes.Where(s => s.EndTime <= DateTime.Now).ToList();
        foreach (var s in ChangedShowtimeStatus)
        {
            s.Status = "Closed";
            _context.Showtimes.Update(s);
        }
        _context.SaveChanges();

        return View();
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
