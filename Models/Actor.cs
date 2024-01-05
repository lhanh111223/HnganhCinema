using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CinemaWeb.Models
{
    public partial class Actor
    {
        public Actor()
        {
            MovieActors = new HashSet<MovieActor>();
        }

        [Key]
        public int ActorId { get; set; }

        [Column(TypeName ="nvarchar")]
        [StringLength(50)]
        [Required(ErrorMessage ="Must input {0}")]
        [DisplayName("Actor Name")]
        public string? ActorName { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        [DisplayName("Actor's Image")]
        public string? Avatar {  get; set; }

        public virtual ICollection<MovieActor> MovieActors { get; set; }
    }
}
