USE CuaHangVIWOOD5


/*************************CÂU TRUY VẤN *****************/

--1. Câu truy vấn 1----
Select MaDonDat, NgayLap, NgayGiao, TinhTrang
from DonDatHang
where NgayLap between '2023-02-01' and '2023-03-28'

--2.câu truy vấn 2--------
select SanPham.MaSP, TeSanPham, GiaBan, SoLuongTon
from CTNhapHang join (SanPham join SoLuongTon 
on SanPham.MaSP=SoLuongTon.MaSP)
on CTNhapHang.MaSP=SanPham.MaSP
where  SoLuongTon =CTNhapHang.SoLuong
Order by GiaBan ASC

--3.Câu truy vấn 3------
select HoTenKH,HoaDon.MaKH, count(HoaDon.MaKH) as solanmua
from KhachHang join HoaDon on KhachHang.MaKH=HoaDon.MaKH
group by HoTenKH,HoaDon.MaKH
having count(HoaDon.MaKH)>=2

--4.Câu truy vấn 4------
select MaNV, HoTen, GioiTinh
from NhanVien join ChucVu on NhanVien.MaCV =ChucVu.MaCV
Where TenCV=N'Nhân viên bán hàng'


/*********** TẠO KHUNG NHÌN - VIEW*******************/

/*1.Tạo view vw_NhanvienBH thể hiện tất cả các thông tin về 
các nhân viên có chức vụ là "Nhân viên bán hàng*/
create view vw_NhanvienBH
as
select MaNV, HoTen, GioiTinh, SDT, Email, TenCV
from NhanVien join ChucVu on NhanVien.MaCV=ChucVu.MaCV
where TenCV ='Nhân viên bán hàng'

--- kiểm thử
select *
from vw_NhanvienBH

/*2.Tạo view vwNV_BanHangTop Lấy ra danh sách nhân viên 
(Mã nhân viên, tên nhân viên, số đơn đã bán) bán được trên 3 đơn hàng trong năm 2023*/
create view vwNV_BanHangTop
as
select HoaDon.MaNV, HoTen, count(HoaDon.MaNV) as SoDonBan
from NhanVien join HoaDon on NhanVien.Manv=HoaDon.MaNV
where year(NgayLap)='2023'
group by HoaDon.MaNV, HoTen
having count(HoaDon.MaNV)>=3

--- kiểm thử
select *
from vwNV_BanHangTop

/*3.Tạo view vwKH_VIP lấy ra danh sách khách hàng nào mua hàng trên ít nhất 2 lần. 
Hiển thị thông tin khách hàng, tổng số lần mua*/
create view vwKH_VIP
as
select HoaDon.MaKH, HoTenKH, DiaChiKH, SDTKH, EmailKH, 
GioiTinhKH, count(HoaDon.MaKH) as SoLanMua
from KhachHang join HoaDon on KhachHang.MaKH=HoaDon.MaKH
where year(NgayLap)='2023'
group by HoaDon.MaKH, HoTenKH, DiaChiKH, SDTKH, EmailKH, GioiTinhKH
having count(HoaDon.MaKH)>=2

--- kiểm thử
select *
from vwKH_VIP

/*4.Tạo view vwSLT_SanPhamNT thông tin của các sản phẩm (Mã sản phẩm, Tên Sản Phẩm, số lượng tồn)
thuộc nhóm “gr004” có số lượng tồn trên 50 sản phẩm.*/
create view vwSLT_SanPhamNT
as
select SanPham.MaSP, TeSanPham, SoLuongTon
from SanPham join SoLuongTon on SanPham.MaSP=SoLuongTon.MaSP
where MaNhom=N'gr004' and SoLuongTon>40

--- kiểm thử
select *
from vwSLT_SanPhamNT

/*5.Tạo view vwSP_NoiThatGiaRe cho biết thông tin gồm mã sản phẩm, 
tên sản phẩm, giá bán của sản phẩm, với giá nhỏ hơn 2.000.000.*/
create view vwSP_NoiThatGiaRe
as
select MaSP, TeSanPham, GiaBan
from SanPham 
where GiaBan<2000000

--- kiểm thử
select *
from vwSP_NoiThatGiaRe

/*6.Tạo view vwSP_BanChay cho biết thông tin gồm mã sản phẩm, tên sản phẩm,
giá bán của sản phẩm được mua ít nhất 2 lần.*/
create view vwSP_BanChay
as
select SanPham.MaSP, TeSanPham, GiaBan, count(CTDonDatHang.MaSP) as SoLanMua
from SanPham join CTDonDatHang on SanPham.MaSP=CTDonDatHang.MaSP
group by SanPham.MaSP, TeSanPham, GiaBan
having count(CTDonDatHang.MaSP)>=2

--- kiểm thử
select *
from vwSP_BanChay

/*7.Tạo khung nhìn cho biết mã sản phẩm, tên sản phẩm và sản phẩm 
có số lượng đặt cao nhất trong ngày ‘01/02/2023’.*/
create view vwSP_MaxLuongDat
as
select SanPham.MaSP, TeSanPham, DonGia, sum(SoLuongDat) as maxSoLuongDat
from DonDatHang join (SanPham join CTDonDatHang on SanPham.MaSP= CTDonDatHang.MaSP) 
on DonDatHang.MaDonDat=CTDonDatHang.MaDonDat
where NgayLap='2023-02-01'
group by SanPham.MaSP, TeSanPham, DonGia
having sum(SoLuongDat)>=all
(
select SoLuongDat
from CTDonDatHang
)
drop view vwSP_MaxLuongDat


--- kiểm thử
select *
from vwSP_MaxLuongDat





/*************************FUNCTION**********************/
---1.
create function f_dulichHA (@MaNV varchar(20))
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
--- kiểm thử
select dbo.f_dulichHA ('NV005')

---2.
create function f_HDthang (@tungay date, @denngay date)
returns table
as
return(
select HoaDon.MaHoaDon, NgayLap, SanPham.MaSP, TeSanPham, SoLuongSP
from HoaDon join (CTHoaDon join SanPham on CTHoaDon.MaSp=SanPham.MaSP)
  on HoaDon.MaHoaDon=CTHoaDon.MaHoaDon
where NgayLap between @tungay and @denngay)

--- kiểm thử
select* from dbo.f_HDthang ('2023-01-01','2023-02-12')

---3
create function f_hp3 (@MaHoaDon varchar(20))
returns float
as
begin
declare @tonggiatriHD float
select @tonggiatriHD=sum(SoLuongSP*DonGia)
from CTHoaDon
where MaHoaDon =@MaHoaDon 
return @tonggiatriHD
end

--- Tạo thủ tục gọi hàm
create proc sp_hp3 @MaHoaDon varchar(20)
as
select HoTenKH, CTHoaDon.MaHoaDon, NgayLap, dbo.f_hp3(@MaHoaDon) as tonggiatriHD
from KhachHang join (HoaDon join CTHoaDon on HoaDon.MaHoaDon=CTHoaDon.MaHoaDon)
                                on KhachHang.MaKH=HoaDon.MaKH
where HoaDon.MaHoaDon=@MaHoaDon

--- kiểm thử
select dbo.f_hp3 ('HD005')

exec sp_hp3 'HD005'




--**********SYNONYM*******---------------------


--1. Tạo synonym truy xuất vào bảng NhapHang do người dùng là dbo làm chủ sở hữu

	/*Câu lệnh*/
	create synonym NH
	for dbo.NhapHang

		/* Kiểm thử*/
	select * from NH


--2. Tạo synonym truy xuất vào bảng NhanVien do người dùng là dbo làm chủ sở hữu


	/* Câu lệnh*/
	create synonym NV
	for dbo.NhanVien

	/* Kiểm thử*/
	select * from NV

--3. Tạo synonym bảng Chất liệu  do người dùng là dbo làm chủ sở hữu
	/* Câu lệnh*/
	create synonym CL
	for dbo.ChatLieu

	/* Kiểm thử*/
	select * from CL

-- Hiển thị danh sách các synonym của Cửa hàng Viwoods
	select name, base_object_name, type
	from sys.synonyms
	order by name




---***************INDEX*******-------------------


   /* 1. Tạo chỉ mục với tên bất kì cho cột Tên Sản phẩm trong bảng sản phẩm (SINGLE-COLUMN INDEX) */

   --câu lệnh
	create index idx_TenSP_SanPham
	on SanPham(TeSanPham)




-- kiểm thử
	select *
	from SanPham
	with (index (idx_TenSP_SanPham))
	where TeSanPham like N'Kệ sách%'


-- xoá index
drop index SanPham.idx_TenSP_SanPham

 /* 2. Tạo chỉ mục với tên bất kì cho cột Mã nhân viên trong bảng Nhân viên (UNIQUE –INDEX)*/

 -- câu lệnh
	CREATE UNIQUE INDEX idx_MaNV_NhanVien
	ON NhanVien (MaNV);

-- kiểm thử : Xuất ra thông tin Nhân Viên có mã ‘NV005’
	select *
	from NhanVien
	with (index (idx_MaNV_NhanVien))
	where MaNV= 'NV005'

-- xoá index
drop index NhanVien.idx_MaNV_NhanVien

/* 3. Tạo chỉ mục cho cột Mã nhân viên, Mã nhà cung cấp trong bảng Nhập hàng (Composite Index )*/

-- câu lệnh
	create index idx_MaNV_MaNCC_NhapHang
	on NhapHang(MaNV,MaNCC)

-- kiểm thử: Cho biết thông tin của Phiếu Nhập hàng do nhân viên có mã ‘NV002’ nhập liệu và Nhà cung 
--cấp có mã ‘CC004’ cung cấp hàng
	
	select *
	from NhapHang
	with (index (idx_MaNV_MaNCC_NhapHang))
	where MaNV='NV002' and MaNCC='CC004'




---************STORED PROCEDURE ***********----------------

-- 1. Cho biết Mã sản phẩm, Tên sản phẩm và Số lượng tồn của từng mặt hàng thuộc loại hàng Đồ trang trí

	-- câu lệnh
		create proc sp_soluongton_Dotrangtri
	as
		select SanPham.MaSP, TeSanPham, SoLuongTon.SoLuongTon
		from Nhom join (SanPham join SoLuongTon on SanPham.MaSP=SoLuongTon.MaSP)
				on Nhom.MaNhom=SanPham.MaNhom
		where Nhom.TenNhom =N'Đồ trang trí'

	-- kiểm thử
	exec sp_soluongton_Dotrangtri

	--xoá proc
	drop proc sp_soluongton_Dotrangtri

--2. Tạo thủ tục cho biết thông tin đơn đặt hàng có trị giá đơn đặt hàng lớn hơn  20 triệu
	-- câu lệnh
	create proc sp_donhanglonhon20trieu
	as
		select DonDatHang.MaDonDat,MaKH,NgayLap,NgayGiao,DiaChiGiao,TinhTrang,GhiChu,
				sum(SoLuongDat*DonGia) as TongTriGiaDonDat
		from DonDatHang join CTDonDatHang on DonDatHang.MaDonDat=CTDonDatHang.MaDonDat
		group by DonDatHang.MaDonDat,MaKH,NgayLap,NgayGiao,DiaChiGiao,TinhTrang,GhiChu
		having sum(SoLuongDat*DonGia) >20000000

	-- kiểm thử
	exec  sp_donhanglonhon20trieu


	-- xoá proc
	drop proc sp_donhanglonhon20trieu

--3. Tạo thủ tục với tên bất kì cho biết Tên sản phẩm, Giá bán, Mô tả, Nhóm sản phẩm, 
-- màu sắc của những sản có chất liệu làm bằng Nứa, trong đó Mã sản phẩm do người dùng nhập vào.

	-- câu lệnh
	create proc sp_SanPhamNua @maSP varchar(10)
	as
		select TeSanPham, GiaBan,MoTa, MaNhom,TenChatLieu,TenMauSac
		from ChatLieu CL join (SanPham SP join  MauSac MS on SP.MaMS=MS.MaMS)
					on CL.MaChatLieu=SP.MaChatLieu
		where TenChatLieu =N'nứa' and MaSP=@maSP
	
	-- kiểm thử
	exec sp_SanPhamNua 'TT001'
	exec sp_SanPhamNua 'PN002'

	--xoá proc
	drop proc sp_SanPhamNua

--4. Tạo thủ tục với tên bất kì để xem số lượng nhập hàng của sản phẩm với Mã sản phẩm là tham 
--số truyền vào, nếu số lượng > 25 thì thông báo 'Còn hàng để bán ' , ngược lại thông báo 'Cần nhập thêm hàng để bán'

	-- câu lệnh
	create proc sp_kiemtraSoLuongTon @maSP varchar(10)
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

	-- kiểm thử
	exec  sp_kiemtraSoLuongTon 'PN003'


	exec  sp_kiemtraSoLuongTon 'NT006'


	-- xoá proc
	drop proc  sp_kiemtraSoLuongTon


--5. Tạo thủ tục cho biết sản phẩm nào được đặt hàng nhiều nhất từ ngày – đến ngày, với ngày
--đặt là tham số truyền vào, mã sản phẩm và số lần đã đặt là tham số truyền ra.

	-- câu lệnh:
	create proc sp_sanphamdatnhieunhat @tungay datetime, @denngay datetime, 
				@solandathang int output, @masp varchar(10) output
	as
		select top(1)  @solandathang= count(CTDonDatHang.MaDonDat) ,@masp=MaSP
		from DonDatHang  join CTDonDatHang  on DonDatHang.MaDonDat=CTDonDatHang.MaDonDat
		where NgayLap >=@tungay and NgayLap <=@denngay
		group by MaSP
		order by count(CTDonDatHang.MaDonDat)  desc


	-- kiểm thử
	declare @solandathang int
	declare @masp varchar(10) 
	set @solandathang=0
	exec sp_sanphamdatnhieunhat '2023/01/10','2023/02/15', @solandathang output, @masp  output
	print N'Sản phẩm có số lần đặt hàng nhiều nhất là '+@masp
	print N'với số lần đặt là: ' +cast(@solandathang as nvarchar(10))


	--xoá proc
	drop proc sp_sanphamdatnhieunhat

--6. Tạo thủ tục và sử dụng cursor cho biết  Tên sản phẩm, Số lượng, đơn giá bán có trong Hoá đơn bán hàng
--tham số truyền vào là mã hóa đơn  và in ra kết quả bên trong thủ tục.*/

create proc sp_hienthiHD @mahoadon varchar(10)
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

		--kiểm thử
		exec sp_hienthiHD 'HD001'

		--xoá proc
		drop proc sp_hienthiHD

--7.Thủ tục Stored Procedure có lệnh trả về Return
/* Tạo thủ tục tính tổng số lượng hàng nhập về của một mặt hàng đối với nhà cung 
cấp chỉ định, kiểm tra xem mã sản phẩm và mã nhà cung cấp mà người dùng truyền vào 
thủ tục có đúng hay không? Quy định thủ dục trả về 0 khi mã mặt hàng không tồn tại, 
trả về 1 khi mã nhà cung cấp không tồn tại*/

-- câu lệnh
	create proc sp_tinhtongSLDat @mancc varchar(10), @masp varchar(10), @tongSLD int output
	as
		if not exists
		(	select * 
			from CTNhapHang join NhapHang on CTNhapHang.MaNhapHang=NhapHang.MaNhapHang
			where MaSP=@masp and MaNCC=@mancc )
			return 1
		if not exists
		(	select * from CTNhapHang join NhapHang on CTNhapHang.MaNhapHang=NhapHang.MaNhapHang
			where MaSP=@masp and MaNCC=@mancc )
			return 2
		select @tongSLD =sum(SoLuong)
		from CTNhapHang CTNH join NhapHang NH on CTNH.MaNhapHang=NH.MaNhapHang
		where MaNCC=@mancc and MaSP=@masp

		if @tongSLD is null
		set @tongSLD=0 return

-- kiểm thử


	declare @tongSLD int, @ketqua int
	exec @ketqua=sp_tinhtongSLDat 'CC001','NT001', @tongSLD output
	if @ketqua=1
		print N'Mã mặt hàng không hợp lệ'
	else if @ketqua=2
		print N'Nhà cung cấp không hợp lệ'
	else 
		print N'Tổng số lượng đặt là: '+ cast(@tongSLD as nvarchar(100))

-- xoá proc
drop proc sp_tinhtongSLDat




------***********TRANSACTION**************-----------------------

--8. Tạo thủ tục cập nhật Địa chỉ của NCC trong bảng NhaCungCap với tham số Mã NCC do người
--dùng nhập và xác định giao dịch hoàn thành hoặc quay lui giao dịch khi có lỗi
create proc sp_update_diachiNCC @maNCC  varchar(6), @diachimoi nvarchar(100)
as
	if exists (
		select *
		from NhaCungCap
		where MaNCC=@maNCC
		)
	begin transaction
		update NhaCungCap
		set DiaChiNCC=@diachimoi
		where MaNCC=@maNCC
	commit transaction
	if @@error<>0
		begin
			print N'Lỗi cập nhật'
			rollback transaction
		end
	else
		print N'cập nhật địa chỉ nhà cung cấp thành công' 

	-- kiểm thử
	exec sp_update_diachiNCC 'CC002', N'Số 60/60 Văn Cao, Q. Ba Đình, Hà Nội'

	exec sp_update_diachiNCC 'CC002343', N'Số 60/60 Văn Cao, Q. Ba Đình, Hà Nội'

---9. Tạo thủ tục thêm một Nhóm sản phẩm trong bảng Nhom và xác định giao dịch hoàn thành hoặc quay lui khi giao dịch có lỗi.

create proc sp_insert_nhomSP @manhom varchar(10),@tennhom nvarchar(50)
as
	
	if  not exists (
		select *
		from Nhom
		where  @manhom =MaNhom)
	begin transaction
		insert into  Nhom values (@manhom, @tennhom)
	commit transaction
	if @@error<>0
		begin
			print (N'lỗi giao dịch')
			rollback transaction
		end
	else print N'Thêm thông tin nhóm sản phẩm thành công'


	-- kiểm thử
	exec sp_insert_nhomSP 'gr100',N'Bàn ghế trẻ em --new '

	exec sp_insert_nhomSP 'gr001',N'Bàn ghế trẻ em --new '




-----------*************TRIGGER*********_______________

--1. Hãy cài đặt ràng buộc toàn vẹn tự động kiểm tra mỗi khi thêm dữ liệu cho bảng chi tiết đơn 
--đặt hàng và đưa ra thông báo lỗi nếu số lượng đặt > số lượng tồn của bảng SP. Cập nhật lại số lượng
--tồn sau mỗi đơn đặt.

	create trigger tg_SoLuongDat_SoLuongTon
	on CTDonDatHang
	for insert,update
	as
		if exists (
			select *
			from inserted join SoLuongTon on inserted.MaSP=SoLuongTon.MaSP
			where inserted.SoLuongDat > SoLuongTon. SoLuongTon
			)
		begin
			print (N'Số lượng đặt hàng phải nhỏ hơn hoặc bằng số lượng tồn')
			print N'Thao tác thất bại'
			rollback tran
		end
					--Tự động cập nhật lại số lượng tồn sau mỗi đơn đặt
			update SoLuongTon
			set SoLuongTon=SoLuongTon-inserted.SoLuongDat
			from SoLuongTon join inserted on inserted.MaSP=SoLuongTon.MaSP

--kiểm thử
	insert into CTDonDatHang values ('DD100','NT002',200 ,25000000) 
	insert into CTDonDatHang values ('DD100','NT002',20 ,25000000) 

	update CTDonDatHang
	set SoLuongDat='120'
	where MaDonDat='DD100' and MaSP='NT002'

--xoá trigger
	drop trigger tg_SoLuongDat_SoLuongTon

--2. Viết ràng buộc toàn vẹn khi xóa một hóa đơn thì thông báo số lượng chi tiết
--đơn hàng thuộc hóa đơn đó nếu có.

	create trigger tg_XoaHoaDon
	on HoaDon
	for delete
	as
		declare @soluongCTHD int
		select @soluongCTHD=count(CTHoaDon.MaHoaDon)
		from CTHoaDon inner join deleted  on CTHoaDon.MaHoaDon =deleted.MaHoaDon
		where CTHoaDon.MaHoaDon=deleted.MaHoaDon
		
		if @soluongCTHD !=0
			begin 
				print N' Lỗi thao tác'
				print N'Tồn tại '+ cast (@soluongCTHD as nvarchar(100)) +N' chi tiết hoá đơn'
				rollback tran
			end

	-- kiểm thử
	delete from HoaDon 
	where MaHoaDon='HD008'

	--xoá trigger
	drop trigger tg_XoaHoaDon


--3. Cài đặt ràng buộc toàn vẹn khi update hoặc insert số lượng nhập hàng trong bảng 
--chi tiết nhập hàng phải > 0

	create trigger tg_soluongnhap
	on CTNhapHang
	for insert, update
	as
		if exists (
				select *
				from CTNhapHang
				where SoLuong <=0)
			begin 
				print N'Thao tác thất bại'
				print N'Số lượng nhập phải lớn hơn 0'
				rollback tran
			end
		else
			print N'Thao tác thành công'

	-- kiểm thử
	insert into CTNhapHang values (N'CTNH10000 ',N'PN009',N'NH3009',-100)

	insert into CTNhapHang values (N'CTNH10000 ',N'PN009',N'NH3009',300)
				



/-----------------******CẤP QUYỀN******-------------------/
USE CuaHangVIWOOD5
GO
---	Tạo nhóm người dùng USER theo chuyên môn
Create role NhanVienBanHang
Create role QuanLyKho
Create role QuanLy

--- Cấp quyền cho nhóm người dùng 
---Nhóm người dùng là nhân viên bán hàng
grant select on ChatLieu to NhanVienBanHang
grant select on MauSac to NhanVienBanHang
grant select on Nhom to NhanVienBanHang
grant select on SoLuongTon to NhanVienBanHang
grant select on CTHoaDon to NhanVienBanHang
grant select on CTDonDatHang to NhanVienBanHang
grant select, insert, update on DonDatHang to NhanVienBanHang
grant select, insert, update on KhachHang to NhanVienBanHang
grant select, insert, update on HoaDon to NhanVienBanHang
grant select, insert, update on HoaDonDD to NhanVienBanHang

---Nhóm người dùng là nhân viên quản lý kho
grant select on NhaCungCap to QuanLyKho
grant select , insert, update on NhapHang to QuanLyKho
grant select, insert, update on CTNhapHang to QuanLyKho
grant select, insert, update on SoLuongTon to QuanLyKho

---Nhóm người dùng là nhân viên quản lý
grant all to QuanLy with grant option

--- Tạo tài khoản đăng nhập và user cho người dùng
EXEC sp_addlogin 'LeThiHoa','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'LeThiHoa','LeThiHoa'
EXEC sp_addlogin 'LeThiThu','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'LeThiThu','LeThiThu'
EXEC sp_addlogin 'NguyenVanTan','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'NguyenVanTan','NguyenVanTan'
EXEC sp_addlogin 'PhanvanAnh','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'PhanvanAnh','PhanvanAnh'

EXEC sp_addlogin 'TranThiThanh','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'TranThiThanh','TranThiThanh'
EXEC sp_addlogin 'TruongThiNhu','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'TruongThiNhu','TruongThiNhu'

EXEC sp_addlogin 'NguyenThuyDung','CuaHangViWood123', 'CuaHangVIWOOD5'
EXEC sp_adduser 'NguyenThuyDung','NguyenThuyDung'

--- Thêm Người dùng vào nhóm người dùng

sp_addrolemember 'NhanVienBanHang','LeThiThu'
sp_addrolemember 'NhanVienBanHang','NguyenVanTan'
sp_addrolemember 'NhanVienBanHang','PhanvanAnh'
sp_addrolemember 'NhanVienBanHang','TranThiThanh'
sp_addrolemember 'NhanVienBanHang','TruongThiNhu'
sp_addrolemember 'QuanLyKho','LeThiHoa'
sp_addrolemember 'QuanLy','NguyenThuyDung'


select*
from CuaHangVIWOOD5.sys.database_principals
		
	