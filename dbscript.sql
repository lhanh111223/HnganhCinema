USE [zcinema]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountCinema]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountCinema](
	[AccountCinemaId] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [nvarchar](450) NULL,
	[CinemaId] [int] NULL,
 CONSTRAINT [PK_AccountCinema] PRIMARY KEY CLUSTERED 
(
	[AccountCinemaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actors]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actors](
	[ActorId] [int] IDENTITY(1,1) NOT NULL,
	[ActorName] [nvarchar](50) NOT NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK_Actors] PRIMARY KEY CLUSTERED 
(
	[ActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppClaims]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClaimName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AppClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppMenu]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClaimId] [int] NOT NULL,
	[CanView] [bit] NOT NULL,
	[CanCreate] [bit] NOT NULL,
	[CanUpdate] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[CanBlock] [bit] NOT NULL,
 CONSTRAINT [PK_AppMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [nvarchar](450) NULL,
	[ShowtimeId] [int] NULL,
	[Seats] [nvarchar](255) NULL,
	[Price] [money] NULL,
	[PointUsed] [float] NULL,
	[Amount] [money] NULL,
	[BookingDate] [date] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinemas]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cinemas](
	[CinemaId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](max) NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[Description] [ntext] NOT NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Cinemas] PRIMARY KEY CLUSTERED 
(
	[CinemaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gernes]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gernes](
	[GerneId] [int] IDENTITY(1,1) NOT NULL,
	[GerneName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gernes] PRIMARY KEY CLUSTERED 
(
	[GerneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieActors]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieActors](
	[MovieActorId] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NULL,
	[ActorId] [int] NULL,
 CONSTRAINT [PK_MovieActors] PRIMARY KEY CLUSTERED 
(
	[MovieActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieGerne]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieGerne](
	[MovieGerneId] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NULL,
	[GerneId] [int] NULL,
 CONSTRAINT [PK_MovieGerne] PRIMARY KEY CLUSTERED 
(
	[MovieGerneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [nvarchar](255) NULL,
	[Description] [ntext] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Time] [int] NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Status] [int] NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prices]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prices](
	[PriceId] [int] IDENTITY(1,1) NOT NULL,
	[PriceName] [nvarchar](50) NOT NULL,
	[UnitPrice] [money] NOT NULL,
 CONSTRAINT [PK_Prices] PRIMARY KEY CLUSTERED 
(
	[PriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimId] [int] NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[CinemaId] [int] NULL,
	[RoomNo] [int] NOT NULL,
	[NumberRow] [int] NOT NULL,
	[NumberCol] [int] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[SeatId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[SeatName] [nvarchar](10) NOT NULL,
	[PriceId] [int] NOT NULL,
 CONSTRAINT [PK_Seat] PRIMARY KEY CLUSTERED 
(
	[SeatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Showtime]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Showtime](
	[ShowtimeId] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NULL,
	[RoomId] [int] NULL,
	[CinemaId] [int] NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[SeatStatus] [nvarchar](max) NULL,
	[Status] [nchar](10) NULL,
 CONSTRAINT [PK_Showtime] PRIMARY KEY CLUSTERED 
(
	[ShowtimeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFeatures]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFeatures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimId] [int] NOT NULL,
	[CanView] [bit] NOT NULL,
	[CanCreate] [bit] NOT NULL,
	[CanUpdate] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[CanBlock] [bit] NOT NULL,
 CONSTRAINT [PK_UserFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](450) NOT NULL,
	[TotalPoint] [money] NULL,
	[PointSpent] [money] NULL,
	[TotalPayment] [money] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 1/5/2024 9:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231226093716_Init', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231226095408_SeedUsers', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231228030322_AddTableAppClaim_AppRoleClaim', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231229043746_RemoveColumnTable_RoleClaims', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231229045432_RollBackTable_UserClaims', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231229053842_AddColumnTableClaims', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231229055754_AddDescriminator', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231229063336_AddTable_Menu_Feature', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240105033620_AddImageToTable', N'6.0.24')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240105072930_EditTableMovie', N'6.0.24')
GO
SET IDENTITY_INSERT [dbo].[AppClaims] ON 

INSERT [dbo].[AppClaims] ([Id], [ClaimName]) VALUES (26, N'Manage Roles')
INSERT [dbo].[AppClaims] ([Id], [ClaimName]) VALUES (29, N'Manage Cinema')
INSERT [dbo].[AppClaims] ([Id], [ClaimName]) VALUES (31, N'Manage Movie')
INSERT [dbo].[AppClaims] ([Id], [ClaimName]) VALUES (32, N'Manage Members	')
SET IDENTITY_INSERT [dbo].[AppClaims] OFF
GO
SET IDENTITY_INSERT [dbo].[AppMenu] ON 

INSERT [dbo].[AppMenu] ([Id], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (4, 26, 1, 1, 1, 1, 0)
INSERT [dbo].[AppMenu] ([Id], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (7, 29, 1, 1, 1, 1, 0)
INSERT [dbo].[AppMenu] ([Id], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (9, 31, 1, 1, 1, 1, 0)
INSERT [dbo].[AppMenu] ([Id], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (10, 32, 1, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[AppMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([MovieId], [MovieName], [Description], [Type], [Time], [ReleaseDate], [EndDate], [Status], [Image]) VALUES (1, N'Spider Man - Far From Home', N'Following the events of Avengers: Endgame (2019), Spider-Man must step up to take on new threats in a world that has changed forever. Following the events of Avengers: Endgame (2019), Spider-Man must step up to take on new threats in a world that has changed forever.', N'2D', 124, CAST(N'2021-03-11' AS Date), CAST(N'2021-03-21' AS Date), 1, N'abc')
INSERT [dbo].[Movies] ([MovieId], [MovieName], [Description], [Type], [Time], [ReleaseDate], [EndDate], [Status], [Image]) VALUES (12, N'Spider Man 3', N'Hello', N'2D', 123, CAST(N'2021-03-11' AS Date), CAST(N'2021-03-21' AS Date), 1, N'abc')
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleClaims] ON 

INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (83, N'f26ab1b2-e564-4b61-b2cb-404722bb8320', 26, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (84, N'f26ab1b2-e564-4b61-b2cb-404722bb8320', 32, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (89, N'fc993dc4-380e-40a6-a3b7-ad7f3cece980', 26, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (90, N'fc993dc4-380e-40a6-a3b7-ad7f3cece980', 29, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (91, N'fc993dc4-380e-40a6-a3b7-ad7f3cece980', 31, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (92, N'fc993dc4-380e-40a6-a3b7-ad7f3cece980', 32, N'AppFeature', N'Feature', N'AppRoleClaim')
INSERT [dbo].[RoleClaims] ([Id], [RoleId], [ClaimId], [ClaimType], [ClaimValue], [Discriminator]) VALUES (94, N'8cadecc5-e592-4c44-b9e1-2106292bb5ef', 31, N'AppFeature', N'Feature', N'AppRoleClaim')
SET IDENTITY_INSERT [dbo].[RoleClaims] OFF
GO
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'8cadecc5-e592-4c44-b9e1-2106292bb5ef', N'Staff', N'STAFF', N'29565bbc-133d-4097-98d3-8d148589754e')
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'f26ab1b2-e564-4b61-b2cb-404722bb8320', N'Editor', N'EDITOR', N'95640667-bbc7-42c1-b969-5e554282619f')
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'fc993dc4-380e-40a6-a3b7-ad7f3cece980', N'Administrator', N'ADMINISTRATOR', N'5745ff66-7542-4c03-89e3-22e2c160ef5e')
GO
SET IDENTITY_INSERT [dbo].[UserFeatures] ON 

INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (153, N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', 26, 1, 1, 1, 1, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (154, N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', 29, 1, 1, 1, 1, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (155, N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', 31, 1, 1, 1, 1, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (156, N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', 32, 1, 1, 1, 1, 1)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (179, N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', 26, 1, 1, 1, 1, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (180, N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', 29, 0, 0, 0, 0, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (181, N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', 31, 0, 0, 0, 0, 0)
INSERT [dbo].[UserFeatures] ([Id], [UserId], [ClaimId], [CanView], [CanCreate], [CanUpdate], [CanDelete], [CanBlock]) VALUES (182, N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', 32, 1, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[UserFeatures] OFF
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', N'f26ab1b2-e564-4b61-b2cb-404722bb8320')
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', N'fc993dc4-380e-40a6-a3b7-ad7f3cece980')
GO
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'00098114-ff53-4a28-a3af-8beb12d949ec', NULL, NULL, NULL, N'User-110', NULL, N'email110@example.com', NULL, 1, NULL, N'3f112dd8-d3ba-465c-8db3-6fa91a47b631', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'005b2e55-631d-48de-a4db-2e74c033980a', NULL, NULL, NULL, N'User-014', NULL, N'email014@example.com', NULL, 1, NULL, N'19ca53d1-af68-4001-80cd-1a8148784205', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'02fe362c-f683-43c4-a7a9-57de7462e9b7', NULL, NULL, NULL, N'User-132', NULL, N'email132@example.com', NULL, 1, NULL, N'c8c64947-5f49-4854-be30-092c275aff8d', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'04bccf9e-ca2a-4061-95ea-f745baefec3c', NULL, NULL, NULL, N'User-124', NULL, N'email124@example.com', NULL, 1, NULL, N'6136360c-16de-49ca-b542-5a79d011d8c4', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'04eab6a2-d552-48de-a3e3-679a8ae0b57e', NULL, NULL, NULL, N'User-108', NULL, N'email108@example.com', NULL, 1, NULL, N'1b9eb077-28f9-4ece-90cf-034b1cdc5a6c', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'06d6df05-d471-4156-95b9-8366c056162e', NULL, NULL, NULL, N'User-032', NULL, N'email032@example.com', NULL, 1, NULL, N'7700323c-5f0f-45e5-8198-d2645497ef9a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'085a637c-ba9f-4e2f-bc47-16c0100f5401', NULL, NULL, NULL, N'User-006', NULL, N'email006@example.com', NULL, 1, NULL, N'fb9f21f4-fbc4-4a7d-8f98-67da20686199', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'09e89d40-67b2-41bf-9eed-3c0321ddd62e', NULL, NULL, NULL, N'User-060', NULL, N'email060@example.com', NULL, 1, NULL, N'c78d3de3-7a81-42a2-835c-c468e3f997ee', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'0def2c52-c0e9-4516-84db-d03b171e4cac', NULL, NULL, NULL, N'User-039', NULL, N'email039@example.com', NULL, 1, NULL, N'18ae3d27-f2fe-48bc-9e20-cd3195392bf0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1013902a-4e3f-4b06-b46c-ed878d23dada', NULL, NULL, NULL, N'User-064', NULL, N'email064@example.com', NULL, 1, NULL, N'6aeb9095-0609-43ea-b2bc-5def6da20d4d', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'116653a6-4809-46a3-93d6-70a48f80fff3', NULL, NULL, NULL, N'User-028', NULL, N'email028@example.com', NULL, 1, NULL, N'805654ac-3a6c-4618-854a-5ea9eacb781a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'12a137da-d74d-4296-ac2a-20518ca99ad5', NULL, NULL, NULL, N'User-083', NULL, N'email083@example.com', NULL, 1, NULL, N'450527c2-cf17-4730-88d6-c264e208d660', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1401409f-4915-424b-aff9-23f0da2c310f', NULL, NULL, NULL, N'User-106', NULL, N'email106@example.com', NULL, 1, NULL, N'6429068a-3bf4-4b5d-a35d-1cef562499a8', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'179f0a4e-bdcd-4b5e-8577-c4744da0f1a2', NULL, NULL, NULL, N'User-145', NULL, N'email145@example.com', NULL, 1, NULL, N'25cb4173-02b3-4a1f-b820-2a6a75891540', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'18d79747-2498-4338-bdf7-0c293d9ffaf1', NULL, NULL, NULL, N'User-085', NULL, N'email085@example.com', NULL, 1, NULL, N'c130124d-5a27-40e4-ac30-5bc4aca77148', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1a14ec52-558e-49cc-a372-7d18a135105f', NULL, NULL, NULL, N'User-111', NULL, N'email111@example.com', NULL, 1, NULL, N'bd644540-a579-4419-8efa-aedaefdef07f', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1c15c475-8f49-4138-9a0f-d74527931f4e', NULL, NULL, NULL, N'User-142', NULL, N'email142@example.com', NULL, 1, NULL, N'a1a479e7-2f77-4a5d-b796-8498ece805ab', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1d42b6e8-cea5-4c0c-9272-94e6244e7b3a', NULL, NULL, NULL, N'User-094', NULL, N'email094@example.com', NULL, 1, NULL, N'649dac62-522d-4284-b4c4-d7637226c9cb', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1d9e8c55-7df3-4dc8-ba1b-d8af0f87cc01', NULL, NULL, NULL, N'User-107', NULL, N'email107@example.com', NULL, 1, NULL, N'6ef9f5bf-c6aa-4e29-a1c6-75b1f505239a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1e9ea8ef-546e-4134-a6bd-b90d19fd9872', NULL, NULL, NULL, N'User-066', NULL, N'email066@example.com', NULL, 1, NULL, N'5cf44d29-3796-4c45-bdf1-523da6e514c9', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', NULL, NULL, NULL, N'anhlh123', N'ANHLH123', N'anhlh.study@gmail.com', N'ANHLH.STUDY@GMAIL.COM', 1, N'AQAAAAIAAYagAAAAEEb1vcj9WnkfK2LV4nld11opGAiIl7smrnyqMh3wvNix5gZtxebY0c2H9SKFO81UYA==', N'GTCVUBQR54FQ4OBAQSFHXTJ2UDVJC5CK', N'632730f4-fa82-4360-856a-dbb0309f4f23', N'0862810356', 1, 1, NULL, 1, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1f20f1b9-5818-40bf-8375-cd5d3c516d0d', NULL, NULL, NULL, N'User-070', NULL, N'email070@example.com', NULL, 1, NULL, N'60d0a542-98f7-4f16-8ee4-c26b110c0d4a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'1f4a2900-6eb9-4eda-9d8b-4be2754243ba', NULL, NULL, NULL, N'User-053', NULL, N'email053@example.com', NULL, 1, NULL, N'5a8acaee-fd2a-43d5-8615-e21fa05b939f', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'21f7af74-d19d-42e0-8586-0c32681949dd', NULL, NULL, NULL, N'User-117', NULL, N'email117@example.com', NULL, 1, NULL, N'2397fe91-7dfd-4838-8160-8d1029f030e7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'236232b6-d206-4878-a65f-0b03e87ad58e', NULL, NULL, NULL, N'User-059', NULL, N'email059@example.com', NULL, 1, NULL, N'441c8f05-2093-43b7-9e76-30f868b37924', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'272fad80-e0c6-4378-9e53-b015803df534', NULL, NULL, NULL, N'User-052', NULL, N'email052@example.com', NULL, 1, NULL, N'b06782b1-f538-4ff0-a2ff-0dd33e207931', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'2888f1bb-0769-4a2d-b0ae-437c2960318e', NULL, NULL, NULL, N'User-041', NULL, N'email041@example.com', NULL, 1, NULL, N'1f795079-5ebd-452f-b0e1-00a4f9e16db4', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'294cb272-cec2-40b3-b870-bf64fb861294', NULL, NULL, NULL, N'User-058', NULL, N'email058@example.com', NULL, 1, NULL, N'c1e51acc-4024-4c77-b583-50993fee7221', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'2c287e08-826e-4944-aebf-97ad2a9fb37c', NULL, NULL, NULL, N'User-004', NULL, N'email004@example.com', NULL, 1, NULL, N'e0d30420-d2ff-46be-a7ff-f83e98aee9bd', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'2eb14d47-137c-4812-911e-edcdeddf0b02', NULL, NULL, NULL, N'User-079', NULL, N'email079@example.com', NULL, 1, NULL, N'7c66eb7c-e6e8-482a-b9c8-cf0565e18099', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3520d8ff-7997-4374-9203-d4bdb7bef057', NULL, NULL, NULL, N'User-095', NULL, N'email095@example.com', NULL, 1, NULL, N'443646b3-b3eb-4d5f-85b7-0a4d5af876c3', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'35d22a4f-9cc5-4cc8-bbc5-41fd5ab6fa37', NULL, NULL, NULL, N'User-129', NULL, N'email129@example.com', NULL, 1, NULL, N'7606a593-d0e4-4a0c-986c-b761e1ba2f37', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'35f4c7c6-0a4d-458d-a266-82329deabb12', NULL, NULL, NULL, N'User-046', NULL, N'email046@example.com', NULL, 1, NULL, N'8d58be2a-c00a-464a-b88e-7677d077a8f0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'366b5de8-7f2f-41d2-8574-2431d8002783', NULL, NULL, NULL, N'User-051', NULL, N'email051@example.com', NULL, 1, NULL, N'1299425e-13dd-40dc-828d-91f768e4c908', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'37cbd3c7-7e05-42f9-8911-aa2b3a4197b6', NULL, NULL, NULL, N'User-056', NULL, N'email056@example.com', NULL, 1, NULL, N'ad595ff3-568d-47cb-a7c8-c83733a89ef2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3a68250c-6323-4317-8599-be504f436d89', NULL, NULL, NULL, N'User-013', NULL, N'email013@example.com', NULL, 1, NULL, N'f28cf95f-de26-475d-bb41-0b86f9f58fb2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3b13b07e-387f-4e73-8f5a-b2c49ee62ef4', NULL, NULL, NULL, N'User-040', NULL, N'email040@example.com', NULL, 1, NULL, N'fac39b6e-c3d9-45ee-bb3c-8c5810bb5327', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3d067b9d-b4a6-4924-b81e-9d97c4ffe852', NULL, NULL, NULL, N'User-076', NULL, N'email076@example.com', NULL, 1, NULL, N'0548727c-11ef-4e23-9391-0c23f7c5e742', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3e345238-5a18-4dd6-aba8-95a6aa5263d6', NULL, NULL, NULL, N'User-027', NULL, N'email027@example.com', NULL, 1, NULL, N'ba3bb2fe-52eb-4d0a-bb86-f8fc1c423c53', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3ef8ef18-a9b5-4c26-b984-692e81afce98', NULL, NULL, NULL, N'User-016', NULL, N'email016@example.com', NULL, 1, NULL, N'c0887972-1073-4e35-9e6d-f684bfe295a4', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'3f52876d-124d-4a36-aed2-06c37a235917', NULL, NULL, NULL, N'User-015', NULL, N'email015@example.com', NULL, 1, NULL, N'38c0235e-6d57-4a35-9250-a1e67281eab2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'41445086-eb0b-429a-adde-582c3f38d306', NULL, NULL, NULL, N'User-050', NULL, N'email050@example.com', NULL, 1, NULL, N'181c667a-fad3-4e0b-8841-3debe3687998', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'44c8abf6-fb6c-4460-a7ca-ad75dbefd624', NULL, NULL, NULL, N'User-042', NULL, N'email042@example.com', NULL, 1, NULL, N'dc33fa73-5d93-4351-af1f-549c54c8587f', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4510f9dc-ab8e-48d6-8f4e-1f305846de1a', NULL, NULL, NULL, N'User-087', NULL, N'email087@example.com', NULL, 1, NULL, N'd1892378-e952-450f-8d3c-d4da7bb6bcd3', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'45a31291-9103-4619-9b7d-e337ae785a35', NULL, NULL, NULL, N'User-130', NULL, N'email130@example.com', NULL, 1, NULL, N'1e7331d7-4ff0-4b3c-9ce4-432310c0e7df', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4ae3ff53-7405-45b9-8719-6e071fdcb1c3', NULL, NULL, NULL, N'User-125', NULL, N'email125@example.com', NULL, 1, NULL, N'7b28836c-9a34-4251-bc2f-2b40a279fe3a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4c464af9-ac19-4ed3-8982-7369532bcfc3', NULL, NULL, NULL, N'User-146', NULL, N'email146@example.com', NULL, 1, NULL, N'88d84f0c-9390-4523-8676-9ae31a10aa82', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4f4e307a-e1ad-4eff-adbc-de44c573afef', NULL, NULL, NULL, N'User-116', NULL, N'email116@example.com', NULL, 1, NULL, N'5c382780-7fde-4c16-86e5-78ca00c5a258', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4fe48246-742c-4b53-9041-74ecfd0abbd4', NULL, NULL, NULL, N'User-047', NULL, N'email047@example.com', NULL, 1, NULL, N'7a811436-8bd9-498d-b320-20ef8390fe4c', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'4fe6a891-0ced-48e1-8be6-046ca77b033b', NULL, NULL, NULL, N'User-044', NULL, N'email044@example.com', NULL, 1, NULL, N'd0750b44-4d04-4a80-a20e-d07b767a24f0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'50230662-27a7-4828-b5ae-b5b9b547689f', NULL, NULL, NULL, N'User-118', NULL, N'email118@example.com', NULL, 1, NULL, N'4eaaa8e4-dfc0-4577-9437-1a96d79e9ea7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5171e597-43a6-4cf1-ba85-87e9f86f14a3', NULL, NULL, NULL, N'User-099', NULL, N'email099@example.com', NULL, 1, NULL, N'57778537-b16c-4088-914d-01d010e684b7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'518be6b4-a5b1-40ae-ac30-c3f86ecab334', NULL, NULL, NULL, N'User-030', NULL, N'email030@example.com', NULL, 1, NULL, N'ff8b297d-2067-43ce-bc4b-a7ba43130e37', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5471e6e0-c7e6-49dd-abf6-b45c8fdcbc89', NULL, NULL, NULL, N'User-120', NULL, N'email120@example.com', NULL, 1, NULL, N'b95a5b3f-4cb2-488d-85f6-a43918a7ef22', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5987f041-ae14-4d51-aabb-164723ab69f9', NULL, NULL, NULL, N'User-115', NULL, N'email115@example.com', NULL, 1, NULL, N'96b41386-6767-430a-abd9-7e1d4cd7947b', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5aa82ae3-9360-4b30-b03c-366f6bffef3e', NULL, NULL, NULL, N'User-062', NULL, N'email062@example.com', NULL, 1, NULL, N'ba878b31-8534-4834-88b0-4fe6873d7c79', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5ac6dbc0-3911-4db5-8394-09521d7c9f10', NULL, NULL, NULL, N'User-019', NULL, N'email019@example.com', NULL, 1, NULL, N'e7375788-bfbe-4bde-a49f-d8b3c2d78dcb', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5dfcc849-32ba-4e9b-bb5b-2ac7fa00467a', NULL, NULL, NULL, N'User-086', NULL, N'email086@example.com', NULL, 1, NULL, N'24d3ad95-9e5e-4428-9a95-74ae43801889', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'5e5df23f-700a-4060-adbc-d369cc3577d1', NULL, NULL, NULL, N'User-034', NULL, N'email034@example.com', NULL, 1, NULL, N'7993846e-8cfc-4839-aae9-3a1cd99aa6b8', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6063636c-ae79-40d7-a58a-d9b3e2d7846d', NULL, NULL, NULL, N'User-113', NULL, N'email113@example.com', NULL, 1, NULL, N'd55a6c80-f4ea-4b32-94b8-065deea0ec4a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'62665d82-7bdf-434a-8eb1-a6aaceaa5973', NULL, NULL, NULL, N'User-010', NULL, N'email010@example.com', NULL, 1, NULL, N'0ac2d9dd-4bf7-4908-b635-6b8a244b017d', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'645578f1-e77c-4556-9e49-9e0ccb8b0f5a', NULL, NULL, NULL, N'User-127', NULL, N'email127@example.com', NULL, 1, NULL, N'a2ef8a9c-3284-49ac-a727-f77f137f0749', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6469e277-f81d-4ee9-8290-2c1432d21adf', NULL, NULL, NULL, N'User-008', NULL, N'email008@example.com', NULL, 1, NULL, N'5605941a-10d2-4af9-854d-f87f14902c4c', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'64e18c2d-5f0c-4251-ae80-c32cefccc313', NULL, NULL, NULL, N'User-131', NULL, N'email131@example.com', NULL, 1, NULL, N'714e7165-dccf-49e5-a6e0-75fdc53e57e5', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'657de7e8-0dde-44aa-980a-04aefbfc3f7d', NULL, NULL, NULL, N'User-020', NULL, N'email020@example.com', NULL, 1, NULL, N'6feb3988-abc9-4468-a223-2331ea92bc5e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6769ceff-9e28-46a4-bb2a-b5ebe4e98c68', NULL, NULL, NULL, N'User-128', NULL, N'email128@example.com', NULL, 1, NULL, N'8d50c735-fa9a-47a8-bcb4-5d584fb810df', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'696a5a90-0aae-49c9-a984-93b492ddc099', NULL, NULL, NULL, N'User-018', NULL, N'email018@example.com', NULL, 1, NULL, N'b0ab7d1b-2d17-45a8-b023-3985bfd92b31', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6aae3874-f94e-4360-8811-33c80dd2a1ff', NULL, NULL, NULL, N'User-103', NULL, N'email103@example.com', NULL, 1, NULL, N'f03f0c32-ca16-4069-9276-a89edf2cae52', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6b047888-1775-45b8-b42e-13f47a02f2c4', NULL, NULL, NULL, N'User-097', NULL, N'email097@example.com', NULL, 1, NULL, N'38cbff75-ca12-4672-ade8-411048ee5063', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6ce07d4e-0457-4851-b613-fae7e5636f2e', NULL, NULL, NULL, N'User-057', NULL, N'email057@example.com', NULL, 1, NULL, N'7546b8ba-eca4-4f20-af1a-56728b9ef04a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6ce6d4d5-d9cb-4e9b-bf97-ade114cf3094', NULL, NULL, NULL, N'User-133', NULL, N'email133@example.com', NULL, 1, NULL, N'5e65c1da-8dbc-4fad-8691-20493fc433e0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6ed36114-a5b2-4767-a8ed-1ed817c3e51b', NULL, NULL, NULL, N'User-134', NULL, N'email134@example.com', NULL, 1, NULL, N'1843353e-a37d-4842-8972-9cc735aa41a9', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6f38acb6-9ea6-4ccd-9e4e-ac9369c83742', NULL, NULL, NULL, N'User-148', NULL, N'email148@example.com', NULL, 1, NULL, N'c581ad76-4fbe-477d-bf71-087b4d95c520', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'6f6c39f9-e314-4a5f-92be-57179e27d8d9', NULL, NULL, NULL, N'User-035', NULL, N'email035@example.com', NULL, 1, NULL, N'728127f9-c7f9-470b-9207-cf2ab7d1a837', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'708d0c8f-0a06-46da-a2d0-136eb36b3897', NULL, NULL, NULL, N'User-043', NULL, N'email043@example.com', NULL, 1, NULL, N'844c8bf0-ae56-467f-803e-8d0479da3a64', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'72ba64bf-5ec0-4061-82f5-0bbdca511016', NULL, NULL, NULL, N'User-007', NULL, N'email007@example.com', NULL, 1, NULL, N'116f6463-ea7e-4434-9dc8-b2a084b4fc00', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'73404683-ff5a-4d5b-84e3-a377d275e2ba', NULL, NULL, NULL, N'User-061', NULL, N'email061@example.com', NULL, 1, NULL, N'b39edc8e-cfe2-4507-a197-4120d41f310f', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'76ea5e13-765f-4bb1-b3ba-e05973aa3de5', NULL, NULL, NULL, N'User-096', NULL, N'email096@example.com', NULL, 1, NULL, N'a2f7b38b-b739-4998-8474-3e0b3cde4b83', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'77b71bf9-25fd-4bbe-a37c-d14d5438c348', NULL, NULL, NULL, N'User-139', NULL, N'email139@example.com', NULL, 1, NULL, N'079520c8-569f-4e49-937e-c6cf0df1114a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'7c8a4f67-bc6b-458f-bf77-3d3b02bc4c94', NULL, NULL, NULL, N'User-144', NULL, N'email144@example.com', NULL, 1, NULL, N'f25b3ee6-9767-459b-9014-a0adb1a194de', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'84291da9-d7f6-4e03-86e5-4ea1099146eb', NULL, NULL, NULL, N'User-141', NULL, N'email141@example.com', NULL, 1, NULL, N'ca5f1fb4-e6d1-4e16-a678-25b8b763aa34', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'87ce4bae-36cd-43df-ab10-b96fe0cb4891', NULL, NULL, NULL, N'User-092', NULL, N'email092@example.com', NULL, 1, NULL, N'4dea5221-70f4-48b8-ac72-2f4e566a1151', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8a06cd90-a88a-4c13-abf9-ffc9066b109b', NULL, NULL, NULL, N'User-036', NULL, N'email036@example.com', NULL, 1, NULL, N'df00d96f-68c1-4794-8810-f28b4a538b70', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8a75db08-c10e-488b-b13f-b7f6455509bf', NULL, NULL, NULL, N'User-026', NULL, N'email026@example.com', NULL, 1, NULL, N'dfa1ff0c-1b26-41c5-a16b-2cc3b281a7cd', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8aef5232-d4a3-4c29-ba2f-dcfd2240eb01', NULL, NULL, NULL, N'User-135', NULL, N'email135@example.com', NULL, 1, NULL, N'e0f98a72-c752-4057-a243-9b1b9b903118', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8b29ab3c-7693-4ff1-9ce0-c540714ac262', NULL, NULL, NULL, N'User-029', NULL, N'email029@example.com', NULL, 1, NULL, N'572f079b-67d9-49c3-a6d4-67c5749e322e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8b93ebb7-9aec-44cd-90f0-4e8f482ba042', NULL, NULL, NULL, N'User-078', NULL, N'email078@example.com', NULL, 1, NULL, N'e6bdeb1b-8501-4bcb-8e92-671d4daaddd5', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'8c926128-c257-4e41-a764-78b57096eb5b', NULL, NULL, NULL, N'User-077', NULL, N'email077@example.com', NULL, 1, NULL, N'c007b954-7cfe-4ce9-8b67-e436e36c69ea', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'925f0c7c-8d47-45e2-abf2-bb06197f5369', NULL, NULL, NULL, N'User-104', NULL, N'email104@example.com', NULL, 1, NULL, N'ae45ae2a-c1a1-47ea-b44d-3ecbebae61e0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'941ec784-a474-44b8-80ae-68826918bc79', NULL, NULL, NULL, N'User-012', NULL, N'email012@example.com', NULL, 1, NULL, N'8b65a436-e7a2-4c6b-94f0-968280a94fb2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'95d507a2-ed08-4ed2-8019-960cc3704b7d', NULL, NULL, NULL, N'User-093', NULL, N'email093@example.com', NULL, 1, NULL, N'9218ddaa-ec73-4e07-a74e-34dac304a5ab', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'95f5c581-f42e-459a-9a6c-e65a0c4c8022', NULL, NULL, NULL, N'User-140', NULL, N'email140@example.com', NULL, 1, NULL, N'8b6d7ade-244c-4a35-a914-03e81ac02f31', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9677a799-cc26-477b-9d8d-6ec1375fa5bf', NULL, NULL, NULL, N'User-049', NULL, N'email049@example.com', NULL, 1, NULL, N'51954d93-df8f-48e5-b973-d0950e5493a2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9776a811-2e66-4f7e-9bf4-3c6b20699d20', NULL, NULL, NULL, N'User-021', NULL, N'email021@example.com', NULL, 1, NULL, N'e58d0be3-796b-42cc-a555-2a7a662be215', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'97c2a34b-54f8-4eef-8f57-27bfbd6ef1e7', NULL, NULL, NULL, N'User-098', NULL, N'email098@example.com', NULL, 1, NULL, N'ba54745c-c92d-4ce9-8ca3-33eec5339a21', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9858b0ff-7fb5-465e-8d9c-3ac45055f63c', NULL, NULL, NULL, N'User-055', NULL, N'email055@example.com', NULL, 1, NULL, N'8d50e6d2-7482-449f-af2a-ebaaee2f854a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9948b601-5fe4-4eff-af84-824f161f7057', NULL, NULL, NULL, N'User-071', NULL, N'email071@example.com', NULL, 1, NULL, N'9822c23b-f582-47a9-a687-0b2c01bc13ae', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9963f359-8c8b-4fab-ad3a-7fad01a1d1ab', NULL, NULL, NULL, N'User-001', N'USER-001', N'email001@example.com', N'EMAIL001@EXAMPLE.COM', 1, NULL, N'44c28139-0a27-4c2c-aa19-9f77cc06cfa5', N'fa995b0d-b3cc-4383-ab8f-28cc5947e896', NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'9f71d73d-abc2-430a-bf99-8143e27eb94d', NULL, NULL, NULL, N'User-102', NULL, N'email102@example.com', NULL, 1, NULL, N'10afb144-810e-462b-b481-1ac09c0d1f36', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'a06c14b9-8044-4e8b-8676-55f5a40347f2', NULL, NULL, NULL, N'User-054', NULL, N'email054@example.com', NULL, 1, NULL, N'e1f8da0d-cc42-432c-804c-b06dc1e930b7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'a0816af2-903b-4f49-9ae0-44a7ac96c4fe', NULL, NULL, NULL, N'User-005', NULL, N'email005@example.com', NULL, 1, NULL, N'4cc731f5-a5b3-499a-a6e1-c149c8c07779', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'a12d00a2-9b53-419c-80d8-e3214ad7ff02', NULL, NULL, NULL, N'User-101', NULL, N'email101@example.com', NULL, 1, NULL, N'564ddf48-5d2b-4667-b4f5-c2f6c898874e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'a863b052-366f-4475-a061-a88e114a29c5', NULL, NULL, NULL, N'User-123', NULL, N'email123@example.com', NULL, 1, NULL, N'88a25634-784f-44c9-b2f8-e72b4333155c', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'a99853a7-041c-4b11-8cf5-ebb1c3a1fae0', NULL, NULL, NULL, N'User-081', NULL, N'email081@example.com', NULL, 1, NULL, N'7bfdc04d-bf66-4783-960c-6ae4a4e4d862', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'ac4967fb-33d6-4038-94bc-f5f7c33008d7', NULL, NULL, NULL, N'User-149', NULL, N'email149@example.com', NULL, 1, NULL, N'0b76e5af-8948-401e-9c91-7e34a550f6c7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'ae033f45-ea52-461d-b98d-cf26e359ce22', NULL, NULL, NULL, N'User-067', NULL, N'email067@example.com', NULL, 1, NULL, N'06ca851a-8862-417c-bd83-49456417487f', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'aec994fa-bb7d-4bfb-90d1-8fefb03a408c', NULL, NULL, NULL, N'User-105', NULL, N'email105@example.com', NULL, 1, NULL, N'91dfe59d-093f-4da3-a526-edb9b8e38366', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b006b97d-78ed-4b91-a021-0e999cea8bc7', NULL, NULL, NULL, N'User-037', NULL, N'email037@example.com', NULL, 1, NULL, N'73e1206e-82ac-45ba-b488-00cce2896fbd', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b26e07c9-645c-4e14-a79b-76c934248d0f', NULL, NULL, NULL, N'User-038', NULL, N'email038@example.com', NULL, 1, NULL, N'19bd189a-9ef0-44bf-857c-0c8f790eb96e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b418a5d4-ed61-461b-bd3f-0f36acbed306', NULL, NULL, NULL, N'User-137', NULL, N'email137@example.com', NULL, 1, NULL, N'a1c054c5-4a97-456b-a4ac-744449acb3ce', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b4cb1a44-b667-4d90-b05f-791c5046c423', NULL, NULL, NULL, N'User-084', NULL, N'email084@example.com', NULL, 1, NULL, N'07eb1d4f-b9c9-4345-b3d1-b34010f806b6', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b4e5dcbc-e647-483a-8ece-442e71d24ab0', NULL, NULL, NULL, N'User-119', NULL, N'email119@example.com', NULL, 1, NULL, N'143081e9-83a8-4bd6-a26f-9fc89b2edb37', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b524d137-f392-485d-8bac-6c246adfb520', NULL, NULL, NULL, N'User-080', NULL, N'email080@example.com', NULL, 1, NULL, N'0be0a2d5-ad9b-44d4-83e0-3211c3ffc4ef', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b5c95549-5d6a-405b-943d-f9682e5860a7', NULL, NULL, NULL, N'User-063', NULL, N'email063@example.com', NULL, 1, NULL, N'789afcf5-7a4b-4c9a-b5b3-f2caa36b9e7b', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b6a8ebbf-09ce-4b0e-9a58-051e39d21c4d', NULL, NULL, NULL, N'User-023', NULL, N'email023@example.com', NULL, 1, NULL, N'dd784752-fdea-45d3-9d44-9047ca24f931', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b6b455c0-5bd4-4d26-9698-c4c770dc501b', NULL, NULL, NULL, N'admin', N'ADMIN', N'admin@example.com', N'ADMIN@EXAMPLE.COM', 1, N'AQAAAAIAAYagAAAAEA5ib3SB+5KrKR7EF5pPWITyj+dHqFWylcLbVE2ruSZX9bOiUvHQG2h730DfMvmJvg==', N'VOJQ64OEQ6N453ZKH2N2WGRJ5J2TL4YV', N'75b1ae11-fbf8-44cc-9a05-6492f10baf98', NULL, 0, 0, NULL, 1, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'b9db2597-4382-4241-9162-d000d97dfd29', NULL, NULL, NULL, N'User-068', NULL, N'email068@example.com', NULL, 1, NULL, N'3177526d-85cc-4b5b-a922-7f3c3d85e5ba', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'bceb387e-09ef-47c3-96a9-a8265ec169c1', NULL, NULL, NULL, N'User-138', NULL, N'email138@example.com', NULL, 1, NULL, N'5a7db30c-aa67-488d-9f6d-3a6cced97972', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'be1ddc89-741d-443d-9c12-a05b4b4c184b', NULL, NULL, NULL, N'User-003', NULL, N'email003@example.com', NULL, 1, NULL, N'8217c111-1681-4ab1-a29b-3413142fe5f7', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'bec526a1-24a3-4814-8e2a-9749c4c463d0', NULL, NULL, NULL, N'User-031', NULL, N'email031@example.com', NULL, 1, NULL, N'696b6861-3d06-4216-a337-4f611e76b9dc', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'c1a47a00-5453-4bfd-8d66-b947169057b0', NULL, NULL, NULL, N'User-075', NULL, N'email075@example.com', NULL, 1, NULL, N'523c1669-5824-40bb-850f-28ecb4ab9328', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'c2f2520e-c747-440d-9b8b-9b7371131b4d', NULL, NULL, NULL, N'User-069', NULL, N'email069@example.com', NULL, 1, NULL, N'18aebecc-04ab-49b1-ae09-f821efeead5b', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'c3d1e7fe-d5d7-4661-9a4c-eb31b8f06a29', NULL, NULL, NULL, N'User-147', NULL, N'email147@example.com', NULL, 1, NULL, N'588a14d6-af71-4a83-9268-f6df29bc8104', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'c572d1c6-51ba-44d8-85ba-aaa0ac856e2b', NULL, NULL, NULL, N'User-122', NULL, N'email122@example.com', NULL, 1, NULL, N'cd01897b-cf8f-4117-ba7f-1e277119bd08', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'c69945b1-8990-473f-b21c-55ebdaf9ab6f', NULL, NULL, NULL, N'User-022', NULL, N'email022@example.com', NULL, 1, NULL, N'03b39271-5122-432c-8eff-97f22bc68f81', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'cc8b7ecd-d2a3-41a1-a717-fc022c1d6b82', NULL, NULL, NULL, N'User-143', NULL, N'email143@example.com', NULL, 1, NULL, N'3c6f981e-9e51-4d9d-9f47-5dbef3321b75', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'cce7d5d0-8da8-4b5e-b3ed-742370048ebd', NULL, NULL, NULL, N'User-074', NULL, N'email074@example.com', NULL, 1, NULL, N'543ea8db-1bf4-45b6-881d-d42abf53214e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'ce20b545-f9cf-4f20-8943-74c4ca043c82', NULL, NULL, NULL, N'User-072', NULL, N'email072@example.com', NULL, 1, NULL, N'7523ab26-6a59-40df-80f2-e3237cea9c3b', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'd48f5887-119b-4fed-8b66-2f508794fa83', NULL, NULL, NULL, N'User-045', NULL, N'email045@example.com', NULL, 1, NULL, N'3c2e797a-bae7-477b-bbcd-107463f2a091', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'd5025943-d2b8-4fe4-8083-3c13df72f05b', NULL, NULL, NULL, N'User-136', NULL, N'email136@example.com', NULL, 1, NULL, N'b726b0a7-a636-4a74-8bcd-161f970dd1f0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'd7910e53-c0be-4f53-959a-5e7660ea92a5', NULL, NULL, NULL, N'User-073', NULL, N'email073@example.com', NULL, 1, NULL, N'b939ae66-d4a1-42f7-aea8-fdfddee5186e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'da016f44-3d4b-4a24-8d26-b88b7dc44ae3', NULL, NULL, NULL, N'User-082', NULL, N'email082@example.com', NULL, 1, NULL, N'93099264-b880-449e-a65c-f4fa49ad6fbc', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'debb555c-0f24-4828-84b8-959f6edda27f', NULL, NULL, NULL, N'User-109', NULL, N'email109@example.com', NULL, 1, NULL, N'efd428cf-8985-4eae-b8ab-a89287fb0998', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'dfcc8a71-2fe5-4b78-b222-f8af5d9e8228', NULL, NULL, NULL, N'User-121', NULL, N'email121@example.com', NULL, 1, NULL, N'1e04b306-c1db-43a5-ad45-1cfbc891f912', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e01a6880-90f6-4fcf-9151-642b4855f117', NULL, NULL, NULL, N'User-112', NULL, N'email112@example.com', NULL, 1, NULL, N'9d527947-6011-41f4-9ab6-7fed8039b2d9', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e0aed2b6-b16e-43b7-be15-25f0478bcdd0', NULL, NULL, NULL, N'User-100', NULL, N'email100@example.com', NULL, 1, NULL, N'9932a3c4-8606-4e93-bff3-21950a9072f0', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e1f3a59b-fb15-4e4e-bddd-a192f82f308e', NULL, NULL, NULL, N'User-002', NULL, N'email002@example.com', NULL, 1, NULL, N'eb6558a0-5cb8-4522-99b1-cb5ba9db6ab2', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e31a0ac1-3eb9-468c-88a8-9cb0c80985c0', NULL, NULL, NULL, N'User-011', NULL, N'email011@example.com', NULL, 1, NULL, N'ecb49d43-92d5-456a-94bd-822209734918', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e467da08-c499-4256-9c19-916be5fcdc8a', NULL, NULL, NULL, N'User-114', NULL, N'email114@example.com', NULL, 1, NULL, N'5a854c23-c341-4bf6-a22e-93770fd61e92', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'e8222c87-0054-4864-84ad-838cf5edfd69', NULL, NULL, NULL, N'User-065', NULL, N'email065@example.com', NULL, 1, NULL, N'4ee40a74-a29e-46f5-b1c8-06fe62cd2263', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'ed8551c3-4ed3-4f76-988c-b7d28d6df5d1', NULL, NULL, NULL, N'User-088', NULL, N'email088@example.com', NULL, 1, NULL, N'2385e9c2-f2cc-442c-85fc-e5b340b3b40a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'ed949851-e92c-45bf-9335-f2abcee5eab3', NULL, NULL, NULL, N'User-048', NULL, N'email048@example.com', NULL, 1, NULL, N'8725ae3d-fee2-4cb9-af5f-8c794b32d323', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f0476a32-a784-473c-91c7-719253d7d82e', NULL, NULL, NULL, N'User-089', NULL, N'email089@example.com', NULL, 1, NULL, N'ccb3e2ac-bc04-4773-a72c-d3203b1604f6', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f0ff3114-52f1-404f-bb4b-13eacdc91f87', NULL, NULL, NULL, N'User-017', NULL, N'email017@example.com', NULL, 1, NULL, N'841a2f53-d0c5-45c1-89d4-f9c5a6914d8c', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f104bbcc-241c-4962-998a-94ab7aee59bb', NULL, NULL, NULL, N'User-126', NULL, N'email126@example.com', NULL, 1, NULL, N'35ed3761-88a3-4bba-a58b-68dc0a448c13', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f111b50f-ca8b-4f02-961c-4c941d1da917', NULL, NULL, NULL, N'User-033', NULL, N'email033@example.com', NULL, 1, NULL, N'7b766b7a-368c-4a41-afc2-c94575d29e2a', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f126a645-e171-4170-b6dc-e07134e208a8', NULL, NULL, NULL, N'User-090', NULL, N'email090@example.com', NULL, 1, NULL, N'127876cd-fa1e-4aa9-b7b1-55131b990124', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f19e24ea-6fa1-4cc7-916d-f6f6f32e9050', NULL, NULL, NULL, N'User-025', NULL, N'email025@example.com', NULL, 1, NULL, N'133f09d6-fe90-4c4b-aa14-c3ca4778bc6b', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f84d1b39-1d7d-4ca6-8f59-8c37c7dda0ed', NULL, NULL, NULL, N'User-091', NULL, N'email091@example.com', NULL, 1, NULL, N'23b48ab9-006b-49f5-8c2d-c22820c5b6a1', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'f96179cf-cfcb-44b2-942e-a3916c9cb279', NULL, NULL, NULL, N'User-024', NULL, N'email024@example.com', NULL, 1, NULL, N'144b5404-53f0-45e4-b359-1bb7d2ebb1b6', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
INSERT [dbo].[Users] ([Id], [TotalPoint], [PointSpent], [TotalPayment], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Avatar]) VALUES (N'fa0c55c0-4eb7-44e4-8a63-4534c6f97a65', NULL, NULL, NULL, N'User-009', NULL, N'email009@example.com', NULL, 1, NULL, N'37dc6101-c149-4b62-a100-2e2d99542d9e', NULL, NULL, 0, 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[UserTokens] ([UserId], [LoginProvider], [Name], [Value]) VALUES (N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', N'[AspNetUserStore]', N'AuthenticatorKey', N'UEYFXJBZRXXUOI5ABBZLQRMROFZDJI6U')
INSERT [dbo].[UserTokens] ([UserId], [LoginProvider], [Name], [Value]) VALUES (N'1ebdd406-8535-4c21-b87b-6fa06bea3e0f', N'[AspNetUserStore]', N'RecoveryCodes', N'N8TMP-FM2YB;HHN5B-5RP54;44TQ8-MBQQM;XK99Y-BJXHQ;24FP8-R37W2')
GO
ALTER TABLE [dbo].[AccountCinema]  WITH CHECK ADD  CONSTRAINT [FK_AccountCinema_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[AccountCinema] CHECK CONSTRAINT [FK_AccountCinema_Account]
GO
ALTER TABLE [dbo].[AccountCinema]  WITH CHECK ADD  CONSTRAINT [FK_AccountCinema_Cinema] FOREIGN KEY([CinemaId])
REFERENCES [dbo].[Cinemas] ([CinemaId])
GO
ALTER TABLE [dbo].[AccountCinema] CHECK CONSTRAINT [FK_AccountCinema_Cinema]
GO
ALTER TABLE [dbo].[AppMenu]  WITH CHECK ADD  CONSTRAINT [FK_AppMenu_AppClaim] FOREIGN KEY([ClaimId])
REFERENCES [dbo].[AppClaims] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppMenu] CHECK CONSTRAINT [FK_AppMenu_AppClaim]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Account]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Showtime] FOREIGN KEY([ShowtimeId])
REFERENCES [dbo].[Showtime] ([ShowtimeId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Showtime]
GO
ALTER TABLE [dbo].[MovieActors]  WITH CHECK ADD  CONSTRAINT [FK_MovieActor_Actor] FOREIGN KEY([ActorId])
REFERENCES [dbo].[Actors] ([ActorId])
GO
ALTER TABLE [dbo].[MovieActors] CHECK CONSTRAINT [FK_MovieActor_Actor]
GO
ALTER TABLE [dbo].[MovieActors]  WITH CHECK ADD  CONSTRAINT [FK_MovieActor_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([MovieId])
GO
ALTER TABLE [dbo].[MovieActors] CHECK CONSTRAINT [FK_MovieActor_Movie]
GO
ALTER TABLE [dbo].[MovieGerne]  WITH CHECK ADD  CONSTRAINT [FK_MovieGerne_Gerne] FOREIGN KEY([GerneId])
REFERENCES [dbo].[Gernes] ([GerneId])
GO
ALTER TABLE [dbo].[MovieGerne] CHECK CONSTRAINT [FK_MovieGerne_Gerne]
GO
ALTER TABLE [dbo].[MovieGerne]  WITH CHECK ADD  CONSTRAINT [FK_MovieGerne_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([MovieId])
GO
ALTER TABLE [dbo].[MovieGerne] CHECK CONSTRAINT [FK_MovieGerne_Movie]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaim_Claim] FOREIGN KEY([ClaimId])
REFERENCES [dbo].[AppClaims] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaim_Claim]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Cinema] FOREIGN KEY([CinemaId])
REFERENCES [dbo].[Cinemas] ([CinemaId])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Cinema]
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD  CONSTRAINT [FK_Seat_Price] FOREIGN KEY([PriceId])
REFERENCES [dbo].[Prices] ([PriceId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Seat] CHECK CONSTRAINT [FK_Seat_Price]
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD  CONSTRAINT [FK_Seat_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Seat] CHECK CONSTRAINT [FK_Seat_Room]
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD  CONSTRAINT [FK_Showtime_Cinema] FOREIGN KEY([CinemaId])
REFERENCES [dbo].[Cinemas] ([CinemaId])
GO
ALTER TABLE [dbo].[Showtime] CHECK CONSTRAINT [FK_Showtime_Cinema]
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD  CONSTRAINT [FK_Showtime_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([MovieId])
GO
ALTER TABLE [dbo].[Showtime] CHECK CONSTRAINT [FK_Showtime_Movie]
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD  CONSTRAINT [FK_Showtime_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Showtime] CHECK CONSTRAINT [FK_Showtime_Room]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[UserFeatures]  WITH CHECK ADD  CONSTRAINT [FK_UserFeature_AppClaim] FOREIGN KEY([ClaimId])
REFERENCES [dbo].[AppClaims] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserFeatures] CHECK CONSTRAINT [FK_UserFeature_AppClaim]
GO
ALTER TABLE [dbo].[UserFeatures]  WITH CHECK ADD  CONSTRAINT [FK_UserFeature_AppUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserFeatures] CHECK CONSTRAINT [FK_UserFeature_AppUser]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserTokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserTokens] CHECK CONSTRAINT [FK_UserTokens_Users_UserId]
GO
