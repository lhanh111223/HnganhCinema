using CinemaWeb.Models;
using Microsoft.AspNetCore.Identity;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;

namespace HnganhCinema.Models
{
    public class AppUser : IdentityUser
    {
        [Column(TypeName = "money")]
        public decimal? TotalPoint {  get; set; }
        [Column(TypeName = "money")]
        public decimal? PointSpent { get; set; }
        [Column(TypeName = "money")]
        public decimal? TotalPayment {  get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [DisplayName("Avatar")]
        public string? Avatar { get; set; }

        public virtual ICollection<AccountCinema> AccountCinemas { get; set; }
        public virtual ICollection<Booking> Bookings { get; set; }
        public virtual ICollection<UserFeature> UserFeatures { get; set; }
    }
}
