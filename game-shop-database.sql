USE [master]
GO
/****** Object:  Database [GameShopDB]    Script Date: 1/17/2025 8:26:21 PM ******/
CREATE DATABASE [GameShopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GameShopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GameShopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GameShopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GameShopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GameShopDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GameShopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GameShopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GameShopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GameShopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GameShopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GameShopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GameShopDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GameShopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GameShopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GameShopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GameShopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GameShopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GameShopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GameShopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GameShopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GameShopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GameShopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GameShopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GameShopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GameShopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GameShopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GameShopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GameShopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GameShopDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GameShopDB] SET  MULTI_USER 
GO
ALTER DATABASE [GameShopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GameShopDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GameShopDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GameShopDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GameShopDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GameShopDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GameShopDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [GameShopDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GameShopDB]
GO
/****** Object:  Table [dbo].[CategoryTable]    Script Date: 1/17/2025 8:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryTable](
	[categoryId] [int] NOT NULL,
	[categoryName] [nvarchar](255) NULL,
 CONSTRAINT [PK_CategoryTable] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameTable]    Script Date: 1/17/2025 8:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameTable](
	[gameId] [int] NOT NULL,
	[gameName] [nvarchar](255) NULL,
	[gamePrice] [float] NULL,
	[gameStock] [int] NULL,
	[gameImage] [nvarchar](max) NULL,
	[categoryId] [int] NULL,
 CONSTRAINT [PK_GameTable] PRIMARY KEY CLUSTERED 
(
	[gameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 1/17/2025 8:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[userId] [int] NOT NULL,
	[userName] [nvarchar](255) NULL,
	[userEmail] [nvarchar](255) NULL,
	[userPassword] [nvarchar](255) NULL,
	[userRole] [nvarchar](255) NULL,
 CONSTRAINT [PK_UserTable] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Insert data into CategoryTable
INSERT INTO CategoryTable (categoryId, categoryName) VALUES 
(1, 'Action'),
(2, 'Adventure'),
(3, 'RPGs'),
(4, 'Sandbox'),
(5, 'Fighting'),
(6, 'Party');

-- Insert data into GameTable
INSERT INTO GameTable (gameId, gameName, gamePrice, gameStock, gameImage, categoryId) VALUES 
(1, 'Sekiro™: Shadows Die Twice', 2099, 2, 'https://cdn.cdkeys.com/700x700/media/catalog/product/l/c/lczcjmcibhpe2btmbxuqcl9v_2__1_1_1_1.jpg', 1),
(2, 'DYNASTY WARRIORS: ORIGINS', 2100, 1, 'https://cdn.cdkeys.com/700x700/media/catalog/product/d/y/dynasty_warriors_origins_digital_deluxe_edition_1_1.png', 1),
(3, 'FINAL FANTASY VII REBIRTH', 2290, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/f/i/final_fantasy_vii_rebirth.png', 2),
(4, 'ELDEN RING', 1790, 5, 'https://cdn.cdkeys.com/700x700/media/catalog/product/5/d/5de6658946177c5f23698932_24__1_3_1.jpg', 2),
(5, 'Warhammer 40,000: Space Marine 2', 1490, 5, 'https://cdn.cdkeys.com/700x700/media/catalog/product/6/9/69654.jpg', 1),
(6, 'Monster Hunter Wilds', 1990, 6, 'https://cdn.cdkeys.com/700x700/media/catalog/product/m/o/monster_hunter_wilds_2_1.png', 2),
(7, 'HELLDIVERS™ 2', 1290, 7, 'https://cdn.cdkeys.com/700x700/media/catalog/product/n/e/new_project_-_2023-09-18t175517.723.jpg', 1),
(8, 'Black Myth: Wukong', 1799, 7, 'https://cdn.cdkeys.com/700x700/media/catalog/product/b/l/black-myth-wukong-steam.jpg', 1),
(9, 'Diablo® IV', 1749, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/n/e/new_project_-_2023-12-15t175853.866.jpg', 1),
(10, 'DRAGON BALL: Sparking! ZERO', 1890, 7, 'https://cdn.cdkeys.com/700x700/media/catalog/product/d/r/dragon_ball_sparking_zero_1.jpg', 5),
(11, 'GOD or WAR RAGNAROK', 1690, 3, 'https://cdn.cdkeys.com/700x700/media/catalog/product/e/g/egs_godofwar_santamonicastudio_s2_1200x1600-fbdf3cbc2980749091d52751ffabb7b7_1.jpg', 1),
(12, 'Ghost of Tsushima', 1690, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/g/h/ghost_of_tsushima_directors_cut-steam.jpg', 2),
(13, 'Resident Evil 4', 1399, 2, 'https://cdn.cdkeys.com/700x700/media/catalog/product/1/3/13_4__4_1.jpg', 1),
(14, 'DOOM Eternal', 899.99, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/b/k/bkg-cover_3_.jpg', 1),
(15, 'Palworld', 590, 3, 'https://cdn.cdkeys.com/700x700/media/catalog/product/n/e/new_project_-_2024-01-22t144018.803_1.jpg', 1),
(16, 'Hogwarts Legacy', 1890, 5, 'https://cdn.cdkeys.com/700x700/media/catalog/product/c/u/cupheaddeliciouslast-1640043161876_3_.jpg', 2),
(17, 'Ready or Not', 699, 7, 'https://cdn.cdkeys.com/700x700/media/catalog/product/d/4/d4f7e42ae7179d5e6e4c2d741b3bca505bda834c2bc83a50c83ac9abbe014eb1_3_.jpg', 1),
(18, 'Stardew Valley', 315, 9, 'https://cdn.cdkeys.com/700x700/media/catalog/product/s/t/stardew_valley_thumbnail.jpg', 4),
(19, 'Indiana Jones and the Great Circle', 2299, 3, 'https://cdn.cdkeys.com/700x700/media/catalog/product/i/n/indiana_jones_and_the_great_circle.png', 2),
(20, 'Devil May Cry 5', 919, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/d/e/devil_may_cry_5_pc_cover.jpg', 1),
(21, 'Grand Theft Auto V', 704.25, 5, 'https://cdn.cdkeys.com/700x700/media/catalog/product/f/a/fate_of_iberia_card_23_.jpg', 1),
(22, 'The Last of Us Part I', 1690, 11, 'https://cdn.cdkeys.com/700x700/media/catalog/product/e/g/egs_wildhearts_koeitecmogamescoltd_s2_1200x1600-398fdb8dbc918051f99347ebe0335973_3_.jpg', 2),
(23, 'Marvel''s Spider-Man: Miles Morales', 1290, 2, 'https://cdn.cdkeys.com/700x700/media/catalog/product/f/a/fadad.jpg', 1),
(24, 'Minecraft: Java & Bedrock Edition PC', 1077, 3, 'https://cdn.cdkeys.com/700x700/media/catalog/product/n/e/new_project_88__2_1.jpg', 4),
(25, 'Red Dead Redemption 2', 1899, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/f/i/fifa-22-pc-game-origin-cover_4_.jpg', 2),
(26, 'SILENT HILL 2', 2147, 2, 'https://cdn.cdkeys.com/700x700/media/catalog/product/s/i/silent_hill_2.jpg', 1),
(27, 'S.T.A.L.K.E.R. 2: Heart of Chornobyl', 1599, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/s/_/s.t.a.l.k.e.r._2_heart_of_chornobyl_.png', 1),
(28, 'Baldur''s Gate 3', 1799, 2, 'https://cdn.cdkeys.com/700x700/media/catalog/product/n/e/new_project_-_2023-12-13t184610.462_1.jpg', 3),
(29, 'Among Us', 110, 4, 'https://cdn.cdkeys.com/700x700/media/catalog/product/g/a/game-steam-among-us-cover_1__1.jpg', 6),
(30, 'Cyberpunk 2077', 1799, 5, 'https://cdn.cdkeys.com/700x700/media/catalog/product/a/v/avasvasvav.jpg', 1);

-- Insert data into UserTable
INSERT INTO UserTable (userId, userName, userEmail, userPassword, userRole) VALUES 
(1, 'Admin', 'Admin@gmail.com', '1234', 'Admin'),
(2, 'User', 'User@gmail.com', '4321', 'User');

USE [master]
GO
ALTER DATABASE [GameShopDB] SET  READ_WRITE 
GO