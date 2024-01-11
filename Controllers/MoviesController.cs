using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CinemaWeb.Models;
using HnganhCinema.Models;
using HnganhCinema.Helper;
using Microsoft.AspNetCore.Identity;
using HnganhCinema.ViewModels.MovieViewModels;
using HnganhCinema.Data;

namespace HnganhCinema.Controllers
{
    public class MoviesController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;
        public MoviesController(CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }

        // GET: Movies
        public IActionResult Index()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Movies", "View"))
            {
                return View("AccessDenied");
            }

            return View();
        }

        public async Task<IActionResult> GetData()
        {
            var results = _context.Movies.ToList();
            return Json(new { data = results });
        }

        // GET: Movies/Details/5 GetDetail
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .FirstOrDefaultAsync(m => m.MovieId == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // GET: Movies/Create  -- GetCreate
        public IActionResult Create()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Movies", "Create"))
            {
                return View("AccessDenied");
            }

            var typeList = Enum.GetValues(typeof(ENUM.MovieTypeEnum))
                                        .Cast<ENUM.MovieTypeEnum>()
                                        .Select((value) => new SelectListItem
                                        {
                                            Value = value.ToString().Substring(1),
                                            Text = value.ToString().Substring(1)
                                        })
                                        .ToList();
            ViewBag.typeList = typeList;

            var statusList = Enum.GetValues(typeof(ENUM.MovieStatusEnum)).Cast<ENUM.MovieStatusEnum>()
                                            .Select((value, index) => new SelectListItem
                                            {
                                                Value = index.ToString(),
                                                Text = value.ToString()
                                            })
                                            .ToList();
            ViewBag.statusList = statusList;

            return View();
        }

        // POST: Movies/Create -- PostCreate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MovieId,MovieName,Description,Type,Image,Time,ReleaseDate,EndDate,Status")] CreateMovieViewModel movie)
        {
            if (movie != null)
            {

                var file = Path.GetFileNameWithoutExtension(Path.GetRandomFileName())
                            + Path.GetExtension(movie.Image.FileName);
                var serverFile = Path.Combine("Uploads", "MovieImage", file);

                using (var fs = new FileStream(serverFile, FileMode.Create))
                {
                    await movie.Image.CopyToAsync(fs);
                }
                _context.Movies.Add(new Movie
                {
                    MovieName = movie.MovieName,
                    Description = movie.Description,
                    Type = movie.Type,
                    Image = file,
                    Time = movie.Time,
                    ReleaseDate = movie.ReleaseDate,
                    EndDate = movie.EndDate,
                    Status = int.Parse(movie.Status) + 1,
                });
                var result = await _context.SaveChangesAsync();
                if (result != 0)
                    return RedirectToAction("Index");

            }
            return View(movie);
        }

        // GET: Movies/Edit/5 
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies.FindAsync(id);
            if (movie == null)
            {
                return NotFound();
            }

            var typeList = Enum.GetValues(typeof(ENUM.MovieTypeEnum))
                                        .Cast<ENUM.MovieTypeEnum>()
                                        .Select((value) => new SelectListItem
                                        {
                                            Value = value.ToString().Substring(1),
                                            Text = value.ToString().Substring(1)
                                        })
                                        .ToList();
            ViewBag.typeList = typeList;

            var statusList = Enum.GetValues(typeof(ENUM.MovieStatusEnum)).Cast<ENUM.MovieStatusEnum>()
                                            .Select((value, index) => new SelectListItem
                                            {
                                                Value = index.ToString(),
                                                Text = value.ToString()
                                            })
                                            .ToList();
            ViewBag.statusList = statusList;

            var editMovieViewModel = new EditMovieViewModel
            {
                MovieId = id.Value,
                MovieName = movie.MovieName,
                Description = movie.Description,
                Type = movie.Type,
                Image = movie.Image,
                Time = movie.Time,
                ReleaseDate = movie.ReleaseDate,
                EndDate = movie.EndDate,
                Status = movie.Status.ToString(),
            };
            return View(editMovieViewModel);
        }

        // POST: Movies/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MovieId,MovieName,Description,Type,Image,ChangeImage,Time,ReleaseDate,EndDate,Status")] EditMovieViewModel model)
        {
            if (id != model.MovieId)
            {
                return NotFound();
            }

            var movie = _context.Movies.Find(id);
            if (model.ChangeImage != null)
            {
                var file = Path.GetFileNameWithoutExtension(Path.GetRandomFileName())
                            + Path.GetExtension(model.ChangeImage.FileName);
                var serverFile = Path.Combine("Uploads", "MovieImage", file);
                
                using (var fs = new FileStream(serverFile, FileMode.Create))
                {
                    await model.ChangeImage.CopyToAsync(fs);
                }
                var deleteImage = "Uploads/MovieImage/" + movie.Image;
                System.IO.File.Delete(deleteImage);
                movie.Image = file;
            }

            try
            {
                movie.MovieName = model.MovieName;
                movie.Description = model.Description;
                movie.Type = model.Type;
                movie.Time = model.Time;
                movie.ReleaseDate = model.ReleaseDate;
                movie.EndDate = model.EndDate;
                movie.Status = int.Parse(model.Status);
                _context.Update(movie);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MovieExists(model.MovieId))
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

        // GET: Movies/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .FirstOrDefaultAsync(m => m.MovieId == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // POST: Movies/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Movies == null)
            {
                return Problem("Entity set 'CinemaDbContext.Movies'  is null.");
            }
            var movie = await _context.Movies.FindAsync(id);
            if (movie != null)
            {
                _context.Movies.Remove(movie);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MovieExists(int id)
        {
            return (_context.Movies?.Any(e => e.MovieId == id)).GetValueOrDefault();
        }
    }
}
