using HnganhCinema.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Areas.Identity.Models.Role
{
    public class AddRoleAppClaim
    {
        [Display(Name = "Role Name")]
        [Required(ErrorMessage = "Must input the {0}")]
        [StringLength(256, MinimumLength = 3, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string Name {  get; set; }

        [DisplayName("Feature")]
        public string[]? Claims { get; set; }
    }
}
