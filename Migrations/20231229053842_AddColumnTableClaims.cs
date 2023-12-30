﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HnganhCinema.Migrations
{
    public partial class AddColumnTableClaims : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name:"ClaimType",
                table:"RoleClaims",
                type: "nvarchar(max)",
                nullable: true
                );
            migrationBuilder.AddColumn<string>(
                name: "ClaimValue",
                table: "RoleClaims",
                type: "nvarchar(max)",
                nullable: true
                );
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
