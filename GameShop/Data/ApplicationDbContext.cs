using Microsoft.EntityFrameworkCore;
using GameShop.Models;

namespace GameShop.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }

        public DbSet<GameTable> GameTable { get; set; }
        public DbSet<CategoryTable> CategoryTable { get; set; }
        public DbSet<UserTable> UserTable { get; set; }
    }
}
