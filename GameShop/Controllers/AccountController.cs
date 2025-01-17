using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

using GameShop.Data;
using GameShop.Models;

namespace GameShop.Controllers
{
    public class AccountController : Controller
    {
        private readonly ApplicationDbContext _context;
        public AccountController(ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Register()
        {
            return View();
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
