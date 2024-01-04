using System.ComponentModel;
using System.Text.Json.Serialization;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Areas.Identity.Models.UserViewModels
{
    public class AddUserRoleModel
    {
        public AppUser user { get; set; }

        [DisplayName("User's role")]
        public string[] RoleNames { get; set; }

        public List<AppClaimModel>? Claims { get; set; }
        public List<AppMenu>? Menu { get; set; }
        
        public List<UserFeature> Features { get; set; }
        public UserFeature UserFeatures { get; set; }

        //public bool CanView {  get; set; }
        //public bool CanCreate {  get; set; }
        //public bool CanUpdate {  get; set; }
        //public bool CanDelete {  get; set; }
        //public bool CanBlock {  get; set; }


    }

    public class AppClaimModel
    {
        [JsonIgnore]
        public AppClaim Claim { get; set; }
        public int Id { get; set; }
        public bool CanView { get; set; }
        public bool CanCreate { get; set; }
        public bool CanUpdate { get; set; }
        public bool CanDelete { get; set; }
        public bool CanBlock { get; set; }
    }
}