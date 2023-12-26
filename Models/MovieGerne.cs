using System;
using System.Collections.Generic;

namespace CinemaWeb.Models
{
    public partial class MovieGerne
    {
        public int MovieGerneId { get; set; }
        public int? MovieId { get; set; }
        public int? GerneId { get; set; }

        public virtual Gerne? Gerne { get; set; }
        public virtual Movie? Movie { get; set; }
    }
}
