using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class Room
    {
        public Room()
        {
            Seats = new HashSet<Seat>();
            Showtimes = new HashSet<Showtime>();
        }

        [Key]
        public int RoomId { get; set; }
        public int? CinemaId { get; set; }

        [Required]
        [DisplayName("Room No")]
        public int RoomNo { get; set; }

        [Required]
        [Range(3,15, ErrorMessage = "{0} must be from {1} to {2}")]
        [DisplayName("Number of rows")]
        public int NumberRow { get; set; }

        [Required]
        [Range(3, 15, ErrorMessage = "{0} must be from {1} to {2}")]
        [DisplayName("Number of seats per row")]
        public int NumberCol { get; set; }
        public string Type { get; set; }
        public int Status { get; set; }

        public virtual Cinema? Cinema { get; set; }
        public virtual ICollection<Seat> Seats { get; set; }
        public virtual ICollection<Showtime> Showtimes { get; set; }
    }
}
