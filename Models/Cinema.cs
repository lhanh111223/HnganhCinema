using HnganhCinema.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CinemaWeb.Models
{
    public partial class Cinema
    {
        //public Cinema()
        //{
        //    Rooms = new HashSet<Room>();
        //    Showtimes = new HashSet<Showtime>();
        //}

        [Key]
        public int CinemaId { get; set; }

        [Column(TypeName = "nvarchar")]
        [StringLength(50)]
        [Required(ErrorMessage = "Must input {0}")]
        public string? Name { get; set; }
        
        [Column(TypeName = "nvarchar(max)")]
        public string? Image { get; set; }

        [Required(ErrorMessage = "Must input {0}")]
        [StringLength(255, MinimumLength = 10, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Must input {0}")]
        [Phone(ErrorMessage = "Invalid Phone number format")]
        public string? Phone { get; set; }

        [Column(TypeName = "ntext")]
        [Required(ErrorMessage = "Must input {0}")]
        public string? Description { get; set; }
        public int? Status { get; set; }

        public int? ProvinceId { get; set; } 
        public virtual Province? Province {  get; set; }

        public virtual ICollection<AccountCinema>? AccountCinemas { get; set; }
        public virtual ICollection<Room>? Rooms { get; set; }
        public virtual ICollection<Showtime>? Showtimes { get; set; }
    }
}
