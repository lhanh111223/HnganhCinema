using CinemaWeb.Models;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Models
{
    public class AppRoleClaim : IdentityRoleClaim<string>
    {
        public int ClaimId { get; set; }

        public virtual AppClaim? Claims { get; set; }
    }
}