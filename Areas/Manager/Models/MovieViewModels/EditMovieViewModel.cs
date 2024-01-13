using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.ViewModels.MovieViewModels
{
    public class EditMovieViewModel
    {
        public int MovieId { get; set; }

        [StringLength(50, MinimumLength = 5, ErrorMessage = "{0} must be from {2} to {1} characters")]
        [DisplayName("Movie Name")]
        [Required]
        public string? MovieName { get; set; }

        [Required]
        public string Description { get; set; }
        [Required]
        public string Type { get; set; }
        [DisplayName("Image")]
        [Required]
        public string Image { get; set; }

        [DisplayName("Change Image")]
        public IFormFile? ChangeImage { get; set; }

        [Required]
        [Range(10, 250, ErrorMessage = "{0} must be from {1} to {2}")]
        public int Time { get; set; }
        [Required]
        [DataType(DataType.Date)]
        [Column(TypeName = "date")]
        public DateTime ReleaseDate { get; set; }
        [Required]
        [DataType(DataType.Date)]
        [Column(TypeName = "date")]
        public DateTime EndDate { get; set; }
        [Required]
        public string Status { get; set; }
    }


}
