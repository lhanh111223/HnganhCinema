using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.RoomViewModels
{
    public class EditRoomViewModel
    {

        public int RoomId { get; set; } 

        [Required(ErrorMessage = "Please choose the Cinema")]
        [DisplayName("Cinema")]
        public int CinemaId { get; set; }

        [Required]
        [DisplayName("Room Number")]
        [Range(1, int.MaxValue, ErrorMessage = "{0} must be a positive number !")]
        public int RoomNo { get; set; }

        [Required]
        [DisplayName("Number of seat rows")]
        [Range(3, 15, ErrorMessage = "{0} must be from {1} to {2}")]

        public int NumberRow { get; set; }

        [Required]
        [DisplayName("Seats per row")]
        [Range(3, 15, ErrorMessage = "{0} must be from {1} to {2}")]

        public int NumberCol { get; set; }

        [Required]
        [DisplayName("Movie Format")]
        public string Type { get; set; }

        [Required]
        [DisplayName("Room Status")]
        public int Status { get; set; }

        public string? RowsVip { get; set; }
    }
}
