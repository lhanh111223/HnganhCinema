﻿// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace HnganhCinema.Areas.Identity.Models.AccountViewModels
{
    public class ResetPasswordViewModel
    {
            [Required(ErrorMessage = "Must input {0}")]
            [EmailAddress(ErrorMessage="Invalid email format")]
            public string Email { get; set; }

            [Required(ErrorMessage = "Must input {0}")]
            [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
            [DataType(DataType.Password)]
            [Display(Name = "New Password")]
            public string Password { get; set; }

            [DataType(DataType.Password)]
            [Display(Name = "Confirm new password")]
            [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
            public string ConfirmPassword { get; set; }

            public string Code { get; set; }

    }
}
