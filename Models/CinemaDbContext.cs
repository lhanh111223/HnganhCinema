using CinemaWeb.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Bcpg.Sig;
using System.Security.Principal;

namespace HnganhCinema.Models
{
    public class CinemaDbContext : IdentityDbContext<AppUser>
    {
        public CinemaDbContext(DbContextOptions<CinemaDbContext> options) : base(options)
        {
        }

        public virtual DbSet<AccountCinema> AccountCinemas { get; set; } = null!;
        public virtual DbSet<Actor> Actors { get; set; } = null!;
        public virtual DbSet<Booking> Bookings { get; set; } = null!;
        public virtual DbSet<Cinema> Cinemas { get; set; } = null!;
        public virtual DbSet<Gerne> Gernes { get; set; } = null!;
        public virtual DbSet<Movie> Movies { get; set; } = null!;
        public virtual DbSet<MovieActor> MovieActors { get; set; } = null!;
        public virtual DbSet<MovieGerne> MovieGernes { get; set; } = null!;
        public virtual DbSet<Price> Prices { get; set; } = null!;
        public virtual DbSet<Room> Rooms { get; set; } = null!;
        public virtual DbSet<Seat> Seats { get; set; } = null!;
        public virtual DbSet<Showtime> Showtimes { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder builder)
        {
            base.OnConfiguring(builder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                var tableName = entityType.GetTableName();
                if (tableName.StartsWith("AspNet"))
                {
                    entityType.SetTableName(tableName.Substring(6));
                }
            }

            // Setting DB
            modelBuilder.Entity<MovieActor>(entity =>
            {
                entity.HasOne(d => d.Actor)
                    .WithMany(p => p.MovieActors)
                    .HasForeignKey(d => d.ActorId)
                    .HasConstraintName("FK_MovieActor_Actor");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.MovieActors)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK_MovieActor_Movie");
            });

            modelBuilder.Entity<MovieGerne>(entity =>
            {
                entity.ToTable("MovieGerne");

                entity.HasOne(d => d.Gerne)
                    .WithMany(p => p.MovieGernes)
                    .HasForeignKey(d => d.GerneId)
                    .HasConstraintName("FK_MovieGerne_Gerne");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.MovieGernes)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK_MovieGerne_Movie");
            });

            modelBuilder.Entity<AccountCinema>(entity =>
            {
                entity.ToTable("AccountCinema");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.AccountCinemas)
                    .HasForeignKey(d => d.AccountId)
                    .HasConstraintName("FK_AccountCinema_Account");

                entity.HasOne(d => d.Cinema)
                    .WithMany(p => p.AccountCinemas)
                    .HasForeignKey(d => d.CinemaId)
                    .HasConstraintName("FK_AccountCinema_Cinema");
            });

            modelBuilder.Entity<Room>(entity =>
            {
                entity.ToTable("Room");

                entity.HasOne(d => d.Cinema)
                    .WithMany(p => p.Rooms)
                    .HasForeignKey(d => d.CinemaId)
                    .HasConstraintName("FK_Room_Cinema");
            });

            modelBuilder.Entity<Booking>(entity =>
            {
                entity.ToTable("Booking");

                entity.Property(e => e.Amount).HasColumnType("money");

                entity.Property(e => e.BookingDate).HasColumnType("date");

                entity.Property(e => e.Price).HasColumnType("money");

                entity.Property(e => e.Seats).HasMaxLength(255);

                entity.HasOne(d => d.Account)
                    .WithMany(p => p.Bookings)
                    .HasForeignKey(d => d.AccountId)
                    .HasConstraintName("FK_Booking_Account");

                entity.HasOne(d => d.Showtime)
                    .WithMany(p => p.Bookings)
                    .HasForeignKey(d => d.ShowtimeId)
                    .HasConstraintName("FK_Booking_Showtime");
            });

            modelBuilder.Entity<Seat>(entity =>
            {
                entity.ToTable("Seat");

                entity.HasOne(d => d.Price)
                    .WithMany(p => p.Seats)
                    .HasForeignKey(d => d.PriceId)
                    .HasConstraintName("FK_Seat_Price");

                entity.HasOne(d => d.Room)
                    .WithMany(p => p.Seats)
                    .HasForeignKey(d => d.RoomId)
                    .HasConstraintName("FK_Seat_Room");
            });

            modelBuilder.Entity<Showtime>(entity =>
            {
                entity.ToTable("Showtime");


                entity.Property(e => e.Status)
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.HasOne(d => d.Cinema)
                    .WithMany(p => p.Showtimes)
                    .HasForeignKey(d => d.CinemaId)
                    .HasConstraintName("FK_Showtime_Cinema");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Showtimes)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK_Showtime_Movie");

                entity.HasOne(d => d.Room)
                    .WithMany(p => p.Showtimes)
                    .HasForeignKey(d => d.RoomId)
                    .HasConstraintName("FK_Showtime_Room");
            });

        }
    }
}