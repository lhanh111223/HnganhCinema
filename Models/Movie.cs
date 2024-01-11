using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CinemaWeb.Models
{
    public partial class Movie
    {
        public Movie()
        {
            MovieActors = new HashSet<MovieActor>();
            MovieGernes = new HashSet<MovieGerne>();
            Showtimes = new HashSet<Showtime>();
        }
        [Key]
        public int MovieId { get; set; }


        [StringLength(50, MinimumLength = 5, ErrorMessage = "{0} must be from {2} to {1} characters")]
        [DisplayName("Movie Name")]
        public string? MovieName { get; set; }

        [Column(TypeName ="ntext")]
        [Required]
        public string Description { get; set; }
        public string Type { get; set; }
        [Column(TypeName = "nvarchar(max)")]
        [DisplayName("Image")]
        public string? Image { get; set; }

        [Required]
        public int Time { get; set; }

        [Column(TypeName = "date")]
        public DateTime ReleaseDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime EndDate { get; set; }
        [Required]
        public int Status { get; set; }

        public virtual ICollection<MovieActor> MovieActors { get; set; }
        public virtual ICollection<MovieGerne> MovieGernes { get; set; }
        public virtual ICollection<Showtime> Showtimes { get; set; }
    }
}
