using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Models
{
    public class AppMenu
    {
        [Key]
        public int Id { get; set; }

        public int ClaimId { get; set; }
        public bool CanView {  get; set; }
        public bool CanCreate {  get; set; }
        public bool CanUpdate {  get; set; }
        public bool CanDelete {  get; set; }
        public bool CanBlock {  get; set; }

        public virtual AppClaim? AppClaim { get; set; }
    }
}
