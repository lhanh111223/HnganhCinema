using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Areas.Manager.Models.ShowtimeViewModels
{
    public class CreateShowtimeViewModel
    {
        [Required]
        [DisplayName("Movie Name")]
        public int MovieId {  get; set; }
        [Required]
        [DisplayName("Cinema")]
        public int CinemaId {  get; set; }
        [Required(ErrorMessage = "Please choose the room")]
        [DisplayName("Room No")]
        public int RoomId { get; set; }

        [Required(ErrorMessage = "Please choose the start time")]
        [DisplayName("Start Time")]
        public DateTime StartTime { get; set; }

        [Required]
        public DateTime EndTime { get; set; }


    }
}
