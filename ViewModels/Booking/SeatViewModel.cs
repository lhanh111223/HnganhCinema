namespace HnganhCinema.ViewModels.Booking
{
    public class SeatViewModel
    {
        public int SeatId { get; set; }
        public int? RoomId { get; set; }
        public int RoomNo { get; set; }
        public string SeatName {  get; set; }
        public int PriceId {  get; set; }
        public decimal Price { get; set; }
        
    }
}
