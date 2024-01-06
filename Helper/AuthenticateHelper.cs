using HnganhCinema.Models;

namespace HnganhCinema.Helper
{
    public class AuthenticateHelper
    {
        private readonly ILogger<AuthenticateHelper> _logger;
        private readonly CinemaDbContext _context;
        public AuthenticateHelper(ILogger<AuthenticateHelper> logger, CinemaDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        public bool CanAccess(string UserId, string Feature, string ActionName)
        {
            var result = (from uf in _context.UserFeatures
                          join ac in _context.AppClaims on uf.ClaimId equals ac.Id
                          where uf.UserId == UserId && ac.ClaimName == Feature
                          select new
                          {
                              CanView = uf.CanView,
                              CanCreate = uf.CanCreate,
                              CanUpdate = uf.CanUpdate,
                              CanDelete = uf.CanDelete,
                              CanBlock = uf.CanBlock,
                          }
                          ).FirstOrDefault();

            if (result == null)
            {
                return false;
            }
            else
            {
                if (ActionName == "View")
                    return result.CanView;
                else if (ActionName == "Create")
                    return result.CanCreate;
                else if(ActionName == "Update")
                    return result.CanUpdate;
                else if(ActionName =="Delete")
                    return result.CanDelete;
                else if(ActionName == "Block")
                    return result.CanBlock;
            }

            return false;
        }
    }
}
