USE [master]
GO
/****** Object:  Database [CuaHangVIWOOD5]    Script Date: 4/21/2023 10:13:52 PM ******/
CREATE DATABASE [CuaHangVIWOOD5]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CuaHangVIWOOD5', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.VINH016\MSSQL\DATA\CuaHangVIWOOD5.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CuaHangVIWOOD5_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.VINH016\MSSQL\DATA\CuaHangVIWOOD5_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CuaHangVIWOOD5] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CuaHangVIWOOD5].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ARITHABORT OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET RECOVERY FULL 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET  MULTI_USER 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CuaHangVIWOOD5] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CuaHangVIWOOD5] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CuaHangVIWOOD5', N'ON'
GO
ALTER DATABASE [CuaHangVIWOOD5] SET QUERY_STORE = OFF
GO
USE [CuaHangVIWOOD5]
GO
/****** Object:  Synonym [dbo].[CL]    Script Date: 4/21/2023 10:13:52 PM ******/
CREATE SYNONYM [dbo].[CL] FOR [dbo].[ChatLieu]
GO
/****** Object:  Synonym [dbo].[KH]    Script Date: 4/21/2023 10:13:52 PM ******/
CREATE SYNONYM [dbo].[KH] FOR [dbo].[KhachHang]
GO
/****** Object:  Synonym [dbo].[NH]    Script Date: 4/21/2023 10:13:52 PM ******/
CREATE SYNONYM [dbo].[NH] FOR [dbo].[NhapHang]
GO
/****** Object:  UserDefinedFunction [dbo].[f_dulichHA]    Script Date: 4/21/2023 10:13:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_dulichHA] (@MaNV varchar(20))
returns nvarchar(150)
as
begin
declare @cau nvarchar(150)
declare @THD int
select @THD=count(MaNV)
from HoaDon
where MaNV=@MaNV and month(NgayLap)=3
group by MaNV
if @THD>2
set @cau=N'Bạn là nhân viên được đi du lịch Hội An'+ cast(@THD as nvarchar(10));
else
set @cau=N'Số đơn bạn bán được là:' + cast(@THD as nvarchar(10));
return @cau
end
GO
/****** Object:  UserDefinedFunction [dbo].[f_hp3]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_hp3] (@MaHoaDon varchar(20))
returns float
as
begin
declare @tonggiatriHD float
select @tonggiatriHD=sum(SoLuongSP*DonGia)
from CTHoaDon
where MaHoaDon =@MaHoaDon 
return @tonggiatriHD
end
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [varchar](20) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[SDT] [nvarchar](15) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[MaCV] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaCV] [varchar](20) NOT NULL,
	[TenCV] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](200) NOT NULL,
	[Luong] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwNV_BanHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwNV_BanHang]
as
select MaNV, HoTen, GioiTinh, SDT, Email, TenCV
from NhanVien join ChucVu on NhanVien.MaCV=ChucVu.MaCV
where TenCV =N'Nhân viên bán hàng'
GO
/****** Object:  View [dbo].[vw_NhanvienBH]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_NhanvienBH]
as
select MaNV, HoTen, GioiTinh, SDT, Email, TenCV
from NhanVien join ChucVu on NhanVien.MaCV=ChucVu.MaCV
where TenCV ='Nhân viên bán hàng'
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [varchar](10) NOT NULL,
	[TeSanPham] [nvarchar](100) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaBan] [float] NOT NULL,
	[NgayNhap] [date] NOT NULL,
	[MoTa] [nvarchar](300) NOT NULL,
	[MaNhom] [varchar](20) NOT NULL,
	[MaChatLieu] [varchar](20) NOT NULL,
	[MaMS] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [varchar](20) NOT NULL,
	[NgayLap] [date] NOT NULL,
	[MaNV] [varchar](20) NOT NULL,
	[MaKH] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTHoaDon]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHoaDon](
	[MaHoaDon] [varchar](20) NOT NULL,
	[MaSP] [varchar](10) NOT NULL,
	[SoLuongSP] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
 CONSTRAINT [pr_CTHoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_HDthang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_HDthang] (@tungay date, @denngay date)
returns table
as
return(
select HoaDon.MaHoaDon, NgayLap, SanPham.MaSP, TeSanPham, SoLuongSP
from HoaDon join (CTHoaDon join SanPham on CTHoaDon.MaSp=SanPham.MaSP)
  on HoaDon.MaHoaDon=CTHoaDon.MaHoaDon
where NgayLap between @tungay and @denngay)
GO
/****** Object:  Table [dbo].[BaoCao]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaoCao](
	[MaBC] [varchar](20) NOT NULL,
	[TenBC] [nvarchar](200) NOT NULL,
	[NgayBC] [date] NOT NULL,
	[MaNV] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatLieu]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatLieu](
	[MaChatLieu] [varchar](20) NOT NULL,
	[TenChatLieu] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChatLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTDonDatHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTDonDatHang](
	[MaDonDat] [varchar](20) NULL,
	[MaSP] [varchar](10) NULL,
	[SoLuongDat] [int] NOT NULL,
	[DonGia] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTNhapHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTNhapHang](
	[MaNhapHangCT] [varchar](20) NOT NULL,
	[MaSP] [varchar](10) NOT NULL,
	[MaNhapHang] [varchar](20) NOT NULL,
	[SoLuong] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhapHangCT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonDatHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDatHang](
	[MaDonDat] [varchar](20) NOT NULL,
	[MaKH] [varchar](20) NOT NULL,
	[NgayLap] [date] NULL,
	[NgayGiao] [date] NULL,
	[DiaChiGiao] [nvarchar](100) NOT NULL,
	[TinhTrang] [nvarchar](30) NOT NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonDat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonDD]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonDD](
	[MaHoaDonDD] [varchar](20) NOT NULL,
	[MaDonDat] [varchar](20) NOT NULL,
	[MaNV] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoaDonDD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [varchar](20) NOT NULL,
	[HoTenKH] [nvarchar](100) NOT NULL,
	[DiaChiKH] [nvarchar](100) NOT NULL,
	[SDTKH] [nvarchar](12) NOT NULL,
	[EmailKH] [nvarchar](50) NOT NULL,
	[GioiTinhKH] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MauSac]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MauSac](
	[MaMS] [varchar](20) NOT NULL,
	[TenMauSac] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [varchar](20) NOT NULL,
	[TenNCC] [nvarchar](50) NOT NULL,
	[DiaChiNCC] [nvarchar](100) NOT NULL,
	[DienThoaiNCC] [varchar](12) NOT NULL,
	[FaxNCC] [nvarchar](12) NOT NULL,
	[EmailNCC] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhapHang]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhapHang](
	[MaNhapHang] [varchar](20) NOT NULL,
	[NgayNhapHang] [date] NOT NULL,
	[MaNV] [varchar](20) NOT NULL,
	[MaNCC] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhapHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nhom]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhom](
	[MaNhom] [varchar](20) NOT NULL,
	[TenNhom] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoLuongTon]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoLuongTon](
	[MaSP] [varchar](10) NULL,
	[SoLuongTon] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[BaoCao] ([MaBC], [TenBC], [NgayBC], [MaNV]) VALUES (N'BC001', N'BÁO CÁO NHẬP KHO THÁNG 1', CAST(N'2023-01-28' AS Date), N'NV002')
INSERT [dbo].[BaoCao] ([MaBC], [TenBC], [NgayBC], [MaNV]) VALUES (N'BC002', N'BÁO CÁO NHẬP KHO THÁNG 2', CAST(N'2023-02-28' AS Date), N'NV002')
INSERT [dbo].[BaoCao] ([MaBC], [TenBC], [NgayBC], [MaNV]) VALUES (N'BC003', N'BÁO CÁO BÁN HÀNG THÁNG 1', CAST(N'2023-01-25' AS Date), N'NV003')
INSERT [dbo].[BaoCao] ([MaBC], [TenBC], [NgayBC], [MaNV]) VALUES (N'BC004', N'BÁO CÁO BÁN HÀNG THÁNG 2', CAST(N'2023-02-25' AS Date), N'NV007')
INSERT [dbo].[BaoCao] ([MaBC], [TenBC], [NgayBC], [MaNV]) VALUES (N'BC005', N'BÁO CÁO BÁN HÀNG THÁNG 3', CAST(N'2023-03-25' AS Date), N'NV005')
GO
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl001', N'gỗ tự nhiên')
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl002', N'gỗ ép loại 1')
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl003', N'gỗ ép loại 2')
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl004', N'gỗ ép loại 3')
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl005', N'tre')
INSERT [dbo].[ChatLieu] ([MaChatLieu], [TenChatLieu]) VALUES (N'cl006', N'nứa')
GO
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [MoTa], [Luong]) VALUES (N'1', N'Quản lý', N' chính thức', 55000000)
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [MoTa], [Luong]) VALUES (N'2', N'Nhân viên quản lý kho', N' chính thức', 35000000)
INSERT [dbo].[ChucVu] ([MaCV], [TenCV], [MoTa], [Luong]) VALUES (N'3', N'Nhân viên bán hàng', N' chính thức', 25000000)
GO
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD001', N'PK007', 1, 4000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD002', N'NT003', 5, 3500000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD003', N'PN007', 1, 19000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD004', N'PB004', 1, 14000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD005', N'PN003', 1, 12000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD006', N'PK003', 2, 7000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD007', N'PK005', 1, 34000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD008', N'PK006', 3, 4000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD009', N'PK009', 1, 7000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD010', N'PN001', 3, 1800000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD011', N'PN002', 4, 1400000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD012', N'PN008', 6, 1300000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD013', N'NT003', 3, 3500000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD014', N'PK009', 4, 7000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD015', N'PN002', 8, 1400000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD001', N'PN003', 1, 12000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD001', N'PN008', 6, 1300000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD002', N'PN007', 1, 19000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD003', N'TT002', 2, 600000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD003', N'PN002', 1, 1400000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD007', N'PK006', 1, 4000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD007', N'PN001', 3, 1800000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD007', N'PN008', 6, 1300000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD009', N'TT002', 3, 900000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD011', N'PK003', 1, 7000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD011', N'PB008', 1, 4400000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD012', N'NT0010', 2, 8000000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD012', N'PB006', 1, 9400000)
INSERT [dbo].[CTDonDatHang] ([MaDonDat], [MaSP], [SoLuongDat], [DonGia]) VALUES (N'DD100', N'NT002', 20, 25000000)
GO
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD001', N'PN001', 2, 1800000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD001', N'PN002', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD001', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD002', N'PN007', 1, 19000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD002', N'PN009', 1, 5400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD003', N'PB005', 3, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD003', N'PB007', 1, 3100000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD004', N'PB006', 1, 9400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD005', N'PB008', 2, 4400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD006', N'PB004', 1, 14000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD007', N'PB007', 1, 3100000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD007', N'PN002', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD008', N'TT001', 4, 300000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD008', N'TT002', 2, 300000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD008', N'TT003', 1, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD008', N'TT004', 2, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD009', N'PN003', 1, 12000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD010', N'NT002', 1, 25000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD011', N'NT004', 1, 10000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD012', N'NT002', 1, 25000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD013', N'PB007', 1, 3100000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD013', N'TT004', 2, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD014', N'NT002', 1, 25000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD015', N'PB006', 1, 9400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD015', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD016', N'PB007', 1, 3100000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD016', N'PN003', 1, 12000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD016', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD016', N'TT003', 1, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD017', N'NT004', 1, 10000000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD018', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD018', N'TT003', 1, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD019', N'PB007', 1, 3100000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD019', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD019', N'TT002', 2, 300000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD019', N'TT003', 1, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD020', N'TT002', 2, 300000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD020', N'TT003', 1, 400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD021', N'PN006', 1, 1400000)
INSERT [dbo].[CTHoaDon] ([MaHoaDon], [MaSP], [SoLuongSP], [DonGia]) VALUES (N'HD022', N'PB006', 1, 9400000)
GO
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH001', N'NT001', N'NH001', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH0010', N'NT0010', N'NH0010', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH002', N'NT002', N'NH002', 120)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH003', N'NT003', N'NH003', 110)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH004', N'NT004', N'NH004', 60)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH005', N'NT005', N'NH005', 70)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH006', N'NT006', N'NH006', 70)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH007', N'NT007', N'NH007', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH008', N'NT008', N'NH008', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH009', N'NT009', N'NH009', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2001', N'PK001', N'NH2001', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2002', N'PK002', N'NH2002', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2003', N'PK003', N'NH2003', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2004', N'PK004', N'NH2004', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2005', N'PK005', N'NH2005', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2006', N'PK006', N'NH2006', 40)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2007', N'PK007', N'NH2007', 55)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2008', N'PK008', N'NH2008', 70)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2009', N'PK009', N'NH2009', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH2010', N'PK0010', N'NH2010', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3001', N'PN001', N'NH3001', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3002', N'PN002', N'NH3002', 40)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3003', N'PN003', N'NH3003', 30)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3004', N'PN004', N'NH3004', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3005', N'PN005', N'NH3005', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3006', N'PN006', N'NH3006', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3007', N'PN007', N'NH3007', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3008', N'PN008', N'NH3008', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH3009', N'PN009', N'NH3009', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4001', N'PB001', N'NH4001', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4002', N'PB002', N'NH4002', 90)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4003', N'PB003', N'NH4003', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4004', N'PB004', N'NH4004', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4005', N'PB005', N'NH4005', 40)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4006', N'PB006', N'NH4006', 50)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4007', N'PB007', N'NH4007', 100)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH4008', N'PB008', N'NH4008', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH5001', N'TT001', N'NH5001', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH5002', N'TT001', N'NH5002', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH5003', N'TT001', N'NH5003', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH5004', N'TT001', N'NH5004', 80)
INSERT [dbo].[CTNhapHang] ([MaNhapHangCT], [MaSP], [MaNhapHang], [SoLuong]) VALUES (N'CTNH5005', N'TT001', N'NH5005', 80)
GO
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD001', N'0001', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-08' AS Date), N'41 đường số 19, khu Phú Mỹ Hưng, P.Tân Phú, Q.7, TP.HCM', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD002', N'0005', CAST(N'2023-02-22' AS Date), CAST(N'2023-02-27' AS Date), N'68 Hồ Xuân Hương, Q.Ngũ Hành Sơn.TP.Đà Nẵng', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD003', N'0006', CAST(N'2023-03-28' AS Date), CAST(N'2023-04-01' AS Date), N'Đảo Hòn Tre, Vĩnh Nguyên, Nha Trang, tình Khánh Hòa', N'Đang chuẩn bị hàng', N'Đã thanh toán')
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD004', N'0007', CAST(N'2023-03-13' AS Date), CAST(N'2023-03-20' AS Date), N'23 Lê Lợi, Q.1, TP.HCM', N'Đang giao', N'Đã thanh toán')
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD005', N'0008', CAST(N'2023-03-15' AS Date), CAST(N'2023-03-22' AS Date), N'Biên Hòa, Đồng Nai', N'Đang giao', N'Chưa thanh toán')
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD006', N'0002', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-08' AS Date), N'1765A Đại Lộ Bình Dương, P.Hiệp An-Thủ Dầu 1, Tỉnh Bình Dương', N'đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD007', N'0019', CAST(N'2023-01-15' AS Date), CAST(N'2023-01-27' AS Date), N'Ngã 5 Chuồng Chó, Gò Vấp', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD008', N'0020', CAST(N'2023-01-17' AS Date), CAST(N'2023-01-28' AS Date), N'Trần Xuân Soạn, Quận 7', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD009', N'0021', CAST(N'2023-02-16' AS Date), CAST(N'2023-02-25' AS Date), N'102, Man Thiện, TP.Thủ Đức', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD010', N'0022', CAST(N'2023-02-18' AS Date), CAST(N'2023-02-27' AS Date), N'111 Tam Hà,TP.Thủ Đức', N'Đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD011', N'0023', CAST(N'2023-03-10' AS Date), CAST(N'2023-03-17' AS Date), N'11/45, Buôn Mê Thuột, ĐăkLăk', N'Đang giao', N'Chưa thanh toán')
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD012', N'0024', CAST(N'2023-02-12' AS Date), CAST(N'2023-02-19' AS Date), N'CuKuin, ĐăLăk', N'đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD013', N'0018', CAST(N'2023-03-12' AS Date), CAST(N'2023-02-19' AS Date), N'CuKuin, ĐăLăk', N'đã giao', NULL)
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD014', N'0004', CAST(N'2023-03-15' AS Date), CAST(N'2023-01-04' AS Date), N'CuKuin, ĐăLăk', N'đang giao', N'đã thanh toán')
INSERT [dbo].[DonDatHang] ([MaDonDat], [MaKH], [NgayLap], [NgayGiao], [DiaChiGiao], [TinhTrang], [GhiChu]) VALUES (N'DD015', N'0020', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-08' AS Date), N'CuKuin, ĐăLăk', N'đã giao', NULL)
GO
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD001', CAST(N'2023-02-01' AS Date), N'NV003', N'0001')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD002', CAST(N'2023-02-01' AS Date), N'NV003', N'0002')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD003', CAST(N'2023-02-06' AS Date), N'NV003', N'0003')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD004', CAST(N'2023-02-17' AS Date), N'NV003', N'0004')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD005', CAST(N'2023-02-22' AS Date), N'NV003', N'0005')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD006', CAST(N'2023-03-28' AS Date), N'NV004', N'0006')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD007', CAST(N'2023-03-13' AS Date), N'NV004', N'0007')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD008', CAST(N'2023-03-15' AS Date), N'NV005', N'0008')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD009', CAST(N'2023-03-09' AS Date), N'NV005', N'0009')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD010', CAST(N'2023-04-08' AS Date), N'NV006', N'0010')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD011', CAST(N'2023-04-14' AS Date), N'NV006', N'0011')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD012', CAST(N'2023-04-13' AS Date), N'NV007', N'0012')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD013', CAST(N'2023-04-15' AS Date), N'NV007', N'0013')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD014', CAST(N'2023-04-11' AS Date), N'NV004', N'0014')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD015', CAST(N'2023-04-03' AS Date), N'NV003', N'0015')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD016', CAST(N'2023-04-02' AS Date), N'NV005', N'0016')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD017', CAST(N'2023-04-01' AS Date), N'NV006', N'0017')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD018', CAST(N'2023-01-13' AS Date), N'NV005', N'0018')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD019', CAST(N'2023-01-15' AS Date), N'NV006', N'0019')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD020', CAST(N'2023-01-14' AS Date), N'NV004', N'0022')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD021', CAST(N'2023-04-02' AS Date), N'NV003', N'0019')
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNV], [MaKH]) VALUES (N'HD022', CAST(N'2023-04-03' AS Date), N'NV004', N'0022')
GO
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD001', N'DD001', N'NV003')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD002', N'DD002', N'NV004')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD003', N'DD003', N'NV005')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD004', N'DD004', N'NV006')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD005', N'DD005', N'NV007')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD006', N'DD006', N'NV003')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD007', N'DD007', N'NV004')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD008', N'DD008', N'NV005')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD009', N'DD009', N'NV006')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD010', N'DD010', N'NV007')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD011', N'DD011', N'NV004')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD012', N'DD012', N'NV003')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD013', N'DD013', N'NV006')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD014', N'DD014', N'NV007')
INSERT [dbo].[HoaDonDD] ([MaHoaDonDD], [MaDonDat], [MaNV]) VALUES (N'HDDD015', N'DD015', N'NV005')
GO
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0001', N'Lê Văn Mỹ', N'41 đường số 19, khu Phú Mỹ Hưng, P.Tân Phú, Q.7, TP.HCM', N'0838414567', N'LeVanMy@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0002', N'Phạm Việt Anh', N'1765A Đại Lộ Bình Dương, P.Hiệp An-Thủ Dầu 1, Tỉnh Bình Dương', N'0838414567', N'VietAnh@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0003', N'Bùi Thị Quỳnh Anh', N'18 Lam Sơn, P.2, Q.Tân Bình, TP.HCM', N'0838414567', N'QunhAnh@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0004', N'Vũ Đức Anh', N'G4-22/1 Nguyễn Thái Học, P.7, TP.Vũng Tàu', N'0838414567', N'ThaiHOc@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0005', N'Nguyễn Phùng Linh Chi', N'68 Hồ Xuân Hương, Q.Ngũ Hành Sơn.TP.Đà Nẵng', N'0838414567', N'LinhChi@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0006', N'Dương Mỹ Dung', N'Đảo Hòn Tre, Vĩnh Nguyên, Nha Trang, tình Khánh Hòa', N'0838414567', N'MyDung@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0007', N'Nguyễn Mạnh Duy', N'23 Lê Lợi, Q.1, TP.HCM', N'0838414567', N'ManhDuyy@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0008', N'Phạm Phương Duy', N'Biên Hòa, Đồng Nai', N'0838414567', N'Phuongduy@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0009', N'Nguyễn Thùy Dương', N'96 Võ Thị Sáu, P.Tân Định, Q.1, TP.HCM', N'0838414567', N'ThuyDuong@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0010', N'Lưu Minh Hằng', N'25 Nguyễn Văn Linh, khu Phú Mỹ Hưng, Q.7, TP.HCM', N'0838414567', N'MinhHang@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0011', N'Nguyễn Hữu Minh Hoàng', N'41 đường số 19, khu Phú Mỹ Hưng, P.Tân Phú, Q.7, TP.HCM', N'0838414567', N'MinhHoang@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0012', N'Nguyễn Đức Huy', N'92 Nguyễn Hữu Cảnh, P.22, Q.Bình Tân', N'0838414567', N'HuuCanh@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0013', N'Vũ Đức Huy', N'P.Hòa Hải, Q.Ngũ Hành Sơn, TP.Đà Nẵng', N'0838414567', N'DucHuy@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0014', N'Nguyễn Minh Khuê', N'23 Lê Lợi, Q.1,TP.HCM', N'0838414567', N'MinhKhue@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0015', N'Nguyễn Phúc Lộc', N' đường số 2, Tăng Nhơn Phú B,TP.Thủ Đức', N'0838414567', N'PhucLoc@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0016', N'Trịnh Xuân Minh', N'đường số 19, Tăng Nhơn Phú B,TP.Thủ Đức', N'0838414567', N'XuanTrinh@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0017', N'Hoàng Kim Ngân', N'120 Lê Văn Việt, TP.Thủ Đức', N'0838414567', N'KimNgan@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0018', N'Lê Văn Hưởng', N'đường số 12, Tăng Nhơn Phú B,TP.Thủ Đức', N'0838414963', N'VanHuong@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0019', N'Trịnh Ái Đào', N'Ngã 5 Chuồng Chó, Gò Vấp', N'0838414475', N'AiDao@gmail.com', N'Nu')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0020', N'Lương kiều Anh', N'78/11, Trần Xuân Soạn, Quận 7', N'0838414365', N'KieuAnh@gmail.com', N'Nu')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0021', N'Lý Ngọc Hiên', N'102, Man Thiện, TP.Thủ Đức', N'0838414354', N'NgocHien@gmail.com', N'Nu')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0022', N'Bùi Vinh Hiển', N'111 Tam Hà,TP.Thủ Đức', N'08384145215', N'VinhHien@gmail.com', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0023', N'Trịnh Kiều ÂN', N'11/45, Buôn Mê Thuột, ĐăkLăk', N'0838414125', N'KieuAn@gmail.com', N'Nu')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0024', N'Lê Thị Hiền', N'CuKuin, ĐăLăk', N'0838414598', N'HienLeh@gmail.com', N'Nu')
INSERT [dbo].[KhachHang] ([MaKH], [HoTenKH], [DiaChiKH], [SDTKH], [EmailKH], [GioiTinhKH]) VALUES (N'0025', N'Lê Văn Lợi', N'Buôn Mê Thuột, ĐăkLăk', N'0335042136', N'VanLoi@gmail.com', N'Nam')
GO
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'brown', N'màu nâu')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'creamwhite', N'màu kem')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'lemonyellow', N'màu vàng chanh')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'lightsand', N'màu cát')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'ligthgreen', N'màu xanh sáng')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'mediumyellow', N'màu vàng trung')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'oceangreen', N'màu xanh nước biển')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'orangeyellow', N'màu vàng cam')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'orche', N'màu đất son')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'sand', N'màu cát sáng')
INSERT [dbo].[MauSac] ([MaMS], [TenMauSac]) VALUES (N'wood', N'màu gỗ')
GO
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChiNCC], [DienThoaiNCC], [FaxNCC], [EmailNCC]) VALUES (N'CC001', N'Nội Thất Mộc Việt', N'106/1N Đường Tân Hiệp 17, ấp Tân Thới 2, Hóc Môn, Tp. Hồ Chí Minh ', N'0162595188', N'0939.39.657', N'noithatmocviet106@gmail.com')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChiNCC], [DienThoaiNCC], [FaxNCC], [EmailNCC]) VALUES (N'CC002', N'Nội Thất Trúc Linh ', N'Số 51/97 Văn Cao, Q. Ba Đình, Hà Nội', N'0903232317', N'0903232311', N'info@truclinh.vn')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChiNCC], [DienThoaiNCC], [FaxNCC], [EmailNCC]) VALUES (N'CC003', N'Nội Thất Minh Tiến', N'Tầng 9, Tòa nhà Sở Công Thương, 163 Hai Bà Trưng, Phường 6, Quận 3, Tp. Hồ Chí  ', N'0139118383', N'39118385', N'minhtien@mtic.vn')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChiNCC], [DienThoaiNCC], [FaxNCC], [EmailNCC]) VALUES (N'CC004', N'Nội Thất Đại Phát', N'Số 18, Đường Số 9, Tổ 74, Khu Phố 3, P. Trung Mỹ Tây, Q. 12, Tp. Hồ Chí Minh  ', N'0162576254', N'62576255', N'daiphat26@gmail.com')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChiNCC], [DienThoaiNCC], [FaxNCC], [EmailNCC]) VALUES (N'CC005', N'Thiết Kế Nội Thất Nam Hà', N'TDP Đồi Cao, TT. Hợp Châu, H. Tam Đảo, Vĩnh Phúc', N'0972 239 368', N'0975 288 106', N'noithatnamha.68@gmail.com')
GO
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV002', N'Lê Thị Hoa', N'NỮ', N'0398874123', N'LeHoa@gmail.com', N'2')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV003', N'Lý Thị Thu', N'NỮ', N'0398874112', N'ThuThug@gmail.com', N'3')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV004', N'Nguyễn Văn Tấn', N'NAM', N'0398874113', N'TanNguyen@gmail.com', N'3')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV005', N'Phan Văn Anh', N'NAM', N'0398874114', N'PhanAnh@gmail.com', N'3')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV006', N'Trần Thị Thanh', N'NỮ', N'0398874115', N'ThanhThanh@gmail.com', N'3')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'NV007', N'Trương Thị Như', N'NỮ', N'0398874116', N'TruongNhug@gmail.com', N'3')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [SDT], [Email], [MaCV]) VALUES (N'QL001', N'Nguyễn Thuy Dung', N'NỮ', N'0398874556', N'ThuyDung@gmail.com', N'1')
GO
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH001', CAST(N'2011-03-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH0010', CAST(N'2023-02-05' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH002', CAST(N'2023-01-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH003', CAST(N'2023-01-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH004', CAST(N'2023-01-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH005', CAST(N'2023-01-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH006', CAST(N'2023-02-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH007', CAST(N'2023-02-07' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH008', CAST(N'2023-02-01' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH009', CAST(N'2023-02-05' AS Date), N'NV002', N'CC001')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2001', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2002', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2003', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2004', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2005', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2006', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2007', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2008', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2009', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH2010', CAST(N'2023-02-05' AS Date), N'NV002', N'CC002')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3001', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3002', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3003', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3004', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3005', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3006', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3007', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3008', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH3009', CAST(N'2023-01-13' AS Date), N'NV002', N'CC003')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4001', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4002', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4003', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4004', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4005', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4006', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4007', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH4008', CAST(N'2023-01-16' AS Date), N'NV002', N'CC004')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH5001', CAST(N'2023-01-17' AS Date), N'NV002', N'CC005')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH5002', CAST(N'2023-01-17' AS Date), N'NV002', N'CC005')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH5003', CAST(N'2023-01-17' AS Date), N'NV002', N'CC005')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH5004', CAST(N'2023-01-17' AS Date), N'NV002', N'CC005')
INSERT [dbo].[NhapHang] ([MaNhapHang], [NgayNhapHang], [MaNV], [MaNCC]) VALUES (N'NH5005', CAST(N'2023-01-17' AS Date), N'NV002', N'CC005')
GO
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr001', N'Ngoại thất')
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr002', N'Nội thất phòng khách')
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr003', N'Nội thất phòng ngủ')
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr004', N'Nội thất phòng bếp')
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr005', N'Sàn gỗ')
INSERT [dbo].[Nhom] ([MaNhom], [TenNhom]) VALUES (N'gr006', N'Đồ trang trí')
GO
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT001', N'Bàn ngoài trời YO', 100, 5000000, CAST(N'2011-03-01' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'sand')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT0010', N'Ghế dài 3 chỗ', 50, 4000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT002', N'Ghế ngoài trời Angela Alu', 120, 25000000, CAST(N'2023-01-01' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'oceangreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT003', N'Ghế ngoài trời Tuka boc vải Samoa SQB', 110, 3500000, CAST(N'2023-01-01' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'creamwhite')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT004', N'Ghế xếp Lorette Lagoon blue 570146', 60, 1000000, CAST(N'2023-01-01' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'orangeyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT005', N'Bàn bên Stulle CB5209-P E P7L/P97W', 70, 1500000, CAST(N'2023-01-01' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT006', N'Bàn bên Stulle P98W', 70, 1400000, CAST(N'2023-02-01' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT007', N'Bàn ngoài trời Easy màu saffron', 100, 4500000, CAST(N'2023-02-07' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT008', N'Ghế tắm nắng Alize Xs Nutmeg', 100, 6000000, CAST(N'2023-02-01' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'NT009', N'Bàn ngoài trời Fermob Sixties', 80, 3600000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'sand')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB001', N'Bàn ăn 1m8 Elegance màu nâu', 100, 7400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'oceangreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB002', N'Ghế ăn có tay Elegance màu nâu', 90, 2400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'orche')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB003', N'Bench Elegance màu nâu da Cognac', 50, 5400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl002', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB004', N'Tủ Rượu Gujilow 410071Z', 50, 14000000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'sand')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB005', N'Xe đẩy đồ ăn Giro', 40, 1400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'oceangreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB006', N'Bàn ăn 1m8 Elegance màu tự nhiên', 50, 9400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'orche')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB007', N'Ghế ăn có tay Elegance màu tự nhiên', 100, 3100000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PB008', N'Bench Elegance màu tự nhiên da cognac', 80, 4400000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr004', N'cl002', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK001', N'Bàn nước Mây - 2 Modul', 50, 4000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl005', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK0010', N'Bàn nước Thin', 100, 1400000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl003', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK002', N'Bàn bên Osaka', 50, 3000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK003', N'Kệ sách Osaka', 50, 7000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'orangeyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK004', N'Tượng con chim gỖ lớn 21847', 50, 600000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'lemonyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK005', N'Sofa Miami 2 chỗ hiện đại vải xanh', 50, 34000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'lightsand')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK006', N'Bàn nước Rumba', 40, 4000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl002', N'lightsand')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK007', N'Tủ tivi Elegance màu tự nhiên', 55, 4000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'wood')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK008', N'Bàn nước Elegance màu tự nhiên', 70, 5000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'brown')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PK009', N'Kệ sách Division F – màu trắng', 50, 7000000, CAST(N'2023-02-05' AS Date), N'hàng nội nhập', N'gr002', N'cl001', N'wood')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN001 ', N'Bàn Console Addict', 50, 1800000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl002', N'wood')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN002', N'Bàn đầu giường Cabo PMA532058 F1', 40, 1400000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl006', N'creamwhite')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN003', N'Giường Cabo 1m8 PMA940025', 30, 12000000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr001', N'cl001', N'wood')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN004', N'Bàn trang điểm Mây - Mẫu 2', 100, 2300000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl005', N'orche')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN005', N'Tủ áo Maxine', 100, 1400000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl001', N'orangeyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN006', N'Bàn đầu giường Maxine', 100, 1400000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl003', N'mediumyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN007', N'Giường ngủ bọc vải Skagen 1m6 màu', 100, 19000000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl001', N'wood')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN008', N'Bàn đầu giường Skagen bên trái', 100, 1300000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl003', N'ligthgreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'PN009', N'Armchair Garbo xanh', 100, 5400000, CAST(N'2023-01-13' AS Date), N'hàng nội nhập', N'gr003', N'cl001', N'oceangreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'TT001', N'Bảng treo chìa khóa', 80, 300000, CAST(N'2023-01-17' AS Date), N'hàng nội nhập', N'gr006', N'cl006', N'mediumyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'TT002', N'Bình Aline xanh XS 16x16x16 23102J', 80, 300000, CAST(N'2023-01-16' AS Date), N'hàng nội nhập', N'gr006', N'cl001', N'ligthgreen')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'TT003', N'Bình con bướm 60464K', 80, 400000, CAST(N'2023-01-17' AS Date), N'hàng nội nhập', N'gr006', N'cl001', N'orangeyellow')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'TT004', N'Bộ hai chân nến Orche 10x30 29078J', 80, 400000, CAST(N'2023-01-17' AS Date), N'hàng nội nhập', N'gr006', N'cl001', N'orche')
INSERT [dbo].[SanPham] ([MaSP], [TeSanPham], [SoLuong], [GiaBan], [NgayNhap], [MoTa], [MaNhom], [MaChatLieu], [MaMS]) VALUES (N'TT005', N'Chậu hoa rừng gỗ nâu vừa 16x16x14 22775', 80, 900000, CAST(N'2023-01-17' AS Date), N'hàng nội nhập', N'gr006', N'cl001', N'wood')
GO
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT001', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT002', 100)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT003', 55)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT004', 60)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT005', 35)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT006', 70)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT007', 100)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT008', 100)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT009', 80)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'NT0010', 20)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK001', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK002', 25)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK003', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK004', 25)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK005', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK006', 20)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK007', 55)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK008', 35)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK009', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PK0010', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN001', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN002', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN003', 10)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN004', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN005', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN006', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN007', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN008', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PN009', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB001', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB002', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB003', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB004', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB005', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB006', 40)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB007', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'PB008', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'TT001', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'TT002', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'TT003', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'TT004', 50)
INSERT [dbo].[SoLuongTon] ([MaSP], [SoLuongTon]) VALUES (N'TT005', 50)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MaNV_NhanVien]    Script Date: 4/21/2023 10:13:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_MaNV_NhanVien] ON [dbo].[NhanVien]
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MaNV_MaNCC_NhapHang]    Script Date: 4/21/2023 10:13:53 PM ******/
CREATE NONCLUSTERED INDEX [idx_MaNV_MaNCC_NhapHang] ON [dbo].[NhapHang]
(
	[MaNV] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BaoCao]  WITH CHECK ADD  CONSTRAINT [fk_bc_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[BaoCao] CHECK CONSTRAINT [fk_bc_MaNV]
GO
ALTER TABLE [dbo].[CTDonDatHang]  WITH CHECK ADD  CONSTRAINT [fk_ctddh_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[CTDonDatHang] CHECK CONSTRAINT [fk_ctddh_MaSP]
GO
ALTER TABLE [dbo].[CTHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_cthd_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[CTHoaDon] CHECK CONSTRAINT [fk_cthd_MaSP]
GO
ALTER TABLE [dbo].[CTNhapHang]  WITH CHECK ADD  CONSTRAINT [fk_ctnh_MaNhapHang] FOREIGN KEY([MaNhapHang])
REFERENCES [dbo].[NhapHang] ([MaNhapHang])
GO
ALTER TABLE [dbo].[CTNhapHang] CHECK CONSTRAINT [fk_ctnh_MaNhapHang]
GO
ALTER TABLE [dbo].[CTNhapHang]  WITH CHECK ADD  CONSTRAINT [fk_ctnh_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[CTNhapHang] CHECK CONSTRAINT [fk_ctnh_MaSP]
GO
ALTER TABLE [dbo].[DonDatHang]  WITH CHECK ADD  CONSTRAINT [fk_ddh_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonDatHang] CHECK CONSTRAINT [fk_ddh_MaKH]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [fk_hd_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [fk_hd_MaKH]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [fk_hd_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [fk_hd_MaNV]
GO
ALTER TABLE [dbo].[HoaDonDD]  WITH CHECK ADD  CONSTRAINT [fk_hddd_MaDonDat] FOREIGN KEY([MaDonDat])
REFERENCES [dbo].[DonDatHang] ([MaDonDat])
GO
ALTER TABLE [dbo].[HoaDonDD] CHECK CONSTRAINT [fk_hddd_MaDonDat]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [fk_mcv] FOREIGN KEY([MaCV])
REFERENCES [dbo].[ChucVu] ([MaCV])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [fk_mcv]
GO
ALTER TABLE [dbo].[NhapHang]  WITH CHECK ADD  CONSTRAINT [fk_nh_MaNCC] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[NhapHang] CHECK CONSTRAINT [fk_nh_MaNCC]
GO
ALTER TABLE [dbo].[NhapHang]  WITH CHECK ADD  CONSTRAINT [fk_nh_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[NhapHang] CHECK CONSTRAINT [fk_nh_MaNV]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [fk_MaChatLieu] FOREIGN KEY([MaChatLieu])
REFERENCES [dbo].[ChatLieu] ([MaChatLieu])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [fk_MaChatLieu]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [fk_MaMS] FOREIGN KEY([MaMS])
REFERENCES [dbo].[MauSac] ([MaMS])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [fk_MaMS]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [fk_MaNhom] FOREIGN KEY([MaNhom])
REFERENCES [dbo].[Nhom] ([MaNhom])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [fk_MaNhom]
GO
ALTER TABLE [dbo].[SoLuongTon]  WITH CHECK ADD  CONSTRAINT [fk_slt_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[SoLuongTon] CHECK CONSTRAINT [fk_slt_MaSP]
GO
/****** Object:  StoredProcedure [dbo].[sp_donhanglonhon20trieu]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[sp_donhanglonhon20trieu]
	as
		select DonDatHang.MaDonDat,MaKH,NgayLap,NgayGiao,DiaChiGiao,TinhTrang,GhiChu,
				sum(SoLuongDat*DonGia) as TongTriGiaDonDat
		from DonDatHang join CTDonDatHang on DonDatHang.MaDonDat=CTDonDatHang.MaDonDat
		group by DonDatHang.MaDonDat,MaKH,NgayLap,NgayGiao,DiaChiGiao,TinhTrang,GhiChu
		having sum(SoLuongDat*DonGia) >20000000
GO
/****** Object:  StoredProcedure [dbo].[sp_hienthiHD]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_hienthiHD] @mahoadon varchar(10)
	as
		declare   @tensp nvarchar(100), @soluong int, @dongia  int
		--khai báo con trỏ
		declare hienthiHD_cursor cursor
		for
			select  TeSanPham, SoLuongSP, DonGia
			from SanPham join CTHoaDon on SanPham.MaSP=CTHoaDon.MaSP
			where MaHoaDon =@mahoadon
		--mở con trỏ
		open hienthiHD_cursor
		print N' ********DANH SÁCH CÁC SẢN PHẨM ĐƯỢC MUA TRONG HOÁ ĐƠN ********'
		--duyệt từng dòng
		fetch next from hienthiHD_cursor into  @tensp , @soluong , @dongia  

		--kiểm tra
		while @@fetch_status =0
		begin
			print N'Tên sản phẩm: '+ @tensp 
			print N'Số lượng: '+ CONVERT(VARCHAR(20), @soluong )
			print N'Đơn giá bán: '+ CONVERT(VARCHAR(20), @dongia )
			print '********-----------------**************'
			

			fetch next from hienthiHD_cursor into   @tensp , @soluong , @dongia  
		end
		close hienthiHD_cursor

		--giải phóng vùng nhớ con trỏ
		deallocate hienthiHD_cursor
GO
/****** Object:  StoredProcedure [dbo].[sp_hp3]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_hp3] @MaHoaDon varchar(20)
as
select HoTenKH, CTHoaDon.MaHoaDon, NgayLap, dbo.f_hp3(@MaHoaDon) as tonggiatriHD
from KhachHang join (HoaDon join CTHoaDon on HoaDon.MaHoaDon=CTHoaDon.MaHoaDon)
                                on KhachHang.MaKH=HoaDon.MaKH
where HoaDon.MaHoaDon=@MaHoaDon
GO
/****** Object:  StoredProcedure [dbo].[sp_kiemtraSoLuongTon]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[sp_kiemtraSoLuongTon] @maSP varchar(10)
	as
	declare @soluongton int
	select @soluongton=SoLuongTon
	from SoLuongTon
	where MaSP=@maSP
	if @soluongton > 25
		begin
			print N'Còn hàng để bán' 
			print N'Số lượng tồn hiện tại là: '+ cast(@soluongton as nvarchar(100))
		end

	else
		begin 
			print N'Số lượng tồn hiện tại là: '+ cast(@soluongton as nvarchar(100))
			print N'Cần nhập thêm hàng để bán'
		end
GO
/****** Object:  StoredProcedure [dbo].[sp_sanphamdatnhieunhat]    Script Date: 4/21/2023 10:13:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[sp_sanphamdatnhieunhat] @tungay datetime, @denngay datetime, 
				@solandathang int output, @masp varchar(10) output
	as
		select top(1)  @solandathang= count(CTDonDatHang.MaDonDat) ,@masp=MaSP
		from DonDatHang  join CTDonDatHang  on DonDatHang.MaDonDat=CTDonDatHang.MaDonDat
		where NgayLap >=@tungay and NgayLap <=@denngay
		group by MaSP
		order by count(CTDonDatHang.MaDonDat)  desc
GO
USE [master]
GO
ALTER DATABASE [CuaHangVIWOOD5] SET  READ_WRITE 
GO
