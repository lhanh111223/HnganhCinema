using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.CinemaViewModels
{
    public class CreateCinemaViewModel
    {
        [Column(TypeName = "nvarchar")]
        [StringLength(50)]
        [Required(ErrorMessage = "Must input {0}")]
        public string? Name { get; set; }

        [Required]
        [DisplayName("Cinema Image")]
        public IFormFile Image { get; set; }

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
