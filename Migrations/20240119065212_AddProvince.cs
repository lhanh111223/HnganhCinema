using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HnganhCinema.Migrations
{
    public partial class AddProvince : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ProvinceId",
                table: "Cinemas",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Provinces",
                columns: table => new
                {
                    ProvinceId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProvinceName = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Provinces", x => x.ProvinceId);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Cinemas_ProvinceId",
                table: "Cinemas",
                column: "ProvinceId");

            migrationBuilder.AddForeignKey(
                name: "FK_Cinema_Province",
                table: "Cinemas",
                column: "ProvinceId",
                principalTable: "Provinces",
                principalColumn: "ProvinceId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Cinema_Province",
                table: "Cinemas");


            migrationBuilder.DropTable(
                name: "Provinces");

            migrationBuilder.DropIndex(
                name: "IX_Cinemas_ProvinceId",
                table: "Cinemas");

            migrationBuilder.DropColumn(
                name: "ProvinceId",
                table: "Cinemas");
        }
    }
}
