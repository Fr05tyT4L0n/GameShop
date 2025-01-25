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
                ViewBag.ErrorMessage = "Username Or Email are invalid.";
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

            if (user.userRole == "Admin")
            {
                return RedirectToAction("Index", "Admin");
            }
            else
            {
                return RedirectToAction("Index", "Game");
            }
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View(); // แสดงฟอร์มสมัครสมาชิก
        }

        // Action Method ที่รับข้อมูลจากฟอร์มสมัครสมาชิก (HTTP POST)
        [HttpPost]
        public IActionResult Register(string username, string email, string password, string cpassword)
        {
            // ตรวจสอบว่า รหัสผ่านที่กรอกสองครั้งตรงกันหรือไม่
            if (password != cpassword)
            {
                ModelState.AddModelError("Cpassword", "Passwords do not match."); // ถ้าไม่ตรงให้แสดงข้อความผิดพลาด
                TempData["AlertMessage"] = "Passwords do not match, Please try again.";
                return View(); // ส่งกลับไปที่หน้าฟอร์มสมัครสมาชิก
            }

            // ตรวจสอบว่ามีผู้ใช้หรืออีเมลนี้ในระบบแล้วหรือไม่
            if (_context.UserTable.Any(u => u.userName == username || u.userEmail == email))
            {
                ModelState.AddModelError("DuplicateUser", "Username or Email already exists."); // ถ้ามีให้แสดงข้อความผิดพลาด
                TempData["AlertMessage"] = "Username or Email already exists, Please try again.";
                return View();
            }

            try
            {
                // สร้างผู้ใช้ใหม่
                var newUser = new UserTable
                {
                    userName = username, // กำหนดชื่อผู้ใช้
                    userEmail = email,       // กำหนดอีเมล
                    userPassword = password, // เก็บรหัสผ่าน (ควรเก็บแบบเข้ารหัสในโปรดักชัน)
                    userRole = "User"        // กำหนดบทบาทผู้ใช้เป็น User
                };

                _context.UserTable.Add(newUser); // เพิ่มผู้ใช้ใหม่ในฐานข้อมูล
                _context.SaveChanges(); // บันทึกการเปลี่ยนแปลงในฐานข้อมูล

                // เปลี่ยนเส้นทางไปที่หน้า Login หลังจากสมัครสมาชิกสำเร็จ
                TempData["AlertMessage"] = "Access Granted. Please Login.";
                return RedirectToAction("Login", "Account");
            }
            catch (Exception ex)
            {
                // ถ้ามีข้อผิดพลาดในการสมัครสมาชิก ให้แสดงข้อความผิดพลาด
                ViewBag.ErrorMessage = ex.InnerException?.Message ?? ex.Message;
                TempData["AlertMessage"] = "Error: " + (ex.InnerException?.Message ?? ex.Message);
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Account");
        }
    }
}
