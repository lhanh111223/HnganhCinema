// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace HnganhCinema.Areas.Identity.Models.AccountViewModels
{
    public class SendCodeViewModel
    {
        [Key]
        public string? SelectedProvider { get; set; }

        public ICollection<SelectListItem>? Providers { get; set; }

        public string? ReturnUrl { get; set; }

        public bool? RememberMe { get; set; }
    }
}
