create database QLBV
ON PRIMARY 
(
	NAME = 'QuanlyBenhVien',
	FILENAME = 'F:\hoctap\Hệ cơ sở dữ liệu\Tiểu luận\Data\QLBV.mdf',
	SIZE = 10MB,
	FILEGROWTH = 20%,
	MAXSIZE = 50MB
)
LOG ON
(
	NAME = 'QLBH_log',
	FILENAME = 'F:\hoctap\Hệ cơ sở dữ liệu\Tiểu luận\Data\QLBV.ldf',
	SIZE = 10MB,
	FILEGROWTH = 10%,
	MAXSIZE = 20MB
)
GO
--------------------------------------------------------------------------------------
USE QLBV
create table NhanVien
(
	MaNV int Not Null,
	TenNV nvarchar(24),
	DiachiNV nvarchar(24),
	SdtNV nvarchar(14),
	Chucdanh nvarchar(24),
	Dantoc nvarchar(24),
	Ghichu nvarchar(15),
	MaK int Not Null
)

create table Khoa
(
	MaK int Not Null,
	TenKhoa nvarchar(24),
	SdtKhoa nvarchar(14)
)

create table BenhNhan
(
	MaBN int Not Null,
	HotenBN nvarchar(24),
	DiachiBN nvarchar(24),
	SdtBN nvarchar(14),
	Nghenghiep nvarchar(24),
	Gioitinh nvarchar(24),
	Ngaysinh DateTime,
	MaBHYT int Not Null
)

create table NguoiThan
(
	HotenNT nvarchar(24) Not Null,
	MaBN int Not Null,
	DiachiNT nvarchar(24),
	SdtNT nvarchar(14),
	Moiquanhe nvarchar(24)
)

create table GiuongBenh
(
	MaGiuong int Not Null,
	Tenphongbenh nvarchar(24),
	DongiaGiuong Money,
	MaK int Not Null,
)

create table Thuoc
(
	MaThuoc int Not Null,
	TenThuoc nvarchar(24),
	Donvitinh nvarchar(24),
	DongiaThuoc Money,
	Xuatxu nvarchar(24),
	MaNCC int Not Null
)

create table NhaCungCap
(
	MaNCC int Not Null,
	TenNCC nvarchar(24),
	DiachiNCC nvarchar(24),
	SdtNCC nvarchar(14)
)


create table HoaDon
(
	MaHD int Not Null,
	MaNV int Not Null,
	MaBN int Not Null,
	NgaylapHD DateTime
)


create table ChiTietHoaDon
(
	MaHD int Not Null,
	MaGiuong int Not Null,
	Ngaynhan DateTime,
	Ngaytra DateTime,
	MaThuoc int Not Null,
	SoluongThuoc int,
	MaDV int Not Null,
	SoluongDV int,
	Ngaybatdau DateTime,
	Ngayketthuc DateTime
)

create table DichVu
(
	MaDV int Not Null,
	TenDV nvarchar(24),
	DongiaDV Money
)

create table TheBHYT
(
	MaBHYT int Not Null,
	Ngaycap DateTime,
	Ngayhethan DateTime
)

alter table [dbo].[Khoa]
add constraint pk_MaK primary key ([MaK])

alter table [dbo].[NhanVien]
add constraint pk_MaNV primary key ([MaNV]),
	constraint fk_MaK foreign key ([MaK]) references [dbo].[Khoa]([MaK])

alter table [dbo].[GiuongBenh]
add constraint pk_MaGiuong primary key ([MaGiuong]),
	constraint fk_MaK1 foreign key ([MaK]) references [dbo].[Khoa]([MaK])

alter table [dbo].[TheBHYT]
add constraint pk_MaBHYT primary key ([MaBHYT])

alter table [dbo].[BenhNhan]
add constraint pk_MaBN primary key ([MaBN]),
	constraint fk_MaBHYT foreign key ([MaBHYT]) references [dbo].[TheBHYT]([MaBHYT])

alter table [dbo].[NguoiThan]
add constraint pk_HotenNT primary key ([HotenNT], [MaBN]),
	constraint fk_MaBN foreign key ([MaBN]) references [dbo].[BenhNhan]([MaBN])

alter table [dbo].[DichVu]
add constraint pk_MaDV primary key ([MaDV])

alter table [dbo].[NhaCungCap]
add constraint pk_MaNCC primary key ([MaNCC])

alter table [dbo].[Thuoc]
add constraint pk_MaThuoc primary key ([MaThuoc]),
	constraint fk_MaNCC foreign key ([MaNCC]) references [dbo].[NhaCungCap]([MaNCC])

alter table [dbo].[HoaDon]
add constraint pk_MaHD primary key ([MaHD]),
	constraint fk_MaNV foreign key ([MaNV]) references [dbo].[NhanVien]([MaNV]),
	constraint fk_MaBN1 foreign key ([MaBN]) references [dbo].[BenhNhan]([MaBN])

alter table [dbo].[ChiTietHoaDon]
add constraint pk_MaHD1 primary key ([MaHD]),
	constraint fk_MaHD2 foreign key ([MaHD]) references [dbo].[HoaDon]([MaHD]),
	constraint fk_MaGiuong foreign key ([MaGiuong]) references [dbo].[GiuongBenh]([MaGiuong]),
	constraint fk_MaThuoc foreign key ([MaThuoc]) references [dbo].[Thuoc]([MaThuoc]),
	constraint fk_MaDV foreign key ([MaDV]) references [dbo].[DichVu]([MaDV])

--------------------------------------------------------------------------

INSERT INTO [dbo].[Khoa] values
(1,N'Tim','1121'),
(2,N'Nội tiết','1122'),
(3,N'Thần kinh','1123'),
(4,N'Não','1124'),
(5,N'Cấp cứu','1125'),
(6,N'Chấn thương chỉnh hình','1126'),
(7,N'Lồng ngực','1127'),
(8,N'Răng - Hàm -Mặt','1128'),
(9,N'Tai - Mũi - Họng','1129'),
(10,N'Khám bệnh','1120')
select* from[dbo].[Khoa]

alter table [dbo].[NhanVien]
alter column [TenNV] nvarchar(50)
alter table [dbo].[NhanVien]
alter column [DiachiNV] nvarchar(150)
INSERT INTO [dbo].[NhanVien] values
(1,N'Nguyễn Xuân Bình',N'Số 16C Tôn Đức Thắng, phường Mỹ Bình, TP. Long Xuyên, tỉnh An Giang','0162.699.6001',N'Bác sĩ',N'Kinh',null,1),
(2,N'Bùi Mạnh Quốc Huy',N'Số 1 Phạm Văn Đồng, phường Phước Trung, TP. Bà Rịa, tỉnh Bà Rịa – Vũng Tàu','0125.691.8513',N'Y tá',N'Hoa',null,1),
(3,N'Lê Thị Thu Thảo',N'Số 04 đường Phan Đình Phùng, phường 3, TP.Bạc Liêu, tỉnh Bạc Liêu','0932.535.862',N'Bác sĩ',N'Kinh',null,2),
(4,N'Huỳnh Minh Thanh',N'Số 82  đường Hùng Vương, TP. Bắc Giang, tỉnh Bắc Giang','0905.244.749',N'Y tá',N'Kinh',null,2),
(5,N'Đỗ Thị Kim Chi	',N'Tổ 1A, phường Phùng Chí Kiên, TX.Bắc Kạn, tỉnh Bắc Kạn','02353864760',N'Bác sĩ',N'Kinh',null,3),
(6,N'Lê Thị Mai',N'Số 10  đường Phù Đổng Thiên Vươn, phường Suối Hoa, TP.Bắc Ninh, tỉnh Bắc Ninh','0989.576.495',N'Y tá',N'Chăm',null,3),
(7,N'Huỳnh Thị Khánh Trang',N'Số 7 đường Cách Mạng Tháng 8, phường 3, TP. Bến Tre, tỉnh Bến Tre','0917.962.678',N'Bác sĩ',N'Kinh',null,4),
(8,N'Trần Kim Ngọc',N'6/1 TX.Đồng Xoài, tỉnh Bình Phước','0977.715.195',N'Y tá',N'Kinh',null,4),
(9,N'Lai Như Quỳnh',N'Số 04 Hải Thượng Lãn Ông, TP.Phan Thiết, tỉnh Bình Thuận','0121.468.0066',N'Bác sĩ',N'Kinh',null,5),
(10,N'Nguyễn Thu Hằng',N'Số 02, đường Hùng Vương, phường 5, TP.Cà Mau, tỉnh Cà Mau','0169.386.6135',N'Y tá',N'Kinh',null,5),
(11,N'Đặng Ngọc Thanh Loan',N'Số 011 đường Hoàng Đình Giong, TP.Cao Bằng, tỉnh Cao Bằng','0987.530.215',N'Bác sĩ',N'Mường',null,6),
(12,N'Quách Mai Dung',N'Số 08 Mai Hắc Đế, TP.Buôn Ma Thuột, tỉnh Đắk Lắk','0905.625.047',N'Y tá',N'Kinh',null,6),
(13,N'Dương Hà Như Thi',N'Đường 23 tháng 3, TX.Gia Nghĩa, tỉnh Đắk Nông','0916.464.747',N'Bác sĩ',N'Kinh',null,7),
(14,N'La Thị Trà Mi',N'Phường Mường Thanh, TP.Điện Biên Phủ, tỉnh Điện Biên','0168.791.7504',N'Y tá',N'Tày',null,7),
(15,N'Nguyễn Bảo Lộc',N'Số 281 đường 30-4, phường Quyết Thắng, TP.Biên Hòa, tỉnh Đồng Nai','0164.498.2171',N'Bác sĩ',N'Kinh',null,8),
(16,N'Cao Ngọc Phương Trinh',N'Số 02 Trần Phú, TP.Pleiku, tỉnh Gia Lai','0905.335.479',N'Y tá',N'Kinh',null,8),
(17,N'Phạm Vũ Quang Vinh',N'Số 222, đường Nguyễn Trãi, thành phố Hà Giang, tỉnh Hà Giang','0986.331.039',N'Bác sĩ',N'Nùng',null,9),
(18,N'Nguyễn Thị Thanh Hồng',N'Số 90 đường Trần Phú, phường Quang Trung, TP.Phủ Lý, tỉnh Hà Nam','0162.982.7531',N'Y tá',N'Kinh',null,9),
(19,N'Trần Thị Thùy Nhung',N'Số 45 Quang Trung, TP.Hải Dương, tỉnh Hải Dương','0989.843.077',N'Bác sĩ',N'Kinh',null,10),
(20,N'Phạm Đoàn Minh Hiếu',N'Số 66 Phan Đình Phùng, TP.Hà Tĩnh, tỉnh Hà Tĩnh.','0981.127.683',N'Y tá',N'Khơ me',null,10)
select*from [dbo].[NhanVien]

INSERT INTO [dbo].[GiuongBenh] values
(1,N'A.1',70000,1),
(2,N'A.1',70000,1),
(3,N'A.1',70000,1),
(4,N'A.1',70000,1),
(5,N'A.1',70000,1),
(6,N'A.2',70000,2),
(7,N'A.2',70000,2),
(8,N'A.2',70000,2),
(9,N'A.2',70000,2),
(10,N'A2.',70000,2),
(11,N'B.1',70000,3),
(12,N'B.1',70000,3),
(13,N'B.1',70000,3),
(14,N'B.1',70000,3),
(15,N'B.1',70000,3),
(16,N'B.2',70000,4),
(17,N'B.2',70000,4),
(18,N'B.2',70000,4),
(19,N'B.2',70000,4),
(20,N'B.2',70000,4),
(21,N'C.1',70000,5),
(22,N'C.1',70000,5),
(23,N'C.1',70000,5),
(24,N'C.1',70000,5),
(25,N'C.1',70000,5),
(26,N'C.2',66000,6),
(27,N'C.2',66000,6),
(28,N'C.2',66000,6),
(29,N'C.2',66000,6),
(30,N'C.2',66000,6),
(31,N'D.1',66000,7),
(32,N'D.1',66000,7),
(33,N'D.1',66000,7),
(34,N'D.1',66000,7),
(35,N'D.1',66000,7),
(36,N'D.2',66000,8),
(37,N'D.2',66000,8),
(38,N'D.2',66000,8),
(39,N'D.2',66000,8),
(40,N'D.2',66000,8),
(41,N'E.1',66000,9),
(42,N'E.1',62000,9),
(43,N'E.1',62000,9),
(44,N'E.1',62000,9),
(45,N'E.1',62000,9),
(46,N'E.2',62000,10),
(47,N'E.2',62000,10),
(48,N'E.2',62000,10),
(49,N'E.2',62000,10),
(50,N'E.2',62000,10)
select*from[dbo].[GiuongBenh]


INSERT INTO [dbo].[TheBHYT] values
(1901,'2016 - 04 - 05','2017 - 04 - 05'),
(1902,'2016 - 05 - 04','2017 - 05 - 04'),
(1903,'2016 - 08 - 07','2017 - 08 - 07'),
(1904,'2016 - 09 - 08','2017 - 09 - 08'),
(1905,'2016 - 07 - 06','2017 - 07 - 06'),
(1906,'2017 - 07 - 03','2018 - 07 - 03'),
(1907,'2017 - 03 - 05','2018 - 03 - 05'),
(1908,'2017 - 07 - 05','2018 - 07 - 05'),
(1909,'2015 - 04 - 02','2016 - 04 - 02'),
(19010,'2017 - 06 - 05','2018 - 06 - 05'),
(19011,'2017 - 07 - 06','2018 - 07 - 06'),
(19012,'2017 - 04 - 06','2018 - 04 - 06'),
(19013,'2017 - 08 - 03','2018 - 08 - 03'),
(19014,'2017 - 09 - 09','2018 - 09 - 09'),
(19015,'2017 - 06 - 05','2018 - 06 - 05'),
(19016,'2017 - 04 - 09','2018 - 04 - 09'),
(19017,'2015 - 05 - 03','2016 - 05 - 03'),
(19018,'2018 - 04 - 04','2019 - 04 - 04'),
(19019,'2017 - 08 - 06','2018 - 08 - 06'),
(19020,'2018 - 07 - 05','2019 - 07 - 05'),
(19021,'2016 - 05 - 04','2017 - 05 - 04'),
(19022,'2018 - 06 - 06','2019 - 06 - 06'),
(19023,'2017 - 04 - 05','2018 - 04 - 05'),
(19024,'2017 - 06 - 03','2018 - 06 - 03'),
(19025,'2017 - 06 - 04','2018 - 06 - 04'),
(19026,'2017 - 09 - 16','2018 - 09 - 16'),
(19027,'2012 - 06 - 15','2013 - 06 - 15'),
(19028,'2017 - 06 - 18','2018 - 06 - 18'),
(19029,'2018 - 06 - 14','2019 - 06 - 14'),
(19030,'2015 - 08 - 17','2016 - 08 - 17'),
(19031,'2015 - 04 - 13','2016 - 04 - 13'),
(19032,'2014 - 08 - 16','2015 - 08 - 16'),
(19033,'2015 - 04 - 15','2016 - 04 - 15'),
(19034,'2017 - 05 - 15','2018 - 05 - 15'),
(19035,'2018 - 06 - 14','2019 - 06 - 14'),
(19036,'2014 - 02 - 28','2015 - 02 - 28'),
(19037,'2017 - 06 - 24','2018 - 06 - 24'),
(19038,'2014 - 05 - 27','2015 - 05 - 27'),
(19039,'2017 - 09 - 26','2018 - 09 - 26'),
(19040,'2017 - 04 - 23','2018 - 04 - 23'),
(19041,'2018 - 06 - 24','2019 - 06 - 24'),
(19042,'2017 - 05 - 21','2018 - 05 - 21'),
(19043,'2014 - 05 - 24','2015 - 05 - 24'),
(19044,'2016 - 06 - 27','2017 - 06 - 27'),
(19045,'2016 - 01 - 23','2017 - 01 - 23'),
(19046,'2016 - 10 - 05','2016 - 10 - 05'),
(19047,'2013 - 12 - 06','2014 - 12 - 06'),
(19048,'2013 - 11 - 05','2014 - 11 - 05'),
(19049,'2015 - 12 - 08','2016 - 12 - 08'),
(19050,'2016 - 10 - 29','2017 - 10 - 29')
select*from TheBHYT



alter table [dbo].[BenhNhan]
alter column [HotenBN] nvarchar(50)
alter table [dbo].[BenhNhan]
alter column [DiachiBN] nvarchar(150)
INSERT INTO [dbo].[BenhNhan] values 
(1,N'Lê Văn Túc',N'thôn Phái Nhơn, xã Tam Hiệp, Núi Thành, Quảng Nam','0987.406.926',N'Nông',N'Nam','1998 - 04 - 02',1901),
(2,N'Nguyễn Mậu Sơn',N'đội 3 thôn Trung Thành, xã Lương Sơn, Thường Xuân, Thanh Hóa','0166.660.3281',N'Giáo viên',N'Nam','1959 - 02 - 14',1902),
(3,N'Nguyễn Đức Minh',N'thôn 4, xã Gia Lâm, Lâm Hà, Lâm Đồng','0163.283.0394',N'Nông',N'Nam','1959 - 03 - 04',1903),
(4,N'Thân Đức Bẩy',N'thôn Bờ Vàng, xã Đại Hoa, Tân Yên, Bắc Giang','0976.285.592',N'Nông',N'Nam','1956 - 12 - 27',1904),
(5,N'Bùi Thị Liên',N'thôn An Sơn, xã Đông Sơn, Chương Mỹ, Hà Nội','0127.473.6701',N'Tài xế',N'Nữ','1921 - 06 - 04',1905),
(6,N'Lý Văn Bộ',N'thôn Nà Thếm, xã Khuôn Hà, Lâm Bình, Tuyên Quang','0162.703.0457',N'Nông',N'Nữ','1962 - 12 - 21',1906),
(7,N'Phùng Thị Ánh',N'tiểu khu 1, thị trấn Neo, Yên Dũng, Bắc Giang','0169.492.9716',N'Công nhân',N'Nam','1955 - 04 - 14',1907),
(8,N'Nguyễn Nho Tiến',N'thôn Huề Trì, xã An Phụ, Kinh Môn, Hải Dương','168.921.0137',N'Nông',N'Nữ','1982 - 04 - 04',1908),
(9,N'Võ Sĩ Lộc',N'TDP 3, TT Mộ Đức, huyện Mộ Đức, Quảng Ngãi','0169.353.1635',N'Giáo viên',N'Nam','1973 - 05 - 16',1909),
(10,N'Trương Hồng Ân',N'thôn Thạc Bích, xã Quế Lâm, Nông Sơn, Quảng Nam','0169.765.5607',N'Nông',N'Nữ','1999 - 08 - 04',19010),
(11,N'Bùi Thị Luyến',N'xóm Đồng Ngoài, xã Vĩnh Tiến, Kim Bôi, Hòa Bình','0914.702.612',N'Công nhân',N'Nam','1934 - 01 - 02',19011),
(12,N'Nguyễn Thị Kim Thanh',N'số 94 tổ 15 đường Minh Khai, P. Đồng Tiến, Hòa Bình','0909.359.262',N'Cán bộ',N'Nữ','1975 - 06 - 14',19012),
(13,N'Quách Thị Lan',N'xóm Thượng, xã Cuối Hạ, Kim Bôi, Hòa Bình','0120.235.7505',N'Nông',N'Nam','1945 - 10 - 24',19013),
(14,N'Bùi Thị Hải',N'xóm Cốc, xã Vĩnh Đồng, Kim Bôi, Hòa Bình','0126.363.9605',N'Giáo viên',N'Nam','1996 - 04 - 05',19014),
(15,N'Trần Dưỡng',N'thôn Trường Thạnh, xã Tam Thạnh, Núi Thành, Quảng Nam','0982.121.259',N'Nông',N'Nam','1945 - 12 - 24',19015),
(16,N'Nguyễn Chí Thanh',N'thôn 3, xã Tiên Lộc, Tiên Phước, Quảng Nam','0166.205.8434',N'Công nhân',N'Nữ','1975 - 07 - 02',19016),
(17,N'Nguyễn Thị Khâm',N'thôn Nghĩa Lập, xã Đức Hiệp, Mộ Đức, Quảng Ngãi','0168.518.6055',N'Cán bộ',N'Nam','1985 - 03 - 17',19017),
(18,N'Nguyễn Hà',N'tổ 92, P. Hòa Quý, Q. Ngũ Hành Sơn, TP Đà Nẵng','0163.875.7814',N'Nông',N'Nam','1975 - 05 - 07',19018),
(19,N'Nguyễn Văn Ngọc',N'khối phố 2, P. Trường Xuân, TP. Tam Kỳ, Quảng Nam','0169.464.8124',N'Tài xế',N'Nam','1978 - 10 - 22',19019),
(20,N'Phan Thị Trà My',N'buôn Ngô A, xã Hòa Phong, Krông Bông, Đăk Lăk','0168.768.6061',N'Nông',N'Nữ','1975 - 04 - 17',19020),
(21,N'Lê Thị Phúc',N'thôn Vĩnh Sơn, xã Vĩnh Phúc, Bắc Quang, Hà Giang','0163.406.7940',N'Cán bộ',N'Nam','1978 - 03 - 05',19021),
(22,N'Nguyễn Thị Khuyến',N'thôn 1, xã Ya Xiêr, huyện Xa Thầy, Kon Tum','0906.234.630',N'Công nhân',N'','1978 - 11 - 21',19022),
(23,N'Nguyễn Thị Nhậ',N'thôn Phú Thọ, xã Xuân Lai, Gia Bình, Bắc Ninh','0973.861.227',N'Nông',N'Nam','1988 - 05 - 02',19023),
(24,N'Trần Thị Nụ',N'thôn Nghĩa Hương, xã Mỹ Hương, Lương Tài, Bắc Ninh','0168.206.4166',N'Tài xế',N'Nam','1978 - 02 - 21',19024),
(25,N'Hoàng Thị Lan',N'thôn Lê Độ, xã Quế Tân, Quế Võ, Bắc Ninh','0162.843.6090',N'Nông',N'Nam','1978 - 11 - 08',19025),
(26,N'Hoàng Thị Lan',N'thôn Nội Phú, TT Gia Bình, Gia Bình, Bắc Ninh','0164.834.8597',N'Cán bộ',N'Nam','1977 - 04 - 07',19026),
(27,N'Lương Viết Lượng',N'thôn Kim Đào, TT Thứa, Lương Tài, Bắc Ninh','0162.771.0911',N'Giáo viên',N'Nữ','1947 - 10 - 02',19027),
(28,N'Trần Văn Vương',N'thôn Trò, xã Công Đa, Yên Sơn, Tuyên Quang','0169.757.0799',N'Nông',N'Nam','1957 - 10 - 25',19028),
(29,N'Lưu Văn Điền',N'thôn Hữu Vu, xã Đại Phú, Sơn Dương, Tuyên Quang','0166.402.6145',N'Công nhân',N'Nữ','1987 - 05 - 04',19029),
(30,N'Mạc Văn Nghè',N'bản Khản, xã Bình Phú, Chiêm Hóa, Tuyên Quang','0905.463.239',N'Nông',N'Nam','1963 - 10 - 07',19030),
(31,N'Trần Quốc Tuận',N'thôn Nhữ hán, xã Nhữ Hán, Yên Sơn, Tuyên Quang','0167.919.5936',N'Nông',N'Nữ','1987 - 01 - 02',19031),
(32,N'Lê Ngọc Sinh',N'thôn 2 Tân Yên, xã Tân Thành, Hàm Yên, Tuyên Quang','0169.760.1615',N'Nông',N'Nữ','1946 - 05 - 02',19032),
(33,N'Tướng Văn Chốc',N'TDP Mỹ Trạch, P. Ninh Hòa, TX Ninh Hòa, Khánh Hòa','0906.484.303',N'Nông',N'Nam','1956 - 05 - 12',19033),
(34,N'Đặng Thị Thanh',N'TDP 3, P. Ninh Hiệp, TX Ninh Hòa, Khánh Hòa','0165.272.9035',N'Nông',N'Nam','1943 - 12 - 25',19034),
(35,N'Trần Thị Phương',N'TDP Hà Thanh 1, P. Ninh Đa, TX Ninh Hòa, Khánh Hòa','0905.273.269',N'Cán bộ',N'Nam','1953 - 04 - 14',19035),
(36,N'Nguyễn Hoài Tâm',N'khối 7B, xã Điện Nam Đông, Điện Bàn, Quảng Nam','0168.406.8451',N'Nông',N'Nam','1975 - 03 - 05',19036),
(37,N'Nguyễn Thị Tín',N'thôn An Thành 2, xã Bình An, Thăng Bình, Quảng Nam','122.437.4568',N'Nông',N'Nam','1956 - 11 - 25',19037),
(38,N'Hồ Thị Nho',N'xóm Bắc Viên, thôn Tất Viên, xã Thủ Sỹ, Tiên Lữ, Hưng Yên','0977.945.504',N'Cán bộ',N'Nam','1956 - 07 - 04',19038),
(39,N'Nguyễn Văn Thảo',N'73A đường Phạm Huy Thông, P. Nại Hiên Đông, Q. Sơn Trà, Đà Nẵng','0933.263.356',N'Nông',N'Nữ','1946 - 11 - 08',19039),
(40,N'Nguyễn Thị Út',N'tổ 5 khu Đoàn Kết, xã Mạo Khê, Đông Triều, Quảng Ninh','0972.262.097',N'Công nhân',N'Nữ','1945 - 03 - 04',19040),
(41,N'Lê Thị Ngọc',N'tổ 44C, P. Hòa Khánh Bắc, Q. Liên Chiểu, TP. Đà Nẵng','0162.988.6172',N'Cán bộ',N'Nam','1978 - 04 - 15',19041),
(42,N'Nguyễn Thị The',N'khối phố Đông Trà, P. Hòa Thuận, TP. Tam Kỳ, Q. Nam','162.679.6279',N'Nông',N'Nữ','1978 - 07 - 08',19042),
(43,N'Ma Đức Xướng',N'tổ 2 khối 7, P. Vĩnh Diện, TX Điện Bàn, Quảng Nam','0967.599.812',N'Tài xế',N'Nam','1975 - 05 - 07',19043),
(44,N'Nguyễn Thị Sen',N'số 28 đường Đinh Tiên Hoàng, P. Nghĩa Chánh, TP. Quảng Ngãi','0913.786.202',N'Nông',N'Nữ','1945 - 10 - 05',19044),
(45,N'Ma Văn Đoan',N'thôn Kênh, xã Ninh Xá, Thuận Thành, Bắc Ninh','0948.644.707',N'Nông',N'Nữ','1948 - 08 - 07',19045),
(46,N'Nguyễn Thị Yến',N'xóm Đình Phú, xã Xuân Phú, Yên Dũng, Bắc Giang','0163.699.7480',N'Cán bộ',N'Nam','1955 - 07 - 13',19046),
(47,N'Nguyễn Thị Minh',N'tổ 18 khối 3, TT Núi Thành, Núi Thành, Quảng Nam','0982.684.328',N'Cán bộ',N'Nam','1946 - 05 - 06',19047),
(48,N'Phạm Văn Lời',N'thôn Tử tế, xã Thanh Tân, Kiến Xương, Thái Bình','0129.510.6776',N'Nông',N'Nam','1974 - 12 - 24',19048),
(49,N'Võ Văn Đồng',N'xóm Nghĩa Bắc, xã Quỳnh Nghĩa, Quỳnh Lưu, Nghệ An','0169.872.2815',N'Tài xế',N'Nam','1946 - 04 - 06',19049),
(50,N'Lương Khánh Ngọc',N'khu 6, xã Hy Cương, Việt Trì, Phú Thọ','0167.632.8025',N'Nông',N'Nam','1987 - 09 - 04',19050)
select * from[dbo].[BenhNhan]

alter table [dbo].[NguoiThan]
alter column [HotenNT] nvarchar(50) Not Null
alter table [dbo].[NguoiThan]
alter column [DiachiNT] nvarchar(150)
INSERT INTO [dbo].[NguoiThan] values
(N'Nguyễn Đức Thanh',1,N'254 A Nguyễn Đình Chiểu, Phường 6, Quận 3, TP Hồ Chí Minh','3560838',N'Cha'),
(N'Đỗ Việt Cường',2,N'750 Sư Vạn Hạnh (nối dài), Phường 12, Quận 10, TP Hồ Chí Minh','3810822',N'Mẹ'),
(N'Đinh Quí Trọng Nhân',3,N'Số 79 Đường số 6, Hưng Phước 4, Phú Mỹ Hưng, Quận 7, TP Hồ Chí Minh','3870871',N'Cha'),
(N'Nguyễn Duy Thanh Châu',4,N'thôn Nam Hòa, xã Hồng Tiến, Kiến Xương, Thái Bình','3810577',N'Vợ'),
(N'Nguyễn Đức Mỹ',5,N'TDP Mỹ Trạch, P. Ninh Hòa, TX Ninh Hòa, Khánh Hòa','3562479',N'Cha'),
(N'	Phan Trung Huân',6,N'TDP 3, P. Ninh Hiệp, TX Ninh Hòa, Khánh Hòa','905527565',N'Mẹ'),
(N'Nguyễn Thị Bạch Thọ',7,N'thôn Hiệp Thành, xã Cam Thịnh Đông, TP. Cam Ranh, K. Hòa','903516171',N'Cha'),
(N'Vũ Đình Tuấn',8,N'thôn Thanh Định, xã Ninh Trung, TX Ninh Hòa, K. Hòa','913478555',N'Chồng'),
(N'Nguyễn Thành Thi',9,N'215 Hà Phước, đường 2/4, P. Vĩnh Phước, TP Nha Trang, Khánh Hòa','3510885',N'Vợ'),
(N'Huỳnh Nam Trung',10,N'đội 11, xã Thanh Hưng, Điện Biên, Điện Biên','3511829',N'Mẹ'),
(N'Võ Xuân Cảnh',11,N'thôn Nà Vài, xã Thổ Bình, Lâm Bình, Tuyên Quang','3826444',N'Chồng'),
(N'Đỗ Thị Hoàng Anh',12,N'thôn Đọ mới, xã Cương Sơn, Lục Nam, Bắc Giang','3510951',N'Cha'),
(N'Nguyễn Hoài Cang',13,N'thôn Nà Áng, xã Minh Quang, Chiêm Hóa, Tuyên Quang','2240548',N'Mẹ'),
(N'Phạm Văn Nhân',14,N'394 tổ 64 khu 7, P. Cao Thắng, TP. Hạ Long, Quảng Ninh','3551579',N'Vợ'),
(N'Đỗ Khắc Duy',15,N'thôn Hồng Hải, xã Đồng Tiến, Cô Tô, Quảng Ninh','6551112',N'Chồng'),
(N'Nguyễn Tấn Phát',16,N'ấp Thạnh 2, xã Long Điền, Đông Hải, Bạc Liêu','387 5499',N'Mẹ'),
(N'Nguyễn Chí Hoàng',17,N'nhóm 2, thôn Lộc Trung, xã Quế Phong, Quế Sơn, Quảng Nam','3514316',N'Cha'),
(N'Nguyễn Đức Trung',18,N'tôổ A2, TT Vĩnh Lộc, Chiêm Hóa, Tuyên Quang','913471406',N'Chồng'),
(N'Lê Minh Quang',19,N'khối phố Bằng An Trung, P. Điện An, TX. Điện Bàn, Q. Nam','0913482539',N'Cha'),
(N'Nguyễn Văn Hải',20,N'thôn Cẩm Tây, xã Tiên Cẩm, Tiên Phước, Quảng Nam','0905083334',N'Mẹ'),
(N'Nguyễn Tri Huy',21,N'tổ 1 TT An Dương, An Dương, Hải Phòng','0903500600',N'Vợ'),
(N'Huỳnh Văn Ánh',22,N'tổ 13 Phúc Lộc, P. Hưng Đạo, Q. Dương Kinh, Hải Phòng','0913485982',N'Chồng'),
(N'Võ Quốc Anh Vũ',23,N'thôn 4, xã Cổ Am, Vĩnh Bảo, Hải Phòng','0983302902',N'Mẹ'),
(N'Nguyễn Cao Sang',24,N'TDP Trung Hải, xã Bàng La, Đồ Sơn, Hải Phòng','0903186596',N'Cha'),
(N'Huỳnh Thiên Cung',25,N'thôn 8, xã Minh Tân, Thủy Nguyên, Hải Phòng','935539375',N'Vợ'),
(N'Đoàn Hoài An',26,N'xóm 10, xã Thanh Liên, Thanh Chương, Nghệ An','987979779',N'Mẹ'),
(N'Lâm Quang Tuấn',27,N'thôn 3, xã Phúc Sơn, Anh Sơn, Nghệ An','904563828',N'Chồng'),
(N'Dương Văn Bình',28,N'thôn Mỹ Lộc, xã Xuân Viên, Nghi Xuân, Hà Tĩnh','905058079',N'Cha'),
(N'Lê Trung Hiền',29,N'bản Mánh, xã Bắc Sơn, Quỳ Hợp, Nghệ An','1666693009',N'Chồng'),
(N'Phù Trần Hữu Phát',30,N'xóm 4, xã Xuân Lâm, Nam Đàn, Nghệ An','979033754',N'Mẹ'),
(N'Lê Phan Thuần',31,N'thôn Tả Van Mông, xã Tả Van, Sa Pa, Lào Cai','903503850',N'Cha'),
(N'Nguyễn Duy Hưng',32,N'xóm 3 Hòa Loan, xã Lũng Hòa, Vĩnh Tường, Vĩnh Phúc','927888393',N'Mẹ'),
(N'Võ Thị Thanh Tâm',33,N'thôn Văn Ổ, xã Đại Đồng, Văn Lâm, Hưng Yên','01275836078	',N'Vợ'),
(N'Võ Tiến Dũng',34,N'thôn Trực Trang, xã Bát Trung, An Lão, Hải Phòng','09732566474',N'Cha'),
(N'Võ Hải',35,N'tiểu khu 4, TT Bắc Yên, Bắc Yên, Sơn La','0901141968',N'Chồng'),
(N'Võ Ngọc Hiên',36,N'thôn 8, xã Cẩm Mỹ, Cẩm Xuyên, Hà Tĩnh','0913477065',N'Chồng'),
(N'Võ Duy Khương',37,N'thôn Quý Xã, xã Yên Bình, Hữu Lũng, Lạng Sơn','0903506266',N'Cha'),
(N'Võ Văn Kiệt',38,N'thôn Séo Phìn Chư, xã A Lù, Bát Xát, Lào Cai','01223434549',N'Mẹ'),
(N'Võ Minh',39,N'thôn Tân Lập, xã Cao Thượng, Tân Yên, Bắc Giang','0903508181',N'Vợ'),
(N'Võ Văn Ngà',40,N'tổ 1 Thái Đông, xã Bình Nam, Thăng Bình, Quảng Nam','0913402487',N'Chồng'),
(N'Võ Duy Tấn',41,N'tổ 1 Thái Đông, xã Bình Nam, Thăng Bình, Quảng Nam','0988017777',N'Chồng'),
(N'Vũ Quang Thành',42,N'số 5 ngõ 319 đường Văn Cao, TP Nam Định, Nam Định','0983150436',N'Cha'),
(N'Võ Văn Thương',43,N'thôn 3, xã Quảng Ngạn, Quảng Điền, Thừa Thiên Huế','0913404428',N'Vợ'),
(N'Võ Thanh Thủy',44,N'thôn Phong Niên Hạ, xã Tịnh Phong, Sơn Tịnh, Quảng Ngãi','0903508699',N'Mẹ'),
(N'Võ Duy Tín',45,N'xóm Giáo, xã Đầm Hà, Đầm Hà, Quảng Ninh','0905265581',N'Chồng'),
(N'Võ Văn Hùng',46,N'xóm Thạch Sơn, xã Đồng Văn, Thanh Chương, Nghệ An','093507229',N'Cha'),
(N'Võ Huy Bảo',47,N'thôn Vạch, xã Khả Cửu, Thanh Sơn, Phú Thọ','0923484848',N'Vợ'),
(N'Võ Sỹ Quang',48,N'tổ 2, thôn Hòa Thọ, xã Hòa Phú, Hòa Vang, Đà Nẵng','0982434627',N'Mẹ'),
(N'Võ Đức Cửu',49,N'khối 7B, xã Điện Nam Đông, Điện Bàn, Quảng Nam','0905438021',N'Vợ'),
(N'Võ Văn Chi',50,N'thôn Hòa Bình, xã Duy Phước, Duy Xuyên, Quảng Nam','0905250222',N'Cha')
select*from [dbo].[NguoiThan]

alter table [dbo].[DichVu]
alter column [TenDV] nvarchar(50)
INSERT INTO [dbo].[DichVu] values
(2501,N'Phòng soi',400000),
(2502,N'Siêu Âm',300000),
(2503,N'X - Quang',200000),
(2504,N'Xét nghiệm',100000),
(2505,N'Xét nghiệm giải phẩu bệnh',500000),
(2506,N'Xe cấp cứu',400000),
(2507,N'Phẩu thuật',6000000)
select*from DichVu

alter table [dbo].[NhaCungCap]
alter column [TenNCC] nvarchar(250) 
alter table [dbo].[NhaCungCap]
alter column [DiachiNCC] nvarchar(250)
alter table [dbo].[NhaCungCap]
alter column [SdtNCC] nvarchar(50)
INSERT INTO [dbo].[NhaCungCap] values
(3401,N'Công Ty TNHH Lê Hào',N'26/36 Đường Thượng Hội, Xã Tân Hội, H. Đan Phượng, Hà Nội','(024) 37190219'),
(3402,N'Công Ty TNHH Mỹ Phẩm EV Princess',N'35 Đường 3/2, Phường 11, Quận 10, Tp. Hồ Chí Minh','(028) 38355005'),
(3403,N'Công Ty Cổ Phần Neemtree',N'37/5B Trung Mỹ Tây, Trung Chánh, Hóc Môn, Tp. Hồ Chí Minh','02871066869'),
(3404,N'Doanh Nghiệp Tư Nhân Trọng Đức',N'Số 127, Tổ 1, Khu 1, Phường Hùng Thắng, Tp Hạ Long, Quảng Ninh','(0203) 3846333'),
(3405,N'Công Ty Cổ Phần Difoco',N'289 Đinh Bộ Lĩnh, P. 26, Q. Bình Thạnh, Tp. Hồ Chí Minh','(028) 6685 7787'),
(3406,N'Công Ty Cổ Phần Nông Nghiệp Công Nghệ Cao Thăng Long',N'Xã Đại Yên, Chương Mỹ, Hà Nội','0972339095'),
(3407,N'Công Ty Cổ Phàn Dưỡng Dược Vĩnh Kim',N'186 Định Công Hạ, P. Định Công, Q. Hoàng Mai, Hà Nội','0919559698'),
(3408,N'Eva Shop',N'475 Đoàn Văn Bơ, Phường 14, Quận 4, Tp. Hồ Chí Minh','09030703384'),
(3409,N'Công Ty Hoa Bảo',N'91 Ngõ 381 Nguyễn Khang, Cầu Giấy, Hà Nội Hà Nội','0988 689 289'),
(3410,N'Công Ty TNHH MTV Thiện Oanh',N'1/13/1 Nguyễn Đình Khơi, P. 4, Q. Tân Bình, Tp. Hồ Chí Minh','(028) 38117762')
select*from NhaCungCap


alter table [dbo].[Thuoc]
alter column [TenThuoc] nvarchar(50) 
alter table [dbo].[Thuoc]
alter column [Xuatxu] nvarchar(50)
INSERT INTO [dbo].[Thuoc] values
(1101,N'Atropin sulfat',N'ống',525,N'Việt Nam',3401),
(1102,N'Bupivacain hydroclorid',N'Lọ',42000,N'Pháp ',3401),
(1103,N'Bupivacain hydroclorid',N'Ống',21000,N'India',3401),
(1104,N'Bupivacain hydroclorid',N'Ống',37250,N'France',3402),
(1105,N'Etomidat',N'Ống',119994,N'Đức',3402),
(1106,N'Fentanyl',N'Ống',11800,N'Germany',3402),
(1107,N'Isoflurane',N'Chai',1124100,N'Anh',3403),
(1108,N'Isoflurane',N'Chai',487253,N'Anh',3403),
(1109,N'Isofluran',N'Chai',280000,N'Mỹ',3403),
(1110,N'Isofluran',N'Chai',575000,N'Mỹ',3404),
(1111,N'Levobupivacain Hydrochloride',N'Ống',120000,N'Na Uy, đóng gói Ý',3404),
(1112,N'Lidocain hydroclorid',N'Ống',15500,N'Italy',3404),
(1113,N'Lidocain hydroclorid',N'Ống',413,N'VietNam',3405),
(1114,N'Lidocaine, Prilocaine',N'Tuýp',37120,N'Thụy Điển',3405),
(1115,N'Midazolam',N'Ống',14700,N'Việt Nam',3405),
(1116,N'Propofol',N'Hộp',375000,N'Ý, đóng gói Anh',3406),
(1117,N'Propofol',N'Ống',118168,N'Ý, đóng gói Anh',3406),
(1118,N'Sevoflurane',N'Chai',3578600,N'Chai',3406),
(1119,N'Celecoxib',N'Viên',11913,N'Mỹ, Đóng gói Đức',3407),
(1120,N'Celecoxib',N'Viên',365,N'Việt Nam',3407),
(1121,N'Diclofenac diethylamine',N'Tuýp',63200,N'Thụy Sỹ',3407),
(1122,N'Diclofenac sodium',N'Ống',18066,N'Slovenia',3408),
(1123,N'Diclofenac',N'Lọ',43000,N'Hàn Quốc',3408),
(1124,N'Acetylsalicylic acid',N'Viên',77,N'VIỆT NAM',3408),
(1125,N'Etodolac',N'Viên',3690,N'Việt Nam',3409),
(1126,N'Etoricoxib',N'Viên',18726,N'Tây Ban Nha, đóng gói Anh',3409),
(1127,N'Fentanyl',N'Miếng',154350,N'Bỉ',3409),
(1128,N'Ketoprofen',N'Ống',35000,N'Italia',3410),
(1129,N'Meloxicam',N'Ống',22761,N'Tây Ban Nha',3410),
(1130,N'Naproxen',N'Viên',4900,N'Cyprus',3410)
select*from Thuoc

INSERT INTO [dbo].[HoaDon] values
(1001,1,6,'2014 - 04 - 06'),
(1002,5,45,'2015 - 08 - 07'),
(1003,8,32,'2015 - 05 - 07'),
(1004,6,21,'2015 - 04 - 07'),
(1005,14,21,'2012 - 07 - 07'),
(1006,2,2,'2012 - 04 - 04'),
(1007,3,5,'2014 - 05 - 03'),
(1008,8,9,'2015 - 04 - 05'),
(1009,16,8,'2017 - 01 - 03'),
(10010,14,7,'2015 - 07 - 07'),
(10011,15,8,'2014 - 04 - 04'),
(10012,5,12,'2017 - 01 - 01'),
(10013,19,20,'2013 - 05 - 04'),
(10014,6,21,'2013 - 06 - 04'),
(10015,2,12,'2013 - 03 - 03'),
(10016,6,20,'2011 - 04 - 05'),
(10017,8,24,'2013 - 04 - 03'),
(10018,19,8,'2016 - 03 - 04'),
(10019,7,6,'2017 - 04 - 05'),
(10020,9,30,'2013 - 07 - 04'),
(10021,4,10,'2014 - 03 - 01'),
(10022,12,14,'2017 - 06 - 01'),
(10023,17,35,'2015 - 05 - 04'),
(10024,5,25,'2014 - 08 - 04'),
(10025,1,15,'2016 - 04 - 01'),
(10026,5,19,'2015 - 02 - 15'),
(10027,19,11,'2017 - 05 - 14'),
(10028,11,12,'2018 - 05 - 23'),
(10029,20,17,'2016 - 05 - 25'),
(10030,17,36,'2015 - 04 - 30'),
(10031,10,32,'2015 - 02 - 23'),
(10032,12,32,'2015 - 05 - 25'),
(10033,13,6,'2015 - 02 - 14'),
(10034,11,16,'2015 - 03 - 04'),
(10035,10,14,'2015 - 02 - 14'),
(10036,19,19,'2015 - 08 - 25'),
(10037,11,34,'2019 - 03 - 25'),
(10038,6,38,'2009 - 07 - 04'),
(10039,8,32,'2015 - 03 - 08'),
(10040,9,10,'2018 - 08 - 27'),
(10041,16,9,'2015 - 03 - 31'),
(10042,11,8,'2015 - 09 - 08'),
(10043,11,28,'2013 - 05 - 24'),
(10044,20,29,'2015 - 04 - 30'),
(10045,16,34,'2018 - 07 - 18'),
(10046,13,30,'2018 - 07 - 25'),
(10047,16,31,'2016 - 06 - 14'),
(10048,19,32,'2011 - 02 - 24'),
(10049,17,6,'2014 - 01 - 01'),
(10050,14,12,'2012 - 04 - 04'),
(10051,13,11,'2018 - 07 - 15'),
(10052,10,10,'2014 - 05 - 25'),
(10053,11,13,'2014 - 04 - 16'),
(10054,1,34,'2017 - 02 - 04'),
(10055,6,41,'2012 - 05 - 27'),
(10056,8,40,'2015 - 02 - 13'),
(10057,6,13,'2015 - 04 - 14'),
(10058,17,18,'2017 - 04 - 25'),
(10059,19,36,'2017 - 07 - 15'),
(10060,13,48,'2015 - 04 - 14'),
(10061,3,28, '2017- 04 - 25'),
(10062,20,31,'2017 - 07 - 04'),
(10063,5,36,'2017 - 04 - 01'),
(10064,1,39,'2018 - 04 - 25'),
(10065,8,38,'2018 - 06 - 08'),
(10066,12,47,'2014 - 04 - 25'),
(10067,6,42,'2018 - 07 - 24'),
(10068,6,38,'2014 - 03 - 25'),
(10069,13,31,'2017 - 04 - 19'),
(10070,12,30,'2015 - 04 - 10'),
(10071,8,35,'2015 - 03 - 20'),
(10072,20,31,'2015 - 05 - 24'),
(10073,1,26,'2014 - 04 - 12'),
(10074,6,15,'2015 - 04 - 23'),
(10075,18,24,'2018 - 07 - 25'),
(10076,2,41,'2017 - 05 - 13'),
(10077,20,42,'2017 - 04 - 28'),
(10078,11,32,'2017 - 10 - 30'),
(10079,12,33,'2018 - 10 - 10'),
(10080,13,22,'2012 - 12 - 17')
select*from HoaDon

INSERT INTO [dbo].[ChiTietHoaDon] values
(1001,1,'2014 - 02 - 02','2014 - 04 - 06',1101,1,2501,1,'2014 - 04 - 05','2014 - 04 - 05'),
(1002,2,'2015 - 07 - 06','2015 - 08 - 07',1123,2,2502,2,'2015 - 08 - 02','2015 - 08 - 04'),
(1003,5,'2015 - 02 - 04','2015 - 05 - 07',1108,0,2504,1,'2015 - 05 - 04','2015 - 05 - 04'),
(1004,3,'2015 - 02 - 05','2015 - 04 - 07',1104,4,2504,1,'2015 - 04 - 05','2015 - 04 - 06'),
(1005,23,'2012 - 04 - 05','2012 - 07 - 07',1103,4,2501,1,'2012 - 07 - 03','2012 - 07 - 04'),
(1006,36,'2012 - 04 - 03','2012 - 04 - 04',1107,2,2506,2,'2012 - 04 - 01','2012 - 04 - 02'),
(1007,25,'2014 - 03- 04','2014 - 05 - 03',1103,0,2503,1,'2014 - 05 - 01','2014 - 05 - 02'),
(1008,6,'2015 - 02 - 24','2015 - 04 - 05',1102,4,2501,1,'2015 - 04 - 01','2015 - 04 - 03'),
(1009,49,'2016 - 09 - 04','2017 - 01 - 03',1105,4,2507,1,'2017 - 01 - 01','2017 - 01 - 02'),
(10010,26,'2015 - 03 - 04','2015 - 07 - 07',1104,4,2505,2,'2015 - 07 - 05','2015 - 07 - 05'),
(10011,31,'2014 - 03 - 04','2014 - 04 - 04',1108,2,2504,2,'2014 - 04 - 01','2014 - 04 - 02'),
(10012,2,'2016 - 12 - 08','2017 - 01 - 01',1107,4,2506,1,'2017 - 01 - 01','2017 - 01 - 01'),
(10013,1,'2013 - 04 - 20','2013 - 05 - 04',1105,3,2507,2,'2013 - 05 - 01','2013 - 05 - 03'),
(10014,10,'2013 - 04 - 13','2013 - 06 - 04',1102,4,2507,1,'2013 - 06 - 01','2013 - 06 - 02'),
(10015,23,'2013 - 02 - 23','2013 - 03 - 03',1101,2,2502,2,'2013 - 03 - 02','2013 - 03 - 02'),
(10016,11,'2011 - 02 - 07','2011 - 04 - 05',1108,4,2501,2,'2011 - 04 - 02','2011 - 04 - 03'),
(10017,39,'2013 - 03 - 06','2013 - 04 - 03',1104,2,2503,0,Null,Null),
(10018,42,'2015 - 12 - 06','2016 - 03 - 04',1104,1,2501,2,'2016 - 03 - 03','2016 - 03 - 03'),
(10019,41,'2017 - 03 - 25','2017 - 04 - 05',1102,4,2502,0,Null,Null),
(10020,45,'2013 - 06 - 03','2013 - 07 - 04',1104,2,2501,2,'2013 - 07 - 03','2013 - 07 - 04'),
(10021,36,'2014 - 02 - 05','2014 - 03 - 01',1110,2,2501,1,'2014 - 03 - 01','2014 - 03 - 01'),
(10022,32,'2017 - 05 - 27','2017 - 06 - 01',1106,4,2502,1,'2017 - 06 - 01','2017 - 06 - 01'),
(10023,31,'2015 - 4 - 30','2015 - 05 - 04',1107,3,2506,2,'2015 - 05 - 03','2015 - 05 - 04'),
(10024,23,'2014 - 06 - 16','2014 - 08 - 04',1107,1,2504,2,'2014 - 08 - 01','2014 - 08 - 02'),
(10025,12,'2016 - 01 - 24','2016 - 04 - 01',1105,14,2505,1,'2016 - 04 - 01','2016 - 04 - 01'),
(10026,10,'2015 - 01 - 06','2015 - 02 - 15',1107,0,2502,1,'2015 - 02 - 10','2015 - 02 - 12'),
(10027,3,'2017 - 04 - 03','2017 - 05 - 14',1106,3,2507,1,'2017 - 05 - 10','2017 - 05 - 11'),
(10028,2,'2018 - 04 - 25','2018 - 05 - 23',1101,1,2504,2,'2018 - 05 - 20','2018 - 05 - 20'),
(10029,1,'2015 - 04 - 23','2016 - 05 - 25',1103,3,2501,1,'2016 - 05 - 12','2016 - 05 - 14'),
(10030,19,'2015 - 03 - 12','2015 - 04 - 30',1104,2,2502,1,'2015 - 04 - 20','2015 - 04 - 21'),
(10031,26,'2015 - 01 - 14', '2015- 02 - 23',1105,1,2503,2,'2015 - 02 - 22','2015 - 02 - 22'),
(10032,8,'2015 - 04 - 06','2015 - 05 - 25',1107,2,2504,2,'2015 - 05 - 22','2015 - 05 - 24'),
(10033,7,'2015 - 01 - 28','2015 - 02 - 14',1109,1,2506,0,Null,Null),
(10034,47,'2015 - 01 - 09','2015 - 03 - 04',1104,3,2501,2,'2015 - 03 - 01','2015 - 03 - 03'),
(10035,45,'2015 - 01 - 24','2015 - 02 - 14',1103,4,2502,1,'2015 - 02 - 11','2015 - 02 - 12'),
(10036,46,'2015 - 08 - 13','2015 - 08 - 25',1104,1,2505,1,'2015 - 08 - 20','2015 - 08 - 22'),
(10037,12,'2019 - 02 - 14','2019 - 03 - 25',1112,0,2505,1,'2019 - 03 - 21','2019 - 03 - 21'),
(10038,19,'2008 - 08 - 09','2009 - 07 - 04',1124,0,2504,2,'2009 - 07 - 02','2009 - 07 - 02'),
(10039,18,'2015 - 03 - 03','2015 - 03 - 08',1114,1,2506,1,'2015 - 03 - 02','2015 - 03 - 04'),
(10040,17,'2018 - 07 - 14','2018 - 08 - 27',1118,5,2502,2,'2018 - 08 - 22','2018 - 08 - 25'),
(10041,13,'2015 - 03 - 02','2015 - 03 - 31',1123,4,2507,2,'2015 - 03 - 30','2015 - 03 - 30'),
(10042,23,'2015 - 07 - 15','2015 - 09 - 08',1128,2,2502,1,'2015 - 09 - 04','2015 - 09 - 04'),
(10043,33,'2013 - 04 - 23','2013 - 05 - 24',1119,1,2502,3,'2013 - 05 - 20','2013 - 05 - 20'),
(10044,3,'2015 - 04 - 06','2015 - 04 - 30',1117,3,2503,1,'2015 - 04 - 30','2015 - 04 - 30'),
(10045,30,'2018 - 06 - 25','2018 - 07 - 18',1120,0,2502,2,'2018 - 07 - 12','2018 - 07 - 12'),
(10046,40,'2018 - 06 - 06','2018 - 07 - 25',1121,4,2501,2,'2018 - 07 - 21','2018 - 07 - 24'),
(10047,41,'2016 - 06 - 04','2016 - 06 - 14',1123,4,2505,1,'2016 - 06 - 11','2016 - 06 - 12'),
(10048,21,'2011 - 01 - 25','2011 - 02 - 24',1114,3,2506,2,'2011 - 02 - 22','2011 - 02 - 22'),
(10049,20,'2013 - 11 - 25','2014 - 01 - 01',1124,5,2504,2,'2014 - 01 - 01','2014 - 01 - 01'),
(10050,8,'2012 - 03 - 08','2012 - 04 - 04',1130,4,2504,0,Null,Null),
(10051,28,'2018 - 06 - 09','2018 - 07 - 15',1129,2,2504,2,'2018 - 07 - 11','2018 - 07 - 13'),
(10052,36,'2014 - 05 - 03','2014 - 05 - 25',1130,4,2501,1,'2014 - 05 - 22','2014 - 05 - 22'),
(10053,35,'2014 - 03 - 02','2014 - 04 - 16',1130,3,2502,1,'2014 - 04 - 11','2014 - 04 - 11'),
(10054,42,'2017 - 01 - 01','2017 - 02 - 04',1114,1,2505,1,'2017 - 02 - 02','2017 - 02 - 03'),
(10055,41,'2012 - 4 - 29','2012 - 05 - 27',1119,0,2504,2,'2012 - 05 - 24','2012 - 05 - 24'),
(10056,16,'2015 - 01 - 23','2015 - 02 - 13',1115,4,2507,2,'2015 - 02 - 11','2015 - 02 - 12'),
(10057,15,'2015 - 03 - 18','2015 - 04 - 14',1113,3,2507,1,'2015 - 04 - 12','2015 - 04 - 12'),
(10058,18,'2017 - 03 - 27','2017 - 04 - 25',1111,4,2501,1,'2017 - 04 - 24','2017 - 04 - 24'),
(10059,49,'2017 - 07 - 06','2017 - 07 - 15',1110,2,2502,2,'2017 - 07 - 14','2017 - 07 - 14'),
(10060,8,'2015 - 04 - 06','2015 - 04 - 14',1120,3,2503,1,'2015 - 04 - 11','2015 - 04 - 12'),
(10061,46,'2017 - 03 - 26','2017 - 04 - 25',1120,4,2505,1,'2017 - 04 - 24','2017 - 04 - 24'),
(10062,30,'2017 - 04 - 02','2017 - 07 - 04',1110,4,2504,2,'2017 - 07 - 03','2017 - 07 - 03'),
(10063,3,'2017 - 03 - 05','2017 - 04 - 01',1114,3,2506,1,'2017 - 04 - 01','2017 - 04 - 01'),
(10064,23,'2018 - 04 - 07','2018 - 04 - 25',1130,2,2507,1,'2018 - 04 - 21','2018 - 04 - 23'),
(10065,38,'2018 - 05 - 28','2018 - 06 - 08',1115,1,2507,2,'2018 - 06 - 04','2018 - 06 - 06'),
(10066,19,'2014 - 04 - 07','2014 - 04 - 25',1125,4,2504,1,'2014 - 04 - 22','2014 - 04 - 24'),
(10067,17,'2018 - 07 - 09','2018 - 07 - 24',1118,0,2501,0,Null,Null),
(10068,13,'2014 - 03 - 18','2014 - 03 - 25',1124,6,2502,1,'2014 - 03 - 22','2014 - 03 - 22'),
(10069,10,'2017 - 03 - 24','2017 - 04 - 09',1114,2,2503,1,'2017 - 04 - 02','2017 - 04 - 05'),
(10070,20,'2015 - 03 - 30','2015 - 04 - 10',1110,4,2502,2,'2015 - 04 - 04','2015 - 04 - 06'),
(10071,25,'2015 - 03 - 13','2015 - 03 - 20',1114,4,2501,1,'2015 - 03 - 11','2015 - 03 - 12'),
(10072,35,'2015 - 05 - 12','2015 - 05 - 24',1112,3,2504,1,'2015 - 05 - 23','2015 - 05 - 23'),
(10073,38,'2014 - 03 - 08','2014 - 04 - 12',1123,4,2503,0,Null,Null),
(10074,26,'2015 - 04 - 08','2015 - 04 - 23',1125,2,2504,1,'2015 - 04 - 20','2015 - 04 - 22'),
(10075,24,'2018 - 07 - 15','2018 - 07 - 25',1127,4,2506,2,'2018 - 07 - 21','2018 - 07 - 21'),
(10076,16,'2017 - 04 - 26','2017 - 05 - 13',1128,2,2504,1,'2017 - 05 - 10','2017 - 05 - 10'),
(10077,13,'2017 - 04 - 15','2017 - 04 - 28',1129,2,2504,2,'2017 - 04 - 20','2017 - 04 - 22'),
(10078,10,'2017 - 10 - 23','2017 - 10 - 30',1124,4,2502,2,'2017 - 10 - 20','2017 - 10 - 21'),
(10079,50,'2018 - 09 - 12','2018 - 10 - 10',1112,2,2504,1,'2018 - 10 - 01','2018 - 10 - 05'),
(10080,50,'2012 - 10 - 08','2012 - 12 - 17',1111,2,2504,1,'2012 - 12 - 07','2012 - 12 - 07')

select* from [dbo].[ChiTietHoaDon]
-----------------------------------------------------------------------------------
