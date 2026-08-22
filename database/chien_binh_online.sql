-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 22, 2026 lúc 05:58 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `chien_binh_online`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `content`, `created_at`, `event_id`) VALUES
(1, 2, 'Bản cập nhật này boss rơi đồ rất hợp lý, mong admin giữ nguyên tỉ lệ.', '2026-08-15 09:00:00', 1),
(2, 3, 'Nhân vật của em bị kẹt ở Map Rừng Karin, nhờ admin hỗ trợ teleport về làng.', '2026-08-15 09:30:00', 1),
(3, 4, 'Khi nào có sự kiện x2 nạp thẻ vậy ban quản trị?', '2026-08-15 10:15:00', 1),
(4, 2, 'mẹ mày bọn ngu', '2026-08-17 12:11:06', 1),
(5, 5, 'sự kiện hay quá', '2026-08-21 00:39:59', 14),
(6, 5, 'adaslna', '2026-08-21 00:40:37', 8),
(7, 2, 'sự kiến thiếu', '2026-08-21 02:20:45', 14);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `downloads`
--

CREATE TABLE `downloads` (
  `id` int(11) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `version` varchar(20) NOT NULL,
  `file_url` varchar(255) NOT NULL,
  `file_size` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `downloads`
--

INSERT INTO `downloads` (`id`, `platform`, `version`, `file_url`, `file_size`, `created_at`) VALUES
(1, 'PC (Windows)', 'v1.2.0', 'https://game.example.com/downloads/HoiUcNgocRong_PC_v1.2.0.zip', '125 MB', '2026-08-15 01:00:00'),
(2, 'Android (APK)', 'v1.2.0', 'https://game.example.com/downloads/HoiUcNgocRong_v1.2.0.apk', '85 MB', '2026-08-15 01:00:00'),
(3, 'iOS (TestFlight)', 'v1.2.0', 'https://testflight.apple.com/join/example', '95 MB', '2026-08-15 01:00:00'),
(4, 'Java (JAR/JAD)', 'v1.2.0', 'https://game.example.com/downloads/HoiUcNgocRong.jar', '5 MB', '2026-08-15 01:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `loai` enum('EVENT','COMMENT') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `events`
--

INSERT INTO `events` (`id`, `user_id`, `title`, `content`, `description`, `image`, `created_at`, `loai`) VALUES
(1, 1, 'Đua Top Chiến Lực Mở Server', 'Người chơi đạt top 1-10 lực chiến sẽ nhận được Cải Trang Goku SSJ và 100.000 Vàng.', '### Sự kiện Đua Top Lực Chiến – Chinh Phục Đỉnh Cao Sức Mạnh\r\n\r\n🔥 **Cuộc đua lực chiến chính thức bắt đầu!** Đây là cơ hội để tất cả chiến binh thể hiện sức mạnh, bản lĩnh và khả năng phát triển nhân vật của mình. Hãy không ngừng nâng cấp trang bị, cường hóa sức mạnh, mở khóa những tính năng mới và xây dựng đội hình mạnh nhất để từng bước **bứt phá lực chiến, vượt qua đối thủ và vươn lên những vị trí cao nhất trên bảng xếp hạng**.\r\n\r\n🏆 Khi sự kiện kết thúc, **10 người chơi có lực chiến cao nhất từ Top 1 đến Top 10** sẽ nhận được phần thưởng cực kỳ hấp dẫn. Đặc biệt, những chiến binh xuất sắc lọt vào Top sẽ sở hữu **Cải Trang Goku SSJ** – biểu tượng của sức mạnh và khí thế chiến đấu – cùng **100.000 Vàng** để tiếp tục nâng cấp nhân vật và chinh phục những thử thách tiếp theo.\r\n\r\n⚡ **Mỗi điểm lực chiến đều có thể quyết định thứ hạng!** Đừng bỏ lỡ bất kỳ cơ hội nào để gia tăng sức mạnh. Hãy tận dụng mọi tài nguyên, hoàn thành nhiệm vụ, nâng cấp trang bị và liên tục phá vỡ giới hạn của bản thân. Cuộc chiến trên bảng xếp hạng sẽ ngày càng khốc liệt khi các chiến binh cùng nhau cạnh tranh từng vị trí.\r\n\r\n🌟 **Bạn có đủ sức trở thành chiến binh mạnh nhất?** Hãy tham gia ngay, tăng tốc lực chiến và chiến đấu để ghi tên mình vào **Top 1–10**. Phần thưởng danh giá đang chờ đợi những người kiên trì và mạnh mẽ nhất!\r\n\r\n**🔥 Bứt phá lực chiến – Chinh phục Top 10 – Nhận Cải Trang Goku SSJ + 100.000 Vàng! 🔥**\r\n', 'event-3.png', '2026-08-15 03:00:00', 'EVENT'),
(2, 1, 'Săn Boss Giải Cứu Trái Đất', 'Tiêu diệt Fide và Cell bọ hung tại Đảo Kame nhận Rương Ngọc Rồng may mắn.', '### 🐉 Sự kiện: Đại Chiến Đảo Kame – Săn Rương Ngọc Rồng May Mắn\r\n\r\n🔥 **Đảo Kame đang gặp nguy hiểm!** Những kẻ thù nguy hiểm **Fide** và **Cell Bọ Hung** đã xuất hiện, mang theo nguồn sức mạnh đáng sợ và sẵn sàng thách thức mọi chiến binh. Đây chính là lúc các chiến binh mạnh mẽ đứng lên, tiến đến **Đảo Kame** và tham gia cuộc chiến đầy kịch tính!\r\n\r\n⚔️ Hãy tập hợp sức mạnh, chuẩn bị trang bị và **tiêu diệt Fide cùng Cell Bọ Hung** để chứng minh bản lĩnh của mình. Mỗi trận chiến là một cơ hội để bạn săn tìm những phần thưởng giá trị và khám phá những điều bất ngờ đang chờ đợi.\r\n\r\n🎁 Đặc biệt, sau khi **tiêu diệt Fide và Cell Bọ Hung tại Đảo Kame**, người chơi sẽ có cơ hội nhận được **Rương Ngọc Rồng May Mắn**. Những chiếc rương bí ẩn này chứa đựng những phần thưởng hấp dẫn, mang đến cơ hội gia tăng sức mạnh và hỗ trợ hành trình chinh phục thế giới.\r\n\r\n🌟 **Cơ hội chỉ dành cho những chiến binh dũng cảm!** Đừng bỏ lỡ cuộc chiến tại Đảo Kame. Hãy nhanh chóng tham gia, đánh bại những kẻ địch mạnh mẽ và thử vận may của mình với **Rương Ngọc Rồng May Mắn**!\r\n\r\n🔥 **Tiêu diệt kẻ địch – Săn Rương May Mắn – Nhận phần thưởng!**\r\n⚡ **Đảo Kame đang chờ những chiến binh mạnh nhất xuất trận!**\r\n', 'event-2.png', '2026-08-15 03:30:00', 'EVENT'),
(3, 1, 'Cảm nhận về sự kiện', 'Sự kiện Đua Top Lực Chiến lần này rất hấp dẫn, phần thưởng Cải Trang Goku SSJ nhìn rất đẹp!', 'Người chơi chia sẻ cảm nhận về sự kiện Đua Top Lực Chiến.', NULL, '2026-08-16 01:30:00', 'COMMENT'),
(4, 1, 'Đánh giá sự kiện Đảo Kame', 'Fide và Cell Bọ Hung khá mạnh, nhưng phần thưởng Rương Ngọc Rồng May Mắn rất đáng để thử sức.', 'Người chơi đánh giá độ khó và phần thưởng của sự kiện.', NULL, '2026-08-16 03:15:00', 'COMMENT'),
(5, 1, 'Hỏi về phần thưởng', 'Nếu đạt Top 5 lực chiến thì có nhận được cả Cải Trang Goku SSJ và 100.000 Vàng không?', 'Câu hỏi của người chơi về phần thưởng sự kiện.', NULL, '2026-08-16 06:20:00', 'COMMENT'),
(6, 1, 'Chia sẻ kinh nghiệm', 'Mình đã nâng cấp trang bị và tăng lực chiến liên tục để lọt vào Top 10.', 'Người chơi chia sẻ kinh nghiệm tăng lực chiến.', NULL, '2026-08-16 08:45:00', 'COMMENT'),
(7, 1, 'Rương Ngọc Rồng', 'Mình vừa đánh bại Cell Bọ Hung và nhận được Rương Ngọc Rồng May Mắn. Hy vọng lần sau sẽ nhận được phần thưởng tốt hơn!', 'Chia sẻ kết quả khi tham gia sự kiện.', NULL, '2026-08-16 11:00:00', 'COMMENT'),
(8, 2, 'sfafasfas', 'xin hao', 'Chỉ là giao lưu', NULL, '2026-08-17 13:41:20', 'COMMENT'),
(11, 1, 'săn sư tử', 'săn sư tử nhận quà', 'cùng đi săn sư tử đện nhạn quà hấp dẫn nào', 'event-1.png', '2026-08-18 15:26:09', 'EVENT'),
(13, 1, 'chiến binh hỏa tốc', 'các chiến binh sayyan có thể giao dịch được không ad', 'Chỉ là giao lưu', NULL, '2026-08-20 02:49:30', 'COMMENT'),
(14, 1, 'sự kiện nhập học', 'mùa nhập học sắp tới chúng ta chuẩn bị đi học thôi nào', 'đây là mùa nhập học vui vẻ', 'event_1787239065698.png', '2026-08-20 12:34:21', 'EVENT');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sender_type` enum('USER','ADMIN') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `sender_type`, `message`, `created_at`) VALUES
(22, 5, 'USER', 'chào bạn', '2026-08-21 01:20:31'),
(23, 5, 'ADMIN', 'chào cái gì', '2026-08-21 01:20:59'),
(24, 2, 'USER', 'đi đánh nhau không', '2026-08-21 02:24:34'),
(25, 2, 'USER', 'đi nhau không', '2026-08-21 02:24:44');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `type` enum('CARD','MOMO','BANK','BUY_ITEM') NOT NULL,
  `status` enum('PENDING','SUCCESS','FAILED') DEFAULT 'PENDING',
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `amount`, `type`, `status`, `description`, `created_at`) VALUES
(1, 2, '100000.00', 'CARD', 'SUCCESS', 'Nạp thẻ Viettel 100k', '2026-08-15 08:10:00'),
(2, 3, '50000.00', 'MOMO', 'SUCCESS', 'Nạp qua ví MoMo', '2026-08-15 08:20:00'),
(3, 4, '200000.00', 'BANK', 'SUCCESS', 'Chuyển khoản Vietcombank', '2026-08-15 08:25:00'),
(4, 2, '50000.00', 'BUY_ITEM', 'SUCCESS', 'Mua Gói Quà Tân Thủ trong game', '2026-08-15 08:40:00'),
(5, 2, '100000.00', 'BANK', 'SUCCESS', 'Nạp 100000đ qua QR Code', '2026-08-17 13:08:35'),
(6, 2, '20000.00', 'BANK', 'SUCCESS', 'Nạp 20000đ qua QR Code', '2026-08-17 13:09:10'),
(7, 2, '50000.00', 'BANK', 'SUCCESS', 'Nạp 50000đ qua QR Code', '2026-08-17 13:09:31'),
(8, 2, '100000.00', 'BANK', 'SUCCESS', 'Nạp 100000đ qua QR Code', '2026-08-17 13:50:13'),
(9, 2, '100000.00', 'BANK', 'SUCCESS', 'Nạp 100000đ qua QR Code', '2026-08-18 00:13:55'),
(10, 1, '1000000.00', 'BANK', 'SUCCESS', 'Nạp 1000000đ qua QR Code', '2026-08-18 01:12:07'),
(11, 1, '1000000.00', 'CARD', 'SUCCESS', 'Nạp 1000000đ qua Thẻ cào', '2026-08-18 01:12:24'),
(12, 1, '40000.00', 'BANK', 'SUCCESS', 'Nạp 40000đ qua QR Code', '2026-08-18 01:15:42'),
(13, 1, '300000.00', 'BANK', 'SUCCESS', 'Nạp 300000đ qua QR Code', '2026-08-18 01:19:23'),
(14, 1, '50000.00', 'BANK', 'SUCCESS', 'VietQR MBBank - Cú pháp: NAP admin', '2026-08-18 16:29:15'),
(15, 5, '100000.00', 'CARD', 'FAILED', 'VIETTEL - Seri: 5346346 - PIN: 346346346', '2026-08-20 02:52:51'),
(16, 5, '100000.00', 'BANK', 'FAILED', 'VietQR MBBank - Cú pháp: NAP moncrook', '2026-08-20 16:09:00'),
(17, 5, '100000.00', 'BANK', 'SUCCESS', 'VietQR MBBank - Cú pháp: NAP moncrook', '2026-08-20 16:09:03'),
(18, 5, '500000.00', 'CARD', 'SUCCESS', 'VIETTEL - Seri: 412421421 - PIN: 12412412124', '2026-08-20 16:09:15'),
(19, 5, '500000.00', 'BANK', 'FAILED', 'VietQR MBBank - Cú pháp: NAP moncrook', '2026-08-20 16:09:27'),
(20, 5, '50000.00', 'BANK', 'FAILED', 'VietQR MBBank - Cú pháp: NAP moncrook', '2026-08-21 00:24:54'),
(21, 5, '20000.00', 'CARD', 'SUCCESS', 'VINAPHONE - Seri: 95325823752 - PIN: 3253235236', '2026-08-21 00:41:41'),
(22, 5, '100000.00', 'BANK', 'SUCCESS', 'VietQR MBBank - Cú pháp: NAP moncrook', '2026-08-21 00:43:33');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(15) NOT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER',
  `balance` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('ACTIVE','BANNED') DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `role`, `balance`, `created_at`, `status`) VALUES
(1, 'admin', 'admin', '123456', 'ADMIN', '2390000.00', '2026-08-15 08:07:32', 'ACTIVE'),
(2, 'concho', 'player01', '123456', 'USER', '470000.00', '2026-08-15 08:07:32', 'ACTIVE'),
(3, 'conga', 'player02', '123456', 'USER', '50000.00', '2026-08-15 08:07:32', 'ACTIVE'),
(4, 'conmeo', 'player03', '123456', 'USER', '200000.00', '2026-08-15 08:07:32', 'ACTIVE'),
(5, 'moncrook', 'moncrook', '123', 'USER', '720000.00', '2026-08-16 09:31:34', 'ACTIVE');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comments_users` (`user_id`),
  ADD KEY `fk_comments_event` (`event_id`);

--
-- Chỉ mục cho bảng `downloads`
--
ALTER TABLE `downloads`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_events_user` (`user_id`);

--
-- Chỉ mục cho bảng `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_transactions_users` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `downloads`
--
ALTER TABLE `downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `fk_comments_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
