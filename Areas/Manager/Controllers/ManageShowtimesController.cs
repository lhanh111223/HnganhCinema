﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CinemaWeb.Models;
using HnganhCinema.Models;
using HnganhCinema.Helper;
using Microsoft.AspNetCore.Identity;
using HnganhCinema.Areas.Manager.Models.ShowtimeViewModels;
using static Org.BouncyCastle.Crypto.Engines.SM2Engine;
using System.Globalization;

namespace HnganhCinema.Areas.Manager.Controllers
{
    [Area("Manager")]
    [Route("/Manager/ManageShowtimes/[action]/{id?}")]
    public class ManageShowtimesController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;

        private static string inputFormat = "MM-dd-yyyy HH:mm";

        public ManageShowtimesController(CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }

        // GET: Manager/ManageShowtimes
        public async Task<IActionResult> Index()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Rooms", "View"))
            {
                return View("AccessDenied");
            }

            return View();
        }
        public async Task<IActionResult> GetShowtimeData()
        {

            var result = _context.Showtimes
                        .Include(s => s.Cinema)
                        .Include(s => s.Room)
                        .Include(s => s.Movie)
                        .OrderByDescending(s => s.ShowtimeId)
                        .ToList();

            List<IndexShowtimeViewModel> list = new List<IndexShowtimeViewModel>();
            foreach (var i in result)
            {
                var index = new IndexShowtimeViewModel();
                index.Id = i.ShowtimeId;
                index.Cinema = i.Cinema.Name;
                index.Room = i.Room.RoomNo;
                index.Movie = i.Movie.MovieName;
                index.StartTime = i.StartTime.ToString("MM-dd-yyyy HH:mm");
                index.EndTime = i.EndTime;
                index.Status = i.Status;
                index.CinemaId = i.CinemaId;
                list.Add(index);
            }
            return Json(new { showtimes = list });
        }

        // GET: Manager/ManageShowtimes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Showtimes == null)
            {
                return NotFound();
            }

            var showtime = await _context.Showtimes
                .Include(s => s.Cinema)
                .Include(s => s.Movie)
                .Include(s => s.Room)
                .FirstOrDefaultAsync(m => m.ShowtimeId == id);
            if (showtime == null)
            {
                return NotFound();
            }

            return View(showtime);
        }

        // GET: Manager/ManageShowtimes/SelectMovie
        public IActionResult SelectMovie()
        {
            DateTime currentDay = DateTime.Parse(DateTime.Now.ToShortDateString());

            var movies = _context.Movies.Where(m => m.EndDate >= currentDay).ToList();
            return View("ListMovies", movies);
        }

        // GET: Manager/ManageShowtimes/Create GET
        public IActionResult Create([FromQuery] int MovieId, [FromQuery] string Type, [FromQuery] int cinema, [FromQuery] int room)
        {
            var selectedMovie = _context.Movies.Find(MovieId);
            var time = selectedMovie.Time;
            ViewData["MovieId"] = new SelectList(_context.Movies, "MovieId", "MovieName", MovieId);

            if (cinema != 0 && room != 0)
            {
                ViewBag.cinema = cinema;
                ViewBag.room = room;
                ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name", cinema);
                ViewData["RoomId"] = new SelectList(_context.Rooms, "RoomId", "RoomNo", room);
            }
            else
            {
                ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name");
                ViewData["RoomId"] = new SelectList(_context.Rooms, "RoomId", "RoomNo");
            }

            ViewBag.Type = Type;
            ViewBag.Movie = MovieId;
            return View();
        }

        // suggest start time
        [HttpPost]
        public async Task<IActionResult> GetSuggestStartTime([Bind("movieId")] int MovieId, [Bind("roomId")] int RoomId)
        {
            var time = _context.Movies.Find(MovieId).Time;
            var surplus = time % 10;
            if (surplus <= 5)
            {
                time += (5 - surplus);
            }
            else
            {
                time += (10 - surplus);
            }
            var ShowtimesInDay = _context.Showtimes
                                .Where(s => s.StartTime.Date == DateTime.Now.Date && s.RoomId == RoomId)
                                .OrderBy(s => s.StartTime)
                                .ToList();
            // Đặt thời điểm bắt đầu và kết thúc của mỗi khoảng thời gian
            DateTime startTime = DateTime.Now;
            DateTime endTime = DateTime.Now.AddHours(24 - DateTime.Now.Hour); // 00:00 PM

            if (ShowtimesInDay.Any())
            {
                bool flag = true;
                for (DateTime currentTime = startTime; currentTime < endTime; currentTime = currentTime.AddMinutes(5))
                {
                    flag = true;
                    DateTime newStart = currentTime;
                    DateTime newEnd = newStart.AddMinutes(time);
                    foreach (var s in ShowtimesInDay)
                    {
                        if (CheckTime(s.StartTime, s.EndTime, newStart, newEnd) == false)
                        {
                            flag = false;
                            break;
                        }
                        else
                        {
                            continue;
                        }
                    }

                    if (flag)
                    {
                        return Json(new { success = true, suggestTime = newStart });
                    }
                    else
                    {
                        continue;
                    }
                }
                
            }
            else
            {
                return Json(new { success = true, suggestTime = startTime.AddMinutes(5) });
            }
            return Ok();
        }

        // getShowtimeOfRoom();
        [HttpGet]
        public async Task<IActionResult> GetShowtimeOfRoom([Bind("roomid")] int RoomId)
        {
            // lấy distinct tất cả các ngày có trong showtime kể từ ngày hôm nay
            var AllDays = _context.Showtimes
                .Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear && s.RoomId == RoomId)
                .OrderBy(s => s.StartTime)
                .Select(s => s.StartTime.ToString("MM-dd-yyyy"))
                .ToList();

            var start = _context.Showtimes
                .Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear && s.RoomId == RoomId)
                .OrderBy(s => s.StartTime)
                .Select(s => s.StartTime.ToString("MM-dd-yyyy HH:mm"))
                .ToList();

            var end = _context.Showtimes
                .Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear && s.RoomId == RoomId)
                .OrderBy(s => s.StartTime)
                .Select(s => s.EndTime.ToString("MM-dd-yyyy HH:mm"))
                .ToList();

            var movie = _context.Showtimes.Include(s => s.Movie)
                .Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear && s.RoomId == RoomId)
                .OrderBy(s => s.StartTime)
                .Select(s => s.Movie.MovieName)
                .ToList();

            if (AllDays.Any() && start.Any() && end.Any())
            {
                List<string> Days = new List<string>();
                foreach (var s in AllDays.Distinct())
                {
                    Days.Add(s);
                }
                List<string> Starts = new List<string>();
                foreach (var d in start)
                {
                    Starts.Add(d);
                }
                List<string> Ends = new List<string>();
                foreach (var d in end)
                {
                    Ends.Add(d);
                }

                return Json(new { success = true, start = Starts, end = Ends, day = Days, movie = movie });
            }

            return Json(new { success = false });
        }

        // On Create
        // Get Showtime - timeline
        [HttpPost]
        public async Task<IActionResult> GetShowtimesData([Bind("CinemaId")] int CinemaId, [Bind("MovieId")] int MovieId, [Bind("RoomId")] int RoomId)
        {
            List<DateTime> listStartTime = _context.Showtimes.Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear
            && s.CinemaId == CinemaId && s.RoomId == RoomId)
                .OrderBy(s => s.ShowtimeId)
                .Select(s => s.StartTime)
                .ToList();
            List<DateTime> listEndTime = _context.Showtimes.Where(s => s.StartTime.DayOfYear >= DateTime.Now.DayOfYear
            && s.CinemaId == CinemaId && s.RoomId == RoomId)
                .OrderBy(s => s.ShowtimeId)
                .Select(s => s.EndTime)
                .ToList();

            if (listStartTime.Count > 0 && listEndTime.Count > 0)
            {
                List<string> starttime = new List<string>();
                foreach (var d in listStartTime)
                {
                    Console.WriteLine(d.ToString("yyyy/MM/dd HH:mm"));
                    starttime.Add(d.ToString("yyyy/MM/dd HH:mm"));
                }

                List<string> endtime = new List<string>();
                foreach (var d in listEndTime)
                {
                    Console.WriteLine(d.ToString("yyyy/MM/dd HH:mm"));
                    endtime.Add(d.ToString("yyyy/MM/dd HH:mm"));
                }

                List<string> movieName = new List<string>();
                List<int> showtimeId = new List<int>();
                foreach (var d in _context.Showtimes.Where(s => s.RoomId == RoomId && s.StartTime.DayOfYear >= DateTime.Now.DayOfYear)
                    .OrderBy(s => s.ShowtimeId)
                    .Include(s => s.Movie)
                    .ToList())
                {
                    movieName.Add(d.Movie.MovieName);
                    showtimeId.Add(d.ShowtimeId);
                }

                return Json(new { success = true, listStartTime = starttime, listEndTime = endtime, listName = movieName, listId = showtimeId });
            }
            return Json(new { success = false });
        }


        // Get Select Cinema Ajax
        [HttpGet]
        [Route("/Manager/ManageShowtimes/GetSelectCinemaData")]
        public IActionResult GetSelectCinemaData([Bind("cinema")] int cinema)
        {
            var cinemas = _context.Cinemas.Where(c => c.Status == 1)
                .OrderBy(c => c.CinemaId == cinema ? 0 : 1)
                .ToList();
            return Json(new { data = cinemas });
        }

        // Get Room data Ajax
        [HttpPost]
        [Route("/Manager/ManageShowtimes/GetRoomData")]
        public IActionResult GetRoomData([Bind("cinemaId")] int cinemaId, [Bind("type")] string type, [Bind("room")] int room)
        {
            var rooms = _context.Rooms.Where(r => r.CinemaId == cinemaId && r.Type == type)
                .OrderBy(c => c.RoomId == room ? 0 : 1)
                .ToList();
            return Json(new { data = rooms });
        }

        // POST: Manager/ManageShowtimes/Create Post
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ShowtimeId,MovieId,RoomId,CinemaId,StartTime,EndTime")] CreateShowtimeViewModel model)
        {
            var SelectedMovie = _context.Movies.Find(model.MovieId);
            if (ModelState.IsValid)
            {
                var Showtime = new Showtime();
                Showtime.MovieId = model.MovieId;
                Showtime.RoomId = model.RoomId;
                Showtime.CinemaId = model.CinemaId;
                Showtime.StartTime = model.StartTime;
                Showtime.Status = "Screening";

                var time = SelectedMovie.Time + 15;

                var surplus = time % 10;
                if (surplus <= 5)
                {
                    time += (5 - surplus);
                }
                else
                {
                    time += (10 - surplus);
                }
                Showtime.EndTime = model.StartTime.AddMinutes(time);

                _context.Showtimes.Add(Showtime);
                await _context.SaveChangesAsync();
                return RedirectToAction("Create", "ManageShowtimes", new { MovieId = model.MovieId, Type = SelectedMovie.Type, cinema = model.CinemaId, room = model.RoomId, area = "Manager" });
            }
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Address", model.CinemaId);
            ViewData["MovieId"] = new SelectList(_context.Movies, "MovieId", "Description", model.MovieId);
            ViewData["RoomId"] = new SelectList(_context.Rooms, "RoomId", "RoomId", model.RoomId);
            return View(model);
        }

        // Post Create
        // Check start time, end time
        [HttpPost]
        public IActionResult CheckStartEndTime([Bind("StartTime")] string StartTime, [Bind("MovieId")] int MovieId, [Bind("RoomId")] int RoomId)
        {
            var movie = _context.Movies.Find(MovieId);
            var time = movie.Time; // Cộng thêm 15 phút dọn dẹp

            // Lấy phần bù của thời gian chiếu để thời gian kết thúc toàn bộ là tròn 30 or 00
            var surplus = time % 10;
            if (surplus <= 5)
            {
                time += (5 - surplus);
            }
            else
            {
                time += (10 - surplus);
            }

            DateTime NewStart = DateTime.Parse(StartTime);

            if (NewStart <= DateTime.Now)
            {
                return Json(new { success = false });
            }

            DateTime NewEnd = NewStart.AddMinutes(time);

            var ShowtimesInDay = _context.Showtimes
                .Where(s => s.StartTime.Date == NewStart.Date && s.RoomId == RoomId)
                .OrderBy(s => s.StartTime)
                .ToList();

            if (ShowtimesInDay.Count > 0)
            {
                foreach (var s in ShowtimesInDay)
                {
                    if (CheckTime(s.StartTime, s.EndTime, NewStart, NewEnd) == false)
                    {
                        return Json(new { success = false });
                    }
                    else
                    {
                        continue;
                    }
                }
                return Json(new { success = true });
            }
            else
            {
                if (NewStart.Hour < 8) return Json(new { success = false });
                return Json(new { success = true });
            }

        }

        private static bool CheckTime(DateTime StartTime, DateTime EndTime, DateTime NewStart, DateTime NewEnd)
        {
            // Lịch chiếu phải bắt đầu từ 8h sáng và phải từ lúc hiện tại trở về sau
            if (NewStart.Hour < 8 || NewStart < DateTime.Now) return false;

            if (StartTime <= NewEnd && NewStart <= EndTime) return false;
            else if (NewStart <= EndTime && NewEnd >= EndTime) return false;
            else if (NewStart >= StartTime && NewEnd <= EndTime) return false;
            else if (NewStart <= StartTime && NewEnd >= EndTime) return false;
            else if (NewEnd <= StartTime) return true;
            else if (NewEnd >= EndTime && NewStart >= EndTime) return true;
            return true;
        }

        public IActionResult GetShowtimeOfMovie()
        {
            return View();
        }

        // GET: Manager/ManageShowtimes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Showtimes == null)
            {
                return NotFound();
            }

            var showtime = await _context.Showtimes.FindAsync(id);
            if (showtime == null)
            {
                return NotFound();
            }
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Address", showtime.CinemaId);
            ViewData["MovieId"] = new SelectList(_context.Movies, "MovieId", "Description", showtime.MovieId);
            ViewData["RoomId"] = new SelectList(_context.Rooms, "RoomId", "RoomId", showtime.RoomId);
            return View(showtime);
        }

        // POST: Manager/ManageShowtimes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ShowtimeId,MovieId,RoomId,CinemaId,StartTime,EndTime,SeatStatus,Status")] Showtime showtime)
        {
            if (id != showtime.ShowtimeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(showtime);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ShowtimeExists(showtime.ShowtimeId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Address", showtime.CinemaId);
            ViewData["MovieId"] = new SelectList(_context.Movies, "MovieId", "Description", showtime.MovieId);
            ViewData["RoomId"] = new SelectList(_context.Rooms, "RoomId", "RoomId", showtime.RoomId);
            return View(showtime);
        }

        // GET: Manager/ManageShowtimes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Showtimes == null)
            {
                return NotFound();
            }

            var showtime = await _context.Showtimes
                .Include(s => s.Cinema)
                .Include(s => s.Movie)
                .Include(s => s.Room)
                .FirstOrDefaultAsync(m => m.ShowtimeId == id);
            if (showtime == null)
            {
                return NotFound();
            }

            return View(showtime);
        }

        // POST: Manager/ManageShowtimes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Showtimes == null)
            {
                return Problem("Entity set 'CinemaDbContext.Showtimes'  is null.");
            }
            var showtime = await _context.Showtimes.FindAsync(id);
            if (showtime != null)
            {
                _context.Showtimes.Remove(showtime);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ShowtimeExists(int id)
        {
            return (_context.Showtimes?.Any(e => e.ShowtimeId == id)).GetValueOrDefault();
        }
    }
}
