using HnganhCinema.Data;
using HnganhCinema.Helper;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace HnganhCinema.Areas.Identity.Controllers
{
    [Area("Identity")]
    public class HomeController : Controller
    {

        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;

        public HomeController(CinemaDbContext context, AuthenticateHelper auth, UserManager<AppUser> user, RoleManager<IdentityRole> role)
        {
            _context = context;
            _auth = auth;
            _userManager = user;
            _roleManager = role;
        }

        [Route("/Manage/")]
        [Authorize(Roles = "Administrator, Editor")]
        public IActionResult Index()
        {
            return View();
        }
    }
}
