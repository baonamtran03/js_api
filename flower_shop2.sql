-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th12 28, 2024 lúc 03:23 PM
-- Phiên bản máy phục vụ: 8.2.0
-- Phiên bản PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `flower_shop2`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `idcontact` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

DROP TABLE IF EXISTS `danhmuc`;
CREATE TABLE IF NOT EXISTS `danhmuc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `danhmucchinh` text NOT NULL,
  `tendanhmuc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_vietnamese_ci NOT NULL,
  `lienket` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lienket_danhmuc` (`lienket`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `danhmuc`
--

INSERT INTO `danhmuc` (`id`, `danhmucchinh`, `tendanhmuc`, `lienket`) VALUES
(1, 'bo-hoa-len', 'Bó hoa len', 'bo-hoa-len'),
(2, 'hoa-len-dau-thu', 'Hoa len đầu thú', 'bo-hoa-len'),
(3, 'chau-hoa-len', 'Chậu hoa len', 'hoa-len-dau-thu'),
(4, 'chau-cay-len', 'Chậu cây len', 'chau-hoa-len');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `kho`
--

DROP TABLE IF EXISTS `kho`;
CREATE TABLE IF NOT EXISTS `kho` (
  `idwardhouse` int NOT NULL,
  `idproduct` int NOT NULL,
  `soluong` varchar(255) NOT NULL,
  PRIMARY KEY (`idwardhouse`),
  KEY `fk_product_warehouse` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `kho`
--

INSERT INTO `kho` (`idwardhouse`, `idproduct`, `soluong`) VALUES
(1, 1, '100'),
(2, 2, '50'),
(3, 3, '75'),
(4, 4, '20'),
(5, 5, '60'),
(6, 6, '30'),
(7, 7, '40'),
(8, 8, '90'),
(9, 9, '10'),
(10, 10, '80'),
(11, 11, '25'),
(12, 13, '15');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(45) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `iduser` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_user` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_item`
--

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE IF NOT EXISTS `order_item` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `fk_order_item_order` (`order_id`),
  KEY `fk_order_item_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `order_item`
--

INSERT INTO `order_item` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 12, 2580000.00),
(2, 2, 2, 22, 1450000.00),
(3, 3, 3, 12, 2580000.00),
(4, 4, 4, 22, 1450000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `idproduct` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `times_sold` int DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imagepath` varchar(150) DEFAULT NULL,
  `imagepathhover` varchar(160) DEFAULT NULL,
  `old_price` int DEFAULT NULL,
  PRIMARY KEY (`idproduct`),
  UNIQUE KEY `idproducts_UNIQUE` (`idproduct`),
  KEY `FK_product_danhmuc` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`idproduct`, `name`, `type`, `description`, `category`, `price`, `times_sold`, `date_added`, `imagepath`, `imagepathhover`, `old_price`) VALUES
(1, 'Bó Hoa Len 5 Cánh Màu Cam Trắng ', 'Bó hoa len', 'Bó hoa len 5 cánh màu cam trắng đẹp, dễ thương được đan móc thủ công tỉ mỉ', 'bo-hoa-len', 19.00, 3, '2023-05-25 00:42:26', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfeOzHlObVqjT1_KR-iSfMVGHOVEIGlCBdhw&s', NULL, NULL),
(2, 'Bó Hoa Hồng Len', 'Bó hoa len', 'Bó hoa hồng được làm thủ công từ len rất tỉ mỉ và lãng mạn', 'bo-hoa-len', 49.99, 10, '2023-05-25 00:54:09', 'https://hoahandmade.vn/public/image/sanpham/171/bo-hoa-handmade-luxury-len_anh_phu.webp', NULL, 55),
(3, 'Bó hoa tulip', 'Bó hoa len', 'Bó hoa tulip hồng được làm thủ công từ len cực tỉ mỉ', 'bo-hoa-len', 59.99, 3, '2023-05-25 00:54:09', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR9kczTW2yI0E3CNGKHKOa45sQ6h2T4mCwlEiFN71-b5L1pBRqe0-GrDBHmdS_bG86ldI&usqp=CAU', NULL, NULL),
(4, 'Bó hoa hướng dương', 'Bó hoa len', 'Bó hoa hướng dương được làm thủ công từ len', 'bo-hoa-len', 79.99, 0, '2023-05-25 00:54:09', 'https://7fgarden.com/wp-content/uploads/2024/06/hoa-huong-duong-bang-len.jpg', NULL, NULL),
(5, 'Hoa len đầu thú hình thỏ ', 'Hoa len đầu thú', 'Hoa len đầu thú hình thỏ được làm tỉ mỉ với màu sắc tươi sáng, dễ thương', 'hoa-len-dau-thu', 39.99, 0, '2023-05-25 00:54:09', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lpqjv9hs32s2ea', NULL, NULL),
(6, 'Hoa len đầu thú hình heo', 'Hoa len đầu thú', 'Hoa len đầu thú hình heo với màu hồng dễ thương', 'hoa-len-dau-thu', 19.99, 0, '2023-05-25 00:54:09', 'https://vn-live-01.slatic.net/p/1ec4fd1aee8e9f767c92fe2f19b51b67.jpg', NULL, 0),
(7, 'Hoa len đầu thú hình cừu', 'Hoa len đầu thú', 'Hoa len đầu thú hình cừu được làm tỉ mỉ', 'hoa-len-dau-thu', 34.99, 0, '2023-05-25 00:54:09', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmo7y6p1ain3e5', NULL, NULL),
(8, 'Chậu hoa len tim', 'Chậu hoa len', 'Chậu hoa len hình trái tim được làm thủ công tỉ mỉ với nhiều màu sắc tươi sáng', 'chau-hoa-len', 24.99, 5, '2023-05-25 00:54:09', 'https://thucongvietnam.com/data/news/17531/z5464306117996_dc0e793efd1029bf10a3d72c0c11cb66.jpg', NULL, 56),
(9, 'Chậu len hoa hồng', 'Chậu hoa len', 'Chậu len hoa hồng được làm thủ công tỉ mỉ với các màu sắc tươi sáng, lãng mạn', 'chau-hoa-len', 89.99, 1, '2023-05-25 00:54:09', 'https://filebroker-cdn.lazada.vn/kf/S8d9ec34e148943c786cfaa67cc8b45cfI.jpg', NULL, NULL),
(10, 'Chậu hoa len linh lan', 'Chậu hoa len', 'Chậu hoa len linh lan được làm thủ công tỉ mỉ', 'chau-hoa-len', 59.99, 8, '2023-05-25 00:54:09', 'https://filebroker-cdn.lazada.vn/kf/Sd93ff8a3994e4b919f9cc4fad84fea80g.jpg', NULL, 88),
(11, 'Chậu cây dâu tây', 'Chậu cây len', 'Chậu cây dâu tây được làm thủ công từ len tỉ mỉ', 'chau-cay-len', 29.99, 0, '2023-05-25 00:54:09', 'https://filebroker-cdn.lazada.vn/kf/Sf896ea96c83c4842922f20f6e5eb8fd80.jpg', NULL, NULL),
(13, 'Chậu cây quít', 'Chậu cây len', 'Chậu cây quít được làm thủ công từ len tỉ mỉ', 'chau-cay-len', 222.00, 2, '2023-05-24 23:04:31', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-llmsrhs1ylks53', '', 250);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sinhvien`
--

DROP TABLE IF EXISTS `sinhvien`;
CREATE TABLE IF NOT EXISTS `sinhvien` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ten` varchar(250) NOT NULL,
  `diem` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `sinhvien`
--

INSERT INTO `sinhvien` (`id`, `ten`, `diem`) VALUES
(1, 'tran', 765),
(2, 'tien', 667);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `idsubscriptions` int NOT NULL AUTO_INCREMENT,
  `emails` varchar(100) NOT NULL,
  PRIMARY KEY (`idsubscriptions`),
  UNIQUE KEY `idsubscriptions_UNIQUE` (`idsubscriptions`),
  UNIQUE KEY `emails_UNIQUE` (`emails`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  `phonenumber` varchar(45) NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user',
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `phonenumber_UNIQUE` (`phonenumber`),
  UNIQUE KEY `iduser_UNIQUE` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`iduser`, `name`, `email`, `username`, `password`, `address`, `phonenumber`, `role`) VALUES
(55, 'admin', 'admin@gmail.com', 'admin', '$2y$12$tcCMb.oj4jkM57Q/zWS2Zu0HtaxXAcXKN6dgX.QvoMt3.MbC7SKr2', 'test', '0123456789', 'admin'),
(56, 'Tran', 'tran@gmail.com', 'namtran', '$2b$10$0HzxMhnMp5pB97YgwQUK9uyf9nV9aJVYELfhpkjVIm5ucVzItvTfq', 'aaaa', '0123456790', 'user'),
(57, 'Tien', 'tien@gmail.com', 'thuytien', '$2b$10$i8p3KP/ENcAF52UQ5VEAuOIyKZa8GCjF06ymKAaDO.Uho286lMrFO', 'aaaa', '0777777777', 'user'),
(71, 'rrreewwqqqqqqqqqqqqqqqq', '2111919@gmail.com', 'NamTran4444', '$2b$10$.TZ0A4DR7CyIAYf1zfUiaOuMskE1mkKouenV.0ZV8YbFDgHKqE97W', 'rrrr', '0364891237', 'user'),
(72, 'r', 'dh52111919@gmail.com', 'ee', '$2b$10$duC66wDCvAaLj2s0M09l1uK1FGzm1setHflwzJdapxt5rh/1CgA5u', '111', '0327774579', 'user');

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD CONSTRAINT `FK_danhmuc_product` FOREIGN KEY (`lienket`) REFERENCES `product` (`category`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `kho`
--
ALTER TABLE `kho`
  ADD CONSTRAINT `fk_product_warehouse` FOREIGN KEY (`idproduct`) REFERENCES `product` (`idproduct`);

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
