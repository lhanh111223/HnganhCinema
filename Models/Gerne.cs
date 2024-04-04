using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class Gerne
    {
        public Gerne()
        {
            MovieGernes = new HashSet<MovieGerne>();
        }

        [Key]
        public int GerneId { get; set; }

        [StringLength(50, MinimumLength = 5, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string GerneName { get; set; }

        public virtual ICollection<MovieGerne> MovieGernes { get; set; }
    }
}
