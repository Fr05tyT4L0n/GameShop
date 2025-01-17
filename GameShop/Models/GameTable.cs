using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GameShop.Models
{
    public class GameTable
    {
        [Key]
        public int gameId { get; set; }
        public string gameName { get; set; }
        public double gamePrice { get; set; }
        public int gameStock { get; set; }
        public string gameImage { get; set; }

        [ForeignKey("categoryId")]
        public int categoryId { get; set; }
        public CategoryTable category { get; set; }
    }
}
