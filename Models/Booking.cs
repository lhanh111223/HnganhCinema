using HnganhCinema.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class Booking
    {
        [Key]
        public int BookingId { get; set; }
        public string? AccountId { get; set; }
        public int? ShowtimeId { get; set; }
        public string? Seats { get; set; }
        public decimal? Price { get; set; }
        public double? PointUsed { get; set; }
        public decimal? Amount { get; set; }
        public DateTime? BookingDate { get; set; }

        public virtual AppUser? Account { get; set; }
        public virtual Showtime? Showtime { get; set; }
    }
}
