// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using HnganhCinema.Models;
using Microsoft.AspNetCore.Identity;

namespace HnganhCinema.Areas.Identity.Models.ManageViewModels
{
    public class IndexViewModel
    {
        public EditExtraProfileModel? profile { get; set; }
        public bool HasPassword { get; set; }

        public IList<UserLoginInfo>? Logins { get; set; }

        public string? PhoneNumber { get; set; }

        public bool TwoFactor { get; set; }

        public bool BrowserRemembered { get; set; } = true;

        public string? AuthenticatorKey { get; set; }

        [DataType(DataType.Upload)]
        [FileExtensions(Extensions = "png,jpg,jpeg")]
        public IFormFile Avatar { get; set; }

        public string? CurrentUserAvatar { get; set; }
    }
}
