using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

using GameShop.Data;
using GameShop.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;

namespace GameShop.Controllers
{
    public class AccountController : Controller
    {
        private readonly ApplicationDbContext _context;
        public AccountController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string username, string password, bool remember)
        {
            var user = _context.UserTable
                .FirstOrDefault(u => (u.userName == username || u.userEmail == username) && u.userPassword == password);

            if (user == null)
            {
                TempData["AlertMessage"] = "Username หรือ Email ไม่ถูกต้อง โปรดลองใหม่อีกครั้ง";
                TempData["AlertType"] = "error";
                return View();
            }

            var claims = new[]
            {
                new Claim(ClaimTypes.Name, user.userName),
                new Claim(ClaimTypes.Email, user.userEmail),
            };

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

            TempData["UserRole"] = user.userRole;
            TempData["AlertMessage"] = "เข้าสู่ระบบสำเร็จ";
            TempData["AlertType"] = "success";

            return View();
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(string username, string email, string password, string cpassword)
        {
            if (password != cpassword)
            {
                TempData["AlertMessage"] = "Password ไม่ตรงกัน โปรดลองใหม่อีกครั้ง";
                TempData["AlertType"] = "error";
                return View();
            }

            if (_context.UserTable.Any(u => u.userName == username || u.userEmail == email))
            {
                TempData["AlertMessage"] = "มี Username หรือ Email นี้อยู่แล้ว กรุณาใช้ชื่ออื่น";
                TempData["AlertType"] = "error";
                return View();
            }

            try
            {
                var newUser = new UserTable
                {
                    userName = username,
                    userEmail = email,
                    userPassword = password,
                    userRole = "User"
                };

                _context.UserTable.Add(newUser);
                _context.SaveChanges();

                TempData["AlertMessage"] = "สมัครสมาชิกสำเร็จ";
                TempData["AlertType"] = "success";

                //return RedirectToAction("Login", "Account");
                return View();
            }
            catch (Exception ex)
            {
                TempData["AlertMessage"] = "มีข้อผิดพลาดของระบบ" + ex.InnerException?.Message ?? ex.Message;
                TempData["AlertType"] = "error";

                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            Response.Cookies.Delete("Cookie");

            return RedirectToAction("Login", "Account");
        }
    }
}
