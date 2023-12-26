using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class Showtime
    {
        public Showtime()
        {
            Bookings = new HashSet<Booking>();
        }
        [Key]
        public int ShowtimeId { get; set; }
        public int? MovieId { get; set; }
        public int? RoomId { get; set; }
        public int? CinemaId { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public string? SeatStatus { get; set; }
        public string? Status { get; set; }

        public virtual Cinema? Cinema { get; set; }
        public virtual Movie? Movie { get; set; }
        public virtual Room? Room { get; set; }
        public virtual ICollection<Booking> Bookings { get; set; }
    }
}
