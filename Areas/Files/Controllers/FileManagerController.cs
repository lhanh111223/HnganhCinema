using Microsoft.AspNetCore.Mvc;

namespace HnganhCinema.Areas.Files.Controllers
{
    public class FileManagerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
