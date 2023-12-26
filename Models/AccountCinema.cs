using HnganhCinema.Models;
using System;
using System.Collections.Generic;

namespace CinemaWeb.Models
{
    public partial class AccountCinema
    {
        public int AccountCinemaId { get; set; }
        public string? AccountId { get; set; }
        public int? CinemaId { get; set; }

        public virtual AppUser? AppUser { get; set; }
        public virtual Cinema? Cinema { get; set; }
    }
}
