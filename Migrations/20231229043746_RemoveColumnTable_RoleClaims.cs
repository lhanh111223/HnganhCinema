using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HnganhCinema.Migrations
{
    public partial class RemoveColumnTable_RoleClaims : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            
            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "RoleClaims");
            
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
