using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.CinemaViewModels
{
    public class EditCinemaViewModel
    {
        public int CinemaId { get; set; }
        [StringLength(50)]
        [Required(ErrorMessage = "Must input {0}")]
        public string? Name { get; set; }

        public string? Image { get; set; }

        [DisplayName("Cinema Image")]
        public IFormFile? ChangeImage { get; set; }

        [Required(ErrorMessage = "Must input {0}")]
        [StringLength(255, MinimumLength = 10, ErrorMessage = "{0} must be from {2} to {1} characters")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Must input {0}")]
        [Phone(ErrorMessage = "Invalid Phone number format")]
        public string Phone { get; set; }

        [Column(TypeName = "ntext")]
        [Required(ErrorMessage = "Must input {0}")]
        public string Description { get; set; }

        [Required]
        public string Status { get; set; }
    }
}
