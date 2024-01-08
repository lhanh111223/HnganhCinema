using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class Seat
    {
        [Key]
        public int SeatId { get; set; }
        public int? RoomId { get; set; }

        [Required]
        [StringLength(10, MinimumLength = 2, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string SeatName { get; set; }
        public int PriceId { get; set; }

        public virtual Price? Price { get; set; }
        public virtual Room? Room { get; set; }
    }
}
