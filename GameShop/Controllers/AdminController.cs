using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

using GameShop.Data;
using GameShop.Models;
using Microsoft.AspNetCore.Authorization;

namespace GameShop.Controllers
{
    //[Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly ApplicationDbContext _context;
        public AdminController(ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult Create()
        {
            return View();
        }

        public IActionResult Update()
        {
            return View();
        }
        public IActionResult Delete()
        {
            return View();
        }

        public IActionResult Index()
        {
            IEnumerable<GameTable> books = _context.GameTable
                .Include(b => b.category)
                .ToList();
            return View(books);
        }
    }
}
