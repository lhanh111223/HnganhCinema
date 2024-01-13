using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CinemaWeb.Models;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;
using System.IO;
using HnganhCinema.Helper;
using HnganhCinema.Data;
using HnganhCinema.Areas.Manager.Models.CinemaViewModels;
using static Org.BouncyCastle.Crypto.Engines.SM2Engine;

namespace HnganhCinema.Areas.Manager.Controllers
{
    [Area("Manager")]
    [Route("/Manager/ManageCinemas/[action]/{id?}")]
    public class ManageCinemasController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;

        public ManageCinemasController(CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }

        // GET: Manager/ManageCinemas
        public async Task<IActionResult> Index()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Cinemas", "View"))
            {
                return View("AccessDenied");
            }

            return View();
        }

        public async Task<IActionResult> GetData()
        {
            var results = _context.Cinemas.ToList();
            return Json(new { data = results });
        }

        // GET: Manager/ManageCinemas/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Cinemas == null)
            {
                return NotFound();
            }

            var cinema = await _context.Cinemas
                .FirstOrDefaultAsync(m => m.CinemaId == id);
            if (cinema == null)
            {
                return NotFound();
            }

            return View(cinema);
        }

        // GET: Manager/ManageCinemas/Create
        public IActionResult Create()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Cinemas", "Create"))
            {
                return View("AccessDenied");
            }

            var statusList = Enum.GetValues(typeof(ENUM.CinemaStatusEnum))
                                    .Cast<ENUM.CinemaStatusEnum>()
                                    .Select((value, index) => new SelectListItem
                                    {
                                        Value = index.ToString(),
                                        Text = value.ToString()
                                    })
                                    .ToList();
            ViewBag.statusList = statusList;

            return View();
        }

        // POST: Manager/ManageCinemas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CinemaId,Name,Image,Address,Phone,Description,Status")] CreateCinemaViewModel cinema)
        {
            if (cinema != null)
            {
                var file = Path.GetFileNameWithoutExtension(Path.GetRandomFileName())
                        + Path.GetExtension(cinema.Image.FileName);
                var serverfile = Path.Combine("Uploads", "CinemaImage", file);
                using (var fs = new FileStream(serverfile, FileMode.Create))
                {
                    await cinema.Image.CopyToAsync(fs);
                }
                _context.Cinemas.Add(new Cinema
                {
                    Name = cinema.Name,
                    Image = file,
                    Address = cinema.Address,
                    Phone = cinema.Phone,
                    Description = cinema.Description,
                    Status = int.Parse(cinema.Status),
                });
                var result = await _context.SaveChangesAsync();
                if (result != 0)
                    return RedirectToAction("Index");
            }

            return View(cinema);
        }

        // GET: Manager/ManageCinemas/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Cinemas == null)
            {
                return NotFound();
            }

            var cinema = await _context.Cinemas.FindAsync(id);
            if (cinema == null)
            {
                return NotFound();
            }
            var statusList = Enum.GetValues(typeof(ENUM.CinemaStatusEnum))
                                    .Cast<ENUM.CinemaStatusEnum>()
                                    .Select((value, index) => new SelectListItem
                                    {
                                        Value = index.ToString(),
                                        Text = value.ToString()
                                    })
                                    .ToList();
            ViewBag.statusList = statusList;

            var editCinemaViewModel = new EditCinemaViewModel
            {
                CinemaId = id.Value,
                Name = cinema.Name,
                Image = cinema.Image,
                Address = cinema.Address,
                Phone = cinema.Phone,
                Description = cinema.Description,
                Status = cinema.Status.ToString(),
            };

            return View(editCinemaViewModel);
        }

        // POST: Manager/ManageCinemas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CinemaId,Name,Image,ChangeImage,Address,Phone,Description,Status")] EditCinemaViewModel model)
        {
            if(id != model.CinemaId)
            {
                return NotFound();
            }
            var cinema = _context.Cinemas.Find(id);
            if (model.ChangeImage != null)
            {
                var file = Path.GetFileNameWithoutExtension(Path.GetRandomFileName())
                            + Path.GetExtension(model.ChangeImage.FileName);
                var serverFile = Path.Combine("Uploads", "CinemaImage", file);

                using (var fs = new FileStream(serverFile, FileMode.Create))
                {
                    await model.ChangeImage.CopyToAsync(fs);
                }
                var deleteImage = "Uploads/MovieImage/" + cinema.Image;
                System.IO.File.Delete(deleteImage);
                cinema.Image = file;
            }
            try
            {
                cinema.Name = model.Name;
                cinema.Address = model.Address;
                cinema.Phone = model.Phone;
                cinema.Description = model.Description;
                cinema.Status = int.Parse(model.Status);
                _context.Cinemas.Update(cinema);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CinemaExists(model.CinemaId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return RedirectToAction(nameof(Index));
        }

        // GET: Manager/ManageCinemas/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Cinemas == null)
            {
                return NotFound();
            }

            var cinema = await _context.Cinemas
                .FirstOrDefaultAsync(m => m.CinemaId == id);
            if (cinema == null)
            {
                return NotFound();
            }

            return View(cinema);
        }

        // POST: Manager/ManageCinemas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Cinemas == null)
            {
                return Problem("Entity set 'CinemaDbContext.Cinemas'  is null.");
            }
            var cinema = await _context.Cinemas.FindAsync(id);
            if (cinema != null)
            {
                _context.Cinemas.Remove(cinema);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CinemaExists(int id)
        {
            return (_context.Cinemas?.Any(e => e.CinemaId == id)).GetValueOrDefault();
        }
    }
}
