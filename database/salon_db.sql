-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 17, 2026 at 01:08 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `salon_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `service_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('Accepted','In Progress','Completed','Cancelled') DEFAULT 'Accepted',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `user_id`, `name`, `email`, `phone`, `service_id`, `staff_id`, `appointment_date`, `appointment_time`, `status`, `created_at`) VALUES
(1, 16, 'Hamdan Sufyan', 'hamdan@gmail.com', '035896314', 1, 14, '2026-07-30', '10:00:00', 'Accepted', '2026-07-15 09:14:46'),
(2, 21, 'Ali Imran', 'ali@gmail.com', '03012468920', 11, 12, '2026-07-30', '15:00:00', 'Accepted', '2026-07-15 09:15:40'),
(3, 17, 'Shariq Shahzad', 'shariq@gmail.com', '036987412', 36, 13, '2026-07-31', '08:00:00', 'Accepted', '2026-07-15 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `blog`
--

CREATE TABLE `blog` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blog`
--

INSERT INTO `blog` (`id`, `title`, `content`, `image`, `post_date`, `category`, `tags`) VALUES
(1, '5 Beard Care Tips Every Gentleman Should Follow', 'A well-maintained beard enhances your appearance and confidence. Learn five essential beard care tips, including proper washing, moisturizing, trimming, and using beard oil to keep your facial hair healthy, soft, and perfectly styled every day.', 'images/blog/beardcare.jpg', '2026-05-30', 'Beard Care', 'beard,beard care,grooming,tips'),
(2, 'Why Every Man Should Use a Professional Hair Care Routine', 'Healthy hair begins with the right routine. Discover how using professional shampoo, conditioner, and nourishing products helps reduce hair damage, strengthens roots, and keeps your hairstyle looking fresh throughout the day.', 'images/blog/haircare.jpg', '2026-03-28', 'Hair Care', 'shampoo,conditioner,hair care,men'),
(3, 'Top Men\'s Haircut Trends', 'Looking for a fresh new hairstyle? Discover the most popular men\'s haircuts of 2026, including fades, textured crops, pompadours, and modern classics. Choose a style that matches your personality and keep your look sharp all year round.', 'images/blog/haircut.png', '2026-06-01', 'Haircut', 'men\'s haircut,fade,pompadour,style'),
(4, 'How to Choose the Right Hair Styling Product?', 'Choosing the right styling product makes all the difference. Compare hair wax, pomade, clay, and gel to find the perfect option for your hair type, desired finish, and long-lasting hold without damaging your hair.', 'images/blog/hairstyle.png', '2026-04-16', 'Hair Styling', 'hair wax,pomade,clay,styling');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `blog_id`, `author`, `email`, `content`, `created_at`) VALUES
(9, 3, 'Hassan Ali', 'hassan@gmail.com', 'Very helpful', '2026-06-06 07:54:51'),
(13, 1, 'Shariq Shahzad', 'shariq@gmail.com', 'Thanks for the useful beard grooming advice!', '2026-07-15 09:06:26'),
(14, 4, 'Ali Imran', 'ali@gmail.com', 'Excellent advice for hair styling!', '2026-07-15 09:11:18'),
(15, 2, 'Ali Imran', 'ali@gmail.com', 'Very useful hair care guide.', '2026-07-15 09:11:55');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `phone`, `subject`, `message`, `submitted_at`) VALUES
(2, 'shariq shahzad', 'shariq@gmail.com', '036987412', 'Feedback', 'Great Service keep it up.', '2026-06-06 08:31:05'),
(3, 'Arham Khan', 'arham@gmail.com', '035896315', 'To appreciate', 'Wonderful Experience staff was so cooperative.', '2026-06-06 09:01:02');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `title`, `category`, `file_path`) VALUES
(1, 'Classic Hair Cut 1', 'hair cutting', 'images/gallery/1.png'),
(2, 'Classic Beard Cut 1', 'beard cutting', 'images/gallery/4.png'),
(3, 'Classic Hair Style 1', 'hair styling', 'images/gallery/2.png'),
(4, 'Classic Hair Styling 2', 'hair styling', 'images/gallery/6.png'),
(5, 'Classic Facial 1', 'facial', 'images/gallery/3.png'),
(6, 'Classic Hair Cut 2', 'hair cutting', 'images/gallery/5.png');

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscribers`
--

CREATE TABLE `newsletter_subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `newsletter_subscribers`
--

INSERT INTO `newsletter_subscribers` (`id`, `email`, `subscribed_at`) VALUES
(1, 'hamdan@gmail.com', '2026-06-06 10:15:34'),
(2, 'hassan@gmail.com', '2026-06-06 10:15:48');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `payment_method` enum('online_payment','cod') NOT NULL DEFAULT 'online_payment',
  `status` enum('unpaid','pending','paid','packed','shipped','delivered','cancelled') DEFAULT 'unpaid',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `first_name`, `last_name`, `email`, `telephone`, `address`, `city`, `postal_code`, `country`, `total`, `payment_method`, `status`, `created_at`, `updated_at`) VALUES
(6, 18, 'Hassan', 'Ali', 'hassan@gmail.com', '032145698', 'gulshan', 'Karachi', '123456', 'Pakistan', 16000.00, 'online_payment', 'paid', '2026-06-05 08:08:17', '2026-06-05 12:50:07'),
(7, 17, 'shariq', 'shahzad', 'shariq@gmail.com', '036987412', 'Tariq road', 'Karachi', '123456', 'Pakistan', 12800.00, 'online_payment', 'shipped', '2026-06-06 08:43:18', '2026-07-15 09:29:53'),
(9, 16, 'Hamdan', 'Sufyan', 'hamdan@gmail.com', '035896314', 'sharfabad', 'Karachi', '123456', 'Pakistan', 6400.00, 'online_payment', 'delivered', '2026-06-06 08:54:10', '2026-07-15 09:29:34'),
(10, 15, 'Arham', 'Khan', 'arham@gmail.com', '035896315', 'FB Area', 'Karachi', '123456', 'Pakistan', 8000.00, 'online_payment', 'pending', '2026-06-06 08:57:26', '2026-06-06 08:57:26'),
(11, 21, 'Ali', 'Imran', 'ali@gmail.com', '03012468920', 'Nazimabad', 'Karachi', '123456', 'Pakistan', 16000.00, 'online_payment', 'pending', '2026-07-13 18:21:49', '2026-07-13 18:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `price`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `product_name`, `quantity`, `price`) VALUES
(6, 6, 1, 'Hair Shampoo', 1, 16000.00),
(7, 7, 2, 'Beard Trimmer', 1, 12800.00),
(9, 9, 6, 'Beard Wax', 1, 6400.00),
(10, 10, 9, 'Beard Oil', 1, 8000.00),
(11, 11, 1, 'Hair Shampoo', 1, 16000.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `stock_status` enum('in_stock','out_of_stock') DEFAULT 'in_stock',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `category`, `price`, `image_url`, `stock_status`, `created_at`, `updated_at`) VALUES
(1, 'Hair Shampoo', 'A nourishing shampoo for all hair types.', 'Hair Care', 4300.00, 'images/shop/1.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:15:49'),
(2, 'Beard Trimmer', 'Precision beard trimmer for all styles.', 'Beard Care', 8500.00, 'images/shop/2.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:16:02'),
(3, 'Shaving Cream', 'Rich shaving cream for a smooth, comfortable shave.', 'Beard Care', 2500.00, 'images/shop/3.png', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 18:53:00'),
(4, 'Face Wash', 'Deep-cleansing face wash for daily use.', 'Skincare', 3500.00, 'images/shop/4.png', 'out_of_stock', '2026-05-19 10:36:34', '2026-07-14 18:35:50'),
(5, 'Hair Spray', 'Volumizing hair spray with extra hold.', 'Hair Care', 3400.00, 'images/shop/5.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:16:17'),
(6, 'Beard Wax', 'Beard wax to style and shape facial hair.', 'Beard Care', 5500.00, 'images/shop/6.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:16:32'),
(7, 'Hair Serum', 'Shine-enhancing serum for smooth hair.', 'Hair Care', 8500.00, 'images/shop/7.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:16:43'),
(8, 'Hair Mask', 'Deep conditioning hair mask for damaged hair.', 'Hair Care', 9000.00, 'images/shop/8.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:17:04'),
(9, 'Beard Oil', 'Nourishing beard oil to soften and condition.', 'Beard Care', 5500.00, 'images/shop/9.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:17:16'),
(10, 'Hair Shining Oil', 'Adds shine and smoothness to hair.', 'Hair Care', 7800.00, 'images/shop/10.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:17:29'),
(11, 'Electric Shaver', 'High-performance electric shaver for clean cuts.', 'Beard Tools', 14500.00, 'images/shop/11.jpg', 'out_of_stock', '2026-05-19 10:36:34', '2026-07-14 19:17:49'),
(12, 'Face Scrub', 'Exfoliating scrub that removes dead skin cells.', 'Skincare', 2200.00, 'images/shop/12.png', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:03:38'),
(13, 'Beard Comb', 'Wooden comb designed specifically for beards.', 'Beard Tools', 2200.00, 'images/shop/13.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:18:01'),
(14, 'Hair Clippers', 'Professional hair clippers for salon-quality cuts.', 'Hair Tools', 12500.00, 'images/shop/14.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:18:14'),
(15, 'Hair Gel', 'Strong hold hair gel for all-day control.', 'Hair Care', 4500.00, 'images/shop/15.jpg', 'in_stock', '2026-05-19 10:36:34', '2026-07-14 19:18:23');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `member_price` decimal(10,2) NOT NULL,
  `duration` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `name`, `category`, `description`, `price`, `member_price`, `duration`, `created_at`, `updated_at`) VALUES
(1, 'Classic Haircut', 'Haircuts', 'Traditional haircut with clean finishing.', 2500.00, 2300.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:24:46'),
(2, 'Skin Fade', 'Haircuts', 'Modern skin fade with precision blending.', 3000.00, 2800.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:25:43'),
(3, 'Taper Fade', 'Haircuts', 'Stylish taper fade for a sharp appearance.', 2800.00, 2600.00, 35, '2026-05-19 10:36:33', '2026-07-12 18:26:24'),
(4, 'Crew Cut', 'Haircuts', 'Short and clean military-inspired haircut.', 2200.00, 2000.00, 25, '2026-05-19 10:36:33', '2026-07-12 18:27:02'),
(5, 'Buzz Cut', 'Haircuts', 'Low-maintenance clipper haircut.', 1800.00, 1600.00, 20, '2026-05-19 10:36:33', '2026-07-12 18:27:56'),
(6, 'Pompadour Cut', 'Haircuts', 'Classic pompadour with volume and style.', 3200.00, 3000.00, 45, '2026-05-19 10:36:33', '2026-07-12 18:28:39'),
(7, 'Textured Crop', 'Haircuts', 'Trendy textured haircut with natural finish.', 3000.00, 2800.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:29:23'),
(8, 'Undercut Style', 'Haircuts', 'Modern undercut with customized styling.', 3200.00, 3000.00, 45, '2026-05-19 10:36:33', '2026-07-12 18:30:21'),
(9, 'Long Hair Trim', 'Haircuts', 'Trim and reshape long hairstyles.', 2200.00, 2000.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:31:12'),
(10, 'Kids Haircut', 'Haircuts', 'Comfortable haircut for children.', 1800.00, 1600.00, 25, '2026-05-19 10:36:33', '2026-07-12 18:31:51'),
(11, 'Beard Trim', 'Beard Grooming', 'Precision beard trimming and shaping.', 1200.00, 1000.00, 20, '2026-05-19 10:36:33', '2026-07-12 18:32:33'),
(12, 'Beard Styling', 'Beard Grooming', 'Professional beard styling and detailing.', 1800.00, 1600.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:33:22'),
(13, 'Royal Beard Grooming', 'Beard Grooming', 'Complete beard care with premium finish.', 2500.00, 2300.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:34:10'),
(14, 'Hot Towel Shave', 'Beard Grooming', 'Traditional hot towel shave experience.', 2200.00, 2000.00, 35, '2026-05-19 10:36:33', '2026-07-12 18:35:03'),
(15, 'Razor Line-Up', 'Beard Grooming', 'Sharp beard and hairline detailing.', 1000.00, 900.00, 15, '2026-05-19 10:36:33', '2026-07-12 18:35:42'),
(16, 'Moustache Styling', 'Beard Grooming', 'Trim and shape your moustache.', 800.00, 700.00, 15, '2026-05-19 10:36:33', '2026-07-12 18:36:19'),
(17, 'Hair Wash', 'Hair Care', 'Deep cleansing with premium shampoo.', 800.00, 700.00, 15, '2026-05-19 10:36:33', '2026-07-12 18:37:10'),
(18, 'Hair Spa', 'Hair Care', 'Nourishing treatment for healthy hair.', 3200.00, 3000.00, 45, '2026-05-19 10:36:33', '2026-07-12 18:38:00'),
(19, 'Deep Conditioning', 'Hair Care', 'Moisturizing treatment for dry hair.', 2500.00, 2300.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:38:47'),
(20, 'Anti-Dandruff Treatment', 'Hair Care', 'Professional scalp treatment.', 3000.00, 2800.00, 45, '2026-05-19 10:36:33', '2026-07-12 18:39:29'),
(21, 'Hair Smoothening', 'Hair Care', 'Smooth and manageable hair treatment.', 7000.00, 6600.00, 60, '2026-05-19 10:36:33', '2026-07-12 18:40:21'),
(22, 'Keratin Treatment', 'Hair Care', 'Keratin therapy for frizz-free hair.', 12000.00, 11500.00, 120, '2026-05-19 10:36:33', '2026-07-12 18:41:08'),
(23, 'Hair Coloring', 'Hair Color', 'Full hair coloring with premium products.', 5000.00, 4700.00, 90, '2026-05-19 10:36:33', '2026-07-12 18:41:59'),
(24, 'Grey Coverage', 'Hair Color', 'Natural grey hair coverage.', 4000.00, 3800.00, 60, '2026-05-19 10:36:33', '2026-07-12 18:42:49'),
(25, 'Beard Coloring', 'Hair Color', 'Color enhancement for beard.', 2200.00, 2000.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:43:24'),
(26, 'Highlights', 'Hair Color', 'Stylish hair highlights.', 6500.00, 6200.00, 120, '2026-05-19 10:36:33', '2026-07-12 18:44:05'),
(27, 'Face Cleanup', 'Facial', 'Refreshing facial cleanup for men.', 2500.00, 2300.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:44:41'),
(28, 'Men\'s Facial', 'Facial', 'Deep cleansing facial treatment.', 4500.00, 4200.00, 60, '2026-05-19 10:36:33', '2026-07-12 18:45:28'),
(29, 'Gold Facial', 'Facial', 'Luxury gold facial for glowing skin.', 6000.00, 5700.00, 75, '2026-05-19 10:36:33', '2026-07-12 18:45:57'),
(30, 'Charcoal Facial', 'Facial', 'Detoxifying charcoal facial.', 5000.00, 4700.00, 60, '2026-05-19 10:36:33', '2026-07-12 18:46:33'),
(31, 'Head Massage', 'Massage', 'Relaxing oil head massage.', 1800.00, 1600.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:47:22'),
(32, 'Shoulder Massage', 'Massage', 'Stress-relieving shoulder massage.', 2200.00, 2000.00, 30, '2026-05-19 10:36:33', '2026-07-12 18:47:51'),
(33, 'Foot Massage', 'Massage', 'Refreshing foot relaxation therapy.', 2500.00, 2300.00, 40, '2026-05-19 10:36:33', '2026-07-12 18:48:30'),
(34, 'Premium Grooming Package', 'Packages', 'Haircut, beard, wash, and styling.', 6000.00, 5700.00, 90, '2026-05-19 10:36:33', '2026-07-12 18:51:04'),
(35, 'Executive Grooming Package', 'Packages', 'Haircut, hair wash, relaxing head massage and hair styling', 9000.00, 8500.00, 150, '2026-05-19 10:36:33', '2026-07-12 18:54:09'),
(36, 'Royal Gentleman Package', 'Packages', 'Haircut, shave, facial, massage, and styling.', 10000.00, 9500.00, 150, '2026-05-19 10:36:33', '2026-07-12 18:55:10');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `role` enum('user','admin','staff') DEFAULT 'user',
  `specialization` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `telephone`, `fax`, `address`, `city`, `country`, `postal_code`, `role`, `specialization`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'User1', 'admin1@sufiyan.dev', '$2y$10$Ku1hfGFdKQ.k8soLQVhvduFjzvvaX7gWZW7akVXEukCnOv.TLgMP6', '032021127', NULL, NULL, NULL, NULL, NULL, 'admin', NULL, '2026-05-19 10:36:33', '2026-06-06 08:28:55'),
(12, 'Azan', 'Khan', 'roghani@gmail.com', '$2y$10$GdnwtpDCkQZnzhlRU59Odelp6Y9UeOR2WtVclnyloDqpFP7oPMxM6', '039656987', NULL, NULL, NULL, NULL, NULL, 'staff', NULL, '2026-06-04 11:43:32', '2026-06-04 11:44:34'),
(13, 'Taha', 'Junaid', 'taha@gmail.com', '$2y$10$eE71jZ2u/tEuKSig3RoSk.XD.uhnEz4X1CjGbdsms9DdjO9zaCnhi', '036985214', NULL, NULL, NULL, NULL, NULL, 'staff', NULL, '2026-06-04 11:45:46', '2026-07-15 08:56:48'),
(14, 'Muneeb', 'Fahad', 'muneeb@gmail.com', '$2y$10$QqFce/aYC2U993ituMRVeu5BFekK7jFvTjaBK2BzymkdodofywLr2', '032587415', NULL, NULL, NULL, NULL, NULL, 'staff', NULL, '2026-06-04 11:46:32', '2026-07-15 08:55:57'),
(15, 'Arham', 'Khan', 'arham@gmail.com', '$2y$10$5DOmXZOaJMfD74nGm3FV/ONiKTe1CqAw6CNgG5oyEHe691dlovPjy', '035896315', NULL, 'FB Area', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-06-04 11:47:15', '2026-06-06 08:56:16'),
(16, 'Hamdan', 'Sufyan', 'hamdan@gmail.com', '$2y$10$QJ1C8KJ5qD8tQb8gLaMkDuOALA.sBZwY3cqL/hHHp2EcZfPQhuulq', '035896314', NULL, 'sharfabad', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-06-04 11:47:52', '2026-06-06 08:52:18'),
(17, 'Shariq', 'Shahzad', 'shariq@gmail.com', '$2y$10$l4VItGJecURsKLMDn87M0ew/baBO0s5hdkVQuabm48KGDxWluwNse', '036987412', '', 'Tariq road', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-06-04 11:48:39', '2026-07-15 09:07:53'),
(18, 'Hassan', 'Ali', 'hassan@gmail.com', '$2y$10$HnAyGzmQ8bDebFXLd0JYh.TGrCMnNrrJpXiJaXfXGWNM2Ad9aIutS', '032145698', NULL, 'gulshan', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-06-04 11:50:08', '2026-06-05 08:08:08'),
(19, 'Ahmed', 'Khan', 'ahmed@gmail.com', '$2y$10$3dgBUf1Sueaao3OiXFst/.nuU9eNSVKCv9UVHTXCbMQAHtmqii6me', '032654198', NULL, 'Bahadurabad', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-06-04 11:51:05', '2026-07-12 19:39:37'),
(20, 'Bilal', 'Waris', 'admin2@gmail.com', '$2y$10$OCfA3QmASY67C06DWYPFL.2qedeDnSQLUgvnZ3zh91ADSUXWE6BU.', '03012342324', '', NULL, NULL, NULL, NULL, 'admin', NULL, '2026-07-08 19:05:23', '2026-07-08 19:07:15'),
(21, 'Ali', 'Imran', 'ali@gmail.com', '$2y$10$Xf2kaMWUhOtDYeAyGXAq8uzPLVhtYK3AUIHQrsO387jmHBxp57wXS', '03012468920', NULL, 'Nazimabad', 'Karachi', 'Pakistan', '123456', 'user', NULL, '2026-07-13 18:19:00', '2026-07-15 08:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_otp`
--

CREATE TABLE `user_otp` (
  `user_otp_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `otp_code` int(11) NOT NULL,
  `otp_expiry` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_otp`
--

INSERT INTO `user_otp` (`user_otp_id`, `first_name`, `last_name`, `email`, `password`, `telephone`, `otp_code`, `otp_expiry`, `created_at`) VALUES
(1, 'Sufyan', 'Shahid', 'sufyan@gmail.com', '$2y$10$xKp94I5Mwomg52O2Fud.0uTHcvEYVpXKCR.CtSk8kR/M7byNdUO3C', '123456', 738853, '2026-05-23 12:43:49', '2026-05-23 10:33:49'),
(2, 'Sufyan', 'Shahid', 'abc@gmail.com', '$2y$10$p/8UGxRJZF0yqYKsx6fFqew98PYQlk2iHLIYS9HhSjVHHZm.FKxea', '123456', 855136, '2026-05-23 13:26:53', '2026-05-23 11:16:53'),
(3, 'Sufyan', 'Shahid', '123@gmail.com', '$2y$10$BSiuw/F44b/6DgkV3cHAfOhwGbEnU63ewT1xKcdPkRJM6EV2qoGmK', '123456', 353506, '2026-05-23 13:40:58', '2026-05-23 11:18:30');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`wishlist_id`, `user_id`, `product_id`, `date_added`) VALUES
(1, 17, 2, '2026-06-06 08:42:17'),
(2, 19, 3, '2026-06-06 08:47:24'),
(3, 16, 5, '2026-06-06 08:53:32'),
(4, 15, 11, '2026-06-06 08:56:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_otp`
--
ALTER TABLE `user_otp`
  ADD PRIMARY KEY (`user_otp_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_otp`
--
ALTER TABLE `user_otp`
  MODIFY `user_otp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
