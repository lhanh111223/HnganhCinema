using HnganhCinema.Models;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HnganhCinema.Areas.Manager.Models.CinemaViewModels
{
    public class IndexCinemaViewModel
    {
        public int CinemaId { get; set; }

        [DisplayName("Cinema Name")]
        public string? Name { get; set; }

        public string? Phone { get; set; }

        public int? Status { get; set; }

        public int? ProvinceId { get; set; }
        [DisplayName("Province")]
        public string ProvinceName {  get; set; }

    }
}
