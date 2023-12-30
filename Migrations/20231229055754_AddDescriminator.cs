using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HnganhCinema.Migrations
{
    public partial class AddDescriminator : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "RoleClaims",
                type: "nvarchar(max)",
                nullable: false
                );
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
