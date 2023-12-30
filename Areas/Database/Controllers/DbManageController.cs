using HnganhCinema.Areas.Database.Models;
using HnganhCinema.Data;
using HnganhCinema.Models;
using Humanizer.Localisation.TimeToClockNotation;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DemoMVC.Areas.Database.Controllers
{
    [Area("Database")]
    [Route("/database-manage/[action]")]
    public class DbManageController : Controller
    {
        private readonly CinemaDbContext _dbContext;
        private readonly UserManager<AppUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ILogger<DbManageController> _logger;

        public DbManageController(CinemaDbContext dbContext, UserManager<AppUser> userManager, RoleManager<IdentityRole> roleManager, ILogger<DbManageController> logger)
        {
            _dbContext = dbContext;
            _userManager = userManager;
            _roleManager = roleManager;
            _logger = logger;
        }

        public IActionResult IndexFeature()
        {
            return View();
        }

        [HttpGet]
        public IActionResult DeleteDb()
        {
            return View();
        }

        [TempData]
        public string StatusMessage { get; set; }

        [HttpPost]
        public async Task<IActionResult> DeleteDbAsync()
        {
            var success = await _dbContext.Database.EnsureDeletedAsync();

            StatusMessage = success ? "Xóa Database thành công" : "Không xóa được Db";

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        public async Task<IActionResult> Migrate()
        {
            await _dbContext.Database.MigrateAsync();

            StatusMessage = "Cập nhật Database thành công";

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> SeedDataAsync()
        {
            // Create Roles
            var rolenames = typeof(RoleName).GetFields().ToList();
            foreach (var r in rolenames)
            {
                var rolename = (string)r.GetRawConstantValue();
                var rfound = await _roleManager.FindByNameAsync(rolename);
                if (rfound == null)
                {
                    await _roleManager.CreateAsync(new IdentityRole(rolename));
                }
            }

            // admin, pass=admin123, admin@example.com
            var useradmin = await _userManager.FindByEmailAsync("admin@example.com");
            if (useradmin == null)
            {
                useradmin = new AppUser()
                {
                    UserName = "admin",
                    Email = "admin@example.com",
                    EmailConfirmed = true,
                };

                await _userManager.CreateAsync(useradmin, "admin123");
                await _userManager.AddToRoleAsync(useradmin, RoleName.Administrator);
            }
            StatusMessage = "Vừa seed Database";
            return RedirectToAction("Index");
        }

        [HttpGet]
        public IActionResult AddFeature()
        {
            return View();
        }

        [HttpPost, ActionName(nameof(AddFeature))]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddFeatureAsync(AddFeatureViewModel model)
        {
            var claim = _dbContext.AppClaims.Where(c => c.ClaimName == model.Feature).FirstOrDefault();
            if (claim != null)
            {
                ViewBag.Message = "This Feature is already existed";
                return View();
            }
            if (!ModelState.IsValid)
            {
                ViewBag.Message = "Invalid Model";
                return View();
            }
            AppClaim newAppClaim = new AppClaim()
            {
                ClaimName = model.Feature
            };
            _dbContext.AppClaims.Add(newAppClaim);
            _dbContext.SaveChanges();

            var addedAppClaim = _dbContext.AppClaims.Where(a => a.ClaimName == model.Feature).FirstOrDefault();
            if (addedAppClaim != null)
            {
                AppMenu newAppMenu = new AppMenu()
                {
                    ClaimId = addedAppClaim.Id,
                    CanView = model.CanView,
                    CanCreate = model.CanCreate,
                    CanDelete = model.CanDelete,    
                    CanUpdate = model.CanUpdate,
                    CanBlock = model.CanBlock,
                };
                _dbContext.AppMenu.Add(newAppMenu);
                await _dbContext.SaveChangesAsync();
            }

            ViewBag.Message = "Added a new Feature";
            return RedirectToAction("IndexFeature");
        }

        [HttpGet("{featureid}")]
        public IActionResult DeleteFeature(string featureid)
        {
            if (featureid == null)
            {
                return NotFound();
            }

            int id = int.Parse(featureid);
            var f = _dbContext.AppClaims.Where(c => c.Id == id).FirstOrDefault();
            if (f == null)
            {
                return NotFound();
            }

            return View((object)f);
        }

        [HttpPost("{featureid}")]
        public async Task<IActionResult> DeleteFeatureAsync(string featureid)
        {
            int id = int.Parse(featureid);
            var f = _dbContext.AppClaims.Where(c => c.Id == id).FirstOrDefault();
            if (f != null)
            {
                _dbContext.AppClaims.Remove(f);
                int res = await _dbContext.SaveChangesAsync();
            }
            else
            {
                return NotFound();
            }
            StatusMessage = "Deleted successfully !";
            return RedirectToAction("IndexFeature");
        }

        [HttpGet("{featureid}")]
        public IActionResult EditFeature(string featureid)
        {
            int id = int.Parse(featureid);
            var f = _dbContext.AppClaims.Where(c => c.Id == id).FirstOrDefault();

            if (f == null)
            {
                return NotFound();
            }
            else
            {
                var menu = _dbContext.AppMenu.Where(a => a.ClaimId == id).FirstOrDefault();
                if (menu == null)
                {
                    return View();
                }
                else
                {
                    EditFeatureViewModel ef = new EditFeatureViewModel()
                    {
                        Feature = f.ClaimName,
                        CanView = menu.CanView,
                        CanCreate = menu.CanCreate,
                        CanDelete = menu.CanDelete,
                        CanBlock = menu.CanBlock,
                        CanUpdate = menu.CanUpdate,
                    };
                    return View((object)ef);
                }
            }

        }

        [HttpPost("{featureid}")]
        public async Task<IActionResult> EditFeatureAsync(string featureid, [Bind("Feature, CanView, CanCreate, CanUpdate, CanDelete, CanBlock")] EditFeatureViewModel model)
        {
            int id = int.Parse(featureid);
            var f = _dbContext.AppClaims.Where(c => c.Id == id).FirstOrDefault();

            if (f == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                return NotFound(ModelState);
            }
            var fname = _dbContext.AppClaims.Where(c => c.ClaimName == model.Feature).FirstOrDefault();
            if (fname != null && fname.ClaimName != f.ClaimName)
            {
                ViewBag.Message = "This feature is already existed !";
                return View();
            }

            f.ClaimName = model.Feature;
            _dbContext.AppClaims.Update(f);

            var appMenu = _dbContext.AppMenu.Where(m => m.ClaimId == f.Id).FirstOrDefault();

            if (appMenu != null)
            {
                appMenu.CanView = model.CanView;
                appMenu.CanDelete = model.CanDelete;
                appMenu.CanUpdate = model.CanUpdate;
                appMenu.CanCreate = model.CanCreate;
                appMenu.CanBlock = model.CanBlock;
                _dbContext.AppMenu.Update(appMenu);
            }
            else
            {
                AppMenu newAppMenu = new AppMenu()
                {
                    ClaimId = f.Id,
                    CanView = model.CanView,
                    CanDelete = model.CanDelete,
                    CanUpdate = model.CanUpdate,
                    CanCreate = model.CanCreate,
                    CanBlock = model.CanBlock,
                };
                _dbContext.AppMenu.Add(newAppMenu);
            }

            var result = await _dbContext.SaveChangesAsync();
            if (result != 0)
            {
                StatusMessage = "Updated Successfully !";
            }
            return RedirectToAction("IndexFeature");

        }
    }
}