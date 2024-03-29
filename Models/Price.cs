﻿using DataAnnotationsExtensions;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CinemaWeb.Models
{
    public partial class Price
    {
        public Price()
        {
            Seats = new HashSet<Seat>();
        }

        [Key]
        public int PriceId { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "{0} must be from {1} to {2} characters")]
        public string PriceName { get; set; }

        [Required]
        [Min(1, ErrorMessage = "{0} must be from {1}")]
        [Column(TypeName ="money")]
        public decimal UnitPrice { get; set; }

        public virtual ICollection<Seat> Seats { get; set; }
    }
}
