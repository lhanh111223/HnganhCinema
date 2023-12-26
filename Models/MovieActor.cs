using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CinemaWeb.Models
{
    public partial class MovieActor
    {
        [Key]
        public int MovieActorId { get; set; }
        public int? MovieId { get; set; }
        public int? ActorId { get; set; }

        public virtual Actor? Actor { get; set; }
        public virtual Movie? Movie { get; set; }
    }
}
