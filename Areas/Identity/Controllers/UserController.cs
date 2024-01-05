// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.Security.Claims;
using HnganhCinema.Areas.Identity.Models.UserViewModels;
using HnganhCinema.ExtendMethods;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace HnganhCinema.Areas.Identity.Controllers
{

    //[Authorize(Roles = "Administrator")]
    [Area("Identity")]
    [Route("/ManageUser/[action]")]
    public class UserController : Controller
    {

        private readonly ILogger<RoleController> _logger;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;

        private readonly UserManager<AppUser> _userManager;

        public UserController(ILogger<RoleController> logger, RoleManager<IdentityRole> roleManager, CinemaDbContext context, UserManager<AppUser> userManager)
        {
            _logger = logger;
            _roleManager = roleManager;
            _context = context;
            _userManager = userManager;
        }



        [TempData]
        public string StatusMessage { get; set; }

        //
        // GET: /ManageUser/Index
        [HttpGet]

        public async Task<IActionResult> Index([FromQuery(Name = "p")] int currentPage)
        {
            var model = new UserListModel();
            model.currentPage = currentPage;

            var qr = _userManager.Users.OrderBy(u => u.UserName);

            model.totalUsers = await qr.CountAsync();
            model.countPages = (int)Math.Ceiling((double)model.totalUsers / model.ITEMS_PER_PAGE);

            if (model.currentPage < 1)
                model.currentPage = 1;
            if (model.currentPage > model.countPages)
                model.currentPage = model.countPages;

            var qr1 = qr.Skip((model.currentPage - 1) * model.ITEMS_PER_PAGE)
                        .Take(model.ITEMS_PER_PAGE)
                        .Select(u => new UserAndRole()
                        {
                            Id = u.Id,
                            UserName = u.UserName,
                        });

            model.users = await qr1.ToListAsync();

            foreach (var user in model.users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                user.RoleNames = string.Join(",", roles);
            }

            return View(model);
        }

        // GET: /ManageUser/AddRole/id
        [HttpGet("{id}")]
        public async Task<IActionResult> AddRoleAsync(string id)
        {
            var model = new AddUserRoleModel();
            if (string.IsNullOrEmpty(id))
            {
                return NotFound($"Không có user");
            }

            model.user = await _userManager.FindByIdAsync(id);

            if (model.user == null)
            {
                return NotFound($"Không thấy user, id = {id}.");
            }

            model.RoleNames = (await _userManager.GetRolesAsync(model.user)).ToArray<string>();

            //Danh sách các role của hệ thống
            List<string> roleNames = await _roleManager.Roles.Select(r => r.Name).ToListAsync();
            ViewBag.allRoles = new SelectList(roleNames);

            //Get claim of user logged in
            var claimOfUsers = (from ur in _context.UserRoles
                                join rc in _context.AppRoleClaims on ur.RoleId equals rc.RoleId
                                join ac in _context.AppClaims on rc.ClaimId equals ac.Id
                                where ur.UserId == id
                                select ac)
                                          .Distinct()
                                          .ToList();
            _logger.LogError("claim of user: " + claimOfUsers.Count);

            // Những Claim(Features) đã có sẵn trong bảng UserFeatures
            var userFeatures = _context.UserFeatures.Where(uf => uf.UserId == id).ToList();

            // Thêm vào List trong model để đẩy lên View
            List<AppClaimModel> appClaimModel = new List<AppClaimModel>();
            foreach (var claim in claimOfUsers)
            {
                bool flag = false;
                foreach (var feature in userFeatures)
                {
                    if (claim.Id == feature.ClaimId && feature.UserId == id)
                    {
                        AppClaimModel added = new AppClaimModel()
                        {
                            Claim = feature.AppClaim,
                            Id = feature.ClaimId,
                            CanView = feature.CanView,
                            CanCreate = feature.CanCreate,
                            CanUpdate = feature.CanUpdate,
                            CanDelete = feature.CanDelete,
                            CanBlock = feature.CanBlock,
                        };
                        appClaimModel.Add(added);
                        flag = true;
                        break;
                    }
                    else
                    {
                        flag = false;
                    }
                }

                if (flag == false)
                {
                    AppClaimModel added = new AppClaimModel()
                    {
                        Claim = claim,
                        Id = claim.Id,
                        CanView = false,
                        CanCreate = false,
                        CanUpdate = false,
                        CanDelete = false,
                        CanBlock = false,
                    };
                    appClaimModel.Add(added);

                }

            }

            model.Claims = appClaimModel;

            // Menu của từng Claim(Feature) 
            model.Menu = (from ur in _context.UserRoles
                          join r in _context.Roles on ur.RoleId equals r.Id
                          join rc in _context.AppRoleClaims on r.Id equals rc.RoleId
                          join ac in _context.AppClaims on rc.ClaimId equals ac.Id
                          join am in _context.AppMenu on ac.Id equals am.ClaimId
                          where ur.UserId == id
                          select am)
                                    .Distinct()
                                    .ToList();

            return View(model);
        }


        // POST: /ManageUser/AddRole/id
        [HttpPost("{id}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddRoleAsync(string id, [Bind("RoleNames, Claims")] AddUserRoleModel model)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound($"Không có user");
            }

            model.user = await _userManager.FindByIdAsync(id);

            if (model.user == null)
            {
                return NotFound($"Không thấy user, id = {id}.");
            }


            if (model.RoleNames == null)
            {
                model.RoleNames = new string[] { };
                var deleted = _context.UserFeatures.Where(uf => uf.UserId == id).ToList();
                _context.UserFeatures.RemoveRange(deleted);
            }
            var OldRoleNames = (await _userManager.GetRolesAsync(model.user)).ToArray();

            var deleteRoles = OldRoleNames.Where(r => !model.RoleNames.Contains(r));
            var addRoles = model.RoleNames.Where(r => !OldRoleNames.Contains(r));
            var resultDelete = await _userManager.RemoveFromRolesAsync(model.user, deleteRoles);
            if (!resultDelete.Succeeded)
            {
                ModelState.AddModelError(resultDelete);
                return View(model);
            }

            var resultAdd = await _userManager.AddToRolesAsync(model.user, addRoles);
            if (!resultAdd.Succeeded)
            {
                ModelState.AddModelError(resultAdd);
                return View(model);
            }

            List<string> roleNames = await _roleManager.Roles.Select(r => r.Name).ToListAsync();

            ViewBag.allRoles = new SelectList(roleNames);

            if (model.Claims != null)
            {
                var deleted = _context.UserFeatures.Where(uf => uf.UserId == id).ToList();
                _context.UserFeatures.RemoveRange(deleted);
                foreach (var i in model.Claims)
                {
                    UserFeature uf = new UserFeature()
                    {
                        UserId = id,
                        ClaimId = i.Id,
                        CanView = i.CanView,
                        CanCreate = i.CanCreate,
                        CanUpdate = i.CanUpdate,
                        CanDelete = i.CanDelete,
                        CanBlock = i.CanBlock,
                    };
                    _context.UserFeatures.Add(uf);
                }
                _context.SaveChanges();
            }

            StatusMessage = $"Updated successful for the role: {model.user.UserName}";
            return RedirectToAction("Index");
        }



        [HttpGet("{id}")]
        public async Task<IActionResult> SetPasswordAsync(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound($"Không có user");
            }

            var user = await _userManager.FindByIdAsync(id);
            ViewBag.user = ViewBag;

            if (user == null)
            {
                return NotFound($"Không thấy user, id = {id}.");
            }

            return View();
        }

        [HttpPost("{id}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SetPasswordAsync(string id, SetUserPasswordModel model)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound($"Không có user");
            }

            var user = await _userManager.FindByIdAsync(id);
            ViewBag.user = ViewBag;

            if (user == null)
            {
                return NotFound($"Không thấy user, id = {id}.");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            await _userManager.RemovePasswordAsync(user);

            var addPasswordResult = await _userManager.AddPasswordAsync(user, model.NewPassword);
            if (!addPasswordResult.Succeeded)
            {
                foreach (var error in addPasswordResult.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }
                return View(model);
            }

            StatusMessage = $"Vừa cập nhật mật khẩu cho user: {user.UserName}";

            return RedirectToAction("Index");
        }


        [HttpGet("{userid}")]
        public async Task<ActionResult> AddClaimAsync(string userid)
        {

            var user = await _userManager.FindByIdAsync(userid);
            if (user == null) return NotFound("Không tìm thấy user");
            ViewBag.user = user;
            return View();
        }

        [HttpPost("{userid}")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> AddClaimAsync(string userid, AddUserClaimModel model)
        {

            var user = await _userManager.FindByIdAsync(userid);
            if (user == null) return NotFound("Không tìm thấy user");
            ViewBag.user = user;
            if (!ModelState.IsValid) return View(model);
            await _userManager.AddClaimAsync(user, new Claim(model.ClaimType, model.ClaimValue));
            StatusMessage = "Đã thêm đặc tính cho user";

            return RedirectToAction("AddRole", new { id = user.Id });
        }




    }
}
