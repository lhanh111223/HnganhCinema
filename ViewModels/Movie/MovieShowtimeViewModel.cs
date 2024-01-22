namespace HnganhCinema.ViewModels.Movie
{
    public class MovieShowtimeViewModel
    {
        public int? ShowtimeId { get; set; }
        public int? MovieId { get; set; }
        public string? MovieName {  get; set; }
        public int? CinemaId {  get; set; }
        public string? CinemaName { get; set; }
        public int? RoomId { get; set; }
        public int? RoomNo {  get; set; }
        public string? StartDate {  get; set; }
        public string? StartTime {  get; set; }

    }
}
