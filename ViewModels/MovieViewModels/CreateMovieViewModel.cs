using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using Microsoft.AspNetCore.Mvc;
using Org.BouncyCastle.Crypto.Parameters;
using System.Xml;

namespace HnganhCinema.ViewModels.MovieViewModels
{
    public class CreateMovieViewModel
    {
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
        public IFormFile Image { get; set; }

        [Required]
        [Range(10, 250, ErrorMessage = "{0} must be from {1} to {2}")]
        public int Time { get; set; }
        [Required]
        [DataType(DataType.Date)]
        [Column(TypeName = "date")]
        [EndDate]
        public DateTime ReleaseDate { get; set; }
        [Required]
        [DataType(DataType.Date)]
        [Column(TypeName = "date")]
        [EndDate]
        public DateTime EndDate { get; set; }
        [Required]
        public string Status { get; set; }
    }

    public class EndDateAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if(value is DateTime endDate)
            {
                var releaseDate = (DateTime)validationContext.ObjectInstance.GetType().GetProperty("ReleaseDate").GetValue(validationContext.ObjectInstance, null);
                if (endDate < releaseDate)
                {
                    return new ValidationResult("EndDate must be greater than or equal to ReleaseDate.");
                }
            }
            return ValidationResult.Success;
        }
    }

}
