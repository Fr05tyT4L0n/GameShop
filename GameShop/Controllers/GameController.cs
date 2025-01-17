using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

using GameShop.Data;
using GameShop.Models;

namespace GameShop.Controllers
{
    public class GameController : Controller
    {
        private readonly ApplicationDbContext _context;

        public GameController(ApplicationDbContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            IEnumerable<GameTable> games = _context.GameTable
                .Include(b => b.category)
                .ToList();
            return View(games);
        }
    }
}
