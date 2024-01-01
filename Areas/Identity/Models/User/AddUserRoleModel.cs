using System.ComponentModel;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Areas.Identity.Models.UserViewModels
{
    public class AddUserRoleModel
    {
        public AppUser user { get; set; }

        [DisplayName("User's role")]
        public string[] RoleNames { get; set; }

        public List<AppClaim>? Claims { get; set; }

        public List<IdentityRoleClaim<string>> claimsInRole { get; set; }
        public List<IdentityUserClaim<string>> claimsInUserClaim { get; set; }

    }
}