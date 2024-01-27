using Bogus.DataSets;
using CinemaWeb.Models;
using HnganhCinema.Models;
using HnganhCinema.ViewModels.Booking;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using System.Net.Mail;

namespace HnganhCinema.Controllers
{
    public class BookingController : Controller
    {
        private readonly CinemaDbContext _context;
        private readonly UserManager<AppUser> _userManager;
        private readonly IEmailSender _emailSender;
        private static AppUser CurrentUser;
        public BookingController(CinemaDbContext context, UserManager<AppUser> userManager, IEmailSender emailSender)
        {
            _context = context;
            _userManager = userManager;
            _emailSender = emailSender;
        }
        public IActionResult Index()
        {
            return View("SelectSeat");
        }


        public async Task<IActionResult> GetSeat([FromQuery] int ShowtimeId, [FromQuery] int RoomId)
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
            if (SelectedSeats == null)
            {
                return Json(new { success = false });
            }
            string[] seats = SelectedSeats.Split(',');
            foreach (var seat in seats)
            {
                var seatId = int.Parse(seat);
                total += _context.Prices.Find(_context.Seats.Find(seatId).PriceId).UnitPrice;
            }

            if (total > 0)
            {
                return Json(new { success = true, price = total });
            }
            return Json(new { success = false });
        }

        [HttpPost]
        [Route("/Booking/BookShowtime")]
        public async Task<IActionResult> BookShowtime([Bind("AccountId, ShowtimeId, Seats, Price, PointUsed, Amount")] Booking bookingDetail,
            [Bind("BookingDate")] string BookingDate, [Bind("SeatStatus")] string SeatStatus,
            [Bind("Cinema")] string Cinema, [Bind("MovieName")] string MovieName, [Bind("RoomNo")] string RoomNo)
        {
            // Set up and add to table BOOKING
            bookingDetail.BookingDate = DateTime.Parse(BookingDate);
            _context.Bookings.Add(bookingDetail);

            // Update Seat Status for Showtime
            var showtime = _context.Showtimes.Find(bookingDetail.ShowtimeId);
            if (showtime != null)
            {
                showtime.SeatStatus += (SeatStatus + ",");
                _context.Showtimes.Update(showtime);
            }

            // SET totalPoint, PointSpent, TotalPayment for Customer
            var user = _context.Users.Find(bookingDetail.AccountId);
            if (user != null)
            {
                if (user.TotalPoint == null)
                    user.TotalPoint = 0;
                if (user.PointSpent == null)
                    user.PointSpent = 0;
                if (user.TotalPayment == null)
                    user.TotalPayment = 0;

                user.PointSpent += (decimal)bookingDetail.PointUsed;
                user.TotalPayment += (decimal)bookingDetail.Amount;
                user.TotalPoint -= (decimal)bookingDetail.PointUsed;

                // Tặng điểm cho khách hàng
                // Khách hàng có hóa đơn trên 100$ => tặng 5% dưới 100$ tặng 2%
                if (bookingDetail.Amount >= 100)
                    user.TotalPoint += (bookingDetail.Amount * 5 / 100);
                else
                    user.TotalPoint += (bookingDetail.Amount * 2 / 100);
                    user.TotalPoint = Math.Ceiling(user.TotalPoint??0);
                _context.Users.Update(user);
            }
            var result = await _context.SaveChangesAsync();
            if (result != 0)
            {
                var email = user.Email;
                // Gửi mail thông báo thông tin vé
                SendMail(MovieName, Cinema, RoomNo, bookingDetail.BookingDate.ToString(), bookingDetail.Seats, bookingDetail.Price.ToString(),
                    bookingDetail.Amount.ToString(), bookingDetail.PointUsed.ToString(), email);
                return Json(new { success = true });
            }
            return Json(new { success = false });
        }

        public void SendMail(string MovieName, string Cinema, string RoomNo, string StartTime, string Seats, string Price, string Amount, string PointUsed, string email)
        {
            var subject = "HNGANH CINEMA - BOOKING DETAILS";

            string emailContent = $@"
    <!DOCTYPE html>
    <html lang=""en"">
    <head>
        <!-- ... (your existing head content) ... -->
    </head>
    <body>
        <div style=""font-family: Arial, sans-serif; max-width: 600px; margin: 20px auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px;"">
            <h2 style=""color: #333;"">Confirmation of Your Movie Ticket Booking</h2>

            <p>Hello <h6>HOANG LE HANG NGA</h6>,</p>

            <p>We sincerely appreciate your use of our movie ticket booking service. Below are the details of your booking:</p>

            <ul>
                <li><strong>Movie Name:</strong> {MovieName}</li>
                <li><strong>Cinema:</strong> {Cinema}</li>
                <li><strong>Room:</strong> {RoomNo}</li>
                <li><strong>Date and Time:</strong> {StartTime}</li>
                <li><strong>Seats:</strong> {Seats}</li>
            </ul>

            <p><strong>Total Order Value:</strong> {Price}</p>
            <p><strong>Points Used:</strong> {PointUsed}</p>

            <p><strong>Total Payment:</strong> {Amount}</p>

            <p>We have received your payment and are currently processing your order. Please review the details to ensure everything is accurate.</p>

            <p>If there are any issues or if you need further assistance, feel free to contact us at 0862801356 or hnganh.cinema@gmail.com .</p>

            <p>We hope you have an excellent movie-watching experience at our theater. Thank you and have a great day!</p>

            <p>Best regards,<br>HNGANH CINEMA<br>Manchester United</p>
        </div>
    </body>
    </html>
";

            _emailSender.SendEmailAsync(email, subject, emailContent);
        }

        public IActionResult ThankYou()
        {
            return View();
        }
    }
}
