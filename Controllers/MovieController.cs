using HnganhCinema.Helper;
using HnganhCinema.Models;
using HnganhCinema.ViewModels.Movie;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
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
        private static AppUser CurrentUser;

        public MovieController(ILogger<HomeController> logger, CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _logger = logger;
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }

        [HttpGet]
        public IActionResult MovieDetail(int? id)
        {
            var movie = _context.Movies.Find(id);
            if (movie == null)
            {
                return NotFound();
            }
            return View(movie);
        }

        [HttpGet]
        public IActionResult MovieShowtimes([FromQuery] int movieid)
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if(CurrentUser == null)
            {
                return Redirect("/login/");
            }
            var cinemas = _context.Cinemas
                .Include(c => c.Showtimes)
                .Where(c => c.Status == 1)
                .OrderByDescending(c => c.Showtimes.Count(st => st.Status == "Screening" && st.MovieId == movieid));

            ViewData["Cinemas"] = new SelectList(cinemas, "CinemaId", "Name");

            ViewBag.MovieId = movieid;

            var movie = _context.Movies.Find(movieid);

            return View(movie);
        }

        [HttpPost]
        public async Task<IActionResult> GetShowtimeOfMovie([Bind("movieid")] int movieid, [Bind("cinemaid")] int cinemaid)
        {
            var showtimes = _context.Showtimes
                    .Include(s => s.Movie)
                    .Include(s => s.Cinema)
                    .Include(s => s.Room)
                    .Where(s => s.Status == "Screening" && s.MovieId == movieid && s.CinemaId == cinemaid)
                    .OrderBy(s => s.StartTime);

            var date = _context.Showtimes
                .Where(s => s.Status == "Screening" && s.MovieId == movieid && s.CinemaId == cinemaid)
                .OrderBy(s => s.StartTime)
                .Select(s => s.StartTime.ToShortDateString())
                .ToList();

            List<string> dateData = new List<string>();
            foreach (var d in date.Distinct())
            {
                dateData.Add(d);
            }

            if (showtimes.Any() && dateData.Any())
            {
                var data = new List<MovieShowtimeViewModel>();
                foreach (var s in showtimes)
                {
                    data.Add(new MovieShowtimeViewModel
                    {
                        ShowtimeId = s.ShowtimeId,
                        MovieId = s.MovieId,
                        MovieName = s.Movie.MovieName,
                        CinemaId = s.CinemaId,
                        CinemaName = s.Cinema.Name,
                        RoomId = s.RoomId,
                        RoomNo = s.Room.RoomNo,
                        StartDate = s.StartTime.ToShortDateString(),
                        StartTime = s.StartTime.ToString("HH:mm")
                    });
                }
                return Json(new { success = true, showtime = data, date = dateData });
            }

            return Json(new { success = false });
        }


    }
}
