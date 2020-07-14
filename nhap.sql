--14.Liệt kê các nhân viên có tổng tiền hóa đơn lập được cao hơn bất kỳ hóa đơn của nhân viên nào trong năm 2018, thông tin gồm MaNV,TenNV,TongHD=SUM(SoluongThuoc*DongiaThuoc+SoluongDV*DongiaDV)
select N.MaNV,TenNV,TongHD=SUM((SoluongThuoc*DongiaThuoc)+(SoluongDV*DongiaDV))
from NhanVien n join HoaDon h on n.MaNV=h.MaNV
						join [dbo].[ChiTietHoaDon] ct on h.MaHD=ct.MaHD
						join Thuoc t on t.MaThuoc=ct.MaThuoc
						join DichVu d on d.MaDV=d.MaDV
where year(NgaylapHD)=2018
group by  N.MaNV,TenNV
having SUM((SoluongThuoc*DongiaThuoc)+(SoluongDV*DongiaDV))>any(select SUM(SoluongThuoc*DongiaThuoc+SoluongDV*DongiaDV)
										from NhanVien n join HoaDon h on n.MaNV=h.MaNV
																join [dbo].[ChiTietHoaDon] ct on h.MaHD=ct.MaHD
																join Thuoc t on t.MaThuoc=ct.MaThuoc
																join DichVu d on d.MaDV=d.MaDV
										where year(NgaylapHD)=2018
										group by n.MaNV)
--15.Xem thông tin của các bệnh nhân có tổng số hóa đơn cao hơn bất kỳ số hóa đơn của khách hàng trong năm 2018. Thông tin gồm MaBN, HotenBN, SoHD

select MaBN, HotenBN, SoHD=COUNT(*)
from NhanVien n join HoaDon h on n.MaNV=h.MaNV
						join [dbo].[ChiTietHoaDon] ct on h.MaHD=ct.MaHD
						join Thuoc t on t.MaThuoc=ct.MaThuoc
						join DichVu d on d.MaDV=d.MaDV
where year(NgaylapHD)=2018
group by  N.MaNV,TenNV
having SUM((SoluongThuoc*DongiaThuoc)+(SoluongDV*DongiaDV))>any(select SUM(SoluongThuoc*DongiaThuoc+SoluongDV*DongiaDV)
										from NhanVien n join HoaDon h on n.MaNV=h.MaNV
																join [dbo].[ChiTietHoaDon] ct on h.MaHD=ct.MaHD
																join Thuoc t on t.MaThuoc=ct.MaThuoc
																join DichVu d on d.MaDV=d.MaDV
										where year(NgaylapHD)=2018
										group by n.MaNV)