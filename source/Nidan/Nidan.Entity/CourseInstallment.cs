namespace Nidan.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CourseInstallment")]
    public partial class CourseInstallment
    {
        public int CourseInstallmentId { get; set; }

        [Required]
        [StringLength(500)]
        public string Name { get; set; }

        public int CourseId { get; set; }


        public int Fee { get; set; }

        public int DownPayment { get; set; }

        public int LumpsumAmt { get; set; }

        [Column(TypeName = "date")]
        public DateTime CreatedDate { get; set; }

        public int OrganisationId { get; set; }

        public int CentreId { get; set; }

        public virtual Organisation Organisation { get; set; }

        public virtual Centre Centre { get; set; }

        public virtual Course Course { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Batch> Batches { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CentreCourseInstallment> CentreCourseInstallments { get; set; }
    }
}