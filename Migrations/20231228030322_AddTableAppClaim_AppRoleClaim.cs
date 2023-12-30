using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HnganhCinema.Migrations
{
    public partial class AddTableAppClaim_AppRoleClaim : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ClaimId",
                table: "RoleClaims",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "RoleClaims",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "AppClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ClaimName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AppClaims", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_RoleClaims_ClaimId",
                table: "RoleClaims",
                column: "ClaimId");

            migrationBuilder.AddForeignKey(
                name: "FK_RoleClaim_Claim",
                table: "RoleClaims",
                column: "ClaimId",
                principalTable: "AppClaims",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_RoleClaim_Claim",
                table: "RoleClaims");

            migrationBuilder.DropTable(
                name: "AppClaims");

            migrationBuilder.DropIndex(
                name: "IX_RoleClaims_ClaimId",
                table: "RoleClaims");

            migrationBuilder.DropColumn(
                name: "ClaimId",
                table: "RoleClaims");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "RoleClaims");
        }
    }
}
