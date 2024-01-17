using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.ShowtimeViewModels
{
    public class IndexShowtimeViewModel
    {
        public int Id { get; set; }
        public string Cinema { get; set; }
        public string Movie { get; set; }
        public int Room { get; set; }
        [DisplayName("Start time")]
        public DateTime StartTime { get; set; }
        [DisplayName("End time")]
        public DateTime EndTime { get; set; }

        public string? SeatStatus {  get; set; }
        public string? Status {  get; set; }
    }
}
