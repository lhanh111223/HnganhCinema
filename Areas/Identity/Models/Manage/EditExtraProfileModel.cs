using System;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Areas.Identity.Models.ManageViewModels
{
    public class EditExtraProfileModel
    {
        [Display(Name = "Username")]
        public string UserName { get; set; }

        [Display(Name = "Email")]
        public string UserEmail { get; set; }
        [Display(Name = "Phone")]
        public string? PhoneNumber { get; set; }

    }
}

