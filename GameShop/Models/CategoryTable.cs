using System.ComponentModel.DataAnnotations;

namespace GameShop.Models
{
    public class CategoryTable
    {
        public ICollection<GameTable> Games { get; set; }

        [Key]
        public int categoryId { get; set; }
        public string categoryName { get; set; }
    }
}
