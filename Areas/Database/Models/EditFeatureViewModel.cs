using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Database.Models
{
    public class EditFeatureViewModel
    {
        [Required(ErrorMessage = "Must input Feature")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "{0} must be from {1} to {2} characters")]
        [DisplayName("Feature")]
        public string Feature { get; set; }

        public bool CanView { get; set; }
        public bool CanCreate { get; set; }
        public bool CanUpdate { get; set; }
        public bool CanDelete { get; set; }
        public bool CanBlock { get; set; }
    }
}
