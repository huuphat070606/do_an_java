/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: quanlyhomestay
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `datphong`
--

DROP TABLE IF EXISTS `datphong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `datphong` (
  `MaDatPhong` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaKhachHang` bigint(20) NOT NULL,
  `MaPhong` bigint(20) NOT NULL,
  `MaLoaiPhong` bigint(20) DEFAULT NULL,
  `NguonDatPhong` varchar(30) NOT NULL COMMENT 'Có thể là ''Ứng dụng này'', ''Điện thoại'', ''Đặt trực tiếp''',
  `CheckIn_DuKien` datetime NOT NULL,
  `CheckOut_DuKien` datetime NOT NULL,
  `CheckIn_ThucTe` datetime DEFAULT NULL,
  `CheckOut_ThucTe` datetime DEFAULT NULL,
  `HanCocTien` datetime DEFAULT NULL,
  `TrangThai` varchar(20) NOT NULL COMMENT '''Pending'', ''Xac nhan'', ''Checked_In'', ''Checked_Out'', "Huy''',
  PRIMARY KEY (`MaDatPhong`),
  KEY `DatPhong_User_FK` (`MaKhachHang`),
  KEY `DatPhong_Phong_FK` (`MaPhong`),
  KEY `DatPhong_LoaiPhong_FK` (`MaLoaiPhong`),
  CONSTRAINT `DatPhong_LoaiPhong_FK` FOREIGN KEY (`MaLoaiPhong`) REFERENCES `loaiphong` (`MaLoaiPhong`),
  CONSTRAINT `DatPhong_Phong_FK` FOREIGN KEY (`MaPhong`) REFERENCES `phong` (`MaPhong`),
  CONSTRAINT `DatPhong_User_FK` FOREIGN KEY (`MaKhachHang`) REFERENCES `user` (`MaUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datphong`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `datphong` WRITE;
/*!40000 ALTER TABLE `datphong` DISABLE KEYS */;
/*!40000 ALTER TABLE `datphong` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `denbu`
--

DROP TABLE IF EXISTS `denbu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `denbu` (
  `MaDenBu` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaDatPhong` bigint(20) NOT NULL,
  `MaThietBi` bigint(20) NOT NULL,
  `SoTienDenBuThucTe` decimal(10,0) NOT NULL,
  `LyDo` varchar(100) DEFAULT NULL,
  `NguoiLapBienBan` bigint(20) NOT NULL,
  `reported_at` datetime NOT NULL,
  PRIMARY KEY (`MaDenBu`),
  KEY `DenBu_datphong_FK` (`MaDatPhong`),
  KEY `DenBu_thietbi_FK` (`MaThietBi`),
  KEY `DenBu_user_FK` (`NguoiLapBienBan`),
  CONSTRAINT `DenBu_datphong_FK` FOREIGN KEY (`MaDatPhong`) REFERENCES `datphong` (`MaDatPhong`),
  CONSTRAINT `DenBu_thietbi_FK` FOREIGN KEY (`MaThietBi`) REFERENCES `thietbi` (`MaThietBi`),
  CONSTRAINT `DenBu_user_FK` FOREIGN KEY (`NguoiLapBienBan`) REFERENCES `user` (`MaUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denbu`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `denbu` WRITE;
/*!40000 ALTER TABLE `denbu` DISABLE KEYS */;
/*!40000 ALTER TABLE `denbu` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `dichvu`
--

DROP TABLE IF EXISTS `dichvu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dichvu` (
  `MaDichVu` bigint(20) NOT NULL AUTO_INCREMENT,
  `LoaiDichVu` varchar(50) NOT NULL,
  `TenDichVu` varchar(100) NOT NULL,
  `DonGia` decimal(10,0) NOT NULL,
  `DonVi` varchar(20) NOT NULL COMMENT '''Lan'', ''Chai'', ''Phan''',
  PRIMARY KEY (`MaDichVu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dichvu`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `dichvu` WRITE;
/*!40000 ALTER TABLE `dichvu` DISABLE KEYS */;
/*!40000 ALTER TABLE `dichvu` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `giaodichcoctien`
--

DROP TABLE IF EXISTS `giaodichcoctien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `giaodichcoctien` (
  `MaCocTien` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaDatPhong` bigint(20) NOT NULL,
  `SoTienCoc` decimal(10,0) DEFAULT NULL,
  `ThanhToanBang` varchar(50) NOT NULL COMMENT '''VN_PAY'', ''MOMO'', ''NGANHANG'', ''TIENMAT''',
  `MaGiaoDich` varchar(100) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`MaCocTien`),
  KEY `GiaoDichCocTien_datphong_FK` (`MaDatPhong`),
  CONSTRAINT `GiaoDichCocTien_datphong_FK` FOREIGN KEY (`MaDatPhong`) REFERENCES `datphong` (`MaDatPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giaodichcoctien`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `giaodichcoctien` WRITE;
/*!40000 ALTER TABLE `giaodichcoctien` DISABLE KEYS */;
/*!40000 ALTER TABLE `giaodichcoctien` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `hoadon`
--

DROP TABLE IF EXISTS `hoadon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoadon` (
  `MaHoaDon` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaDatPhong` bigint(20) NOT NULL,
  `TienPhong` decimal(10,0) NOT NULL,
  `TienDichVu` decimal(10,0) NOT NULL,
  `TienKhachCoc` decimal(10,0) DEFAULT NULL,
  `TongTienPhaiTra` decimal(10,0) NOT NULL,
  `TrangThai` varchar(100) DEFAULT NULL COMMENT '''Chưa thanh toán'', ''Thanh toán 1 phần'', Đã thanh toán''',
  `PhuongThucThanhToan` varchar(50) NOT NULL COMMENT '''Tiền mặt'', ''Chuyển khoản ngân hàng''',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`MaHoaDon`),
  UNIQUE KEY `HoaDon_unique` (`MaDatPhong`),
  CONSTRAINT `hoadon_datphong_FK` FOREIGN KEY (`MaDatPhong`) REFERENCES `datphong` (`MaDatPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoadon`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `hoadon` WRITE;
/*!40000 ALTER TABLE `hoadon` DISABLE KEYS */;
/*!40000 ALTER TABLE `hoadon` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lichsudichvu`
--

DROP TABLE IF EXISTS `lichsudichvu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lichsudichvu` (
  `MaLichSu` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaDatPhong` bigint(20) NOT NULL,
  `MaDichVu` bigint(20) NOT NULL,
  `SoLuong` decimal(10,0) NOT NULL,
  `TongTien` decimal(10,0) DEFAULT NULL COMMENT 'SoLuong * DonGia',
  `Note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MaLichSu`),
  KEY `LichSuDichVu_datphong_FK` (`MaDatPhong`),
  KEY `LichSuDichVu_DichVu_FK` (`MaDichVu`),
  CONSTRAINT `LichSuDichVu_DichVu_FK` FOREIGN KEY (`MaDichVu`) REFERENCES `dichvu` (`MaDichVu`),
  CONSTRAINT `LichSuDichVu_datphong_FK` FOREIGN KEY (`MaDatPhong`) REFERENCES `datphong` (`MaDatPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lichsudichvu`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lichsudichvu` WRITE;
/*!40000 ALTER TABLE `lichsudichvu` DISABLE KEYS */;
/*!40000 ALTER TABLE `lichsudichvu` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `loaiphong`
--

DROP TABLE IF EXISTS `loaiphong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaiphong` (
  `MaLoaiPhong` bigint(20) NOT NULL AUTO_INCREMENT,
  `GiaNiemYet` decimal(10,0) NOT NULL,
  `TenLoaiPhong` varchar(20) DEFAULT NULL COMMENT 'Có 3 giá trị: ''Phòng trống'', '' Đã có người'', ''Đang dọn dẹp'', ''Đang bảo trì''',
  `MoTaTienIch` text DEFAULT NULL COMMENT 'Mô tả các tiện ích của phòng',
  `SoNguoiToiDa` int(11) NOT NULL,
  PRIMARY KEY (`MaLoaiPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaiphong`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `loaiphong` WRITE;
/*!40000 ALTER TABLE `loaiphong` DISABLE KEYS */;
/*!40000 ALTER TABLE `loaiphong` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `loaithietbi`
--

DROP TABLE IF EXISTS `loaithietbi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaithietbi` (
  `MaLoaiThietBi` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenLoaiThietBi` varchar(100) NOT NULL,
  `PhanLoai` varchar(50) NOT NULL COMMENT '''Điện tử'', ''Nội thất'', ''Đồ vải/Khăn ga'', ''Tiện ích''',
  `GiaTriDenBu` decimal(10,0) NOT NULL,
  `GhiChu` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaLoaiThietBi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaithietbi`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `loaithietbi` WRITE;
/*!40000 ALTER TABLE `loaithietbi` DISABLE KEYS */;
/*!40000 ALTER TABLE `loaithietbi` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `phong`
--

DROP TABLE IF EXISTS `phong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `phong` (
  `MaPhong` bigint(20) NOT NULL AUTO_INCREMENT,
  `SoPhong` varchar(20) NOT NULL,
  `MaLoaiPhong` bigint(20) NOT NULL,
  `TrangThai` varchar(20) NOT NULL COMMENT '''Phòng trống'', ''Đã được thuê'', ''Cần dọn dẹp'', ''Đang sửa chữa''',
  PRIMARY KEY (`MaPhong`),
  UNIQUE KEY `Phong_unique` (`SoPhong`),
  KEY `Phong_LoaiPhong_FK` (`MaLoaiPhong`),
  CONSTRAINT `Phong_LoaiPhong_FK` FOREIGN KEY (`MaLoaiPhong`) REFERENCES `loaiphong` (`MaLoaiPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phong`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `phong` WRITE;
/*!40000 ALTER TABLE `phong` DISABLE KEYS */;
/*!40000 ALTER TABLE `phong` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `thietbi`
--

DROP TABLE IF EXISTS `thietbi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `thietbi` (
  `MaThietBi` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaPhong` bigint(20) NOT NULL,
  `MaLoaiThietBi` bigint(20) NOT NULL,
  `TrangThai` varchar(20) NOT NULL COMMENT '''Tot'', ''Can Chinh Sua'', ''That lac''',
  `last_checked_at` datetime NOT NULL,
  PRIMARY KEY (`MaThietBi`),
  KEY `ThietBi_phong_FK` (`MaPhong`),
  KEY `ThietBi_loaithietbi_FK` (`MaLoaiThietBi`),
  CONSTRAINT `ThietBi_loaithietbi_FK` FOREIGN KEY (`MaLoaiThietBi`) REFERENCES `loaithietbi` (`MaLoaiThietBi`),
  CONSTRAINT `ThietBi_phong_FK` FOREIGN KEY (`MaPhong`) REFERENCES `phong` (`MaPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thietbi`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `thietbi` WRITE;
/*!40000 ALTER TABLE `thietbi` DISABLE KEYS */;
/*!40000 ALTER TABLE `thietbi` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `MaUser` bigint(20) NOT NULL AUTO_INCREMENT,
  `VaiTro` varchar(15) NOT NULL,
  `HoTen` varchar(50) NOT NULL,
  `SoDienThoai` varchar(15) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `SoCCCD` varchar(100) NOT NULL,
  `AnhCCCD` varchar(100) NOT NULL COMMENT 'Đường dẫn lưu ảnh',
  `Password` varchar(50) NOT NULL,
  `Username` varchar(20) NOT NULL,
  PRIMARY KEY (`MaUser`),
  UNIQUE KEY `User_unique` (`SoCCCD`),
  UNIQUE KEY `user_unique2` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping routines for database 'quanlyhomestay'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-20 21:10:29
