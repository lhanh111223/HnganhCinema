using CinemaWeb.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Models
{
    public class AppClaim
    {
        public AppClaim()
        {
            RoleClaims = new HashSet<AppRoleClaim>();
        }
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage ="Must input Feature")]
        [StringLength(50, MinimumLength = 3, ErrorMessage ="{0} must be from {1} to {2} characters")]
        [DisplayName("Feature")]
        public string ClaimName {  get; set; }

        public virtual ICollection<AppRoleClaim> RoleClaims { get; set; }
        public virtual ICollection<AppMenu> AppMenu { get; set; }
        public virtual ICollection<UserFeature> UserFeatures { get; set; }
    }
}
