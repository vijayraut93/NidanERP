namespace Nidan.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Brainstorming")]
    public partial class Brainstorming
    {
        public int BrainstormingId { get; set; }

        public int QuestionId { get; set; }

        public int EventId { get; set; }

        [Required]
        [StringLength(10)]
        public string Completed { get; set; }

        [Required]
        public string Comment { get; set; }

        public int OrganisationId { get; set; }

        public int CentreId { get; set; }

        public virtual Organisation Organisation { get; set; }

        public virtual Centre Centre { get; set; }

        public virtual Event Event { get; set; }

        public virtual Question Question { get; set; }
    }
}
