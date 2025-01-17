using System.ComponentModel.DataAnnotations;

namespace GameShop.Models
{
    public class UserTable
    {
        [Key]
        public int userId { get; set; }
        public string userName { get; set; }
        public string userEmail { get; set; }
        public string userPassword { get; set; }
        public string userRole { get; set; }
    }
}
