using CinemaWeb.Models;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Models
{
    public class Province
    {
        [Key]
        public int ProvinceId {  get; set; }
        [Required]
        public string ProvinceName { get; set; }

        public virtual ICollection<Cinema>? Cinemas { get; set; }
    }
}
