using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Areas.Identity.Models.RoleViewModels
{
  public class EditRoleModel
    {
        [Display(Name = "Role Name")]
        [Required(ErrorMessage = "Must input {0}")]
        [StringLength(256, MinimumLength = 3, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string Name { get; set; }
        public List<IdentityRoleClaim<string>>? Claims { get; set; }
        public string? []? Features { get; set; }
        public IdentityRole? role { get; set; }




    }
}
