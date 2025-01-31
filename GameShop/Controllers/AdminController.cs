using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

using GameShop.Data;
using GameShop.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Rendering;

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
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(string gameName, string gameImage, double gamePrice, int gameStock, int categoryId)
        {
            try
            {
                var newGame = new GameTable
                {
                    gameName = gameName,
                    gameImage = gameImage,
                    gamePrice = gamePrice,
                    gameStock = gameStock,
                    categoryId = categoryId
                };

                _context.GameTable.Add(newGame);
                _context.SaveChanges();

                return RedirectToAction("Index", "Admin");
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = ex.InnerException?.Message ?? ex.Message;
                TempData["AlertMessage"] = "Error: " + (ex.InnerException?.Message ?? ex.Message);
                return View();
            }
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            var model = _context.GameTable.FirstOrDefault(g => g.gameId == id);
            if (model == null)
            {
                TempData["AlertMessage"] = "ไม่พบเกม";
                TempData["AlertType"] = "error";
                return RedirectToAction("Index", "Admin");
            }
            return View(model);
        }

        [HttpPost]
        public IActionResult Edit(int id, GameTable model)
        {
            try
            {
                var existingGame = _context.GameTable.FirstOrDefault(g => g.gameId == id);

                if (existingGame == null)
                {
                    TempData["AlertMessage"] = "ไม่พบเกม";
                    TempData["AlertType"] = "error";
                    return RedirectToAction("Index", "Admin");
                }

                existingGame.gameName = model.gameName;
                existingGame.gameImage = model.gameImage;
                existingGame.gameStock = model.gameStock;
                existingGame.gamePrice = model.gamePrice;
                existingGame.categoryId = model.categoryId;

                _context.SaveChanges();

                TempData["AlertMessage"] = "อัพเดทสำเร็วแล้ว";
                TempData["AlertType"] = "success";

                return RedirectToAction("Index", "Admin");
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = ex.InnerException?.Message ?? ex.Message;
                TempData["AlertMessage"] = "พบข้อผิดพลาด : " + (ex.InnerException?.Message ?? ex.Message);
                TempData["AlertType"] = "error";
                return View(model);
            }
        }

        // Delete
        [HttpPost]
        public IActionResult Delete(int id)
        {
            var game = _context.GameTable.Find(id);
            if (game == null)
            {
                return NotFound();
            }

            _context.GameTable.Remove(game);
            _context.SaveChanges();

            TempData["AlertMessage"] = "เกมถูกลบสำเร็จ!";
            TempData["AlertType"] = "success";

            return RedirectToAction("Index");


        }

        // Index
        public IActionResult Index()
        {
            IEnumerable<GameTable> books = _context.GameTable
                .Include(b => b.category)
                .ToList();
            return View(books);
        }
    }
}
