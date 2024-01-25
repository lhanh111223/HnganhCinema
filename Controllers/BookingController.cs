using CinemaWeb.Models;
using HnganhCinema.Models;
using HnganhCinema.ViewModels.Booking;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace HnganhCinema.Controllers
{
    public class BookingController : Controller
    {
        private readonly CinemaDbContext _context;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;
        public BookingController(CinemaDbContext context, UserManager<AppUser> userManager)
        {
            _context = context;
            _userManager = userManager;
        }
        public IActionResult Index()
        {
            return View("SelectSeat");
        }

        
        public async Task<IActionResult> GetSeat([FromQuery] int ShowtimeId, [FromQuery]int RoomId)
        {
            var room = _context.Rooms.Find(RoomId);
            ViewBag.room = room;
            //ViewBag.numRow = room.NumberRow;
            //ViewBag.numCol = room.NumberCol;

            ViewBag.showtime = _context.Showtimes.Find(ShowtimeId);

            ViewBag.seatStatus = _context.Showtimes.Find(ShowtimeId).SeatStatus;
            ViewBag.movie = _context.Movies.Find(_context.Showtimes.Find(ShowtimeId).MovieId);

            ViewBag.cinema = _context.Cinemas.Find(_context.Rooms.Find(RoomId).CinemaId).Name;

            var seats = _context.Seats.Where(s => s.RoomId == RoomId)
                .Include(s => s.Room)
                .Include(s => s.Price)
                .ToList();

            var listSeats = new List<SeatViewModel>();
            foreach (var item in seats)
            {
                listSeats.Add(new SeatViewModel()
                {
                    SeatId = item.SeatId,
                    RoomId = item.RoomId,
                    RoomNo = item.Room.RoomNo,
                    SeatName = item.SeatName,
                    PriceId = item.PriceId,
                    Price = item.Price.UnitPrice
                });
            }
            listSeats.Insert(0, new SeatViewModel()
            {
                SeatId = 0
            });
            return View("SelectSeat", listSeats);
        }

        public async Task<IActionResult> GetTotalPrice([Bind("SelectedSeats")] string SelectedSeats)
        {
            decimal total = 0;
            if(SelectedSeats == null)
            {
                return Json(new { success = false });
            }
            string[] seats = SelectedSeats.Split(',');
            foreach(var seat in seats)
            {
                var seatId = int.Parse(seat);
                total += _context.Prices.Find(_context.Seats.Find(seatId).PriceId).UnitPrice;
            }

            if(total > 0)
            {
                return Json(new {success = true, price = total});
            }
            return Json(new {success = false});
        }

        [HttpPost]
        [Route("/Booking/BookShowtime")]
        public async Task<IActionResult> BookShowtime([Bind("AccountId, ShowtimeId, Seats, Price, PointUsed, Amount")] Booking bookingDetail, 
            [Bind("BookingDate")] string BookingDate, [Bind("SeatStatus")] string SeatStatus)
        {
            Console.WriteLine(DateTime.Parse(BookingDate));
            return Ok();
        }
    }
}
