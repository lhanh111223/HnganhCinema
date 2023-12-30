using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace HnganhCinema.Models
{
    public class RoleAppClaim
    {
        [Key]
        public int Id { get; set; }

        public string RoleId { get; set; }
        public int? ClaimId {  get; set; }

        public IdentityRole? Role { get; set; }
        public AppClaim? AppClaim { get; set; }
    }
}
