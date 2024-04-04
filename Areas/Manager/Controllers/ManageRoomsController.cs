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
using HnganhCinema.Areas.Manager.Models.RoomViewModels;
using HnganhCinema.Data;
using Bogus;

namespace HnganhCinema.Areas.Manager.Controllers
{
    [Area("Manager")]
    [Route("/Manager/ManageRooms/[action]/{id?}")]
    public class ManageRoomsController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly CinemaDbContext _context;
        private readonly AuthenticateHelper _auth;
        private readonly UserManager<AppUser> _userManager;
        private static AppUser CurrentUser;
        private static char[] rowName = { '-', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
        public ManageRoomsController(CinemaDbContext context, RoleManager<IdentityRole> roleManager, AuthenticateHelper auth, UserManager<AppUser> userManager)
        {
            _context = context;
            _roleManager = roleManager;
            _auth = auth;
            _userManager = userManager;
        }

        // GET: Manager/ManageRooms
        public async Task<IActionResult> Index()
        {
            CurrentUser = _userManager.GetUserAsync(User).Result;
            if (CurrentUser == null || !_auth.CanAccess(CurrentUser.Id, "Manage Rooms", "View"))
            {
                return View("AccessDenied");
            }

            List<Province> provinces = _context.Provinces.ToList();
            ViewBag.provinceList = provinces;
            List<Cinema> cinemas = _context.Cinemas.ToList();
            ViewBag.cinemaList = cinemas;
            //provinces.Insert(0, new Province()
            //{
            //    ProvinceId = 0,
            //    ProvinceName = "All Provinces"
            //});
            //ViewBag.provinceList = new SelectList(provinces, "ProvinceId", "ProvinceName", 0);


            //cinemas.Insert(0, new Cinema()
            //{
            //    CinemaId = 0,
            //    Name = "All Cinemas"
            //});
            //ViewBag.cinemaList = new SelectList(cinemas, "CinemaId", "Name", 0);
            return View();
        }
        public async Task<IActionResult> GetData()
        {
            List<IndexRoomViewModel> listRooms = new List<IndexRoomViewModel>();
            var results = _context.Rooms.Include(r => r.Cinema).ToList().OrderBy(r=>r.CinemaId);
            foreach (var r in results)
            {
                listRooms.Add(new IndexRoomViewModel
                {
                    RoomId = r.RoomId,
                    RoomNo = r.RoomNo,
                    Type = r.Type,
                    Cinema = r.Cinema.Name,
                    Status = r.Status == 0 ? "Closed" : "Open",
                    CinemaId = r.Cinema.CinemaId,
                    ProvinceId = r.Cinema.ProvinceId
                });
            }
            return Json(new { data = listRooms });
        }

        // GET: Manager/ManageRooms/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Rooms == null)
            {
                return NotFound();
            }

            var room = await _context.Rooms
                .Include(r => r.Cinema)
                .FirstOrDefaultAsync(m => m.RoomId == id);
            if (room == null)
            {
                return NotFound();
            }

            return View(room);
        }

        // GET: Manager/ManageRooms/Create
        public IActionResult Create()
        {
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name");
            var statusList = Enum.GetValues(typeof(ENUM.RoomStatusEnum))
                        .Cast<ENUM.RoomStatusEnum>()
                        .Select((value, index) => new SelectListItem
                        {
                            Value = index.ToString(),
                            Text = value.ToString()
                        })
                        .ToList();
            ViewBag.Status = statusList;

            var typeList = Enum.GetValues(typeof(ENUM.MovieTypeEnum))
                                        .Cast<ENUM.MovieTypeEnum>()
                                        .Select((value) => new SelectListItem
                                        {
                                            Value = value.ToString().Substring(1),
                                            Text = value.ToString().Substring(1)
                                        })
                                        .ToList();
            ViewBag.Type = typeList;
            return View();
        }

        // POST: Manager/ManageRooms/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("RoomId,CinemaId,RoomNo,NumberRow,NumberCol,Type,Status,RowsVip")] CreateRoomViewModel model)
        {

            if (_context.Rooms.Any(r => r.CinemaId == model.CinemaId && r.RoomNo == model.RoomNo))
            {
                var statusList = Enum.GetValues(typeof(ENUM.RoomStatusEnum))
                        .Cast<ENUM.RoomStatusEnum>()
                        .Select((value, index) => new SelectListItem
                        {
                            Value = index.ToString(),
                            Text = value.ToString()
                        })
                        .ToList();
                ViewBag.Status = statusList;

                var typeList = Enum.GetValues(typeof(ENUM.MovieTypeEnum))
                                            .Cast<ENUM.MovieTypeEnum>()
                                            .Select((value) => new SelectListItem
                                            {
                                                Value = value.ToString().Substring(1),
                                                Text = value.ToString().Substring(1)
                                            })
                                            .ToList();
                ViewBag.Type = typeList;
                ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name");
                ViewData["ErrorMessage"] = "This room is already existed in this Cinema !";
                return View();
            }


            if (ModelState.IsValid)
            {
                // Add room
                var room = new Room()
                {
                    CinemaId = model.CinemaId,
                    RoomNo = model.RoomNo,
                    NumberRow = model.NumberRow,
                    NumberCol = model.NumberCol,
                    Type = model.Type,
                    Status = model.Status,
                    RowsVip = model.RowsVip,
                };
                _context.Rooms.Add(room);
                _context.SaveChanges();

                // Add Seats
                for (int i = 1; i <= room.NumberRow; i++)
                {
                    for (int j = 1; j <= room.NumberCol; j++)
                    {
                        Seat seat = new Seat();
                        seat.RoomId = room.RoomId;
                        seat.SeatName = (rowName[i] + "" + j);

                        if (model.RowsVip != null)
                        {
                            if (model.RowsVip.Contains(i.ToString()))
                            {
                                // Rows seat Vip
                                if (room.Type == "2D")      // 2D
                                    seat.PriceId = 3;
                                else if (room.Type == "3D")  // 3D
                                    seat.PriceId = 1;
                            }
                            else
                            {
                                if (room.Type == "2D")      // 2D
                                    seat.PriceId = 4;
                                else if (room.Type == "3D")  // 3D
                                    seat.PriceId = 2;
                            }
                        }
                        else
                        {
                            if (room.Type == "2D")      // 2D
                                seat.PriceId = 4;
                            else if (room.Type == "3D")  // 3D
                                seat.PriceId = 2;
                        }
                        _context.Seats.Add(seat);
                    }
                }
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name", model.CinemaId);
            return View(model);
        }

        // GET: Manager/ManageRooms/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Rooms == null)
            {
                return NotFound();
            }

            var room = await _context.Rooms.FindAsync(id);
            if (room == null)
            {
                return NotFound();
            }

            var statusList = Enum.GetValues(typeof(ENUM.RoomStatusEnum))
                        .Cast<ENUM.RoomStatusEnum>()
                        .Select((value, index) => new SelectListItem
                        {
                            Value = index.ToString(),
                            Text = value.ToString()
                        })
                        .ToList();
            ViewBag.Status = statusList;

            var typeList = Enum.GetValues(typeof(ENUM.MovieTypeEnum))
                                        .Cast<ENUM.MovieTypeEnum>()
                                        .Select((value) => new SelectListItem
                                        {
                                            Value = value.ToString().Substring(1),
                                            Text = value.ToString().Substring(1)
                                        })
                                        .ToList();
            ViewBag.Type = typeList;


            var model = new EditRoomViewModel()
            {
                RoomId = room.RoomId,
                CinemaId = room.CinemaId,
                RoomNo = room.RoomNo,
                NumberRow = room.NumberRow,
                NumberCol = room.NumberCol,
                Type = room.Type,
                Status = room.Status,
                RowsVip = room.RowsVip,
            };

            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Name", room.CinemaId);
            return View(model);
        }

        // POST: Manager/ManageRooms/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("RoomId,CinemaId,RoomNo,NumberRow,NumberCol,Type,Status,RowsVip")] EditRoomViewModel model)
        {
            var room = _context.Rooms.Find(model.RoomId);

            if (id != model.RoomId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {

                    room.Type = model.Type;
                    room.Status = model.Status;

                    // xóa hết ghế cũ và update ghế mới khi số lượng rol, col thay đổi
                    if (model.NumberCol != room.NumberCol || model.NumberRow != room.NumberRow /*|| model.RowsVip != room.RowsVip*/)
                    {
                        room.NumberCol = model.NumberCol;
                        room.NumberRow = model.NumberRow;
                        _context.Seats.RemoveRange(_context.Seats.Where(s => s.RoomId == model.RoomId));
                        // Add Seats
                        for (int i = 1; i <= model.NumberRow; i++)
                        {
                            for (int j = 1; j <= model.NumberCol; j++)
                            {
                                Seat seat = new Seat();
                                seat.RoomId = room.RoomId;
                                seat.SeatName = (rowName[i] + "" + j);

                                if (model.RowsVip != null)
                                {
                                    if (model.RowsVip.Contains(i.ToString()))
                                    {
                                        // Rows seat Vip
                                        if (room.Type == "2D")      // 2D
                                            seat.PriceId = 3;
                                        else if (room.Type == "3D")  // 3D
                                            seat.PriceId = 1;
                                    }
                                    else
                                    {
                                        if (room.Type == "2D")      // 2D
                                            seat.PriceId = 4;
                                        else if (room.Type == "3D")  // 3D
                                            seat.PriceId = 2;
                                    }
                                }
                                else
                                {
                                    if (room.Type == "2D")      // 2D
                                        seat.PriceId = 4;
                                    else if (room.Type == "3D")  // 3D
                                        seat.PriceId = 2;
                                }
                                _context.Seats.Add(seat);
                            }
                        }
                    }
                    else
                    {
                        if (model.RowsVip != null && model.RowsVip != room.RowsVip)
                        {
                            for (int i = 1; i <= model.NumberRow; i++)
                            {
                                for (int j = 1; j <= model.NumberCol; j++)
                                {
                                    Seat seat = _context.Seats.Where(s => s.SeatName == (rowName[i] + "" + j)).FirstOrDefault();

                                    if (model.RowsVip.Contains(i.ToString()))
                                    {
                                        // Rows seat Vip
                                        if (room.Type == "2D")      // 2D
                                            seat.PriceId = 3;
                                        else if (room.Type == "3D")  // 3D
                                            seat.PriceId = 1;
                                    }
                                    else
                                    {
                                        if (room.Type == "2D")      // 2D
                                            seat.PriceId = 4;
                                        else if (room.Type == "3D")  // 3D
                                            seat.PriceId = 2;
                                    }
                                    room.RowsVip = model.RowsVip;
                                    _context.Seats.Update(seat);
                                }
                            }
                        }
                    }
                    _context.Update(room);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RoomExists(model.RoomId))
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
            ViewData["CinemaId"] = new SelectList(_context.Cinemas, "CinemaId", "Address", room.CinemaId);
            return View(model);
        }

        // GET: Manager/ManageRooms/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Rooms == null)
            {
                return NotFound();
            }

            var room = await _context.Rooms
                .Include(r => r.Cinema)
                .FirstOrDefaultAsync(m => m.RoomId == id);
            if (room == null)
            {
                return NotFound();
            }

            return View(room);
        }

        // POST: Manager/ManageRooms/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Rooms == null)
            {
                return Problem("Entity set 'CinemaDbContext.Rooms'  is null.");
            }
            var room = await _context.Rooms.FindAsync(id);
            if (room != null)
            {
                _context.Rooms.Remove(room);
            }

            var result = await _context.SaveChangesAsync();
            if (result == 0)
            {
                return Content("Error to Delete");
            }
            return RedirectToAction(nameof(Index));
        }

        private bool RoomExists(int id)
        {
            return (_context.Rooms?.Any(e => e.RoomId == id)).GetValueOrDefault();
        }
    }
}
