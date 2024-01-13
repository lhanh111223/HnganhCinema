using HnganhCinema.Helper;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SQLitePCL;

namespace HnganhCinema.Controllers
{
    public class MovieController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;

        public MovieController(ILogger<HomeController> logger, CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _logger = logger;
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult MovieDetail(int? id)
        {
            var movie = _context.Movies.Find(id);
            return View(movie);
        }

    }
}
