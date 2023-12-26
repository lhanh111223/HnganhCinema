using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Areas.Identity.Models.UserViewModels
{
  public class AddUserClaimModel
  {
    [Display(Name = "Claim name")]
    [Required(ErrorMessage = "Must input {0}")]
    [StringLength(256, MinimumLength = 3, ErrorMessage = "{0} must be from {2} to {1} characters")]
    public string ClaimType { get; set; }

    [Display(Name = "Value")]
    [Required(ErrorMessage = "Must input {0}")]
    [StringLength(256, MinimumLength = 3, ErrorMessage = "{0} must be from {2} to {1} characters")]
    public string ClaimValue { get; set; }

  }
}