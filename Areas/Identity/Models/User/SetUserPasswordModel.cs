using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace HnganhCinema.Areas.Identity.Models.UserViewModels
{
  public class SetUserPasswordModel
  {
      [Required(ErrorMessage = "Must input {0}")]
      [StringLength(100, ErrorMessage = "{0} must be from {2} to {1} characters.", MinimumLength = 6)]
      [DataType(DataType.Password)]
      [Display(Name = "New Password")]
      public string NewPassword { get; set; }

      [DataType(DataType.Password)]
      [Display(Name = "Confirm Password")]
      [Compare("NewPassword", ErrorMessage = "Incorrect confirm password.")]
      public string ConfirmPassword { get; set; }


  }
}