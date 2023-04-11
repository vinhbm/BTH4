USE QLBH
GO
---cau1
CREATE FUNCTION fn_LayThongTinSanPhamTheoHang(@tenhang NVARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @tenhang
)
SELECT * FROM fn_LayThongTinSanPhamTheoHang('Samsung')
---cau2
CREATE FUNCTION fn_DanhSachSanPhamTheoNgayNhap(@ngayx NVARCHAR(10), @ngayy NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT sp.tensp, hsx.tenhang, n.soluongN, n.dongiaN
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    INNER JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap BETWEEN @ngayx AND @ngayy
)
SELECT * FROM fn_DanhSachSanPhamTheoNgayNhap('2019-03-05', '2020-06-18')
---cau3
CREATE FUNCTION fn_GetProductByManufacturer(@manufacturer NVARCHAR(50), @option INT)
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, sp.soluong
    FROM Sanpham sp
    INNER JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE hs.tenhang = @manufacturer AND (@option = 0 AND sp.soluong = 0 OR @option = 1 AND sp.soluong > 0)
SELECT *FROM fn_GetProductByManufacturer('Samsung', 1)
---câu4
drop function fn_DanhSachNhanVienTheoPhong
CREATE FUNCTION fn_DanhSachNhanVienTheoPhong(@tenPhong NVARCHAR(50))
RETURNS TABLE
AS
RETURN 
(
    SELECT *
    FROM Nhanvien
    WHERE phong = @tenPhong
)

SELECT * FROM fn_DanhSachNhanVienTheoPhong(N'Vật tư')
---cau5
CREATE FUNCTION DanhSachHangSX ( @diachi NVARCHAR(100) )
RETURNS TABLE
AS
RETURN
    SELECT tenhang, diachi, sodt, email
    FROM Hangsx
    WHERE diachi LIKE '%' + @diachi + '%';

SELECT * FROM DanhSachHangSX('KOREA');
---cau6
CREATE FUNCTION danh_sach_sp_hangsx_xuat_namxy(@namx int, @namy int)
RETURNS TABLE
AS
RETURN
    SELECT s.tensp, h.tenhang
    FROM Sanpham s 
    JOIN Hangsx h ON s.mahangsx = h.mahangsx
    JOIN Xuat x ON s.masp = x.masp
    WHERE YEAR(x.ngayxuat) BETWEEN @namx AND @namy;

SELECT * FROM danh_sach_sp_hangsx_xuat_namxy('2019', '2020')

---cau8
CREATE FUNCTION fn_NhanVienNhapHang(@ngayNhap DATE)
RETURNS TABLE
AS
RETURN
SELECT DISTINCT NV.manv, NV.tennv, NV.diachi, NV.sodt, NV.email, NV.phong
FROM Nhap N
JOIN Nhanvien NV ON N.manv = NV.manv
WHERE N.ngaynhap = @ngayNhap

SELECT * FROM fn_NhanVienNhapHang('2020-05-17')








