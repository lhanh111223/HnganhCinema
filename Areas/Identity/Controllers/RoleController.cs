// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.Linq;
using System.Security.Claims;
using HnganhCinema.Areas.Identity.Models.Role;
using HnganhCinema.Areas.Identity.Models.RoleViewModels;
using HnganhCinema.Data;
using HnganhCinema.ExtendMethods;
using HnganhCinema.Helper;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Bcpg.Sig;

namespace HnganhCinema.Areas.Identity.Controllers
{

    //[Authorize(Roles = RoleName.Administrator)]
    [Area("Identity")]
    [Route("/Role/[action]")]
    public class RoleController : Controller
    {

        private readonly ILogger<RoleController> _logger;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        [TempData]
        public string StatusMessage { get; set; }
        private static AppUser CurrentUser;
        public RoleController(ILogger<RoleController> logger, RoleManager<IdentityRole> roleManager, CinemaDbContext context, UserManager<AppUser> userManager
            , AuthenticateHelper auth)
        {
            _logger = logger;
            _roleManager = roleManager;
            _context = context;
            _userManager = userManager;
            _auth = auth;

        }



        // GET: /Role/Index
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Roles", "View"))
            {
                return View("AccessDenied");
            }

            var r = await _roleManager.Roles.OrderBy(r => r.Name).ToListAsync();
            var roles = new List<RoleModel>();
            foreach (var _r in r)
            {
                var claims = await _roleManager.GetClaimsAsync(_r);
                var claimsString = claims.Select(c => c.Type + "=" + c.Value);

                var rm = new RoleModel()
                {
                    Name = _r.Name,
                    Id = _r.Id,
                    Claims = claimsString.ToArray()
                };
                roles.Add(rm);
            }

            return View(roles);
        }
        [HttpGet]
        public async Task<IActionResult> GetAllRoles()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            return Json(roles);
        }



        // GET: /Role/Create
        [HttpGet]
        public IActionResult Create()
        {
            var featureList = _context.AppClaims.Select(f => new SelectListItem
            {
                Value = f.Id.ToString(),
                Text = f.ClaimName
            }).ToList();


            ViewBag.allFeature = featureList;
            return View();
        }

        // POST: /Role/Create
        [HttpPost, ActionName(nameof(Create))]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateAsync(AddRoleAppClaim model)
        {

            if (!ModelState.IsValid)
            {
                return View();
            }

            var newRole = new IdentityRole(model.Name);
            var result = await _roleManager.CreateAsync(newRole);
            if (result.Succeeded)
            {
                StatusMessage = $"Created role: '{model.Name}' successfully !";

                if (model.Features?.Length > 0 || model.Features != null)
                {
                    foreach (var featureid in model.Features)
                    {
                        await _context.AddToRoleClaims(newRole.Id, int.Parse(featureid));
                    }
                }

                return RedirectToAction(nameof(Index));
            }
            else
            {
                ModelState.AddModelError(result);
            }
            return View();
        }

        // GET: /Role/Delete/roleid
        [HttpGet("{roleid}")]
        public async Task<IActionResult> DeleteAsync(string roleid)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }
            return View((object)role);
        }

        [HttpPost("{roleid}"), ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmAsync(string roleid)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null) return NotFound("Not found ROLE ");

            var result = await _roleManager.DeleteAsync(role);

            if (result.Succeeded)
            {
                StatusMessage = $"Deleted: {role.Name}";
                return RedirectToAction(nameof(Index));
            }
            else
            {
                ModelState.AddModelError(result);
            }
            return View(role);
        }

        // GET: /Role/Edit/roleid
        [HttpGet("{roleid}")]
        public async Task<IActionResult> EditAsync(string roleid, [Bind("Name")] EditRoleModel model)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }
            model.Name = role.Name;
            model.Claims = await _context.RoleClaims.Where(rc => rc.RoleId == role.Id).ToListAsync();

            model.Features = await _context.AppRoleClaims
                                .Where(feature => feature.RoleId == role.Id)
                                .Select(feature => feature.ClaimId.ToString())
                                .ToArrayAsync<string>();

            //model.Features = _context.AppRoleClaims.Select(rc => rc.ClaimId.ToString).Where(rc => rc.RoleId == roleid).ToArray();

            var featureList = _context.AppClaims.Select(f => new SelectListItem
            {
                Value = f.Id.ToString(),
                Text = f.ClaimName
            }).ToList();


            ViewBag.allFeature = featureList;

            model.role = role;
            ModelState.Clear();
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> GetClaim([FromQuery] string roleid)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }

            var Claims = await _context.RoleClaims.Where(rc => rc.RoleId == role.Id).ToListAsync();
            return Json(Claims);
        }

        // POST: /Role/Edit/1
        [HttpPost("{roleid}"), ActionName("Edit")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditConfirmAsync(string roleid, [Bind("Name, Features")] EditRoleModel model)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }
            model.Claims = await _context.RoleClaims.Where(rc => rc.RoleId == role.Id).ToListAsync();
            model.role = role;
            if (!ModelState.IsValid)
            {
                foreach (var modelState in ModelState.Values)
                {
                    foreach (var error in modelState.Errors)
                    {
                        _logger.LogError($"Error: {error.ErrorMessage}");
                    }
                }
                return View(model);
            }

            role.Name = model.Name;
            var result = await _roleManager.UpdateAsync(role);
            var roleClaimsDelete = _context.AppRoleClaims.Where(rc => rc.RoleId == roleid).ToList();
            _context.AppRoleClaims.RemoveRange(roleClaimsDelete);
            if (model.Features != null)
            {
                foreach (var featureid in model.Features)
                {
                    await _context.AddToRoleClaims(roleid, int.Parse(featureid));
                }
            }
            if (result.Succeeded)
            {
                StatusMessage = $"Update uccessful for: {model.Name}";
                return RedirectToAction(nameof(Index));
            }
            else
            {
                ModelState.AddModelError(result);
            }

            if (model?.Features?.Length > 0)
            {
                foreach (var feature in model.Features)
                {
                    var addFeature = new AppRoleClaim
                    {
                        RoleId = role.Id,
                        ClaimValue = feature,
                    };
                }
            }
            return View(model);
        }

        // GET: /Role/AddRoleClaim/roleid
        [HttpGet("{roleid}")]
        public async Task<IActionResult> AddRoleClaimAsync(string roleid)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }

            var model = new EditClaimModel()
            {
                role = role
            };
            return View(model);
        }

        // POST: /Role/AddRoleClaim/roleid
        [HttpPost("{roleid}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddRoleClaimAsync(string roleid, [Bind("ClaimType", "ClaimValue")] EditClaimModel model)
        {
            if (roleid == null) return NotFound("Not found ROLE");
            var role = await _roleManager.FindByIdAsync(roleid);
            if (role == null)
            {
                return NotFound("Not found ROLE");
            }
            model.role = role;
            if (!ModelState.IsValid) return View(model);


            if ((await _roleManager.GetClaimsAsync(role)).Any(c => c.Type == model.ClaimType && c.Value == model.ClaimValue))
            {
                ModelState.AddModelError(string.Empty, "This claim is already existed in this Role");
                return View(model);
            }

            var newClaim = new Claim(model.ClaimType, model.ClaimValue);
            var result = await _roleManager.AddClaimAsync(role, newClaim);

            if (!result.Succeeded)
            {
                ModelState.AddModelError(result);
                return View(model);
            }

            StatusMessage = "Created successfully !";

            return RedirectToAction("Edit", new { roleid = role.Id });

        }

        // GET: /Role/EditRoleClaim/claimid
        [HttpGet("{claimid:int}")]
        public async Task<IActionResult> EditRoleClaim(int claimid)
        {
            var claim = _context.RoleClaims.Where(c => c.Id == claimid).FirstOrDefault();
            if (claim == null) return NotFound("Not found ROLE");

            var role = await _roleManager.FindByIdAsync(claim.RoleId);
            if (role == null) return NotFound("Not found ROLE");
            ViewBag.claimid = claimid;

            var Input = new EditClaimModel()
            {
                ClaimType = claim.ClaimType,
                ClaimValue = claim.ClaimValue,
                role = role
            };


            return View(Input);
        }

        // GET: /Role/EditRoleClaim/claimid
        [HttpPost("{claimid:int}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditRoleClaim(int claimid, [Bind("ClaimType", "ClaimValue")] EditClaimModel Input)
        {
            var claim = _context.RoleClaims.Where(c => c.Id == claimid).FirstOrDefault();
            if (claim == null) return NotFound("Not found ROLE");

            ViewBag.claimid = claimid;

            var role = await _roleManager.FindByIdAsync(claim.RoleId);
            if (role == null) return NotFound("Not found ROLE");
            Input.role = role;
            if (!ModelState.IsValid)
            {
                return View(Input);
            }
            if (_context.RoleClaims.Any(c => c.RoleId == role.Id && c.ClaimType == Input.ClaimType && c.ClaimValue == Input.ClaimValue && c.Id != claim.Id))
            {
                ModelState.AddModelError(string.Empty, "This claim is already existed in Role");
                return View(Input);
            }


            claim.ClaimType = Input.ClaimType;
            claim.ClaimValue = Input.ClaimValue;

            await _context.SaveChangesAsync();

            StatusMessage = "This claim has been updated successfully !";

            return RedirectToAction("Edit", new { roleid = role.Id });
        }
        // POST: /Role/EditRoleClaim/claimid
        [HttpPost("{claimid:int}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteClaim(int claimid, [Bind("ClaimType", "ClaimValue")] EditClaimModel Input)
        {
            var claim = _context.RoleClaims.Where(c => c.Id == claimid).FirstOrDefault();
            if (claim == null) return NotFound("Not found ROLE");

            var role = await _roleManager.FindByIdAsync(claim.RoleId);
            if (role == null) return NotFound("Not found ROLE");
            Input.role = role;
            if (!ModelState.IsValid)
            {
                return View(Input);
            }
            if (_context.RoleClaims.Any(c => c.RoleId == role.Id && c.ClaimType == Input.ClaimType && c.ClaimValue == Input.ClaimValue && c.Id != claim.Id))
            {
                ModelState.AddModelError(string.Empty, "This claim is already existed in Role");
                return View(Input);
            }


            await _roleManager.RemoveClaimAsync(role, new Claim(claim.ClaimType, claim.ClaimValue));

            StatusMessage = "Deleted claim successfully !";


            return RedirectToAction("Edit", new { roleid = role.Id });
        }


    }
}
