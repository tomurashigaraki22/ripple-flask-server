-- RippleBids Database Dump
-- Generated: 2025-10-07 19:28:33.023084

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Table structure for StorefrontSettings
DROP TABLE IF EXISTS `StorefrontSettings`;
CREATE TABLE `StorefrontSettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `new_orders` tinyint(1) DEFAULT '1',
  `order_updates` tinyint(1) DEFAULT '1',
  `payment_received` tinyint(1) DEFAULT '1',
  `low_stock` tinyint(1) DEFAULT '1',
  `promotions` tinyint(1) DEFAULT '0',
  `newsletter` tinyint(1) DEFAULT '0',
  `login_alerts` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_settings` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for StorefrontSettings

-- Table structure for admin_settings
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings` (
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for admin_settings
INSERT INTO `admin_settings` (`key`, `value`, `created_at`, `updated_at`) VALUES
('system_settings', '{"general":{"siteName":"RippleBids","siteDescription":"A Decentralized Marketplace","maintenanceMode":false,"registrationEnabled":true},"security":{"twoFactorRequired":false,"sessionTimeout":24,"maxLoginAttempts":5,"passwordMinLength":8},"notifications":{"emailNotifications":true,"smsNotifications":false,"pushNotifications":true,"adminAlerts":true},"blockchain":{"xrpNetwork":"mainnet","evmNetwork":"ethereum","solanaNetwork":"mainnet-beta","gasLimits":{"xrp":1000000,"evm":21000,"solana":200000}}}', '2025-08-15 03:48:53', '2025-08-15 03:48:53');


-- Table structure for ai_estimations
DROP TABLE IF EXISTS `ai_estimations`;
CREATE TABLE `ai_estimations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` text COLLATE utf8mb4_general_ci,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `dimensions` json DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for ai_estimations
INSERT INTO `ai_estimations` (`id`, `image_url`, `title`, `description`, `dimensions`, `weight`, `created_at`) VALUES
(1, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:41:45'),
(2, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:43:09'),
(3, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:44:53'),
(4, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:45:59'),
(5, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:52:07'),
(6, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 8.0, "height": 4.0, "length": 10.0}', 6.18, '2025-09-26 17:58:03'),
(7, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758905171/ripple-marketplace/listings/listing_1758905150_eocd8i.jpg', 'Airtel 5g Router', 'The Airtel 5g Router is a versatile Physical item that meets all your needs. Crafted with premium materials for lasting durability.', '{"width": 3.5, "height": 8.5, "length": 3.5}', 2.0, '2025-09-26 18:01:00'),
(8, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758915339/ripple-marketplace/listings/listing_1758915330_bqjq3s.jpg', 'Airtel 5G Router', 'Unleash the power of true 5G at home with the Airtel 5G Router! Experience lightning-fast speeds and ultra-low latency for seamless streaming, gaming, and remote work. Connect all your devices effortlessly – from smart TVs to laptops – and enjoy stable, reliable internet across every corner. Easy to set up, this router transforms your digital life. Upgrade to Airtel 5G and future-proof your connected home today!', '{"width": 3.7, "height": 8.5, "length": 3.7}', 2.0, '2025-09-26 19:35:58'),
(9, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758916739/ripple-marketplace/listings/listing_1758916737_6qi7zq.jpg', 'Airtel 5g Router (Used)', 'Unlock next-gen speed with this reliable, used Airtel 5G Router! Experience lightning-fast internet for all your streaming, gaming, and work needs. Connect multiple devices effortlessly via robust Wi-Fi.

This pre-loved router offers an incredibly affordable way to bring powerful 5G connectivity into your home or office. Fully tested and ready to deploy. Grab premium performance for a fraction of the cost – upgrade your internet today!', '{"width": 3.5, "height": 8.5, "length": 3.0}', 1.8, '2025-09-26 20:00:32'),
(10, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758917496/ripple-marketplace/listings/listing_1758917460_fuzsxmj.jpg', 'T-Shirt', '**Your new go-to T-shirt has arrived!** Experience ultimate comfort and effortless style with this premium tee. Crafted from ultra-soft, breathable cotton, it feels incredible against your skin, perfect for all-day wear. Its classic, flattering fit makes it versatile for any look – layer it or wear it solo. Durable and designed to hold its shape, this T-shirt is built to last, maintaining its quality wash after wash. Upgrade your essentials with comfort that never quits.', '{"width": 21.0, "height": 0.8, "length": 29.0}', 0.45, '2025-09-26 20:14:39'),
(11, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759325821/ripple-marketplace/listings/listing_1759325817_avfna.jpg', 'Ferrari ', 'Own a legend. This exquisite physical Ferrari product captures the exhilarating spirit and unparalleled design of the world''s most iconic marque. Meticulously crafted with stunning precision, it''s more than an item – it''s a tribute to speed, luxury, and engineering mastery. Perfect for display, this piece ignites passion and adds a touch of automotive greatness to any space. A timeless collectible for the true enthusiast.', '{"width": 77.9, "height": 47.5, "length": 181.5}', 3164.0, '2025-10-01 13:37:22'),
(12, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759325821/ripple-marketplace/listings/listing_1759325817_avfna.jpg', 'Ferrari ', 'Own a legend. This exquisite physical Ferrari product captures the exhilarating spirit and unparalleled design of the world''s most iconic marque. Meticulously crafted with stunning precision, it''s more than an item – it''s a tribute to speed, luxury, and engineering mastery. Perfect for display, this piece ignites passion and adds a touch of automotive greatness to any space. A timeless collectible for the true enthusiast.', '{"width": 197.9, "height": 120.6, "length": 461.1}', 1435.0, '2025-10-01 13:54:29'),
(13, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759339886/ripple-marketplace/listings/listing_1759340037_3idql8.jpg', 'test 1', 'Unveil ''test 1,'' a truly captivating original artwork. This unique piece features a minimalist human form brought to life with vibrant, overlapping strokes of red, blue, and yellow. The stunning multi-hued outline creates a mesmerizing chromatic effect, giving it a modern, dynamic feel. Perfect for adding an artistic statement and a burst of color to any room. Make it yours and let this intriguing drawing spark conversation.', '{"width": 61.0, "height": 1.5, "length": 76.2}', 1.5, '2025-10-01 17:36:43'),
(14, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759344325/ripple-marketplace/listings/listing_1759344475_z9x3q.jpg', 'test 2 ', 'Unveiling the **''test 2''** smartphone – designed for your dynamic life! Immerse yourself in a stunning, vibrant display featuring a modern punch-hole camera and slim bezels. Experience vivid visuals and intuitive access to your camera and voice assistant directly from the lock screen. Its sleek design and robust battery (66% shown!) keep you connected on the go. Ready for your SIM, ''test 2'' delivers essential performance in a stylish package. Upgrade your everyday tech!', '{"width": 7.5, "height": 0.9, "length": 16.0}', 0.19, '2025-10-01 18:46:23'),
(15, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759349268/ripple-marketplace/listings/listing_1759349418_ibu32.jpg', '', '', '{"width": 7.6, "height": 1.2, "length": 16.5}', 0.28, '2025-10-01 20:08:35'),
(16, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759393412/ripple-marketplace/listings/listing_1759393562_yehniq.jpg', 'Test 2', 'Unleash potential with the **Test 2** smartphone. Boasting a vibrant, immersive display, this device transforms your digital experience with stunning visuals and clear detail. Its modern design features a sleek profile and a discreet punch-hole camera, making it both stylish and functional.

Navigate effortlessly with quick access to your camera and voice assistant from the lock screen. Powered for your day, the Test 2 offers reliable performance and impressive battery life. Stay connected, capture memories, and enjoy intuitive technology designed for you. Discover your new essential device!', '{"width": 7.6, "height": 0.8, "length": 16.3}', 0.185, '2025-10-02 08:33:04'),
(17, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759417398/ripple-marketplace/listings/listing_1759417549_fxnj2.jpg', 'test 2 phone', 'Unveil the **test 2** smartphone! Experience an immersive, vibrant display that brings your content to life with stunning clarity. Its modern punch-hole design integrates a front camera, ensuring sleek aesthetics.

With intuitive lock screen access to your camera and a robust 66% battery visible, you''re always ready to capture moments and stay powered. Housed in a durable case, this device is engineered for both style and resilience. Elevate your everyday connection!', '{"width": 8.0, "height": 1.1, "length": 17.0}', 0.25, '2025-10-02 16:30:58'),
(18, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759437851/ripple-marketplace/listings/listing_1759437828_xylegp.jpg', 'test 2', '**Product: test 2**

Secure your smartphone with the sophisticated ''test 2'' flip wallet case. Crafted from durable, dark material, this case offers ultimate protection and style.

**Key Features:**
*   **Full Coverage:** Safeguards your screen and device body from daily bumps and scratches.
*   **Built-in Wallet:** Convenient interior slots keep your essential cards or cash organized.
*   **Sleek Design:** Its classic dark finish perfectly complements your phone, including any vibrant accents like its visible blue trim.

Keep your essentials close and your phone protected in one elegant solution!', '{"width": 8.5, "height": 1.8, "length": 17.5}', 0.25, '2025-10-02 20:46:07'),
(19, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759440934/ripple-marketplace/listings/listing_1759441085_btnre.jpg', 'test 1 art drawing', 'Unveil the unique charm of ''test 1 art drawing.'' This original hand-drawn artwork captivates with its dynamic, multi-colored lines that beautifully define an enigmatic figure. Each vibrant stroke creates a subtle chromatic effect, bringing depth and emotion to a minimalist silhouette. An engaging piece that adds a modern, artistic flair and stimulating focal point to any contemporary space. Perfect for art lovers seeking distinct expression.', '{"width": 40.0, "height": 0.5, "length": 50.0}', 0.25, '2025-10-02 21:37:34'),
(20, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759441238/ripple-marketplace/listings/listing_1759441389_2c6v84.webp', 'test 3', '', '{"width": 50.0, "height": 2.0, "length": 42.0}', 0.25, '2025-10-02 21:41:14'),
(21, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759441238/ripple-marketplace/listings/listing_1759441389_2c6v84.webp', 'test 3', '', '{"width": 52.0, "height": 3.5, "length": 42.0}', 0.2, '2025-10-02 21:42:17'),
(22, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759441474/ripple-marketplace/listings/listing_1759441625_zew76d.jpg', 'test 4 accessories SUI', 'Never run out of power with the **Blue Star Wall Charger**! This all-in-one solution features a convenient, integrated Micro USB cable, perfect for your Android smartphone, tablet, and other compatible devices.

Its sleek black design is compact and travel-friendly, making it your ideal companion. With a durable European 2-pin plug, you get reliable charging wherever you go. Stay connected and powered up effortlessly with this essential accessory.', '{"width": 4.0, "height": 2.8, "length": 5.8}', 0.1, '2025-10-02 21:45:49'),
(23, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759441637/ripple-marketplace/listings/listing_1759441789_6jm68j.webp', 'test 5 jewelry ETH', 'Embrace timeless elegance with this exquisite polished band. Crafted from gleaming, high-quality metal, its sleek, minimalist design offers versatile sophistication. Perfect as a wedding band, a promise ring, or a refined everyday accessory. Experience enduring comfort and radiant style that complements any look. A true testament to classic beauty. Make a subtle, powerful statement.', '{"width": 2.2, "height": 0.5, "length": 2.2}', 0.009, '2025-10-02 21:48:38'),
(24, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759441884/ripple-marketplace/listings/listing_1759442036_npr7b.jpg', 'TEST 6 BOOK BITCOIN', 'Unearth unparalleled intrigue with ''TEST 6 BOOK BITCOIN''. This remarkably preserved ancient tome, with its weathered cover and crumbling pages, exudes centuries of untold stories. Its authentic antique charm makes it an exquisite decorative accent or a compelling prop. Yet, its peculiar title begs the question: what hidden wisdom connects this relic to the world of Bitcoin? A truly unique find, it''s a profound conversation starter that masterfully blends historical mystery with modern digital fascination. Perfect for discerning collectors and history enthusiasts!', '{"width": 19.0, "height": 6.5, "length": 28.0}', 2.5, '2025-10-02 21:52:31'),
(25, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759499767/ripple-marketplace/listings/listing_1759499762_hy6hxh.jpg', 'Test phone', 'Introducing the ''Test Phone'' – engineered for unwavering performance and everyday reliability. Forget the fuss; this device delivers essential features with precision. Enjoy crystal-clear calls, seamless messaging, and a battery that powers your day. Built with robust materials and rigorously tested for durability, it’s designed to simply work, every time. Experience straightforward, dependable technology. Grab your ultimate reliable companion now!', '{"width": 7.5, "height": 0.8, "length": 16.0}', 0.19, '2025-10-03 13:57:04'),
(26, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759860220/ripple-marketplace/listings/listing_1759860217_vp8ild.jpg', 'Test Device - Infinix', 'Unlock precision with the ''Test Device - Infinix''.

This essential physical device offers a dedicated, authentic Infinix environment, purpose-built for rigorous app and software testing. Developers and QA professionals will appreciate its reliable performance and native accuracy, ensuring your innovations run flawlessly. Elevate your development workflow and perfect your projects. Test smarter, achieve more.', '{"width": 7.7, "height": 0.8, "length": 16.5}', 0.2, '2025-10-07 18:04:29');


-- Table structure for auction_payments
DROP TABLE IF EXISTS `auction_payments`;
CREATE TABLE `auction_payments` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `auction_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `winning_bid_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `winner_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `seller_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `transaction_hash` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_deadline` timestamp NOT NULL,
  `status` enum('pending','paid','failed','expired') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `auction_id` (`auction_id`),
  KEY `winning_bid_id` (`winning_bid_id`),
  KEY `winner_id` (`winner_id`),
  KEY `seller_id` (`seller_id`),
  KEY `idx_status` (`status`),
  KEY `idx_deadline` (`payment_deadline`),
  CONSTRAINT `auction_payments_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `listings` (`id`),
  CONSTRAINT `auction_payments_ibfk_2` FOREIGN KEY (`winning_bid_id`) REFERENCES `bids` (`id`),
  CONSTRAINT `auction_payments_ibfk_3` FOREIGN KEY (`winner_id`) REFERENCES `users` (`id`),
  CONSTRAINT `auction_payments_ibfk_4` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for auction_payments

-- Table structure for audit_trail
DROP TABLE IF EXISTS `audit_trail`;
CREATE TABLE `audit_trail` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `admin_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `target_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` json DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_action` (`action`),
  KEY `idx_target_type` (`target_type`),
  KEY `idx_target_id` (`target_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `audit_trail_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for audit_trail
INSERT INTO `audit_trail` (`id`, `admin_id`, `action`, `target_type`, `target_id`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
('000ac252-379e-4591-91e6-d9f74d82cc1b', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '75c36d48-1328-4a50-9ed5-77730e9cc567', '{"email": "teddy.tadios777@gmail.com", "months": 1, "tierName": "pro", "username": "Tedyobski777", "emailSent": true, "expiresAt": "2025-10-13T18:53:18.990Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:53:20'),
('052c8ba7-5c95-4bf0-a68a-d00b9468782e', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '33dbeac7-6996-49f8-a2dc-b974e7399d8e', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Guerlain La Petite Robe Noir Eau De Parfum 100ML"}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:53:46'),
('0692d32f-65e6-48fb-bc80-9bb47d0068ab', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', '{"email": "namangwl2005@gmail.com", "months": 1, "tierName": "pro", "username": "Neo", "emailSent": true, "expiresAt": "2025-09-15T23:48:52.797Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:53'),
('06fed1fe-cd1e-4a9a-93a9-1a7a023d8cce', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_viewed', 'listing', '12ac6960-996d-4d77-9c07-1dce871df20f', '{"seller": "devtomiwa9", "listingTitle": "Tesst2 Auction"}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:50:29'),
('0a137dc2-85f8-4f8d-b892-a989932805d4', '8966824e-28e4-4829-afb6-663ac276b7ad', 'user_membership_granted', 'user', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '{"email": "blockcred.ng@gmail.com", "months": 12, "tierName": "pro", "username": "devt990", "emailSent": true, "expiresAt": "2026-09-09T01:00:22.436Z", "isFirstTimeMember": false}', '51.158.74.104', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-09 01:00:25'),
('0bebe7a1-42ac-4871-a914-9750f8e5038e', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', '553ffb0a-408a-44d9-8e17-2a06582323aa', '{"action": "approve", "seller": "devtomiwa9", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Auction Nw test"}', '173.90.107.136', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-08-27 23:42:30'),
('100f31b7-76d0-4531-bddc-23775e639cb7', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'a5a64899-d629-4242-88df-b645677374ed', '{"email": "chuckiectg1987@gmail.com", "months": 1, "tierName": "pro", "username": "Chuckdeez", "emailSent": true, "expiresAt": "2025-10-13T18:53:00.322Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:53:01'),
('1346e0bc-d053-4e73-af7f-220901601657', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', '139365cc-a9d4-4979-a3ec-a3637696af74', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Escentric 04 Escentric Molecules"}', '173.90.107.136', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-10 00:31:09'),
('1612775e-c776-4c44-b4e1-f041d4735710', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'f8bacc1b-39ef-462c-b55c-e962c603e9fb', '{"email": "silvertreeprod@gmail.com", "months": 1, "tierName": "pro", "username": "ToysnMore", "emailSent": true, "expiresAt": "2025-09-15T23:48:42.035Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:42'),
('1fa6b652-352d-496d-8262-546d98957c3e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'update_settings', 'site', 'settings_maintenance', '{"maintenance_enabled": true}', 'marketplace.ripplebids.com', NULL, '2025-10-03 08:06:44'),
('224b3090-e9c2-4572-9404-3ba375135c7e', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '8f82551a-1ff6-4d36-8492-216652260d6e', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Polo-black"}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-23 22:19:10'),
('29ee7472-8a1d-4768-a578-7993bb6c8727', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '1d9db35c-e67d-4915-bf02-54d9e9bc7736', '{"email": "remivictor20@gmail.com", "months": 1, "tierName": "pro", "username": "Big Remy", "emailSent": true, "expiresAt": "2025-10-13T18:41:21.082Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:41:22'),
('2da3bb26-f4c6-4250-8b2c-67c8376f7106', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '4fe6ce1d-2f4c-4ed2-aea0-4180efec058e', '{"email": "ddcabella@gmail.com", "months": 1, "tierName": "pro", "username": "ddcabella", "emailSent": true, "expiresAt": "2025-09-18T11:50:30.443Z", "isFirstTimeMember": true}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:50:31'),
('2e0a518e-9252-484d-8f3c-0926320a9101', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'f0841792-c385-4c41-a5e9-cf1210d853e6', '{"email": "dufganshopping@gmail.com", "months": 1, "tierName": "pro", "username": "Dufgan", "emailSent": true, "expiresAt": "2025-09-15T23:46:38.705Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:39'),
('32178b23-e26a-4715-8dc7-c9c1d87126c9', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'cc8c5195-9583-4a2e-b707-1fc8c0f86d71', '{"email": "Liquidassetsboca@gmail.com", "months": 1, "tierName": "pro", "username": "Liquidassetsboca", "emailSent": true, "expiresAt": "2025-09-16T22:39:38.637Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-16 22:39:39'),
('35f616ac-3585-4abb-adc3-9c7462934364', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_viewed', 'listing', '78a90e4a-b4bd-47ab-885f-abda97b7a3c0', '{"seller": "JT132724", "listingTitle": "LBJ 13 Shoes"}', '172.59.24.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-29 02:24:04'),
('3953b3f6-a71c-4b1c-bd20-c3c2291b8e1f', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'd1382ea4-9a6f-4fdb-bb88-67e146160cf8', '{"email": "shaptefratia@gmail.com", "months": 1, "tierName": "pro", "username": "Alex", "emailSent": true, "expiresAt": "2025-10-13T18:41:32.718Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:41:33'),
('3d5c7234-8392-4a89-bdca-feece82eb078', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'f8e9cf0c-4ef0-4060-b2b2-a61d4e2db1bc', '{"email": "folsomhodl@gmail.com", "months": 1, "tierName": "pro", "username": "Woodenarch", "emailSent": true, "expiresAt": "2025-09-18T11:50:23.463Z", "isFirstTimeMember": true}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:50:24'),
('3e350b8c-7c52-467d-92e7-76485176aabb', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '05a3018b-498d-464f-a31c-0857c55a6a89', '{"email": "Nalatransit@gmail.com", "months": 1, "tierName": "pro", "username": "Sun33", "emailSent": true, "expiresAt": "2025-09-15T23:45:46.168Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:45:48'),
('3f7afac2-f06b-4f8b-98fc-ac85b14cf2c0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'update_settings', 'site', 'settings_maintenance', '{"maintenance_enabled": false}', 'marketplace.ripplebids.com', NULL, '2025-10-03 08:25:26'),
('424f91d0-d354-406b-aa17-81ec56084860', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '4bad0d5e-92d4-43e2-919a-5d4b8e9eae1a', '{"email": "silverandgold4me2@gmail.com", "months": 1, "tierName": "pro", "username": "SilverGoldGpa", "emailSent": true, "expiresAt": "2025-09-15T23:46:46.845Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:47'),
('42f32350-e07d-4afe-a06f-c580da55c0d7', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', 'a9b1ee60-001d-49ee-96dc-21f03778ec67', '{"action": "approve", "seller": "pinzut17", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "opmiou"}', '173.90.107.136', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-10 00:31:25'),
('450ae08d-e3ee-4c64-b036-16913ed3acd9', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', 'eae96f0a-8f9b-430b-a2e3-133ed050e9f6', '{"action": "approve", "seller": "Neo", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Coral Vase "}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:49:49'),
('46acfe6c-761c-4de2-85ea-3efa8107b61d', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '085a0a9c-a10d-4d0b-86df-74403d3b3690', '{"email": "reelrarities1@gmail.com", "months": 1, "tierName": "pro", "username": "reelrarities", "emailSent": true, "expiresAt": "2025-09-15T23:49:04.875Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:49:05'),
('4db53647-c18a-4ebf-9f57-be57199555b5', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '14e63306-0162-4ff9-98df-77ade30b5f88', '{"email": "erotokritosmichaelides@gmail.com", "months": 1, "tierName": "pro", "username": "ErosCya", "emailSent": true, "expiresAt": "2025-09-15T23:48:13.689Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:14'),
('4ebe9e3f-543a-4fac-a36a-4fb356f3972a', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', '5819684f-f618-4d5b-9b9f-9d0aa2aaa884', '{"action": "approve", "seller": "SKYLON ", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "HUF & DEE Women''s Box Neck T-Shirt Avocado Green"}', '107.123.49.83', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-08-17 13:02:32'),
('52560d44-67b7-4444-8bb4-46326173105b', '8966824e-28e4-4829-afb6-663ac276b7ad', 'update_settings', 'site', 'settings_maintenance', '{"maintenance_enabled": false}', '172.20.10.2', NULL, '2025-08-24 19:25:02'),
('547608c8-b19a-4b3a-85cd-ed60c1ef1994', '8eea3a76-97df-438f-9685-f978cadacc77', 'user_membership_granted', 'user', '9e84ae99-d7d0-4ced-ae75-4753175e494d', '{"email": "corvetsr@aol.com", "months": 1, "tierName": "pro", "username": "ENPOWERSPORTS ", "emailSent": true, "expiresAt": "2025-09-21T22:04:09.074Z", "isFirstTimeMember": true}', '172.59.24.211', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-21 22:04:10'),
('57984fea-2a4f-4782-9aed-d988a6d5281e', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'c1812920-c6e7-4d4b-a8be-4fb4df09a2eb', '{"email": "trekoutdoorco@gmail.com", "months": 1, "tierName": "pro", "username": "Trek Outdoor Co", "emailSent": true, "expiresAt": "2025-09-27T12:02:14.579Z", "isFirstTimeMember": true}', '172.59.25.67', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-27 12:02:15'),
('5dcf7530-4ded-4e5c-b918-6ee6568b3190', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '8b9b36f6-4be0-477a-89e9-e47e9e77d7a4', '{"email": "alghaithaljamel@gmail.com", "months": 1, "tierName": "pro", "username": "alghaithaljamel", "emailSent": true, "expiresAt": "2025-10-13T18:52:48.859Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:52:49'),
('637d1217-9608-40e5-9db8-e3faae2af039', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'a7ef51c5-58d4-40bc-b90c-936c5d5738af', '{"email": "tegaakpoyibo14@gmail.com", "months": 1, "tierName": "pro", "username": "Managewithtega", "emailSent": true, "expiresAt": "2025-09-28T01:10:06.772Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-28 01:10:07'),
('65c68f2a-5823-4577-b530-a6ea18b1c796', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '6bc1bc70-9797-40b6-83a8-f4f54c434c69', '{"email": "info@zonetect.com", "months": 1, "tierName": "pro", "username": "zonetect", "emailSent": true, "expiresAt": "2025-09-18T11:50:16.855Z", "isFirstTimeMember": true}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:50:18'),
('67caf62e-d7f9-4938-b396-ce20bc223c97', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '1aa7717e-510c-406e-bdd7-d32e90a1603f', '{"email": "himesgelo@gmail.com", "months": 1, "tierName": "pro", "username": "xrpfather", "emailSent": true, "expiresAt": "2025-09-15T23:48:04.442Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:05'),
('6b2fe296-4455-4b64-a17d-6d607dbf0bc6', '8eea3a76-97df-438f-9685-f978cadacc77', 'user_membership_granted', 'user', 'fa7cffc8-0383-4988-898e-900eadd6388f', '{"email": "familyonly89@yahoo.com", "months": 1, "tierName": "pro", "username": "Rjdebo", "emailSent": true, "expiresAt": "2025-09-21T22:04:25.701Z", "isFirstTimeMember": true}', '172.59.24.211', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-21 22:04:27'),
('6dd935df-29bd-45c4-9d16-ec0fc710023e', '8eea3a76-97df-438f-9685-f978cadacc77', 'user_membership_granted', 'user', 'c40146e5-9ec5-4b57-b204-f464634489bb', '{"email": "britneykristine24@gmail.com", "months": 1, "tierName": "pro", "username": "whit4034", "emailSent": true, "expiresAt": "2025-09-21T22:04:03.301Z", "isFirstTimeMember": true}', '172.59.24.211', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-21 22:04:04'),
('71f61e2f-0b38-429a-b549-95d8b4070eb7', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '75d2f82a-bd10-4cea-8aec-98518d667e7b', '{"email": "cryptosphere34@hotmail.com", "months": 1, "tierName": "pro", "username": "cryptosphere34", "emailSent": true, "expiresAt": "2025-09-15T23:46:27.120Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:28'),
('72115069-bf75-4560-90c6-57b9568ef0fb', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '234f4b06-158b-46b3-a549-c834345afbc1', '{"email": "cartervail@icloud.com", "months": 1, "tierName": "pro", "username": "cartervail2", "emailSent": true, "expiresAt": "2025-09-15T23:46:18.938Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:19'),
('750940db-5f09-4d16-aa27-9b4a9b70d00e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'update_settings', 'site', 'settings_maintenance', '{"maintenance_enabled": true}', '172.20.10.2', NULL, '2025-08-24 19:14:58'),
('77497f44-7fee-42e5-a071-ce3ff8c97a57', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '9bb3fd9f-8082-4f82-83d4-b2b12cef42af', '{"email": "dlsgh3760@gmail.com", "months": 1, "tierName": "pro", "username": "INHO", "emailSent": true, "expiresAt": "2025-09-29T02:23:46.983Z", "isFirstTimeMember": true}', '172.59.24.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-29 02:23:48'),
('7be2c096-25dd-462b-b4cb-8eaa7e90936c', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_viewed', 'listing', '0761d10c-6299-4e3f-b1d2-83659c58521f', '{"seller": "FullEarth", "listingTitle": "HP EliteBook 850 G3 "}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-16 22:40:16'),
('7f9687be-4188-477c-baed-f843e2b0dfb5', '8eea3a76-97df-438f-9685-f978cadacc77', 'user_membership_granted', 'user', '2364093f-06d2-46df-84b2-203a0e72099c', '{"email": "muarsool1997@gmail.com", "months": 1, "tierName": "pro", "username": "M-BAH", "emailSent": true, "expiresAt": "2025-09-21T22:04:35.439Z", "isFirstTimeMember": true}', '172.59.24.211', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-21 22:04:36'),
('801d1d97-51d1-4502-93a1-f8b8c2901644', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '0761d10c-6299-4e3f-b1d2-83659c58521f', '{"action": "approve", "seller": "FullEarth", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "HP EliteBook 850 G3 "}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-16 22:40:11'),
('8165eef6-6f44-4620-9493-7c76289f8874', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '959d1e27-a851-4b61-b029-bebef6942945', '{"email": "johnathan.t.butler@gmail.com", "months": 1, "tierName": "pro", "username": "Chappelle4life", "emailSent": true, "expiresAt": "2025-09-15T23:47:04.718Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:47:05'),
('8399011b-c48c-4a2a-ba7f-6ead3737f851', '8966824e-28e4-4829-afb6-663ac276b7ad', 'user_membership_granted', 'user', '8966824e-28e4-4829-afb6-663ac276b7ad', '{"email": "devtomiwa9@gmail.com", "months": 1, "tierName": "pro", "username": "devtomiwa9", "emailSent": true, "expiresAt": "2025-09-15T03:21:29.219Z", "isFirstTimeMember": false}', '::ffff:192.168.1.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-15 03:21:34'),
('8493e024-d71b-4dae-8125-795a43a8aada', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'd181fd42-9ebc-4cf6-847b-9886e20723f8', '{"email": "arizonamointainwater@gmail.com", "months": 1, "tierName": "pro", "username": "AZ Mountain Water", "emailSent": true, "expiresAt": "2025-09-28T01:10:18.039Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-28 01:10:18'),
('84fe19f2-e944-44a9-91fc-d38fddc0e4d7', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '36bc8611-4313-44de-8fe3-72f93f665bf5', '{"action": "approve", "seller": "Neo", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Owl Night Lamp "}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:49:31'),
('85188d72-f20b-4be5-b853-a6a53541fba2', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'listing_approved', 'listing', 'fc7db510-c238-4042-97d7-b96113b928a4', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Fragrance perfume brand"}', '67.144.165.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-08-19 22:54:28'),
('8550f603-b187-4d9a-8877-9d6687301bb3', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '18aca1f3-fe5c-4e5a-84db-d9a38fa3c31d', '{"email": "ArizonaMountainWater@gmail.com", "months": 1, "tierName": "pro", "username": "AZMountainWater", "emailSent": true, "expiresAt": "2025-09-28T01:10:11.634Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-28 01:10:12'),
('85daf5b2-3e90-4128-94a5-7917409dec84', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '7708d7df-2ffb-4532-8a15-fe270bb1c109', '{"email": "awanderingponderer@yahoo.com", "months": 1, "tierName": "pro", "username": "Rufus Toothfist ", "emailSent": true, "expiresAt": "2025-10-13T18:41:43.719Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:41:44'),
('8efbde88-7974-4cc5-b0ff-bac518defe09', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'c697b17e-74af-492e-abe5-258ae1f85cee', '{"email": "tomb3169@gmail.com", "months": 1, "tierName": "pro", "username": "tomb3169@gmail.com", "emailSent": true, "expiresAt": "2025-09-15T23:49:20.603Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:49:21'),
('983c6c04-8b51-4e2c-ad9a-09db1039d9e4', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', 'd5a56ff1-3eb2-46ba-b2da-639b36315dfe', '{"action": "approve", "seller": "Neo", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Designer Vase "}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:49:42'),
('98990cc1-2084-4e21-965e-25010e019640', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'c7cd7ec3-4b68-4a17-aeab-c3be3ba4adf4', '{"email": "bukkyhassan80@gmail.com", "months": 1, "tierName": "pro", "username": "bukkyp", "emailSent": true, "expiresAt": "2025-09-15T23:46:55.342Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:56'),
('a2142f4b-d226-443c-b560-85ad105bda60', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'eb7a98ff-4020-4131-902a-7542a84146ba', '{"email": "wilshireralphxiii@gmail.com", "months": 1, "tierName": "pro", "username": "Wilshire ", "emailSent": true, "expiresAt": "2025-10-13T18:53:24.610Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:53:25'),
('ae5ce3aa-4ca3-41b9-8086-79818ab771e7', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '57f1952d-8454-4c99-b9fb-624be70db745', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Lady million-Fabulous "}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-23 22:19:07'),
('af03f255-1b1d-4b31-904b-bd6c76bfba0b', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', 'b6cabb8a-1ead-4967-b071-19c37e60698c', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Amouage Epic Eau de perfum "}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-23 22:19:12'),
('af5053be-eaf1-46e2-8e20-cc1be2dcda58', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'listing_approved', 'listing', 'ae741c42-e20d-40b5-b8a3-1b35d227dbf1', '{"action": "approve", "seller": "BrizzyBandz", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Cross iPhone Case"}', '67.144.165.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-08-19 22:54:23'),
('b130ce69-ea5b-4d21-9028-3263570e113f', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', '{"email": "muarsool@gmail.com", "months": 1, "tierName": "pro", "username": "Mujtaba", "emailSent": true, "expiresAt": "2025-09-15T23:49:49.466Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:49:50'),
('b14219dd-0663-433a-95d0-dc47c82a94ee', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', '{"email": "nicolas.padovani@wanadoo.fr", "months": 1, "tierName": "pro", "username": "pinzut17", "emailSent": true, "expiresAt": "2025-10-07T22:07:43.767Z", "isFirstTimeMember": false}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-09-07 22:07:45'),
('b64b6e3d-3aaa-46bc-9e86-7c56ba3e48e7', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'b34a8e57-18ad-4adf-a3e1-a34743be6a6b', '{"email": "lemaitrestudio@gmail.com", "months": 1, "tierName": "pro", "username": "Themojodev", "emailSent": true, "expiresAt": "2025-09-25T16:47:37.180Z", "isFirstTimeMember": true}', '172.59.24.121', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-25 16:47:38'),
('b898c6c7-9188-4ba4-9c85-dcfcab198a2d', '8eea3a76-97df-438f-9685-f978cadacc77', 'user_membership_granted', 'user', 'a1eef3f3-c846-480a-8c01-a99dc0eede5c', '{"email": "lam28815@gmail.com", "months": 1, "tierName": "pro", "username": "nhocmot", "emailSent": true, "expiresAt": "2025-09-21T22:03:53.795Z", "isFirstTimeMember": true}', '172.59.24.211', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-21 22:03:55'),
('c0200e8b-5193-4618-925a-cc9c01446a83', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', 'dafb7682-df9a-47b3-9e8c-bb5103373f24', '{"action": "approve", "seller": "Mujtaba", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "A Milano Eau de Parfum 100ml"}', '173.90.107.136', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-10 00:31:12'),
('c6afc613-6f80-4793-8fba-24ff7d83aa42', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'd606f7b9-f445-4559-9bdd-28f8c881693c', '{"email": "dylincarter99@gmail.com", "months": 1, "tierName": "pro", "username": "Carter", "emailSent": true, "expiresAt": "2025-09-15T23:48:32.710Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:33'),
('c91dbe27-74e1-4844-9263-57783d9a117c', '8966824e-28e4-4829-afb6-663ac276b7ad', 'user_membership_granted', 'user', '8966824e-28e4-4829-afb6-663ac276b7ad', '{"email": "devtomiwa9@gmail.com", "months": 1, "tierName": "pro", "username": "devtomiwa9", "emailSent": true, "expiresAt": "2025-09-15T03:19:10.239Z", "isFirstTimeMember": false}', '::ffff:192.168.1.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-15 03:19:15'),
('cc6d3777-fa9e-43d5-9781-6a3a6ec2a73a', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '5c36c202-d883-4280-95cf-d1b53d510939', '{"email": "simonsamuel195@gmail.com", "months": 1, "tierName": "pro", "username": "BigSam", "emailSent": true, "expiresAt": "2025-10-13T18:41:37.987Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:41:38'),
('cf1fa261-d3e9-4130-8d94-a3cc44c9eb12', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'b04397fc-e89f-4647-8ed4-bf01e0f8a00c', '{"email": "hopscotch", "months": 1, "tierName": "pro", "username": "Hopscotch", "emailSent": false, "expiresAt": "2025-09-15T23:48:23.460Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:48:23'),
('d25763a2-4cbf-441f-acbe-0a5947b26591', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'ec80c3e6-ee1e-472d-9d3f-29074f144aea', '{"email": "jshelton352@gmail.com", "months": 1, "tierName": "pro", "username": "Lavish Savant ", "emailSent": true, "expiresAt": "2025-09-19T11:45:16.379Z", "isFirstTimeMember": true}', '172.59.25.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-19 11:45:18'),
('d692f1c6-d927-41a0-a9ad-877f6910cc34', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'f7a15ecc-ebec-4ff5-87a3-c6e517c8fac8', '{"email": "billsun4567@hotmail.com", "months": 1, "tierName": "pro", "username": "William Sun", "emailSent": true, "expiresAt": "2025-09-15T23:46:03.245Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:04'),
('d77eb0ae-eeb9-482b-973d-b8466962762f', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '4db4233d-fa69-4ab6-9126-74339c8fecd4', '{"email": "utunkarim2@gmail.com", "months": 1, "tierName": "pro", "username": "utunkarim2", "emailSent": true, "expiresAt": "2025-09-17T05:31:36.342Z", "isFirstTimeMember": true}', '172.59.25.234', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-17 05:31:37'),
('dafea772-2fa6-4593-aa42-4dd73745f47c', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', 'b004ab4f-24a8-49b9-bd56-c5cfcc1734de', '{"action": "approve", "seller": "FullEarth", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Apple earbuds wired lightning port OEM"}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:50:19'),
('db72c243-c50b-45f7-b15a-01e37b6e5c06', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '7793b9f4-ae0b-433f-8019-b3b3902e6dd1', '{"email": "binsuwaidan.ss@gmail.com", "months": 1, "tierName": "pro", "username": "Alprinc", "emailSent": true, "expiresAt": "2025-09-15T23:45:55.494Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:45:56'),
('e2eabcd7-395c-46e5-beb8-e6d31cd753e2', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', 'f150bf83-2211-468b-9268-626e54068b45', '{"email": "bobbyisactive@outlook.com", "months": 1, "tierName": "pro", "username": "Bobbyy", "emailSent": true, "expiresAt": "2025-09-15T23:47:14.887Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:47:15'),
('e909d9c5-6355-4621-b7fb-1417db7d2943', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '8d7cc243-ad53-4144-bcf3-2058658ad213', '{"email": "derrikphicks@gmail.com", "months": 1, "tierName": "pro", "username": "Shinigami117", "emailSent": true, "expiresAt": "2025-09-15T23:46:10.388Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-15 23:46:11'),
('ea55ce6e-1d01-4bb8-b97c-9295b58f64bd', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'user_membership_granted', 'user', '315a7c50-1fa5-4705-add1-cecefad26e3c', '{"email": "stathamjason618@gmail.com", "months": 1, "tierName": "pro", "username": "jason", "emailSent": true, "expiresAt": "2025-10-13T18:41:27.325Z", "isFirstTimeMember": true}', '67.144.110.185', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-09-13 18:41:29'),
('ec67fc82-1ee9-4fc0-94a6-d292cc193ee4', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_approved', 'listing', '4593d2a0-d908-4802-a449-853e14fcfc62', '{"action": "approve", "seller": "Neo", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "Fox Night Lamp"}', '172.59.25.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-18 11:49:39'),
('f2f28975-63eb-4d9e-b331-8e436e1ad321', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'listing_viewed', 'listing', '36bc8611-4313-44de-8fe3-72f93f665bf5', '{"seller": "Neo", "listingTitle": "Owl Night Lamp "}', '172.59.25.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2025-08-19 11:58:25'),
('f59f54c8-1eae-4322-9e5e-ceca6cb459bf', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'listing_approved', 'listing', '78a90e4a-b4bd-47ab-885f-abda97b7a3c0', '{"action": "approve", "seller": "JT132724", "newStatus": "approved", "oldStatus": "pending", "listingTitle": "LBJ 13 Shoes"}', '173.90.107.136', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', '2025-08-27 23:42:33'),
('fa0bf3cf-e5b6-49c0-8ac0-dd6d1f59421f', '8966824e-28e4-4829-afb6-663ac276b7ad', 'listing_viewed', 'listing', '12ac6960-996d-4d77-9c07-1dce871df20f', '{"seller": "devtomiwa9", "listingTitle": "Tesst2 Auction"}', '::ffff:192.168.1.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-15 03:14:55');


-- Table structure for bids
DROP TABLE IF EXISTS `bids`;
CREATE TABLE `bids` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `listing_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bidder_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bid_amount` decimal(20,8) NOT NULL,
  `wallet_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `chain` enum('xrp','evm','solana') COLLATE utf8mb4_general_ci NOT NULL,
  `wallet_balance_verified` tinyint(1) DEFAULT '0',
  `status` enum('active','outbid','winning','won','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_listing_amount` (`listing_id`,`bid_amount` DESC),
  KEY `idx_bidder` (`bidder_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`bidder_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for bids
INSERT INTO `bids` (`id`, `listing_id`, `bidder_id`, `bid_amount`, `wallet_address`, `chain`, `wallet_balance_verified`, `status`, `created_at`, `updated_at`) VALUES
('309ff675-232e-46a1-94ca-39d490a181bc', '4e296b14-1f18-4b92-a8fc-4fa6b132d5b8', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '11.00000000', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'xrp', 1, 'outbid', '2025-08-11 08:34:46', '2025-08-11 08:35:24'),
('628d4f58-592c-4476-9593-083ad4bca0dd', '4e296b14-1f18-4b92-a8fc-4fa6b132d5b8', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '21.00000000', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'xrp', 1, 'active', '2025-08-11 08:35:24', '2025-08-11 08:35:24');


-- Table structure for contact_messages
DROP TABLE IF EXISTS `contact_messages`;
CREATE TABLE `contact_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sender_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sender_email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('unread','read','replied') COLLATE utf8mb4_general_ci DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_storefront_id` (`storefront_id`),
  CONSTRAINT `contact_messages_ibfk_1` FOREIGN KEY (`storefront_id`) REFERENCES `user_profiles` (`storefront_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for contact_messages

-- Table structure for email_campaigns
DROP TABLE IF EXISTS `email_campaigns`;
CREATE TABLE `email_campaigns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `recipient_count` int DEFAULT '0',
  `sent_count` int DEFAULT '0',
  `failed_count` int DEFAULT '0',
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  `template_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'promotional',
  PRIMARY KEY (`id`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for email_campaigns
INSERT INTO `email_campaigns` (`id`, `subject`, `message`, `recipient_count`, `sent_count`, `failed_count`, `created_by`, `created_at`, `completed_at`, `template_type`) VALUES
(1, 'wdwd', 'wdwd', 1, 0, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 15:35:21', NULL, 'promotional'),
(2, 'wdwd', 'wdwd', 1, 0, 1, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 15:37:33', '2025-08-08 15:37:33', 'promotional'),
(3, 'This is a tesst', 'Testinng', 1, 1, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 15:39:05', '2025-08-08 15:39:08', 'promotional'),
(4, 'Special Offer - RippleBids Offer Letter', '👥Special Offer: Test content test content...', 1, 1, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 16:02:21', '2025-08-08 16:02:24', 'promotional'),
(5, 'Testing testing', '👀Special Offer: This is the promotional content...', 1, 1, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 16:04:10', '2025-08-08 16:04:13', 'promotional'),
(6, 'Testingggg', 'Newsletter: This is the newsletter contenntn...', 1, 1, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 16:04:52', '2025-08-08 16:04:56', 'newsletter'),
(7, 'wdawda', 'awndawnkdlaw: iawndawlinbdalwubndfejb fkawbd fawjbdnkwbnd👩🏻👀👁️👀👀👀👀👀...', 1, 1, 0, '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-08-08 16:09:18', '2025-08-08 16:09:22', 'promotional');


-- Table structure for email_queue
DROP TABLE IF EXISTS `email_queue`;
CREATE TABLE `email_queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recipient` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `subject` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `template_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `data` text COLLATE utf8mb4_general_ci,
  `status` enum('pending','processing','sent','failed') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` timestamp NULL DEFAULT NULL,
  `result` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_status_created` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for email_queue

-- Table structure for escrow_accounts
DROP TABLE IF EXISTS `escrow_accounts`;
CREATE TABLE `escrow_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `escrow_address` varchar(50) NOT NULL,
  `destination_address` varchar(50) NOT NULL,
  `chain` varchar(10) NOT NULL,
  `amount` decimal(30,10) NOT NULL,
  `currency` varchar(50) NOT NULL,
  `transaction_hash` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `condition_payment_verified` tinyint(1) DEFAULT '0',
  `condition_admin_approved` tinyint(1) DEFAULT '0',
  `condition_dispute_open` tinyint(1) DEFAULT '0',
  `condition_released` tinyint(1) DEFAULT '0',
  `condition_refunded` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data for escrow_accounts
INSERT INTO `escrow_accounts` (`id`, `escrow_address`, `destination_address`, `chain`, `amount`, `currency`, `transaction_hash`, `status`, `condition_payment_verified`, `condition_admin_approved`, `condition_dispute_open`, `condition_released`, `condition_refunded`, `created_at`, `updated_at`) VALUES
(1, 'rpeh58KQ7cs76Aa2639LYT2hpw4D6yrSDq', 'rL56jbotdLLpThXctCpB3vZR9kXe5QzVDb', 'XRPL', '50.0000000000', 'XRPB', NULL, 'PENDING', 0, 0, 0, 0, 0, '2025-08-25 08:32:58', '2025-08-25 08:32:58');


-- Table structure for escrows
DROP TABLE IF EXISTS `escrows`;
CREATE TABLE `escrows` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seller` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` decimal(20,8) NOT NULL,
  `chain` enum('solana','xrpl','xrpl_evm','sui','eth','xrpb-sol','xrpb-evm') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fee` decimal(20,8) DEFAULT '0.00000000',
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Dynamic conditions stored as JSON object',
  `status` enum('pending','funded','conditions_met','released','disputed','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `transaction_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `release_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `withdrawal_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dispute_reason` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_seller` (`seller`),
  KEY `idx_buyer` (`buyer`),
  KEY `idx_status` (`status`),
  CONSTRAINT `escrows_chk_1` CHECK (json_valid(`conditions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for escrows
INSERT INTO `escrows` (`id`, `seller`, `buyer`, `amount`, `chain`, `fee`, `conditions`, `status`, `transaction_hash`, `release_hash`, `withdrawal_address`, `dispute_reason`, `created_at`, `updated_at`) VALUES
('0f84c633-e5bc-42df-99b7-7a758a537b9c', 'devtomiwa9', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', '0.02593660', 'sui', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', 'EvP1MBpW65dpqWvwSMNDw3wsUF6SM6Uf1NMiXruxW3rx', NULL, NULL, NULL, '2025-10-07 18:10:04', '2025-10-07 18:10:04'),
('26e00962-8d0b-4a98-808a-072d03833abe', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17731.05215702', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x141c160eec0b822d237fc4840da0bf50eea369ee4ab68f76651bd285be4c96f7', NULL, NULL, NULL, '2025-10-03 10:09:20', '2025-10-03 10:09:20'),
('29b2c804-abeb-4641-912f-a2e0912c986c', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1673.00000000', NULL, '41.82500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 11:20:55', '2025-08-01 11:20:55'),
('2e29fc8a-e731-4585-8532-cf9fc6be6961', 'devtomiwa9', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', '0.27777778', 'sui', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '4CzxRJ8J8H6UbnHfXf6tK3FxR1usX3FAefbXHoBrdJ9z', NULL, NULL, NULL, '2025-10-03 19:45:04', '2025-10-03 19:45:04'),
('381bd6d1-96c7-4648-9b89-f75f53cb1140', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '0.00022283', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x005f729279eef813e5dc13f38ae9f1ba74ddd16aafee5d2159174f098c484633', NULL, NULL, NULL, '2025-10-04 03:35:53', '2025-10-04 03:35:53'),
('3a86b663-560b-42b0-9704-447a1145bf80', 'devtomiwa9', 'ATfhapTLwrPzqEQBywirrTw7BGWaDmaGkMXtPyHtzh3F', '40209.08725372', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '2HNNrWXrcbbwrPdB6DsaL7jivjb6Lg1ZatPZMmZnRSL1AnoiiCRrmnhJqbyebNj5iC2Z3yjnEXeqkSFpSVi94n82', NULL, NULL, NULL, '2025-10-03 20:41:34', '2025-10-03 20:41:34'),
('41b2edbf-958c-4f64-9efe-d1bb20c10c32', '', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '81929.00000000', 'xrpl_evm', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'funded', NULL, NULL, NULL, NULL, '2025-08-06 16:13:38', '2025-08-06 16:13:39'),
('5050fb10-804c-4e2b-ac91-e72c1aac809e', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1645.00000000', NULL, '41.12500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'funded', NULL, NULL, NULL, NULL, '2025-08-01 12:41:34', '2025-08-01 12:41:34'),
('50d2e36c-8b87-4725-8180-468008b3b0c7', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1656.00000000', NULL, '41.40000000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, 'release_1754051996513_lzhmoskto', '0x9919cfC0DBcdEe6a60F05e974EBFCa89150b0E7B', NULL, '2025-08-01 12:11:44', '2025-08-01 12:39:56'),
('51a255d5-2e26-4eef-a830-62f4ffa918ac', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17729.07780768', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x0e3d915bc742260ab904c011ff4cee8cd30df8449c0e67ed68e0195e5aafcf61', NULL, NULL, NULL, '2025-10-03 11:07:32', '2025-10-03 11:07:32'),
('53385328-fcf2-44bf-b172-96eca21afa6a', 'pending_wallet_setup', 'rD3YmncnvAmAHdEg5PUdY7CaDw279gc1Xt', '1.00000000', NULL, '0.02500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 11:01:35', '2025-08-01 11:01:35'),
('5ec61bd5-7b12-451a-9abc-3718937e6f62', 'pending_wallet_setup', 'rD3YmncnvAmAHdEg5PUdY7CaDw279gc1Xt', '1.00000000', NULL, '0.02500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 10:55:32', '2025-08-01 10:55:32'),
('60f57231-2d5a-4947-838d-79226839b28c', 'pending_wallet_setup', 'rD3YmncnvAmAHdEg5PUdY7CaDw279gc1Xt', '1.00000000', NULL, '0.02500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 10:44:51', '2025-08-01 10:44:51'),
('6c233399-84f5-4ff1-8365-b07b0bf8825d', 'devtomiwa9', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', '0.02593660', 'sui', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '74JPjP9yBdBUTJ6mFqVGK84rea7vHAudGb3JqevczRyZ', NULL, NULL, NULL, '2025-10-07 18:06:53', '2025-10-07 18:06:53'),
('898d9cf7-f51f-41a0-ae95-9b4d73b0504e', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17735.94942583', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x8132e0035132db1ec3679c099bc06ea65f53aa4a5e2c0e0da4000c08ba64f2b3', NULL, NULL, NULL, '2025-10-03 09:52:08', '2025-10-03 09:52:08'),
('8a74f10b-d503-4ab7-8c94-0bb181a75990', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17731.05215702', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0xfa8e2e7c9bc7d589b542eabac1dce30607cbeedfa52dbc3ce7971b9eeca44e54', NULL, NULL, NULL, '2025-10-03 10:01:11', '2025-10-03 10:01:11'),
('8bfe8e6f-9bef-4ba8-b8f8-10645a6b4499', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17714.20455067', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x3942d350bedf82f8ac72ae3775e522b31b03f16aa616cd4ba02867a6f2b6252b', NULL, NULL, NULL, '2025-10-03 09:40:48', '2025-10-03 09:40:48'),
('8f32d095-d3ef-4953-851b-7bbcfa4b2f0c', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1656.00000000', NULL, '41.40000000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 12:10:05', '2025-08-01 12:10:05'),
('9072a966-d44b-4c4a-b88c-d6627b8bccb1', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '0.00022084', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0xab5372dc3b2c33420c36d811e36c089553b36e5a84d7641740f8aca95bd000c9', NULL, NULL, NULL, '2025-10-04 00:07:05', '2025-10-04 00:07:05'),
('91e248d1-c6f0-4637-80b4-b66f2cd470e7', '', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1656.00000000', 'xrpl_evm', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'funded', NULL, NULL, NULL, NULL, '2025-08-01 13:47:07', '2025-08-01 13:47:07'),
('97b36fd8-d008-4c90-bb3c-179fc08818cd', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17714.20455067', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0xe10984b9ae207fae64f67fc0d630ff25428e3240e89459d50b93fcbc50af22c8', NULL, NULL, NULL, '2025-10-03 09:43:46', '2025-10-03 09:43:46'),
('988183fb-535b-4683-8cf3-f3fa90bf3656', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1679.00000000', NULL, '41.97500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 11:12:14', '2025-08-01 11:12:14'),
('a9d8c97e-9457-488c-8d6a-85001232b04c', 'devtomiwa9', '2ZTgNc4tCnZsrvMQtRu5fJGVwkhy6ZuZaAtUgDb9dxd5', '0.00434047', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', 'gyoxe9ny9SKJcGBZVPL5EFfmoTGY9DB1wC1ERPA2P1Bny5A1kNeN3mxMjb7X5sMEW6wvrRSD4CT6wN1bbjj7ruH', NULL, NULL, NULL, '2025-10-03 15:35:42', '2025-10-03 15:35:42'),
('ab951a9c-1a8e-4578-ad97-fc03e7fe96c2', '', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1651.00000000', 'xrpl_evm', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, '0x97521e8aab2999a9e9594e19e660f602ec6763c53f101ec68881f126ca810955', '0x9919cfC0DBcdEe6a60F05e974EBFCa89150b0E7B', NULL, '2025-08-01 12:57:17', '2025-08-01 13:22:24'),
('b4853eea-e51b-446c-9dcc-bd2cc75c2f33', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1651.00000000', NULL, '41.27500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, 'release_1754051631491_a96ke5ydb', '0x9919cfC0DBcdEe6a60F05e974EBFCa89150b0E7B', NULL, '2025-08-01 12:19:32', '2025-08-01 12:33:51'),
('ba94bd53-78e5-4c20-be77-5749bc42de5c', 'devtomiwa9', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', '0.02593660', 'sui', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', 'TSVa73LfaAQgsTveFX1WpptMSrVGUa4rUaYvSRVntQZ', NULL, NULL, NULL, '2025-10-07 18:08:31', '2025-10-07 18:08:31'),
('be2b7f51-5b3f-4d6b-9024-885b88f644aa', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '0.00022084', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0xdbe3737c0a6ed0d733810482d76ed8e384c4581950663b36b068985cc559c649', NULL, NULL, NULL, '2025-10-04 00:07:53', '2025-10-04 00:07:53'),
('c4d77b9f-45a3-4156-ab0d-07ef800ebfc2', 'pending_wallet_setup', 'rD3YmncnvAmAHdEg5PUdY7CaDw279gc1Xt', '1.00000000', NULL, '0.02500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 11:10:25', '2025-08-01 11:10:25'),
('ceadf6bd-2f6d-4d39-95a2-574d7e58243f', '', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '16566.00000000', 'xrpl_evm', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'funded', NULL, NULL, NULL, NULL, '2025-08-06 15:34:25', '2025-08-06 15:34:26'),
('dc5acc58-6cff-4e82-903e-dbe0e9b8525e', '', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1629.00000000', 'xrpl_evm', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, '0x5bf72a114157c4a04e4a7218b83dcd13d919deca65cd08ca763440d7f011e85e', '0x9919cfC0DBcdEe6a60F05e974EBFCa89150b0E7B', NULL, '2025-08-01 14:52:55', '2025-08-01 14:54:35'),
('dc7adf72-80f1-4e22-8159-f4ba2b93ed62', 'devtomiwa9', 'ATfhapTLwrPzqEQBywirrTw7BGWaDmaGkMXtPyHtzh3F', '39588.28186857', 'xrpl', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '3gEYocQWpkDzpzBxT1S3Vs1Dwec6eZGTx6vcTqDuLrQx1e9yF2xtmWbTVwVwC7VqCUdhhgYMdumEtGkNGLoVr88G', NULL, NULL, NULL, '2025-10-03 20:22:08', '2025-10-03 20:22:08'),
('e6d422b8-9ee7-4d01-b3d0-eee87593ceda', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17729.07780768', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x1b0ddb75a72f02d17e818f4b49644b90acfcf6419d86537dd6d1eb3dce1ea753', NULL, NULL, NULL, '2025-10-03 11:09:43', '2025-10-03 11:09:43'),
('e8474845-f689-4cdf-9460-ee0de558cc5f', '', 'GC6ojLMXLi9Az42SXK1o1v1ec9uWGFwwiJW92U1uD4i9', '216967.00000000', 'solana', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, NULL, NULL, NULL, '2025-08-03 21:18:25', '2025-08-03 21:19:10'),
('f2d18908-d592-4ce3-8d87-e6a9f5b26df2', 'pending_wallet_setup', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '1667.00000000', NULL, '41.67500000', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'pending', NULL, NULL, NULL, NULL, '2025-08-01 11:54:33', '2025-08-01 11:54:33'),
('f43b6eaf-1d8c-40aa-a8ac-5af9f09b2f34', 'devtomiwa9', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', '17731.05215702', 'xrpl_evm', '0E-8', '{"delivery_required": true, "satisfactory_condition": true, "auto_release_days": 20}', 'funded', '0x02f3c39162f87a05a1d3a53afb9870f2ad47af38c024c18d80693002cd649697', NULL, NULL, NULL, '2025-10-03 10:07:25', '2025-10-03 10:07:25'),
('fc7c4a93-46a8-4632-b476-4fafd198ba29', '', 'rD3YmncnvAmAHdEg5PUdY7CaDw279gc1Xt', '92.00000000', 'xrpl', '0E-8', '{"delivery_required":true,"satisfactory_condition":true,"auto_release_days":20}', 'released', NULL, NULL, NULL, NULL, '2025-08-03 19:49:37', '2025-08-03 21:25:12');


-- Table structure for gradient_themes
DROP TABLE IF EXISTS `gradient_themes`;
CREATE TABLE `gradient_themes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `primary_color` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  `secondary_color` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  `accent_color` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `is_preset` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_storefront_id` (`storefront_id`),
  CONSTRAINT `gradient_themes_ibfk_1` FOREIGN KEY (`storefront_id`) REFERENCES `user_profiles` (`storefront_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for gradient_themes
INSERT INTO `gradient_themes` (`id`, `owner_id`, `storefront_id`, `name`, `primary_color`, `secondary_color`, `accent_color`, `is_active`, `is_preset`, `created_at`, `updated_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Ocean Blue', '#1a1a2e', '#16213e', '#39FF14', 0, 1, '2025-09-05 20:10:58', '2025-09-06 00:56:48'),
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Sunset Orange', '#2d1b69', '#11998e', '#ff6b6b', 0, 1, '2025-09-05 20:10:58', '2025-09-05 20:10:58'),
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Purple Dream', '#667eea', '#764ba2', '#f093fb', 0, 1, '2025-09-05 20:10:58', '2025-09-05 20:10:58'),
(4, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'New Theme', '#c13371', '#189a6f', '#39FF14', 0, 0, '2025-09-06 00:56:48', '2025-09-12 12:39:05'),
(5, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Dev''s Theme', '#2525cb', '#71747f', '#c22f0a', 0, 0, '2025-09-12 12:39:05', '2025-09-22 19:28:42'),
(6, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Tomiwa’s New Theme', '#e22400', '#669d34', '#39FF14', 0, 0, '2025-09-22 19:28:42', '2025-09-22 22:58:39'),
(7, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'Hi', '#0056d6', '#b51a00', '#39FF14', 1, 0, '2025-09-22 19:38:30', '2025-09-22 19:38:30'),
(8, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'bleu', '#420a06', '#16213e', '#39FF14', 0, 0, '2025-09-22 20:25:44', '2025-09-22 20:27:05'),
(9, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'red', '#44041d', '#33361f', '#39FF14', 0, 0, '2025-09-22 20:27:05', '2025-09-22 20:27:30'),
(10, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#1a1a2e', '#16213e', '#fa4518', 0, 0, '2025-09-22 20:27:31', '2025-09-22 20:29:13'),
(11, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'violet', '#1a1a2e', '#16213e', '#3127eb', 0, 0, '2025-09-22 20:29:13', '2025-09-22 20:31:06'),
(12, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'red', '#1a1a2e', '#16213e', '#fa5118', 0, 0, '2025-09-22 20:31:06', '2025-09-22 20:36:46'),
(13, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'yellow', '#408080', '#0000ff', '#ffff00', 0, 0, '2025-09-22 20:36:47', '2025-09-22 20:37:38'),
(14, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'black', '#400000', '#400080', '#ff0000', 0, 0, '2025-09-22 20:37:38', '2025-09-22 20:52:01'),
(15, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'black white yellow', '#000000', '#ffffff', '#ffff00', 0, 0, '2025-09-22 20:52:01', '2025-09-22 22:26:48'),
(16, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'red', '#442004', '#ff0080', '#ffff00', 0, 0, '2025-09-22 22:26:48', '2025-09-22 22:28:50'),
(17, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'yellow', '#ffff00', '#1c0154', '#ff0080', 0, 0, '2025-09-22 22:28:50', '2025-09-22 22:43:45'),
(18, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'vert', '#408080', '#ffff80', '#2e1ef4', 0, 0, '2025-09-22 22:43:45', '2025-09-23 13:34:54'),
(19, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Dev''s New Theme (2)', '#0f0f14', '#465fa4', '#4c9e3d', 1, 0, '2025-09-22 22:58:39', '2025-09-22 22:58:39'),
(20, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'nui', '#1a1a2e', '#16213e', '#978b7b', 0, 0, '2025-09-23 13:34:54', '2025-09-26 13:24:55'),
(21, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#1a1a2e', '#16213e', '#ff8000', 0, 0, '2025-09-26 13:24:55', '2025-09-30 20:45:56'),
(22, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#1a1a2e', '#16213e', '#ff8000', 0, 0, '2025-09-30 20:45:56', '2025-10-01 11:42:41'),
(23, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#1a1a2e', '#008000', '#ff8000', 0, 0, '2025-10-01 11:42:41', '2025-10-01 11:43:39'),
(24, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#c0c0c0', '#004040', '#ff8000', 0, 0, '2025-10-01 11:43:40', '2025-10-01 11:46:56'),
(25, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'orange', '#c0c0c0', '#408080', '#ff8000', 1, 0, '2025-10-01 11:46:56', '2025-10-01 11:46:56');


-- Table structure for listings
DROP TABLE IF EXISTS `listings`;
CREATE TABLE `listings` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `price` decimal(20,8) NOT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subcategory` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `brand` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `condition_type` enum('new','like_new','very_good','good','acceptable','poor') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `weight` decimal(8,3) DEFAULT NULL COMMENT 'Weight in kg',
  `length` decimal(8,2) DEFAULT NULL COMMENT 'Length in cm',
  `width` decimal(8,2) DEFAULT NULL COMMENT 'Width in cm',
  `height` decimal(8,2) DEFAULT NULL COMMENT 'Height in cm',
  `color` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `size` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `material` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sku` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `isbn` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `upc_ean` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state_province` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `original_price` decimal(20,8) DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  `bulk_pricing` json DEFAULT NULL,
  `key_features` json DEFAULT NULL,
  `technical_specs` json DEFAULT NULL,
  `compatibility` text COLLATE utf8mb4_general_ci,
  `warranty_period` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `warranty_type` enum('manufacturer','seller','extended','none') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `return_policy` text COLLATE utf8mb4_general_ci,
  `return_period_days` int DEFAULT NULL,
  `shipping_weight` decimal(8,3) DEFAULT NULL COMMENT 'Shipping weight in kg',
  `shipping_dimensions` json DEFAULT NULL COMMENT 'L x W x H in cm',
  `shipping_cost` decimal(10,2) DEFAULT NULL,
  `free_shipping` tinyint(1) DEFAULT '0',
  `shipping_methods` json DEFAULT NULL,
  `processing_time_days` int DEFAULT NULL,
  `quantity_available` int DEFAULT '1',
  `min_order_quantity` int DEFAULT '1',
  `max_order_quantity` int DEFAULT NULL,
  `age_restriction` int DEFAULT NULL COMMENT 'Minimum age required',
  `requires_assembly` tinyint(1) DEFAULT '0',
  `energy_rating` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `certifications` json DEFAULT NULL,
  `included_accessories` json DEFAULT NULL,
  `care_instructions` text COLLATE utf8mb4_general_ci,
  `storage_requirements` text COLLATE utf8mb4_general_ci,
  `chain` enum('xrp','evm','solana','btc','sui','eth') COLLATE utf8mb4_general_ci NOT NULL,
  `is_physical` tinyint(1) DEFAULT '0',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `status` enum('draft','pending','approved','rejected','sold','out_of_stock') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `views` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_auction` tinyint(1) DEFAULT '0',
  `starting_bid` decimal(20,8) DEFAULT NULL,
  `current_bid` decimal(20,8) DEFAULT NULL,
  `bid_increment` decimal(20,8) DEFAULT '10.00000000',
  `auction_end_date` timestamp NULL DEFAULT NULL,
  `auction_winner_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `auction_status` enum('active','ended','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `stock_quantity` int DEFAULT '1',
  `original_stock` int DEFAULT '1',
  `low_stock_threshold` int DEFAULT '5',
  `buy_now_price` decimal(20,8) DEFAULT NULL,
  `shipping_from` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `fk_auction_winner` (`auction_winner_id`),
  CONSTRAINT `fk_auction_winner` FOREIGN KEY (`auction_winner_id`) REFERENCES `users` (`id`),
  CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `listings_chk_1` CHECK (json_valid(`images`)),
  CONSTRAINT `listings_chk_2` CHECK (json_valid(`tags`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for listings
INSERT INTO `listings` (`id`, `user_id`, `title`, `description`, `price`, `category`, `subcategory`, `brand`, `model`, `condition_type`, `weight`, `length`, `width`, `height`, `color`, `size`, `material`, `sku`, `isbn`, `upc_ean`, `country`, `state_province`, `city`, `original_price`, `discount_percentage`, `bulk_pricing`, `key_features`, `technical_specs`, `compatibility`, `warranty_period`, `warranty_type`, `return_policy`, `return_period_days`, `shipping_weight`, `shipping_dimensions`, `shipping_cost`, `free_shipping`, `shipping_methods`, `processing_time_days`, `quantity_available`, `min_order_quantity`, `max_order_quantity`, `age_restriction`, `requires_assembly`, `energy_rating`, `certifications`, `included_accessories`, `care_instructions`, `storage_requirements`, `chain`, `is_physical`, `images`, `tags`, `status`, `views`, `created_at`, `updated_at`, `is_auction`, `starting_bid`, `current_bid`, `bid_increment`, `auction_end_date`, `auction_winner_id`, `auction_status`, `stock_quantity`, `original_stock`, `low_stock_threshold`, `buy_now_price`, `shipping_from`) VALUES
('000bbe5b-6d5c-424d-b5f1-782eea4ad2ff', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'Round Neck Shift Dress With Flaps-Dark Green', 'Product specific (Avg. measurement - inches)

Chest: XS - 32.5 , S - 34 , M -36  , L - 38 , XL - 40 , XXL -42

Across Shoulders:  XS - 13.625 , S - 14 , M - 14.5 , L - 15 , XL - 15.5 , XXL - 16

 

 

Material: COTTON/POLYESTER
Color: DARK GREEN

Fit Type: REGULAR FIT

Stretch: No Stretch
Style:Round Neck ,Shift Dress  

Accessories: ZIPPER
Model Size: S

Wash & Care:Normal Wash


Note: Product Colour May Slightly Vary Due To Photographic Lighting Sources Or Your Monitor Setting.', '29.99000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672829/ripple-marketplace/listings/listing_1754672828_6nvw1.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672845/ripple-marketplace/listings/listing_1754672843_l9z1x.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672853/ripple-marketplace/listings/listing_1754672852_zydgn7.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672861/ripple-marketplace/listings/listing_1754672860_couqys.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672869/ripple-marketplace/listings/listing_1754672868_yucxc.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672960/ripple-marketplace/listings/listing_1754672958_qdqct.webp"]', '["women clothes","Frok","Dresses","Cute Dress","Round Neck","FrockFashion","InstaStyle","CasualDress","ElegantStyle","ModernFashion","EverydayWear"]', 'approved', 56, '2025-08-08 17:15:52', '2025-08-26 18:58:16', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 20, 20, 5, NULL, NULL),
('0043c32f-a99f-4fe7-b747-7ba1f1742e52', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Apricot Visionary Flora Frayed Boxy Tee', 'Perception shapes reality.
This boxy-fit T-shirt merges surrealism with natural form, showcasing flowers with delicate, traditional petals and stems that subtly resemble retinas a symbolic reminder that what we see isn’t always what is. The design features kanji meaning:
"Someone who appears calm and quiet might actually have profound thoughts and emotions."

🔹 Oversized, structured silhouette with raw frayed edges
🔹 Hand-drawn artwork layered with depth and intention
🔹 A Surreal Elysium exclusive – not just a T-shirt, but a philosophy made wearable

See deeper. Think deeper. Order now. ', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364411/ripple-marketplace/listings/listing_1754364398_f08set.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364414/ripple-marketplace/listings/listing_1754364402_zvgbs.jpg"]', '["apricot frayed boxy tee"]', 'approved', 16, '2025-08-05 03:28:33', '2025-08-16 01:18:45', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('039e11d0-16c9-4108-8680-5d9c62ef9018', '1314b0cf-559b-43db-b13c-507a12d8e520', 'CRYPTO UNCENSORED ~ SERIES 1', 'This item is an educational ebook mainly produced for the serialization and sensitization of those who don''t know how to go about the world of “CRYPTO” 
From the baseline to the main things to know about how it started and where its at currently and also the hidden things that even experts didn''t know existed in this space 

', '5.00000000', 'books', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'evm', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754523360/ripple-marketplace/listings/listing_1754523354_3294ig.png"]', '["Books","Crypto","Author","Web3","Money"]', 'approved', 176, '2025-08-06 23:36:12', '2025-08-11 21:11:20', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('058f76ef-6b8e-45be-93a0-9217c731b45e', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'Square Neck Skater Dress', 'Product specific (Avg. measurement - inches)

Chest: XS - 31 , S -32.5  , M -34.5  , L -36.5  , XL - 38.5 , XXL - 40.5

 

Material: POLYESTER
Color: NAVY BLUE FLORAL PRINTED

Fit Type: REGULAR FIT

Stretch: No Stretch
Style: Square Neck,  Puff Sleeves

Accessories: ZIPPER
Model Size: S

Wash & Care: Normal Wash


Note: Product Colour May Slightly Vary Due To Photographic Lighting Sources Or Your Monitor Setting.

 ', '29.99000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754810376/ripple-marketplace/listings/listing_1754810373_txznuh.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754810383/ripple-marketplace/listings/listing_1754810381_6h2fx4.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754810388/ripple-marketplace/listings/listing_1754810387_5dpdxo.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754810395/ripple-marketplace/listings/listing_1754810393_9thqze.webp"]', '["women clothes","Frok","Dresses","Cute Dress","Round Neck","FrockFashion","InstaStyle","CasualDress","ElegantStyle","ModernFashion","EverydayWear"]', 'approved', 102, '2025-08-10 07:20:58', '2025-08-23 14:28:19', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 10, 10, 3, NULL, NULL),
('0761d10c-6299-4e3f-b1d2-83659c58521f', '039d7712-5163-4dd6-8fd9-887e6f8289a9', 'HP EliteBook 850 G3 ', 'HP Laptop in Good Condition - Fully Functional with Windows 11 Pro Installed!
Up for sale is a reliable HP laptop that''s ready to go right out of the box. This unit is in good overall condition with only minor cosmetic wear (like light scratches or scuffs from normal use), but nothing that affects its performance. It''s been well-maintained and is fully functional, powering through everyday tasks with ease.
Key Features:

Pre-installed with genuine Windows 11 Pro for a smooth, secure, and up-to-date operating system.
Perfect for work, school, browsing, streaming, or light productivity.
All ports, keyboard, trackpad, and display are in excellent working order—no issues whatsoever.

This laptop has been tested and is running like a champ. It''s a great value for anyone looking for an affordable, dependable machine without the bells and whistles of a brand-new model. Comes with the charger 
Condition Details: Good used condition with minor cosmetic imperfections, but structurally sound and 100% operational.
Shipping is fast and secure—I''ll pack it carefully to ensure it arrives safely. Local pickup available if you''re in the area. Feel free to ask any questions before bidding!
No returns on electronics, sold as-is. Thanks for looking!', '88.50000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383053/ripple-marketplace/listings/listing_1755383053_zd4ce5.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383053/ripple-marketplace/listings/listing_1755383054_0oy17k.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383054/ripple-marketplace/listings/listing_1755383055_gfmelp.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383096/ripple-marketplace/listings/listing_1755383097_szwki.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383112/ripple-marketplace/listings/listing_1755383113_f5woxf.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383113/ripple-marketplace/listings/listing_1755383113_3acss.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383113/ripple-marketplace/listings/listing_1755383114_mi7msq.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383114/ripple-marketplace/listings/listing_1755383115_35lhrq.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383115/ripple-marketplace/listings/listing_1755383115_r1rlo.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755383150/ripple-marketplace/listings/listing_1755383151_vsleh.png"]', '["Laptop","HP","EliteBook","PC"]', 'approved', 262, '2025-08-16 22:28:26', '2025-09-04 00:45:50', 1, '88.50000000', '88.50000000', '10.00000000', '2025-08-23 22:27:00', NULL, 'active', 1, 1, 5, NULL, NULL),
('0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Testing Escrow', 'This is the file', '1.00000000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754042987/ripple-marketplace/listings/listing_1754042985_i16kgx.png"]', '[]', 'sold', 120, '2025-08-01 10:09:51', '2025-08-01 14:52:55', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('0e7f1de4-1b41-4766-b04f-afb83a1ef4c5', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Airtel 5g Router (Used)', 'Unlock next-gen speed with this reliable, used Airtel 5G Router! Experience lightning-fast internet for all your streaming, gaming, and work needs. Connect multiple devices effortlessly via robust Wi-Fi.

This pre-loved router offers an incredibly affordable way to bring powerful 5G connectivity into your home or office. Fully tested and ready to deploy. Grab premium performance for a fraction of the cost – upgrade your internet today!', '20.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'sui', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758916739/ripple-marketplace/listings/listing_1758916737_6qi7zq.jpg"]', '["rare", "vintage"]', 'approved', 14, '2025-09-26 20:00:48', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 100, 100, 5, NULL, '{"city": "Newark", "phone": "07044831729", "state": "DE", "street": "100 David Hollowell Drive", "country": "US", "zipCode": "19711"}'),
('0fc3fa65-8f4c-4284-ba04-cc35f4dc0a06', 'b0c19acc-8207-41a4-bcf4-316c098ddd9f', 'Invicta I-Force 25272 Men''s Chronograph 50mm Black & Gold- Japanese Quartz, Silicone/Stainless Band', 'The Invicta I-Force Model 25272 features a robust 50mm gold-tone stainless steel case, paired with a black silicone strap with gold-tone accents. It''s powered by a Japanese Quartz chronograph movement, offering 60-sec, 60-min, and 24 hour subdials, and backed by a 100m/330 ft water resistance rating. ', '80.99000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435983/ripple-marketplace/listings/listing_1754435982_51173.heic","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435989/ripple-marketplace/listings/listing_1754435989_bv64g6.heic","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435994/ripple-marketplace/listings/listing_1754435994_i9l3rd.heic"]', '[]', 'approved', 189, '2025-08-05 23:20:27', '2025-10-01 18:07:06', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('0fdc7b44-0966-48c2-8f9c-ecc96da582e6', 'b0c19acc-8207-41a4-bcf4-316c098ddd9f', 'Invicta stainless‑steel chronograph watch', 'Stainless steel chronograph watch, part of the pro diver and speciality line. Silver dial, polyurethane strap, and the familiar oversized styling.', '100.00000000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754094845/ripple-marketplace/listings/listing_1754094822_daiah5.jpg"]', '[]', 'approved', 1100, '2025-08-02 00:34:14', '2025-10-06 18:30:16', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('12ac6960-996d-4d77-9c07-1dce871df20f', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Tesst2 Auction', 'THIS IS A TESST ITEM_ DO NOT BUY', '0.02000000', 'sports-recreation', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754900875/ripple-marketplace/listings/listing_1754900875_kfy00e.jpg"]', '["test","auction","bid"]', 'approved', 232, '2025-08-11 08:28:07', '2025-10-01 09:56:49', 1, '1.00000000', '1.00000000', '10.00000000', '2025-08-18 08:27:00', NULL, 'active', 20, 20, 5, NULL, NULL),
('135ae0f9-d156-4207-9f28-95f616070f36', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Apricot Chase the Vision Frayed Boxy Tee', '👁️ What we see is limited by what we understand. 👁️
This boxy-fit graphic T-shirt features a flying eyeball escaping grasping skeleton hands, symbolizing the relentless pursuit of knowledge and ambition. Designed with frayed edges for added texture, this piece embodies the essence of existential and surreal streetwear.

🔹 Premium heavyweight cotton with a structured fit.
🔹 Frayed edges for an edgy, worn-in feel.
🔹 Exclusive to Surreal Elysium – Designed for the visionaries.

Chase the vision before it flies away. Get yours now.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754365057/ripple-marketplace/listings/listing_1754365044_mr46ag.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754365065/ripple-marketplace/listings/listing_1754365052_pe5o4v.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754365071/ripple-marketplace/listings/listing_1754365056_1oivag.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754365076/ripple-marketplace/listings/listing_1754365063_mvlda3.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754365081/ripple-marketplace/listings/listing_1754365068_g2p5l8.jpg"]', '["apricot frayed boxy tee"]', 'approved', 64, '2025-08-05 03:38:24', '2025-08-20 12:48:30', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('139365cc-a9d4-4979-a3ec-a3637696af74', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Escentric 04 Escentric Molecules', 'Molecule instead of mass: "Less" is often "more" in the world of perfumes. At the heart of Escentric Molecules 04 is the molecule Javanol, which takes sandalwood into a new dimension. Molecule 04 contains pure Javanol, Escentric 04 surraunds it with aromas of grapefruit, juniper, osmanthus, rose, matic and galbanum." - a note from the brand.', '119.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757145672/ripple-marketplace/listings/listing_1757145670_xm2fb.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757145673/ripple-marketplace/listings/listing_1757145673_08nra.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757145674/ripple-marketplace/listings/listing_1757145674_stw27k.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757145675/ripple-marketplace/listings/listing_1757145675_3thyw8.jpg"]', '[]', 'approved', 115, '2025-09-06 08:04:36', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('1bb0338f-31d8-4400-a7ed-7b29f87c23d0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'MTN 5G Router', 'It''s a pre-owned MTN router', '60.00000000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1753741115/ripple-marketplace/listings/listing_1753741114_yqwmup.jpg"]', '[]', 'sold', 3, '2025-07-28 22:18:39', '2025-07-29 13:53:11', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('1cb6866d-b5a2-4e68-b2e9-6ff7ec75f4db', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Testing', 'This is a test listing, will be deleted soon, do not buy', '0.02000000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754250446/ripple-marketplace/listings/listing_1754250443_wtawuc.jpg"]', '[]', 'sold', 8, '2025-08-03 19:47:29', '2025-08-03 19:49:37', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('1d5cc3f4-a813-4af3-bf7b-31404d5338d9', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Oversize Crown of Ambition T-Shirt', 'The price of success, the weight of ambition.

Scotty sits engulfed in smoke, a blunt in hand, as ghostly apparitions rise from the embers, specters of past struggles, lingering doubts, and the weight of expectations. His red ruby crown melts into his eyes, a searing symbol of the immense pressure and pain that come with relentless ambition. Every hardship fuels his drive, every scar pushing him further in his pursuit of greatness.

Crown of Ambition is a visual manifestation of sacrifice the fine line between chasing success and numbing the pain it leaves behind. It embodies the hunger to break free from the past, to carve a new future, and to prove that struggle is the foundation of transformation.

At Surreal Elysium, we believe that ambition is forged in fire. This design is a reminder that we don’t just exist—we chase, we conquer, we endure.

Wear this piece as a testament to your unbreakable will and the journey to turn adversity into triumph.

🔹 Oversized fit for bold existential streetwear aesthetics.
🔹 Premium heavyweight cotton for comfort and durability.
🔹 Exclusive to Surreal Elysium – Where ambition meets artistry.

Crown of Ambition Poem

Pressure grips his soul with might, Weighing down in the depth of night.

 Pain fuels his unending fight, Dreams keep his ambitions in sight.

Through storms and trials, he forges on, Every hardship, a step toward dawn. 

With unyielding drive, he chases dreams, In success, his pain redeems. 

Burdened by the weight he bears, His spirit strong, he won''t despair. 

In a world where shadows betray, Through struggle and fire, he finds his way.

 For each drop of pain, each ounce of strain, He rises anew, defying the chain.

In pursuit of dreams, he reaches high, Transformed by fire, he touches the sky. 

From the ashes, arose a king, Triumphant, with a crown of dreams.

 In the kingdom of success, he''ll reign, Conquering all, he breaks the chains.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363610/ripple-marketplace/listings/listing_1754363597_81y77.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363674/ripple-marketplace/listings/listing_1754363662_ez62c9.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363713/ripple-marketplace/listings/listing_1754363701_6hldh.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363757/ripple-marketplace/listings/listing_1754363744_zs0gut.jpg"]', '["snow washed Surreal Elysium black T-shirt"]', 'approved', 39, '2025-08-05 03:16:47', '2025-08-28 00:40:31', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('1e7baa15-f0b3-4c52-85fd-2dc9d5fbbe68', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Oversize Embers of Exhaled Woe T-Shirt', 'The fire within.. destructive yet inescapable.

Scotty exhales flames from his mouth and eyes, only to French inhale the fire back in, caught in an endless cycle of self-inflicted suffering. The burning embers symbolize the searing pain of past wounds, while the act of breathing them in again reflects the haunting nature of self-sabotage, knowing the damage yet unable to break free.

Embers of Exhaled Woe is a visceral portrayal of internal struggle, a reminder of how pain, when left unchecked, can become an addiction of its own. It speaks to those who have felt trapped in their own destructive patterns, yet still search for the strength to rise from the ashes.

At Surreal Elysium, we confront the darkness head-on, transforming raw emotion into art. This design stands as a testament to the battle for self-acceptance, the fight to let go, and the resilience to rewrite one’s story.

Wear this piece as a symbol of your strength—the determination to break free and forge a new path.

🔹 Premium heavyweight cotton with a vintage wash.
🔹 Oversized fit for effortless streetwear appeal.
🔹 Exclusive to Surreal Elysium – Wear your story.

Embers Of Exhaled Woe

In shadows deep, where anguish flows,

Lies the specter no one knows.

A skull adorned with eyes of flame,

Exhales regret, consuming shame.

Embers born of wretched breath,

Ignite the night, a dance with death.

With every flame, a truth untold,

In twisted smoke, despair unfolds.

A blaze that rages from within,

Burns bright the scars of every sin.

Consumed within, the fire grows,

As self-inflicted sorrow shows.

The mirror shows a haunting guise,

A ghostly mask with fiery eyes.

From depths of pain, where echoes grow,

Rise the embers of exhaled woe.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362624/ripple-marketplace/listings/listing_1754362612_x20e3h.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362713/ripple-marketplace/listings/listing_1754362700_g9bk4km.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362795/ripple-marketplace/listings/listing_1754362782_4oxzt7.jpg"]', '["snow washed Surreal Elysium Black T-Shirt"]', 'approved', 13, '2025-08-05 03:02:12', '2025-09-08 16:02:02', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('25a1a83c-3c15-4b7f-84a2-36c3d11d5ca1', '2a46ff9e-eb44-4dbb-9f9b-c5600f5fa827', 'Red Dragon - Articulated - 3D Print', 'Articulated 3D Printed Dragon
(Price includes shipping)', '24.99000000', 'art', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754409526/ripple-marketplace/listings/listing_1754409525_lh7jf.jpg"]', '["Dragon","3D print","collectibles"]', 'approved', 64, '2025-08-05 16:00:51', '2025-10-02 22:39:35', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('2ca64b92-cb5c-441c-9c98-2cd8eef7da45', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Chase the Vision Frayed Boxy Tee', '👁️ What we see is limited by what we understand. 👁️
This boxy-fit graphic T-shirt features a flying eyeball escaping grasping skeleton hands, symbolizing the relentless pursuit of knowledge and ambition. Designed with frayed edges for added texture, this piece embodies the essence of existential and surreal streetwear.

🔹 Premium heavyweight cotton with a structured fit.
🔹 Frayed edges for an edgy, worn-in feel.
🔹 Exclusive to Surreal Elysium – Designed for the visionaries.

Chase the vision before it flies away. Get yours now.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364762/ripple-marketplace/listings/listing_1754364749_33hyts.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364766/ripple-marketplace/listings/listing_1754364754_hcbz3m.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364776/ripple-marketplace/listings/listing_1754364763_hy56i.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364799/ripple-marketplace/listings/listing_1754364787_7aw5pt.jpg"]', '["white frayed boxy tee"]', 'approved', 45, '2025-08-05 03:34:35', '2025-09-26 21:38:01', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('33dbeac7-6996-49f8-a2dc-b974e7399d8e', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Guerlain La Petite Robe Noir Eau De Parfum 100ML', '
amazing perfume-orginal

Top notes are Sour Cherry, Almond, Red Berries and Bergamot; middle notes are Licorice, Rose, Tea and Taif Rose; base notes are Vanilla, Anise, Tonka Bean, Patchouli and Iris', '55.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757527478/ripple-marketplace/listings/listing_1757527474_tmdlak.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757527480/ripple-marketplace/listings/listing_1757527479_jc2c1.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757527484/ripple-marketplace/listings/listing_1757527481_35f4ca.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757527488/ripple-marketplace/listings/listing_1757527485_690124.jpg"]', '[]', 'approved', 130, '2025-09-10 18:08:12', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('36bc8611-4313-44de-8fe3-72f93f665bf5', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'Owl Night Lamp ', 'Owl Lamp – Wisdom Illuminated
Grace your space with the timeless elegance of the Owl Lamp, a perfect blend of artistry and function. Symbolizing wisdom and mystery, the sculpted owl form brings character and sophistication to any room. When lit, it casts a warm, soothing glow—creating an inviting atmosphere for cozy evenings, study sessions, or quiet reflection.

Crafted with precision, this lamp is more than a light source—it’s a collectible statement piece. Its intricate detailing and modern design make it a stunning addition to living rooms, bedrooms, or workspaces. Ideal for gifting or curating your own unique décor, the Owl Lamp embodies both beauty and meaning.', '25.00000000', 'home-garden', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755501030/ripple-marketplace/listings/listing_1755501026_7as7h.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755501043/ripple-marketplace/listings/listing_1755501041_b3ct5o.jpg"]', '["Vase. Decoration. Collectibles. NIght Lamp"]', 'approved', 206, '2025-08-18 07:11:06', '2025-09-29 22:42:36', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 2, 2, 1, NULL, NULL),
('3b8ec793-62a8-4f1e-b6d9-e6de1a2258bf', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Phantom Test', 'This is a test for phantom wallet', '0.00100000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754255651/ripple-marketplace/listings/listing_1754255643_voag7s.jpg"]', '[]', 'approved', 1229, '2025-08-03 21:14:14', '2025-09-17 03:45:03', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('4593d2a0-d908-4802-a449-853e14fcfc62', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'Fox Night Lamp', 'Fox Lamp – A Touch of Whimsy & Warmth
Bring charm and character into your space with this beautifully designed Fox Lamp. Inspired by the elegance of a fox, its sculpted form blends artistic design with functional lighting. The lamp casts a soft, ambient glow that creates a cozy atmosphere, perfect for bedrooms, living rooms, or creative corners.

Crafted with precision and care, the Fox Lamp doubles as both décor and light source—a collectible piece that sparks conversation while brightening your home. Its unique design makes it an ideal gift for art lovers, nature enthusiasts, and those who appreciate one-of-a-kind creations.', '25.00000000', 'home-garden', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500900/ripple-marketplace/listings/listing_1755500896_9rcr9k.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500911/ripple-marketplace/listings/listing_1755500907_uddl1.png"]', '["Vase. Decoration. Collectibles. NIght Lamp"]', 'approved', 74, '2025-08-18 07:09:12', '2025-09-29 22:42:48', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 2, NULL, NULL),
('4c1bea84-7c10-4bc5-b262-e1ecfeb6d9b1', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Visionary Flora Frayed Boxy Tee', 'Perception shapes reality.
This boxy-fit T-shirt merges surrealism with natural form, showcasing flowers with delicate, traditional petals and stems that subtly resemble retinas a symbolic reminder that what we see isn’t always what is. The design features kanji meaning:
"Someone who appears calm and quiet might actually have profound thoughts and emotions."

🔹 Oversized, structured silhouette with raw frayed edges
🔹 Hand-drawn artwork layered with depth and intention
🔹 A Surreal Elysium exclusive – not just a T-shirt, but a philosophy made wearable

See deeper. Think deeper. Order now. ', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364195/ripple-marketplace/listings/listing_1754364182_94pxhl.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754364201/ripple-marketplace/listings/listing_1754364189_u6seua.jpg"]', '["frayed white boxy tee"]', 'approved', 16, '2025-08-05 03:25:56', '2025-08-10 21:49:49', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('4e296b14-1f18-4b92-a8fc-4fa6b132d5b8', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Testing Auction', 'This is an item i''m using to tesst the auction feature - DO NOT BUY', '0.02000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754900738/ripple-marketplace/listings/listing_1754900737_c99df.jpg"]', '["vintage","rare","auction","bid"]', 'approved', 105, '2025-08-11 08:26:47', '2025-10-02 22:41:24', 1, '1.00000000', '21.00000000', '10.00000000', '2025-09-10 00:25:00', NULL, 'active', 20, 20, 5, NULL, NULL),
('56dde193-c0cf-418c-b93f-c9a8de1bd088', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Test phone', 'Introducing the ''Test Phone'' – engineered for unwavering performance and everyday reliability. Forget the fuss; this device delivers essential features with precision. Enjoy crystal-clear calls, seamless messaging, and a battery that powers your day. Built with robust materials and rigorously tested for durability, it’s designed to simply work, every time. Experience straightforward, dependable technology. Grab your ultimate reliable companion now!', '1.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'sui', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759499767/ripple-marketplace/listings/listing_1759499762_hy6hxh.jpg"]', '["Rare"]', 'approved', 109, '2025-10-03 13:57:14', '2025-10-07 17:34:57', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, '{"city": "Newark", "phone": "07044831729", "state": "Delaware", "street": "100 David hollowell drive ", "weight": 0.19, "country": "United States", "zipCode": "19711", "dimensions": {"width": 7.5, "height": 0.8, "length": 16}, "validatedAddress": {"name": "SHIPPING ADDRESS", "email": null, "phone": "07044831729", "postal_code": "19716-7499", "company_name": null, "country_code": "US", "address_line1": "100 DAVID HOLLOWELL DR", "address_line2": "", "address_line3": null, "city_locality": "NEWARK", "state_province": "DE", "address_residential_indicator": "unknown"}, "validationStatus": "verified"}'),
('574603ea-2882-418f-98b7-8afda362d76e', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'LeBron James 13', 'LBJ 13 size 11 ', '50.00000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754492249/ripple-marketplace/listings/listing_1754492249_7xfugs.jpg"]', '["823300 060"]', 'sold', 4, '2025-08-06 15:01:24', '2025-08-20 00:44:45', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('57f1952d-8454-4c99-b9fb-624be70db745', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Lady million-Fabulous ', 'Lady million-eau de perfum 80ml
Authentic ', '80.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755901131/ripple-marketplace/listings/listing_1755901127_xgnns.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755901173/ripple-marketplace/listings/listing_1755901170_ewrux.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755901198/ripple-marketplace/listings/listing_1755901195_0xivxf.jpg"]', '[]', 'approved', 215, '2025-08-22 22:20:07', '2025-10-02 13:54:01', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('5819684f-f618-4d5b-9b9f-9d0aa2aaa884', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'HUF & DEE Women''s Box Neck T-Shirt Avocado Green', 'S, M, SL Sizes available

This Cotton fashion piece features a plain texture long sleeve with Box neckline.

Note: Product color may vary slightly due to different lighting conditions during photography and individual monitor settings.
We work with trusted and exceptional courier services to make sure your order is received safely on time. Delivery times will be from Monday to Saturday and will not occur on Sundays & Mercantile Holidays. There is an additional cost for delivery. Any orders placed on weekends will be dispatched on Monday. We will try our best to accommodate any special delivery instructions; however this may cause an extra delay from our normal delivery timings.

* We will try our best to deliver orders within the allocated delivery time. However there may be unforeseen circumstances that may cause a delivery to be delayed. If this occurs we apologize in advance and will aim to get the order to you as soon as we can.', '14.99000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409768/ripple-marketplace/listings/listing_1755409766_hp2x1l.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409773/ripple-marketplace/listings/listing_1755409772_zz8f3.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409779/ripple-marketplace/listings/listing_1755409779_9mevws.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409785/ripple-marketplace/listings/listing_1755409784_rtf784.webp","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409814/ripple-marketplace/listings/listing_1755409814_g2wr6s.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755409825/ripple-marketplace/listings/listing_1755409825_rd5ror.png"]', '["women clothes","Box Neck T-Shirt"]', 'approved', 60, '2025-08-17 05:53:13', '2025-09-25 19:14:51', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 10, 10, 2, NULL, NULL),
('5929fba9-ab89-4979-b049-bb23226ad7cc', '0d495d79-e9c5-49f6-a568-aff7e202f88f', 'Traxxas  Maxx 4s 55mph plus ➕️ ', '4s battery 
Remote control Car 
By Traxxas 
Model: maxx 4s 
Speed 55mph and more with UPGRADES 
FUN FOR ADULTS AND TEENS
FAST,DURABLE, RELAXING 😌, AND
THERAPEUTIC!!!
COMES WITH CONTROLLER
And battery 🔋 ', '499.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490799/ripple-marketplace/listings/listing_1754490798_aq4j3g.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490802/ripple-marketplace/listings/listing_1754490801_ga13jw.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490804/ripple-marketplace/listings/listing_1754490803_0wwchs.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490806/ripple-marketplace/listings/listing_1754490805_zf8h0y.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490808/ripple-marketplace/listings/listing_1754490808_b1n6ud.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490811/ripple-marketplace/listings/listing_1754490810_mmzxq.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754490813/ripple-marketplace/listings/listing_1754490812_xbjc8.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754491169/ripple-marketplace/listings/listing_1754491168_zka9pf.jpg"]', '[]', 'approved', 501, '2025-08-06 14:41:25', '2025-09-18 14:45:57', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('76d03cb8-6c11-41f3-b1c6-955f5d5ab64e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Airtel 5g Router', 'It''s just a fucking router', '50.00000000', 'utility', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1753740900/ripple-marketplace/listings/listing_1753740899_fxisn.jpg"]', '[]', 'rejected', 0, '2025-07-28 22:17:09', '2025-08-04 18:22:52', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('78a90e4a-b4bd-47ab-885f-abda97b7a3c0', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'LBJ 13 Shoes', 'LBJ 13 size 11', '50.00000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1756337363/ripple-marketplace/listings/listing_1756337362_zfd7b.jpg"]', '["LBJ 13 shoe 823300 060"]', 'approved', 250, '2025-08-27 23:31:50', '2025-10-03 08:05:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('7e964bfa-edf1-4fbd-b61a-79a44d977067', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'Cross iPhone Cases', 'iPhone 13 & 14 model cases with cross design (includes shipping)', '10.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754444729/ripple-marketplace/listings/listing_1754444729_uqyeqf.jpg"]', '["iPhone Case"]', 'sold', 88, '2025-08-06 01:45:53', '2025-08-19 22:47:27', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('7f6a2b0d-22ce-4483-94ff-089086e1dcdb', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'Grammarly Personal Premium Account', 'Premium features for 1 month
For plugin for words
After place order please provide email address to us through lazada chat.
Stable account.
One order for one device.
You need contact us to get the login code. 
For personal account, please provide email to us after place order.', '19.99000000', 'services', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754835127/ripple-marketplace/listings/listing_1754835126_l0dkb.png"]', '[]', 'approved', 20, '2025-08-10 14:14:01', '2025-08-16 20:20:02', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 5, 5, 2, NULL, NULL),
('8c03c509-715b-4819-a11c-f4528efa4ebf', 'b0c19acc-8207-41a4-bcf4-316c098ddd9f', 'Invicta Chronograph, Pro Diver or Bolt Series ', 'Gently used. Fully functional with minimal wear. Crystal and case is in excellent shape, strap shows very light signs of use. See Photos for full details. 
Sale will be watch only. Securely packaged with tracking. ', '80.00000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435054/ripple-marketplace/listings/listing_1754435053_gz211o.heic","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435061/ripple-marketplace/listings/listing_1754435061_wcy2v5.heic","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754435066/ripple-marketplace/listings/listing_1754435067_8iqvu0s.heic"]', '[]', 'approved', 50, '2025-08-05 23:04:35', '2025-09-08 23:10:06', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('8f82551a-1ff6-4d36-8492-216652260d6e', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Polo-black', 'Polo black - eau de toilette
Authentic 100ml 
', '40.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900612/ripple-marketplace/listings/listing_1755900609_ewjs6l.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900662/ripple-marketplace/listings/listing_1755900659_9r9ux.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900688/ripple-marketplace/listings/listing_1755900684_r8rvsx.jpg"]', '[]', 'approved', 212, '2025-08-22 22:11:36', '2025-09-26 19:46:09', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('94653e10-4b4e-4608-b3c6-d578e61ff541', '1d9db35c-e67d-4915-bf02-54d9e9bc7736', 'Free eagle ', 'Eagles fly best when there have all the free space to fly
A caged eagle could forget how to fly

Your freedom
Your advantage!', '2.00000000', 'digital-virtual', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'evm', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758469327/ripple-marketplace/listings/listing_1758469315_fpxrt3.jpg"]', '["#NFT"]', 'pending', 0, '2025-09-21 15:42:29', '2025-09-21 15:42:29', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('9488ba9a-a715-476f-a7c7-2ce157a2f5c9', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Ferrari ', 'Own a legend. This exquisite physical Ferrari product captures the exhilarating spirit and unparalleled design of the world''s most iconic marque. Meticulously crafted with stunning precision, it''s more than an item – it''s a tribute to speed, luxury, and engineering mastery. Perfect for display, this piece ignites passion and adds a touch of automotive greatness to any space. A timeless collectible for the true enthusiast.', '2000000.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'sui', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759342825/ripple-marketplace/listings/listing_1759342810_kf33hm.jpg"]', '["car"]', 'approved', 57, '2025-10-01 13:54:46', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, '{"city": "Port Harcourt", "phone": "07044831729", "state": "Rivers", "street": "26b Elijiji Street", "weight": "1234", "country": "Nigeria", "zipCode": "520052", "dimensions": {"width": "20", "height": "500", "length": "146"}}'),
('9a18fa66-dcc1-4954-942a-727761c50789', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Test Device - Infinix', 'Unlock precision with the ''Test Device - Infinix''.

This essential physical device offers a dedicated, authentic Infinix environment, purpose-built for rigorous app and software testing. Developers and QA professionals will appreciate its reliable performance and native accuracy, ensuring your innovations run flawlessly. Elevate your development workflow and perfect your projects. Test smarter, achieve more.', '0.09000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'sui', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759860220/ripple-marketplace/listings/listing_1759860217_vp8ild.jpg"]', '["rare", "test"]', 'approved', 2, '2025-10-07 18:04:44', '2025-10-07 18:07:26', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 12, 12, 5, NULL, '{"city": "Newark", "phone": "07044831729", "state": "Delaware", "street": "100 David hollowell drive", "weight": 0.2, "country": "United States", "zipCode": "19711", "dimensions": {"width": 7.7, "height": 0.8, "length": 16.5}, "validatedAddress": {"name": "SHIPPING ADDRESS", "email": null, "phone": "07044831729", "postal_code": "19716-7499", "company_name": null, "country_code": "US", "address_line1": "100 DAVID HOLLOWELL DR", "address_line2": "", "address_line3": null, "city_locality": "NEWARK", "state_province": "DE", "address_residential_indicator": "unknown"}, "validationStatus": "verified"}'),
('9b3e38ea-9a80-4286-8660-fdb52fb74bbd', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'Juicy Couture', 'Black Winter Boots style JC-Koala size 6', '75.00000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754432187/ripple-marketplace/listings/listing_1754432185_omitie.jpg"]', '["04337TJB B4337SW"]', 'approved', 60, '2025-08-05 22:20:13', '2025-08-24 07:49:39', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('9c6c1d36-d264-4b2c-bfe1-d1929c5977a4', '2a46ff9e-eb44-4dbb-9f9b-c5600f5fa827', 'Devil Tea Light (Light Included)', '3D printed Devil Tea Light with red light (price includes shipping) ', '12.99000000', 'art', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754368960/ripple-marketplace/listings/listing_1754368960_bd9gvi.jpg"]', '["Decoration","3D print","light","collectible"]', 'approved', 228, '2025-08-05 04:46:47', '2025-09-12 21:53:02', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('9fec8a56-fffa-4970-85d9-cedbd323dc7a', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Testing', 'Test item do not buy', '2.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755987714/ripple-marketplace/listings/listing_1755987713_1vfnd.png"]', '["vintage", "rare", "medicine", "test"]', 'approved', 300, '2025-08-23 22:22:48', '2025-10-03 02:08:31', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 10, 10, 5, NULL, NULL),
('ae741c42-e20d-40b5-b8a3-1b35d227dbf1', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'Cross iPhone Case', 'iPhone 13 & 14 model cases with cross design (includes shipping)', '10.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755643992/ripple-marketplace/listings/listing_1755643991_frdxr4.jpg"]', '["iPhone Case"]', 'approved', 280, '2025-08-19 22:53:57', '2025-09-25 10:46:47', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 100, 100, 5, NULL, NULL),
('b004ab4f-24a8-49b9-bd56-c5cfcc1734de', '039d7712-5163-4dd6-8fd9-887e6f8289a9', 'Apple earbuds wired lightning port OEM', 'Apple earbuds wired lightning port OEM NEW', '9.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755224577/ripple-marketplace/listings/listing_1755224573_bm3dbv.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755224580/ripple-marketplace/listings/listing_1755224579_ud5u6l.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755224582/ripple-marketplace/listings/listing_1755224582_ac17.jpg"]', '["Apple earbuds"]', 'approved', 142, '2025-08-15 02:23:26', '2025-09-18 04:10:04', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 3, 3, 5, NULL, NULL),
('b6cabb8a-1ead-4967-b071-19c37e60698c', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Amouage Epic Eau de perfum ', 'AMOUAGE EPIC - Ed Pefume 
Brand new for sale - Authentic ', '150.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900345/ripple-marketplace/listings/listing_1755900341_t89qk.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900373/ripple-marketplace/listings/listing_1755900370_wxkpfp.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755900397/ripple-marketplace/listings/listing_1755900394_56pbh5.jpg"]', '[]', 'approved', 122, '2025-08-22 22:06:39', '2025-09-10 17:22:42', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('b84550c1-0add-4bf4-9668-9b0d72ff13f8', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Oversize Eternal Contrast T-Shirt', 'A story stitched from longing, loss, and the quiet war for self-acceptance.

Scotty stands in haunting stillness beside the one he once loved, a figure of stark opposition. Draped in heavy blacks and muted greys, he wears the burden of inner demons, the weight of every doubt that ever whispered you are not enough.
By his side, the angel glows in soft white and pale grey, a vision of unconditional love close enough to feel, but forever just beyond reach.

Eternal Contrast speaks to the soul of the hopeless romantic, the ones who crave connection but wrestle daily with invisible wounds. It’s about the scars etched by love withheld, the walls we build from survival, and the slow, defiant journey back to believing we are worthy of something pure.

At Surreal Elysium, we don’t shy away from the raw and the broken, we transform it into something beautiful.
This piece isn''t just clothing; it''s a mirror for those who have stood between light and darkness and still chose to reach for hope.

Wear Eternal Contrast as a reminder:
You are not your shadows.
You are the courage to love anyway.

Eternal Contrast

In the quiet night, where dreams take flight, a heart aches for love''s tender light. Raised in shadows, without embrace, yearning for warmth, a longing to chase.

Each day a battle, self-worth’s cruel fight, haunted by doubts, seeking love’s light. Through darkened paths, a flicker gleams. Hope endures in a world of dreams.

With courage found in the depths of despair, A heart learns to love, a journey to share. In whispers of words, love will reside, a hopeless romantic, no longer denied.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362314/ripple-marketplace/listings/listing_1754362301_gbp6gh.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362372/ripple-marketplace/listings/listing_1754362359_dogae4.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362428/ripple-marketplace/listings/listing_1754362415_f7761n.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754362457/ripple-marketplace/listings/listing_1754362445_ppts8n.jpg"]', '["snow wash Surreal Elysium oversize black T-shirt"]', 'approved', 22, '2025-08-05 02:55:49', '2025-09-17 15:01:28', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('bbc8347b-bcfb-4350-877b-16d1a86244e5', '49944aa2-f8a9-4f49-a295-c0742c213662', 'Oversize Scotty''s Silent Agony T-Shirt', 'A reflection of solitude, struggle, and self-acceptance.

Alone, Scotty sits in silence, cigarette in one hand, a bottle in the other. His disheveled teeth, skinny arms, and widened rib cage embody the deep-seated insecurities that many silently endure. This design captures the weight of self-doubt, the fear of losing oneself to vices, and the ache of longing for a love that feels forever out of reach.

Scotty’s Silent Agony is more than an image, it’s an unfiltered look into the battles we fight within ourselves. It speaks to the struggle of self-acceptance, the fear of isolation, and the resilience required to confront one’s own demons.

At Surreal Elysium, we believe in giving voice to the emotions often left unspoken. This piece stands as a reminder that even in the darkest moments, there is strength in acknowledging your pain and facing it head-on.

Wear this design as a testament to your resilience the courage to confront your deepest insecurities and emerge stronger.

Scotty’s Silent Agony Poem

In the dark, where fears ignite, Alcohol and smoke take flight. Mirrors show a skewed disguise, Body image, plagued by lies.

In these battles, there''s a spark, A strength within to leave the dark. Courage blooms, and hope''s embrace, Guides the way to a brighter place.', '45.75000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363081/ripple-marketplace/listings/listing_1754363068_0s6jz.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363104/ripple-marketplace/listings/listing_1754363092_ird2ek.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363178/ripple-marketplace/listings/listing_1754363165_1n1g.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363198/ripple-marketplace/listings/listing_1754363185_mq6r1u.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363249/ripple-marketplace/listings/listing_1754363237_apz0rk.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754363324/ripple-marketplace/listings/listing_1754363311_sjr1kf.jpg"]', '["snow washed Surreal Elysium T-shirt black"]', 'approved', 32, '2025-08-05 03:10:13', '2025-08-09 02:15:03', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('bea5e2dd-6a2b-40ae-8bf1-55bdc5c2fdd1', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Auction Airtel 5G Router- Updated', 'This is an airtel 5g router but i''m using the listing to test auctions', '20.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'evm', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757944586/ripple-marketplace/listings/listing_1757944582_i7ctn.jpg", "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758650246/ripple-marketplace/listings/listing_1758650242_l6037.jpg"]', '["used", "5g", "rare"]', 'approved', 106, '2025-09-15 13:58:25', '2025-10-07 16:45:40', 1, '10.00000000', '10.00000000', '10.00000000', '2025-09-22 13:58:21', NULL, 'active', 10, 10, 5, NULL, '{"city": "Newark", "phone": "07044831729", "state": "DE", "street": "100 David Hollowell Drive", "country": "US", "zipCode": "19711"}'),
('c675e070-2cbf-4523-99d0-63f92059ede4', 'e001cc3e-819c-402f-8ca7-07b854377103', '151 Booster Bundle', '151 Booster Bundle listing is for 1 sealed booster bundle', '65.00000000', 'art-collectibles', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754356020/ripple-marketplace/listings/listing_1754356012_xse3mv.jpg"]', '["Pokémon","booster","bundle","pikachu","mew"]', 'approved', 64, '2025-08-05 01:07:46', '2025-08-20 15:55:28', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('d5a56ff1-3eb2-46ba-b2da-639b36315dfe', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'Designer Vase ', 'Sculptural Coral-Inspired Vase
This vase is more than a vessel—it’s a work of art. Featuring flowing, organic curves reminiscent of ocean corals and blossoming petals, its design strikes a perfect balance between modern minimalism and natural elegance. The matte ivory finish highlights its sculptural form, making it an eye-catching centerpiece whether styled with flowers or displayed on its own.

Crafted with precision through advanced 3D printing, this piece is lightweight, durable, and uniquely detailed. Its fluid silhouette invites light and shadow to play across its surface, creating a dynamic presence in any setting.

Perfect for collectors, design lovers, and those who appreciate timeless, ocean-inspired artistry, this vase adds a touch of refined sophistication to interiors of all styles.', '30.00000000', 'home', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500547/ripple-marketplace/listings/listing_1755500543_yy6mkv.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500570/ripple-marketplace/listings/listing_1755500567_fk8dc4.jpg"]', '["Vase. Decoration. Collectibles."]', 'approved', 40, '2025-08-18 07:03:30', '2025-09-07 22:54:43', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 2, 2, 1, NULL, NULL),
('d629a5de-13d6-4f5b-94dd-87f27df145b4', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'Shadowless Machoke 34/102 ', 'NM Shadowless Machoke 34/102 First product listed on Ripplebids', '10.00000000', 'collectibles', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754087463/ripple-marketplace/listings/listing_1754087459_8bq8a.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754087472/ripple-marketplace/listings/listing_1754087472_sqevte.webp"]', '[]', 'sold', 753, '2025-08-01 22:31:17', '2025-08-03 21:18:25', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('dafb7682-df9a-47b3-9e8c-bb5103373f24', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'A Milano Eau de Parfum 100ml', 'A Milano by Giorgio Armani is a Floral Woody Musk fragrance for women and men. A Milano was launched in 2021. Top notes are Citruses, Citron and elemi; middle notes are Wild Lavender and Cypress; base notes are Orris Root and White Musk.', '160.00000000', 'health-beauty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144563/ripple-marketplace/listings/listing_1757144559_0jpqz.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144564/ripple-marketplace/listings/listing_1757144564_1k9yvj.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144565/ripple-marketplace/listings/listing_1757144565_09zquf.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144566/ripple-marketplace/listings/listing_1757144566_cebmj.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144567/ripple-marketplace/listings/listing_1757144568_lj0u6.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757144568/ripple-marketplace/listings/listing_1757144569_hre004.jpg"]', '[]', 'approved', 63, '2025-09-06 07:44:21', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('e5c43931-44d5-4682-9c6f-c15370713ab9', 'bfbde9b2-f63b-44a2-8ae0-b06f3bcebd01', 'Mini Camera drone.  Tello Boost Combo', 'Mini Camera drone.  Tello Boost Combo.
Never used only open once to verify contents of box and take photo. 
A birthday present I got and never had time or a place to use it. Hoping to find someone that will be able to enjoy using it. 
Only mailing anywhere in the USA. Shipping and handling are covered in the price. ', '155.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754700510/ripple-marketplace/listings/listing_1754700510_rgarj.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754700511/ripple-marketplace/listings/listing_1754700511_igaape.jpg"]', '["Drones","camera","electronics","toys"]', 'approved', 138, '2025-08-09 00:51:25', '2025-09-04 00:48:20', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('e853165e-a48f-4d8b-80df-e68ab0b0c497', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'Jesus iPhone Cases', 'iPhone 13 & 14 model cases with Jesus Cross Design (includes shipping)', '10.00000000', 'electronics', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754444532/ripple-marketplace/listings/listing_1754444532_4zin5r.jpg"]', '["iPhone Case"]', 'approved', 85, '2025-08-06 01:43:33', '2025-09-23 10:31:02', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('eae96f0a-8f9b-430b-a2e3-133ed050e9f6', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'Coral Vase ', 'Coral-Inspired Vase
Bring the beauty of the ocean into your home with this elegant coral-style vase. Inspired by the natural forms of sea corals, its intricate design captures the essence of marine life while adding a modern artistic touch to your space. Perfect as a statement décor piece, it can be displayed on its own or paired with fresh or dried flowers.

Crafted with precision and care, this vase offers a unique 3D-printed texture that mimics the delicate branching of corals, creating depth and sophistication. Its lightweight yet durable build ensures it’s easy to handle while maintaining long-lasting quality.

Whether placed in a living room, bedroom, or office, this vase is sure to spark conversation and elevate your interior with a touch of coastal charm.', '22.89000000', 'home', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500218/ripple-marketplace/listings/listing_1755500211_dubp5.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500295/ripple-marketplace/listings/listing_1755500290_c30fr8.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755500313/ripple-marketplace/listings/listing_1755500309_9vh56.png"]', '["Vase. Decoration. Collectibles."]', 'approved', 9, '2025-08-18 06:59:28', '2025-09-09 19:01:03', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 5, 5, 2, NULL, NULL),
('f3a2441e-8e5e-4530-8e04-22720dce1c21', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'HUF & DEE Women''s Casual Pant', 'Note : Only Small & Medium Sizes are available
Description
These long, plain-textured viscose palazzo pants from HUF & DEE offer a comfortable and stylish option for everyday wear.

Note: Product color may vary slightly due to different lighting conditions during photography and individual monitor settings.
We work with trusted and exceptional courier services to make sure your order is received safely on time. Delivery times will be from Monday to Saturday and will not occur on Sundays & Mercantile Holidays. There is an additional cost for delivery. Any orders placed on weekends will be dispatched on Monday. We will try our best to accommodate any special delivery instructions; however this may cause an extra delay from our normal delivery timings.

* We will try our best to deliver orders within the allocated delivery time. However there may be unforeseen circumstances that may cause a delivery to be delayed. If this occurs we apologize in advance and will aim to get the order to you as soon as we can.', '12.99000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'solana', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672160/ripple-marketplace/listings/listing_1754672156_42gi4g.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672214/ripple-marketplace/listings/listing_1754672211_f4j6ol.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672222/ripple-marketplace/listings/listing_1754672220_haib5.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672230/ripple-marketplace/listings/listing_1754672227_d76kvn.png","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754672238/ripple-marketplace/listings/listing_1754672236_cbeebj.png"]', '["women clothes","pants","casual pants"]', 'approved', 48, '2025-08-08 17:00:05', '2025-08-20 05:06:07', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 100, 100, 5, NULL, NULL),
('fc7db510-c238-4042-97d7-b96113b928a4', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Bad Boy Le Parfum 100ml', 'op Ingredients: Hemp, Leather, Vetiver

Olfactive Family: AROMATIC Woody Amber

Top Notes: Hemp Accord, Grapefruit

Heart Notes: Sage, Geranium

Bottom Notes: Leather, Vetiver


*Top notes: First impression of a perfume, last 5-15 minutes after applying to skin.

*Heart notes: Start to come through as the top notes fade, last approximately 20-60 minutes.

*Base notes: The underlying aroma throughout the wear of the perfume. Lingers the longest on skin (up to 6 hours) after the other notes have faded.
', '90.00000000', 'fashion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'xrp', 0, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755626164/ripple-marketplace/listings/listing_1755626161_toouq.jpg","https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755626199/ripple-marketplace/listings/listing_1755626196_9udxxo.jpg"]', '[]', 'approved', 241, '2025-08-19 17:58:42', '2025-09-09 03:31:55', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 1, 1, 5, NULL, NULL),
('ff200ebb-92ca-43ed-bba2-5d819658bc92', '8966824e-28e4-4829-afb6-663ac276b7ad', 'T-Shirt', '**Your new go-to T-shirt has arrived!** Experience ultimate comfort and effortless style with this premium tee. Crafted from ultra-soft, breathable cotton, it feels incredible against your skin, perfect for all-day wear. Its classic, flattering fit makes it versatile for any look – layer it or wear it solo. Durable and designed to hold its shape, this T-shirt is built to last, maintaining its quality wash after wash. Upgrade your essentials with comfort that never quits.', '10.00000000', 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'eth', 1, '["https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758917496/ripple-marketplace/listings/listing_1758917460_fuzsxmj.jpg"]', '["fine", "cute"]', 'approved', 65, '2025-09-26 20:15:05', '2025-10-07 16:45:40', 0, NULL, NULL, '10.00000000', NULL, NULL, 'active', 10, 10, 5, NULL, '{"city": "Newark", "phone": "07044831729", "state": "DE", "street": "100 David Hollowell Drive", "weight": 0.45, "country": "US", "zipCode": "19711", "dimensions": {"width": 21, "height": 0.8, "length": 29}}');


-- Table structure for membership_tiers
DROP TABLE IF EXISTS `membership_tiers`;
CREATE TABLE `membership_tiers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` enum('basic','pro','premium') COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(20,8) DEFAULT '0.00000000',
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `membership_tiers_chk_1` CHECK (json_valid(`features`))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for membership_tiers
INSERT INTO `membership_tiers` (`id`, `name`, `price`, `features`, `created_at`) VALUES
(1, 'basic', '0E-8', '{"listings_limit": 5, "featured_listings": 0, "analytics": false}', '2025-07-28 18:20:26'),
(2, 'pro', '50.00000000', '{"listings_limit": 25, "featured_listings": 3, "analytics": true}', '2025-07-28 18:20:26'),
(3, 'premium', '100.00000000', '{"listings_limit": -1, "featured_listings": 10, "analytics": true, "priority_support": true}', '2025-07-28 18:20:26');


-- Table structure for messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `room_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `buyer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sent_by` enum('buyer','seller') COLLATE utf8mb4_general_ci NOT NULL,
  `reported` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for messages
INSERT INTO `messages` (`id`, `room_id`, `order_id`, `buyer_id`, `seller_id`, `message`, `image_url`, `sent_by`, `reported`, `created_at`, `updated_at`) VALUES
('0339b712-b757-4908-8752-64a87d66b523', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', NULL, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1754520454/ripple-marketplace/messages/message_1754520449_wm6mp.webp', 'buyer', 0, '2025-08-06 22:47:35', '2025-08-06 22:47:35'),
('08ed5df2-a8f0-4a9e-953c-c22978cdf942', 'ff22b58c-8a40-4846-8811-036a3eaf0582', 'ff22b58c-8a40-4846-8811-036a3eaf0582', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'hi', NULL, 'seller', 0, '2025-08-20 21:21:27', '2025-08-20 21:21:27'),
('3e637030-e151-4c48-8d6b-2ff658b7e08e', '6f87583c-c552-43b0-af06-051b68fe1b59', '6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', NULL, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759487135/ripple-marketplace/messages/message_1759487103_s9jfed.jpg', 'buyer', 0, '2025-10-03 10:25:38', '2025-10-03 10:25:38'),
('45965b32-c754-4ab4-850c-789c0a3d7d57', '0152fa74-d2c2-406b-9c29-b7bb19e22348', '0152fa74-d2c2-406b-9c29-b7bb19e22348', '8966824e-28e4-4829-afb6-663ac276b7ad', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'Hey dev was this just a test transaction?', NULL, 'seller', 0, '2025-08-06 23:22:44', '2025-08-06 23:22:44'),
('4b5f1e77-3b8a-4d87-ab06-f4888e35ae41', '6f87583c-c552-43b0-af06-051b68fe1b59', '6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'testing chat system', NULL, 'buyer', 0, '2025-10-03 10:24:32', '2025-10-03 10:24:32'),
('61d3da34-3f08-4804-a68f-adecfbb9f576', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'hi', NULL, 'buyer', 0, '2025-08-24 01:32:49', '2025-08-24 01:32:49'),
('a41c385b-b7b4-4bc6-8f3e-81664b0805ac', '6f87583c-c552-43b0-af06-051b68fe1b59', '6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'hello', NULL, 'buyer', 0, '2025-10-03 10:24:27', '2025-10-03 10:24:27'),
('a9894ef0-7a0a-458a-8e89-0dab9c94290b', '6f87583c-c552-43b0-af06-051b68fe1b59', '6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '🤩testing emojis too', NULL, 'buyer', 0, '2025-10-03 10:24:53', '2025-10-03 10:24:53'),
('ae743e04-464b-442b-9a5b-7c6f2de6b746', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'hi', NULL, 'buyer', 0, '2025-08-24 01:34:07', '2025-08-24 01:34:07'),
('b37a4608-c4e9-4212-9be4-a9bd2d3ee639', '6f87583c-c552-43b0-af06-051b68fe1b59', '6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'hey', NULL, 'buyer', 0, '2025-10-03 10:24:20', '2025-10-03 10:24:20'),
('d7b34768-e6f0-4d9b-867e-ee68928ef0cf', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'hello', NULL, 'buyer', 0, '2025-08-24 01:34:16', '2025-08-24 01:34:16'),
('dd93884c-e810-4f48-80c5-8622734b6445', '82f496fc-8338-4b2f-aa7f-069a9ed3e8cb', '82f496fc-8338-4b2f-aa7f-069a9ed3e8cb', '5728dce0-413f-49cb-b08d-76e7f06a01f0', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'hello', NULL, 'seller', 0, '2025-08-07 21:24:06', '2025-08-07 21:24:06'),
('e429e704-87a3-4708-b527-d7419187e216', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'yo', NULL, 'buyer', 0, '2025-08-06 22:47:22', '2025-08-06 22:47:22'),
('f2d44cb9-0153-4dd7-a760-b8f5246b94aa', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'hi', NULL, 'buyer', 0, '2025-08-06 22:46:19', '2025-08-06 22:46:19'),
('f6a46699-0f11-4947-a2e4-feb25b09e8ee', 'e6550e78-27bb-4324-bef2-c19328671a36', 'e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', NULL, 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755999894/ripple-marketplace/messages/message_1755999893_l6kwzj.png', 'buyer', 0, '2025-08-24 01:44:55', '2025-08-24 01:44:55');


-- Table structure for music_widget_settings
DROP TABLE IF EXISTS `music_widget_settings`;
CREATE TABLE `music_widget_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `widget_type` enum('spotify','soundcloud') COLLATE utf8mb4_general_ci NOT NULL,
  `widget_url` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_storefront_id` (`storefront_id`),
  CONSTRAINT `music_widget_settings_ibfk_1` FOREIGN KEY (`storefront_id`) REFERENCES `user_profiles` (`storefront_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for music_widget_settings
INSERT INTO `music_widget_settings` (`id`, `owner_id`, `storefront_id`, `widget_type`, `widget_url`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'spotify', 'https://open.spotify.com/embed/playlist/37i9dQZF1DX0XUsuxWHRQd', 1, '2025-09-05 20:11:06', '2025-09-05 20:11:06'),
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'soundcloud', 'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/1234567890', 1, '2025-09-05 20:11:06', '2025-09-05 20:11:06'),
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'spotify', 'https://open.spotify.com/embed/playlist/4k1dVoA4q8xMLJpB7ScDCe', 1, '2025-09-18 23:21:48', '2025-09-19 00:00:01'),
(4, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'spotify', 'https://open.spotify.com/playlist/5KyxVse59nEIyVTCRpfNVI?si=lZoPnYCLRKGKeYeiiz8Oaw', 1, '2025-09-22 17:31:07', '2025-09-22 17:31:07'),
(5, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'spotify', 'https://open.spotify.com/embed/playlist/0PWrunyRDpowsawWVYnDWi?si=f6f9f8923c3b41bd&pt=a854c463c626a60cf1b2ecae589efa7c', 0, '2025-09-23 13:33:02', '2025-09-23 13:33:02'),
(6, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'spotify', 'https://open.spotify.com/playlist/5KyxVse59nEIyVTCRpfNVI?', 0, '2025-10-02 23:08:15', '2025-10-02 23:08:15');


-- Table structure for notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` enum('wallet_setup','escrow_funded','order_received','payment_released','escrow_released') COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Additional notification data',
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_unread` (`user_id`,`is_read`),
  KEY `idx_type` (`type`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_chk_1` CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for notifications
INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `data`, `is_read`, `created_at`, `updated_at`) VALUES
('16291dd4-4450-4d9e-b3cf-2a04b0f33460', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"5ec61bd5-7b12-451a-9abc-3718937e6f62","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrp"}', 0, '2025-08-01 10:55:33', '2025-08-01 10:55:33'),
('1836c526-281b-400c-a5a3-bc8b6758f4e1', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"ceadf6bd-2f6d-4d39-95a2-574d7e58243f","listingId":"7e964bfa-edf1-4fbd-b61a-79a44d977067","amount":16566,"chain":"xrpl_evm"}', 0, '2025-08-06 15:34:25', '2025-08-06 15:34:25'),
('1ec0aab2-611c-4b49-b2e7-486ea38bc1a9', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"988183fb-535b-4683-8cf3-f3fa90bf3656","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 11:12:14', '2025-08-01 11:12:14'),
('2a230002-4be4-4dbe-9f18-5ed45f4072c1', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"fc7c4a93-46a8-4632-b476-4fafd198ba29","listingId":"1cb6866d-b5a2-4e68-b2e9-6ff7ec75f4db","chain":"xrpl"}', 0, '2025-08-03 19:49:37', '2025-08-03 19:49:37'),
('2c783326-9ecf-456d-9a54-f2931141c6f0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"60f57231-2d5a-4947-838d-79226839b28c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1,"chain":"xrp"}', 0, '2025-08-01 10:44:51', '2025-08-01 10:44:51'),
('30e8be81-f4db-4113-b683-0f652cb440dd', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"988183fb-535b-4683-8cf3-f3fa90bf3656","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1679,"chain":"xrpl_evm"}', 0, '2025-08-01 11:12:14', '2025-08-01 11:12:14'),
('33f626f8-35e5-4a3a-9e70-68ec814ab480', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"ab951a9c-1a8e-4578-ad97-fc03e7fe96c2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1651,"chain":"xrpl_evm"}', 0, '2025-08-01 12:57:17', '2025-08-01 12:57:17'),
('3ae17979-0a79-43fd-9f02-7c9650a73b65', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"29b2c804-abeb-4641-912f-a2e0912c986c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 11:20:55', '2025-08-01 11:20:55'),
('3ae51397-9b6a-475b-b778-4bfcddc57404', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"b4853eea-e51b-446c-9dcc-bd2cc75c2f33","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 12:19:32', '2025-08-01 12:19:32'),
('4cbeb188-90fb-4136-8245-c20790a367b5', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"dc5acc58-6cff-4e82-903e-dbe0e9b8525e","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1629,"chain":"xrpl_evm"}', 0, '2025-08-01 14:52:55', '2025-08-01 14:52:55'),
('510dc33b-374e-4296-8be9-8a4ca5203f85', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"50d2e36c-8b87-4725-8180-468008b3b0c7","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 12:11:44', '2025-08-01 12:11:44'),
('5531b32d-818f-4594-a289-2376667df3d0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"91e248d1-c6f0-4637-80b4-b66f2cd470e7","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1656,"chain":"xrpl_evm"}', 0, '2025-08-01 13:47:07', '2025-08-01 13:47:07'),
('5fff73aa-f13a-4836-8a8f-f1bad33ccc7d', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"ceadf6bd-2f6d-4d39-95a2-574d7e58243f","listingId":"7e964bfa-edf1-4fbd-b61a-79a44d977067","chain":"xrpl_evm"}', 0, '2025-08-06 15:34:25', '2025-08-06 15:34:25'),
('62455791-884d-4ce5-b47b-44252f5e1dc0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"ab951a9c-1a8e-4578-ad97-fc03e7fe96c2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 12:57:17', '2025-08-01 12:57:17'),
('65d858ca-9f1a-4bf0-8a3b-6341696c010d', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"8f32d095-d3ef-4953-851b-7bbcfa4b2f0c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 12:10:05', '2025-08-01 12:10:05'),
('66a0f3c4-1bb0-486f-8fe2-27b15689cc35', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"8f32d095-d3ef-4953-851b-7bbcfa4b2f0c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1656,"chain":"xrpl_evm"}', 0, '2025-08-01 12:10:05', '2025-08-01 12:10:05'),
('6ec2bc58-ef07-48f9-9e13-2c64548211f3', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"c4d77b9f-45a3-4156-ab0d-07ef800ebfc2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrp"}', 0, '2025-08-01 11:10:25', '2025-08-01 11:10:25'),
('76a56aac-e357-479a-9f1a-5b192f6dd30c', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"e8474845-f689-4cdf-9460-ee0de558cc5f","listingId":"d629a5de-13d6-4f5b-94dd-87f27df145b4","chain":"solana"}', 0, '2025-08-03 21:18:25', '2025-08-03 21:18:25'),
('7e63ceb9-c11b-4f70-984d-ad8d77e221b0', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"f2d18908-d592-4ce3-8d87-e6a9f5b26df2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1667,"chain":"xrpl_evm"}', 0, '2025-08-01 11:54:33', '2025-08-01 11:54:33'),
('815e4d53-6190-4546-baa3-908c549c23a2', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"b4853eea-e51b-446c-9dcc-bd2cc75c2f33","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1651,"chain":"xrpl_evm"}', 0, '2025-08-01 12:19:32', '2025-08-01 12:19:32'),
('86d900a3-b60e-435a-909d-e187e31d7b5a', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"f2d18908-d592-4ce3-8d87-e6a9f5b26df2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 11:54:33', '2025-08-01 11:54:33'),
('9445ddb0-fbfc-4a38-b14e-d231cabe3289', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"29b2c804-abeb-4641-912f-a2e0912c986c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1673,"chain":"xrpl_evm"}', 0, '2025-08-01 11:20:55', '2025-08-01 11:20:55'),
('9e1572af-8d9f-4014-a252-c640461634b8', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"e8474845-f689-4cdf-9460-ee0de558cc5f","listingId":"d629a5de-13d6-4f5b-94dd-87f27df145b4","amount":216967,"chain":"solana"}', 0, '2025-08-03 21:18:25', '2025-08-03 21:18:25'),
('9fa94748-30a4-4662-b21d-c95b6090cf13', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"41b2edbf-958c-4f64-9efe-d1bb20c10c32","listingId":"574603ea-2882-418f-98b7-8afda362d76e","chain":"xrpl_evm"}', 0, '2025-08-06 16:13:39', '2025-08-06 16:13:39'),
('affe51ab-d4d8-4d79-b487-32acb4e80497', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"dc5acc58-6cff-4e82-903e-dbe0e9b8525e","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 14:52:55', '2025-08-01 14:52:55'),
('b521722c-60c0-4c6e-b15e-9e79b9bb4417', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"fc7c4a93-46a8-4632-b476-4fafd198ba29","listingId":"1cb6866d-b5a2-4e68-b2e9-6ff7ec75f4db","amount":92,"chain":"xrpl"}', 0, '2025-08-03 19:49:37', '2025-08-03 19:49:37'),
('b751b420-dc81-4002-941b-f2ed2f9f05b8', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"50d2e36c-8b87-4725-8180-468008b3b0c7","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1656,"chain":"xrpl_evm"}', 0, '2025-08-01 12:11:44', '2025-08-01 12:11:44'),
('c1db489a-e8e3-4889-ae16-d68783490141', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"5050fb10-804c-4e2b-ac91-e72c1aac809e","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 12:41:34', '2025-08-01 12:41:34'),
('c26813d8-2d28-436e-97fc-33b8b4b899ba', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"53385328-fcf2-44bf-b172-96eca21afa6a","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrp"}', 0, '2025-08-01 11:01:35', '2025-08-01 11:01:35'),
('c44cfb9d-a221-49db-af9f-bced5c7aca4c', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"91e248d1-c6f0-4637-80b4-b66f2cd470e7","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrpl_evm"}', 0, '2025-08-01 13:47:07', '2025-08-01 13:47:07'),
('c4935597-9874-463e-9728-ce2c9e20eed3', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"41b2edbf-958c-4f64-9efe-d1bb20c10c32","listingId":"574603ea-2882-418f-98b7-8afda362d76e","amount":81929,"chain":"xrpl_evm"}', 0, '2025-08-06 16:13:39', '2025-08-06 16:13:39'),
('cb01b526-fd71-4de5-b2b3-fc79e5c133fb', '8966824e-28e4-4829-afb6-663ac276b7ad', 'wallet_setup', 'Set Up Your Wallet Address', 'You have received an order but need to set up your wallet address to receive payments. Please update your wallet settings.', '{"escrowId":"60f57231-2d5a-4947-838d-79226839b28c","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","chain":"xrp"}', 0, '2025-08-01 10:44:51', '2025-08-01 10:44:51'),
('ce99da75-b21f-40ce-8347-e2bdb2c74d2b', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"5ec61bd5-7b12-451a-9abc-3718937e6f62","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1,"chain":"xrp"}', 0, '2025-08-01 10:55:33', '2025-08-01 10:55:33'),
('e6b9a784-14b6-45a5-bf7f-8fbd9bcdd612', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"53385328-fcf2-44bf-b172-96eca21afa6a","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1,"chain":"xrp"}', 0, '2025-08-01 11:01:35', '2025-08-01 11:01:35'),
('ed912ce8-a343-4cd3-86fb-8818cc82a70e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"5050fb10-804c-4e2b-ac91-e72c1aac809e","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1645,"chain":"xrpl_evm"}', 0, '2025-08-01 12:41:34', '2025-08-01 12:41:34'),
('f1c9811b-1d31-4474-b85c-67eeedc5ecef', '8966824e-28e4-4829-afb6-663ac276b7ad', 'order_received', 'New Order Received', 'You have received a new order. The payment is held in escrow until delivery is confirmed.', '{"escrowId":"c4d77b9f-45a3-4156-ab0d-07ef800ebfc2","listingId":"0832401c-f0fe-43c8-ab21-ad7a2bc64f6e","amount":1,"chain":"xrp"}', 0, '2025-08-01 11:10:25', '2025-08-01 11:10:25');


-- Table structure for orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `buyer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `listing_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `buyer_wallet` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_wallet` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` decimal(20,8) NOT NULL,
  `order_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('pending','paid','shipped','delivered','cancelled','escrow_funded','completed') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `shipping_address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tracking_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_carrier` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_notes` text COLLATE utf8mb4_general_ci,
  `escrow_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_chain` enum('solana','xrpl','xrpl_evm','sui','eth','xrpb-sol','xrpb-evm') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `shipped_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `carrier_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'se-3051222',
  PRIMARY KEY (`id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `seller_id` (`seller_id`),
  KEY `listing_id` (`listing_id`),
  KEY `idx_escrow_id` (`escrow_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`),
  CONSTRAINT `orders_chk_1` CHECK (json_valid(`shipping_address`)),
  CONSTRAINT `orders_chk_2` CHECK (json_valid(`shipping_info`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for orders
INSERT INTO `orders` (`id`, `buyer_id`, `seller_id`, `listing_id`, `buyer_wallet`, `seller_wallet`, `amount`, `order_type`, `transaction_hash`, `status`, `shipping_address`, `created_at`, `updated_at`, `tracking_number`, `shipping_carrier`, `shipping_notes`, `escrow_id`, `payment_chain`, `shipping_info`, `shipped_at`, `delivered_at`, `quantity`, `carrier_id`) VALUES
('0152fa74-d2c2-406b-9c29-b7bb19e22348', '8966824e-28e4-4829-afb6-663ac276b7ad', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', '7e964bfa-edf1-4fbd-b61a-79a44d977067', NULL, NULL, '16566.00000000', 'purchase', NULL, 'escrow_funded', '{"address":"26b Elijiji Street Off Woji Road Port Harcourt","city":"Port Harcourt","state":"Rivers","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-08-06 15:34:27', '2025-08-06 15:34:26', NULL, NULL, NULL, 'ceadf6bd-2f6d-4d39-95a2-574d7e58243f', 'xrpl_evm', NULL, NULL, NULL, 1, 'se-3051222'),
('03a4aa33-6bfd-4ec9-90d5-dc630a9c72fd', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '1cb6866d-b5a2-4e68-b2e9-6ff7ec75f4db', NULL, NULL, '92.00000000', 'purchase', '54BCDFE190FAEE1E0BA1967439A28C9707229E9E572812CD1F744C32394E2828', 'completed', '{"address":"26b Elijiji Street Off Woji Road Port Harcourt","city":"Port Harcourt","state":"Rivers","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-08-03 19:49:38', '2025-08-03 21:25:12', NULL, NULL, NULL, 'fc7c4a93-46a8-4632-b476-4fafd198ba29', 'xrpl', NULL, NULL, NULL, 1, 'se-3051222'),
('1d1a65f6-c4ce-4e8b-af66-de8e8f7bc5ee', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1651.00000000', 'purchase', '0x174d9d68616a5bc3c59c8d3736fca542d66bda92fbf38a73d11d9b39003aa516', 'shipped', '{"address":"wdwv","city":"uygwyuvjfyv","state":"ywfvjvjvjvj","zipCode":"vjyvkubbu,b","country":"kubvyjv","phone":"09382717162"}', '2025-08-01 12:57:17', '2025-08-01 15:05:52', '12345678', 'UPS', 'None', 'ab951a9c-1a8e-4578-ad97-fc03e7fe96c2', 'xrpl_evm', NULL, '2025-08-01 15:05:52', NULL, 1, 'se-3051222'),
('26988c91-6c78-444a-abe4-8de2d83335ec', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17729.07780768', 'purchase', '0x0e3d915bc742260ab904c011ff4cee8cd30df8449c0e67ed68e0195e5aafcf61', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 11:07:32', '2025-10-03 11:07:32', NULL, NULL, NULL, '51a255d5-2e26-4eef-a830-62f4ffa918ac', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('312069b5-656e-4ee0-8638-c83fe45f68c6', NULL, '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17714.20455067', 'purchase', '0x3942d350bedf82f8ac72ae3775e522b31b03f16aa616cd4ba02867a6f2b6252b', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 09:40:49', '2025-10-03 09:40:49', NULL, NULL, NULL, '8bfe8e6f-9bef-4ba8-b8f8-10645a6b4499', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('3134cb0a-dc21-4ca6-96ac-a575983fb2c8', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1629.00000000', 'purchase', '0xb2bc1c0158e7c4c0d55361ff3d9f5ae8f22dff510631938284e89e47acfe12f2', 'delivered', '{"address":"26b Elijiji Street, Off Woji Road","city":"Port Harcourt","state":"Rivers State","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-08-01 14:52:55', '2025-08-03 21:25:08', '4039201049', 'UPS', 'None', 'dc5acc58-6cff-4e82-903e-dbe0e9b8525e', 'xrpl_evm', NULL, '2025-08-01 15:02:59', '2025-08-03 21:25:08', 1, 'se-3051222'),
('33a3e90e-d1c4-41d4-aa26-e508f2755fbd', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', 'ATfhapTLwrPzqEQBywirrTw7BGWaDmaGkMXtPyHtzh3F', 'devtomiwa9', '40209.08725372', 'purchase', '2HNNrWXrcbbwrPdB6DsaL7jivjb6Lg1ZatPZMmZnRSL1AnoiiCRrmnhJqbyebNj5iC2Z3yjnEXeqkSFpSVi94n82', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 20:41:34', '2025-10-03 20:41:34', NULL, NULL, NULL, '3a86b663-560b-42b0-9704-447a1145bf80', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('3b10fe36-baff-4bee-96e6-26e1f174e867', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '9a18fa66-dcc1-4954-942a-727761c50789', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', 'devtomiwa9', '0.02593660', 'purchase', '74JPjP9yBdBUTJ6mFqVGK84rea7vHAudGb3JqevczRyZ', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-07 18:06:53', '2025-10-07 18:06:53', NULL, NULL, NULL, '6c233399-84f5-4ff1-8365-b07b0bf8825d', 'sui', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('473d1bc1-8522-4aa8-a921-8af86cfe4c48', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '0.00022084', 'purchase', '0xab5372dc3b2c33420c36d811e36c089553b36e5a84d7641740f8aca95bd000c9', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-04 00:07:05', '2025-10-04 00:07:05', NULL, NULL, NULL, '9072a966-d44b-4c4a-b88c-d6627b8bccb1', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('61f6ccf9-8c49-4b5c-ab7a-6e0cb821d482', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17731.05215702', 'purchase', '0x02f3c39162f87a05a1d3a53afb9870f2ad47af38c024c18d80693002cd649697', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 10:07:26', '2025-10-03 10:07:26', NULL, NULL, NULL, 'f43b6eaf-1d8c-40aa-a8ac-5af9f09b2f34', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('69646269-d161-4ff0-8f03-8d7646542bb2', NULL, '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17731.05215702', 'purchase', '0xfa8e2e7c9bc7d589b542eabac1dce30607cbeedfa52dbc3ce7971b9eeca44e54', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 10:01:11', '2025-10-03 10:01:11', NULL, NULL, NULL, '8a74f10b-d503-4ab7-8c94-0bb181a75990', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('6f87583c-c552-43b0-af06-051b68fe1b59', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17731.05215702', 'purchase', '0x141c160eec0b822d237fc4840da0bf50eea369ee4ab68f76651bd285be4c96f7', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 10:09:20', '2025-10-03 10:09:20', NULL, NULL, NULL, '26e00962-8d0b-4a98-808a-072d03833abe', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('745049dd-f6c2-4614-9203-01147acd6544', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '0.00022283', 'purchase', '0x005f729279eef813e5dc13f38ae9f1ba74ddd16aafee5d2159174f098c484633', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-04 03:35:53', '2025-10-04 03:35:53', NULL, NULL, NULL, '381bd6d1-96c7-4648-9b89-f75f53cb1140', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('81e77e75-dcb1-4056-a6df-c6e905c2f709', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17729.07780768', 'purchase', '0x1b0ddb75a72f02d17e818f4b49644b90acfcf6419d86537dd6d1eb3dce1ea753', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 11:09:43', '2025-10-03 11:09:43', NULL, NULL, NULL, 'e6d422b8-9ee7-4d01-b3d0-eee87593ceda', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('82f496fc-8338-4b2f-aa7f-069a9ed3e8cb', '5728dce0-413f-49cb-b08d-76e7f06a01f0', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'd629a5de-13d6-4f5b-94dd-87f27df145b4', NULL, NULL, '216967.00000000', 'purchase', '3skabEs8fsRxkuQdyZv1HwbMnrUJzS7Jp3iscBX3dHo4Z6cFJS5NFK1M2RSvqaL8WwcekUCRFLy8UJCYpkg1hDa6', 'completed', '{"address":"324 oak knoll ave se","city":"warren","state":"ohio","zipCode":"44485","country":"united state ","phone":"3303303030"}', '2025-08-03 21:18:26', '2025-08-03 21:19:10', NULL, NULL, NULL, 'e8474845-f689-4cdf-9460-ee0de558cc5f', 'solana', NULL, NULL, NULL, 1, 'se-3051222'),
('90bc1e83-c543-44a4-8410-fb5663aa941d', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1673.00000000', NULL, '0x9133afa3408039be21b7849438d2979db5456b6d68da1eeb6bc71686ba5cd2c4', 'escrow_funded', '{"address":"jhduhu","city":"khbkuhb","state":"ukbkuk","zipCode":"vkvkvbkv","country":"kvkvtgvytgkulhb","phone":"07044831729"}', '2025-08-01 11:20:55', '2025-08-01 11:20:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'se-3051222'),
('9cc4352e-751f-4b20-9906-6a7ca475b8ec', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '9a18fa66-dcc1-4954-942a-727761c50789', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', 'devtomiwa9', '0.02593660', 'purchase', 'EvP1MBpW65dpqWvwSMNDw3wsUF6SM6Uf1NMiXruxW3rx', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-07 18:10:04', '2025-10-07 18:10:04', NULL, NULL, NULL, '0f84c633-e5bc-42df-99b7-7a758a537b9c', 'sui', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('b8465d92-23b5-4df1-8fc6-689ef48dcc26', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', 'devtomiwa9', '0.27777778', 'purchase', '4CzxRJ8J8H6UbnHfXf6tK3FxR1usX3FAefbXHoBrdJ9z', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 19:45:04', '2025-10-03 19:45:04', NULL, NULL, NULL, '2e29fc8a-e731-4585-8532-cf9fc6be6961', 'sui', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('c0d9dc5d-5394-46d7-91cf-bee1a9043475', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', '2ZTgNc4tCnZsrvMQtRu5fJGVwkhy6ZuZaAtUgDb9dxd5', 'devtomiwa9', '0.00434047', 'purchase', 'gyoxe9ny9SKJcGBZVPL5EFfmoTGY9DB1wC1ERPA2P1Bny5A1kNeN3mxMjb7X5sMEW6wvrRSD4CT6wN1bbjj7ruH', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 15:35:42', '2025-10-03 15:35:42', NULL, NULL, NULL, 'a9d8c97e-9457-488c-8d6a-85001232b04c', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('c72c897b-148a-424c-b6e5-3dac06c74b7e', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '9a18fa66-dcc1-4954-942a-727761c50789', '0x5d71211c5f1a387adca18b88f6e4a8a452eb0612adbda35a0baa3ab790d5c1e5', 'devtomiwa9', '0.02593660', 'purchase', 'TSVa73LfaAQgsTveFX1WpptMSrVGUa4rUaYvSRVntQZ', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-07 18:08:31', '2025-10-07 18:08:31', NULL, NULL, NULL, 'ba94bd53-78e5-4c20-be77-5749bc42de5c', 'sui', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('c7ae3f4c-14fc-4993-a72e-e0ac61a34cb8', NULL, '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17714.20455067', 'purchase', '0xe10984b9ae207fae64f67fc0d630ff25428e3240e89459d50b93fcbc50af22c8', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 09:43:47', '2025-10-03 09:43:47', NULL, NULL, NULL, '97b36fd8-d008-4c90-bb3c-179fc08818cd', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('c9d3b2b4-783d-4a48-af2b-96527c3fcde3', NULL, '8966824e-28e4-4829-afb6-663ac276b7ad', 'ff200ebb-92ca-43ed-bba2-5d819658bc92', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '17735.94942583', 'purchase', '0x8132e0035132db1ec3679c099bc06ea65f53aa4a5e2c0e0da4000c08ba64f2b3', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 09:52:08', '2025-10-03 09:52:08', NULL, NULL, NULL, '898d9cf7-f51f-41a0-ae95-9b4d73b0504e', 'xrpl_evm', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('d51c88c2-9af8-4f89-80e5-ad1c181c46f3', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 'devtomiwa9', '0.00022084', 'purchase', '0xdbe3737c0a6ed0d733810482d76ed8e384c4581950663b36b068985cc559c649', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-04 00:07:54', '2025-10-04 00:07:54', NULL, NULL, NULL, 'be2b7f51-5b3f-4d6b-9024-885b88f644aa', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('df33f075-9f85-4bc1-902d-c6042cad222e', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1667.00000000', NULL, '0xe4f39de92005197afd419dcfd9dcc93ed1c3cdd7dccf236654e9b8d9fde592f1', 'shipped', '{"address":"duabkwdb","city":"ubd kawubddkb kbw db","state":"kubnd,bd","zipCode":"uwakbduwb","country":"uwabkduwb","phone":"07044831729"}', '2025-08-01 11:54:33', '2025-08-01 15:10:46', '2222', 'DHL', '', NULL, NULL, NULL, '2025-08-01 15:10:46', NULL, 1, 'se-3051222'),
('dfef9a37-b70d-4c6c-9d6f-67a39a69574d', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1651.00000000', 'purchase', '0xb8aebb1c73c56691a3cbd57c66f4e44a9172fe721e5ea729a2364c52d9b91ac8', 'shipped', '{"address":"26b Elijiji Street, Off W","city":"PH","state":"Rivers","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-08-01 12:19:33', '2025-08-01 15:08:40', '222', 'USPS', '', 'b4853eea-e51b-446c-9dcc-bd2cc75c2f33', 'xrpl_evm', NULL, '2025-08-01 15:08:40', NULL, 1, 'se-3051222'),
('e01bdee4-2e01-40e2-bcdf-4a2d67c6558a', 'c61cde9c-197f-45e8-b881-d6f67bc60e6a', '8966824e-28e4-4829-afb6-663ac276b7ad', '1bb0338f-31d8-4400-a7ed-7b29f87c23d0', NULL, NULL, '60.00000000', NULL, NULL, 'delivered', '{"address":"26b Elijiji Street, Off Woji Road, Port Harcourt","city":"Port Harcourt","state":"Rivers State","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-07-29 13:53:11', '2025-08-01 15:33:29', '221122', 'FedEx', 'SHIP WITH CARE', NULL, NULL, NULL, NULL, '2025-08-01 15:33:29', 1, 'se-3051222'),
('e6550e78-27bb-4324-bef2-c19328671a36', '8966824e-28e4-4829-afb6-663ac276b7ad', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', '574603ea-2882-418f-98b7-8afda362d76e', NULL, NULL, '81929.00000000', 'purchase', NULL, 'escrow_funded', '{"address":"Vbevshd","city":"Bdbdb","state":"Whbsbs","zipCode":"Bsbebe","country":"Shwbebd","phone":"070994667315"}', '2025-08-06 16:13:40', '2025-08-06 16:13:39', NULL, NULL, NULL, '41b2edbf-958c-4f64-9efe-d1bb20c10c32', 'xrpl_evm', NULL, NULL, NULL, 1, 'se-3051222'),
('e6919853-c84c-4179-8272-dde67c24adfa', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1645.00000000', 'purchase', '0x1f045d5c7fb5e083e3217b6958c7134aab678a834cd4a7df85f143f8a8b23b17', 'shipped', '{"address":"26b Elijiji S","city":"PH","state":"Rivers","zipCode":"500102","country":"Nigeria","phone":"08044982128"}', '2025-08-01 12:41:34', '2025-08-01 15:07:46', '020220202', 'FedEx', '', '5050fb10-804c-4e2b-ac91-e72c1aac809e', 'xrpl_evm', NULL, '2025-08-01 15:07:46', NULL, 1, 'se-3051222'),
('ee74f078-2d07-4753-8823-7851122f2cc1', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1656.00000000', 'purchase', '0x269dadca9f9ba7bfc9d18cb06b3e5a6d3b5b9c1becb8bb4f808609c550c7bbb2', 'shipped', '{"address":"26b E","city":"PH","state":"Rivers","zipCode":"500102","country":"Nigeria","phone":"07044831729"}', '2025-08-01 12:11:45', '2025-08-01 15:10:33', '222', 'FedEx', '', '50d2e36c-8b87-4725-8180-468008b3b0c7', 'xrpl_evm', NULL, '2025-08-01 15:10:33', NULL, 1, 'se-3051222'),
('fdda8137-104a-46e0-b6db-e8e3e8cab30b', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '56dde193-c0cf-418c-b93f-c9a8de1bd088', 'ATfhapTLwrPzqEQBywirrTw7BGWaDmaGkMXtPyHtzh3F', 'devtomiwa9', '39588.28186857', 'purchase', '3gEYocQWpkDzpzBxT1S3Vs1Dwec6eZGTx6vcTqDuLrQx1e9yF2xtmWbTVwVwC7VqCUdhhgYMdumEtGkNGLoVr88G', 'escrow_funded', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', '2025-10-03 20:22:08', '2025-10-03 20:22:08', NULL, NULL, NULL, 'dc7adf72-80f1-4e22-8159-f4ba2b93ed62', 'xrpl', '{"originalCost": 0, "finalCost": 0, "gasFeeIncrement": 1.5}', NULL, NULL, 1, 'se-3051222'),
('ff22b58c-8a40-4846-8811-036a3eaf0582', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '0832401c-f0fe-43c8-ab21-ad7a2bc64f6e', NULL, NULL, '1656.00000000', 'purchase', '0xd686149921199cf1b348f4766dff3ae77e72c09b5c2d0d2ccde24c0f3ad08877', 'shipped', '{"address":"jbhmvbhvm","city":"hgfhqhj","state":"htdhj","zipCode":"500102","country":"nig","phone":"07044831729"}', '2025-08-01 13:47:07', '2025-08-01 15:03:58', 'dawdawdawd', 'USPS', 'w', '91e248d1-c6f0-4637-80b4-b66f2cd470e7', 'xrpl_evm', NULL, '2025-08-01 15:03:58', NULL, 1, 'se-3051222');


-- Table structure for pickup_suggestion_requests
DROP TABLE IF EXISTS `pickup_suggestion_requests`;
CREATE TABLE `pickup_suggestion_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `suggestions_count` int DEFAULT NULL,
  `suggestions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for pickup_suggestion_requests
INSERT INTO `pickup_suggestion_requests` (`id`, `country`, `state`, `city`, `street`, `suggestions_count`, `suggestions`, `created_at`) VALUES
(1, 'Nigeria', 'Rivers', 'Port Harcourt', '26 Elijiji Street', 0, '{"pickup_locations": []}', '2025-10-01 19:52:25'),
(2, 'Nigeria', 'Rivers', 'Port Harcourt', '26 Elijiji Street', 4, '{"pickup_locations": [{"name": "NIPOST Port Harcourt Main Post Office", "hours": "Monday - Friday: 8:00 AM - 4:00 PM, Saturday: 9:00 AM - 1:00 PM", "phone": "+234 803 700 8922 (NIPOST Customer Service)", "address": "Aba Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 4-6 km", "services": "International EMS (Express Mail Service), registered mail, parcel post, stamp sales, domestic mail services."}, {"name": "DHL Express Service Centre (Trans Amadi)", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM", "phone": "+234 7000 2255 88 (DHL Nigeria Customer Service)", "address": "33 Trans Amadi Rd, Rumuobiakani, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 2-4 km", "services": "International express package delivery, domestic express, document shipping, tracking, package pickup/drop-off."}, {"name": "FedEx Ship Centre (Red Star Express)", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM", "phone": "+234 803 700 8922 (Red Star Express Customer Service)", "address": "2 Trans Amadi Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 2-4 km", "services": "International express shipping, domestic courier services, freight services, package pickup/drop-off."}, {"name": "UPS Customer Center", "hours": "Monday - Friday: 8:00 AM - 5:00 PM", "phone": "+234 800 2255 877 (UPS Nigeria Customer Service)", "address": "10 Trans Amadi Road, Rumuobiakani, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 2-4 km", "services": "International and domestic package and freight shipping, supply chain solutions, package pickup/drop-off."}]}', '2025-10-01 19:58:56'),
(3, 'Nigeria', 'Rivers', 'Port Harcourt', '26 Elijiji Street', 5, '{"pickup_locations": [{"name": "NIPOST Main Post Office, Port Harcourt", "hours": "Mon-Fri: 8:00 AM - 4:00 PM, Sat: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 803 901 0212 (NIPOST National Customer Service, may not connect directly to branch)", "address": "Post Office Road, Old GRA, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 3.5 km (driving)", "services": "International mail services, EMS (Express Mail Service) for international parcels, registered mail, domestic postal services.", "carrier_id": "se-3051222"}, {"name": "Red Star Express (FedEx Authorized Ship Centre) Port Harcourt", "hours": "Mon-Fri: 8:00 AM - 5:00 PM, Sat: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 803 901 0404 (Red Star Express Customer Service)", "address": "33 Trans-Amadi Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 4.7 km (driving)", "services": "International express shipping (FedEx services), domestic express shipping, freight services, customs clearance, package tracking.", "carrier_id": "se-3051224"}, {"name": "DHL Express Service Centre Port Harcourt", "hours": "Mon-Fri: 8:00 AM - 5:00 PM, Sat: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 1 2700 812 (DHL Nigeria Customer Service)", "address": "110 Aba Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 5.5 km (driving)", "services": "International express shipping for documents and parcels, time-definite delivery, customs brokerage, global tracking.", "carrier_id": "se-3051222"}, {"name": "Aramex Port Harcourt Office", "hours": "Mon-Fri: 8:00 AM - 5:00 PM, Sat: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 806 828 0178 (Aramex Nigeria Customer Service)", "address": "114 Aba Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 5.5 km (driving)", "services": "International and domestic express shipping, e-commerce solutions, freight forwarding, logistics, tracking.", "carrier_id": "se-3051222"}, {"name": "UPS Customer Centre Port Harcourt", "hours": "Mon-Fri: 8:00 AM - 5:00 PM, Sat: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 1 270 0870 (UPS Nigeria Customer Service)", "address": "Plot 510, Trans-Amadi Industrial Layout, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 5.8 km (driving)", "services": "International express shipping (UPS Worldwide Express, Expedited), domestic shipping, freight services, customs solutions, tracking.", "carrier_id": "se-3051222"}]}', '2025-10-01 21:05:52'),
(4, 'Nigeria', 'Rivers', 'Port Harcourt', '26 Elijiji Street', 5, '{"pickup_locations": [{"name": "NIPOST Port Harcourt Main Post Office", "hours": "Monday - Friday: 8:00 AM - 4:00 PM; Saturday, Sunday: Closed", "phone": "+234 700 64767864 (NIPOST Customer Service)", "address": "Old Aba Road, Rumuomasi, Port Harcourt, Rivers State, Nigeria", "distance": "~6 km", "services": "International & Domestic Mail, Parcel Post, EMS (Express Mail Service) for international packages, Registered Mail, Postal Orders.", "carrier_id": "se-3051222"}, {"name": "FedEx / Red Star Express Service Center", "hours": "Monday - Friday: 8:00 AM - 5:00 PM; Saturday: 9:00 AM - 1:00 PM; Sunday: Closed", "phone": "+234 818 222 2222 (Red Star Express Customer Service)", "address": "11 Rumuigbo Street, Rumuola, Port Harcourt, Rivers State, Nigeria", "distance": "~5 km", "services": "International Express Package Delivery, Domestic Courier, Freight Services, Customs Clearance, E-commerce Logistics.", "carrier_id": "se-3051224"}, {"name": "UPS Port Harcourt Service Center", "hours": "Monday - Friday: 8:00 AM - 5:00 PM; Saturday: 9:00 AM - 1:00 PM; Sunday: Closed", "phone": "+234 700 700 8000 (UPS Nigeria Customer Service)", "address": "Plot 237/238 Rumuola Road, Rumuola, Port Harcourt, Rivers State, Nigeria", "distance": "~5 km", "services": "International & Domestic Express Shipping, Freight Solutions, Supply Chain Services, Customs Brokerage.", "carrier_id": "se-3051222"}, {"name": "DHL Express Service Point Port Harcourt", "hours": "Monday - Friday: 8:00 AM - 5:00 PM; Saturday: 9:00 AM - 1:00 PM; Sunday: Closed", "phone": "+234 803 900 3888 (DHL Nigeria Customer Service)", "address": "3 Rumuogba Estate Road, Off Old Aba Road, Rumuogba, Port Harcourt, Rivers State, Nigeria", "distance": "~7 km", "services": "International Express Parcel & Document Delivery, Time-definite Shipping, Global Mail Services, Customs Expertise.", "carrier_id": "se-3051223"}, {"name": "GIG Logistics (GIGL) Service Center", "hours": "Monday - Friday: 8:00 AM - 5:00 PM; Saturday: 9:00 AM - 3:00 PM; Sunday: Closed", "phone": "+234 817 0000 222 (GIGL Customer Service)", "address": "10 Rumuigbo Street, Rumuola, Port Harcourt, Rivers State, Nigeria", "distance": "~5 km", "services": "International Shipping (via partner networks), Domestic Courier Services, E-commerce Logistics, Freight Forwarding.", "carrier_id": "se-3051222"}]}', '2025-10-01 21:08:34'),
(5, 'Nigeria', 'Rivers', 'Port Harcourt', '26b Elijiji Street, Off Woji Road', 5, '{"pickup_locations": [{"name": "DHL Express Service Point", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 700 225 5345 (Customer Service)", "address": "8 Peter Odili Road, Trans Amadi Industrial Layout, Port Harcourt, Rivers State", "distance": "Approx. 4.5 km (15-20 min drive)", "services": "International express shipping, domestic express delivery, parcel pickup and drop-off, customs clearance assistance.", "carrier_id": "se-3051223"}, {"name": "Red Star Express (FedEx Partner)", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 803 700 8788 (Customer Service)", "address": "10 Peter Odili Road, Trans Amadi Industrial Layout, Port Harcourt, Rivers State", "distance": "Approx. 4.5 km (15-20 min drive)", "services": "International express shipping (FedEx), domestic express delivery, freight services, parcel pickup and drop-off.", "carrier_id": "se-3051224"}, {"name": "UPS Port Harcourt Service Center", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 803 901 0000 (Customer Service)", "address": "Plot 22, Trans Amadi Industrial Layout, Port Harcourt, Rivers State", "distance": "Approx. 4.5 km (15-20 min drive)", "services": "International express shipping, domestic shipping, freight services, customs brokerage, parcel pickup and drop-off.", "carrier_id": "se-3051222"}, {"name": "GIG Logistics Terminal (Peter Odili Road)", "hours": "Monday - Friday: 8:00 AM - 5:00 PM, Saturday: 9:00 AM - 2:00 PM, Sunday: 12:00 PM - 4:00 PM", "phone": "+234 817 200 1334 (Customer Service)", "address": "5 Peter Odili Road, Trans Amadi Industrial Layout, Port Harcourt, Rivers State", "distance": "Approx. 4.5 km (15-20 min drive)", "services": "International shipping (via partners), domestic express delivery, e-commerce logistics, warehousing, parcel pickup and drop-off.", "carrier_id": "se-3051222"}, {"name": "NIPOST Port Harcourt General Post Office", "hours": "Monday - Friday: 8:00 AM - 4:00 PM, Saturday: 9:00 AM - 1:00 PM, Sunday: Closed", "phone": "+234 803 903 0000 (NIPOST Customer Service)", "address": "Azikiwe Road, Port Harcourt, Rivers State", "distance": "Approx. 8 km (20-30 min drive)", "services": "International EMS (Express Mail Service), international registered mail, international parcel post, domestic mail services, money order.", "carrier_id": "se-3051222"}]}', '2025-10-01 22:23:01'),
(6, 'Nigeria', 'Rivers', 'Port Harcourt', 'Plot 22 Trans Amadi', 5, '{"pickup_locations": [{"name": "FedEx Ship Centre", "hours": "Mon-Fri: 8:00 AM - 5:00 PM; Sat: 9:00 AM - 12:00 PM", "phone": "+234 803 901 0000 (FedEx Nigeria Customer Service)", "address": "Plot 35, Trans Amadi Industrial Layout, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 0.8 km", "services": "International Express Parcel & Document Shipping, Domestic Courier Services, Freight Forwarding.", "carrier_id": "se-3051224"}, {"name": "DHL Express Service Point", "hours": "Mon-Fri: 8:00 AM - 5:00 PM; Sat: 9:00 AM - 1:00 PM", "phone": "+234 803 901 0000 (DHL Nigeria Customer Service)", "address": "82 Trans Amadi Industrial Layout, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 1.8 km", "services": "International Express Parcel & Document Shipping, Domestic Express Delivery, Customs Clearance.", "carrier_id": "se-3051223"}, {"name": "UPS Customer Service Centre", "hours": "Mon-Fri: 8:00 AM - 5:00 PM; Sat: 9:00 AM - 1:00 PM", "phone": "+234 803 901 0000 (UPS Nigeria Customer Service)", "address": "10 Peter Odili Road, Trans Amadi, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 2.5 km", "services": "International Express Parcel & Document Shipping, Domestic Courier Services, Supply Chain Solutions.", "carrier_id": "se-3051222"}, {"name": "GIG Logistics (GIGL) Service Centre", "hours": "Mon-Fri: 8:00 AM - 6:00 PM; Sat: 9:00 AM - 4:00 PM; Sun: 10:00 AM - 3:00 PM (Kindly confirm Sunday hours locally)", "phone": "+234 813 986 4220", "address": "No 1, Elelenwo Street (By Trans Amadi Road Junction), Rumuomasi, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 3.5 km", "services": "International Shipping, Domestic Express Delivery, Cargo & Freight Services, Warehousing.", "carrier_id": "se-3051222"}, {"name": "NIPOST General Post Office (GPO)", "hours": "Mon-Fri: 8:00 AM - 4:00 PM (Typical for NIPOST. Saturdays often shorter or closed. Confirm locally.)", "phone": "+234 905 607 6088 (General NIPOST Customer Care)", "address": "Azikiwe Road, Port Harcourt, Rivers State, Nigeria", "distance": "Approximately 6.5 km", "services": "International Mail (Registered, EMS), Domestic Mail, Parcel Post, Money Order, Stamp Sales.", "carrier_id": "se-3051222"}]}', '2025-10-01 22:25:48');


-- Table structure for roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` enum('user','admin','moderator') COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for roles
INSERT INTO `roles` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'admin', 'Administrator with full system access', '2025-07-28 18:20:26'),
(2, 'moderator', 'Moderator with content management permissions', '2025-07-28 18:20:26'),
(3, 'user', 'Regular user with basic permissions', '2025-07-28 18:20:26');


-- Table structure for services
DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `price_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `starting_price` decimal(10,2) DEFAULT NULL,
  `features` json DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_storefront_id` (`storefront_id`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`storefront_id`) REFERENCES `user_profiles` (`storefront_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for services
INSERT INTO `services` (`id`, `owner_id`, `storefront_id`, `title`, `description`, `price_text`, `starting_price`, `features`, `category`, `is_active`, `created_at`, `updated_at`) VALUES
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'NFT Collection Creation', 'Complete NFT collection with metadata and smart contracts', 'Starting at $2,499', '2499.00', '["Smart Contract", "Metadata Generation", "Rarity System", "Marketplace Ready"]', NULL, 1, '2025-09-05 20:10:46', '2025-09-05 20:10:46'),
(4, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Custom Web Development', 'Full-stack web applications built with modern technologies', 'Starting at $500', '500.00', '"[\"Responsive Design\", \"SEO Optimized\", \"Fast Loading\", \"Mobile First\"]"', NULL, 1, '2025-09-06 00:56:18', '2025-09-06 00:56:18'),
(8, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'Credential Manaagement', 'This is a credential management service', 'Starting at $49.99', '49.99', '[]', 'OnChain', 1, '2025-09-12 11:58:22', '2025-09-12 11:58:22');


-- Table structure for site_settings
DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data for site_settings
INSERT INTO `site_settings` (`id`, `is_maintenance`, `updated_at`) VALUES
(1, 0, '2025-10-03 08:25:24');


-- Table structure for social_media_links
DROP TABLE IF EXISTS `social_media_links`;
CREATE TABLE `social_media_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `platform` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_storefront_id` (`storefront_id`),
  CONSTRAINT `social_media_links_ibfk_1` FOREIGN KEY (`storefront_id`) REFERENCES `user_profiles` (`storefront_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for social_media_links
INSERT INTO `social_media_links` (`id`, `owner_id`, `storefront_id`, `platform`, `url`, `is_active`, `created_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Twitter', 'https://twitter.com/_devTomiwa', 1, '2025-09-05 20:11:01'),
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'LinkedIn', 'https://linkedin.com/in/devtomiwa', 1, '2025-09-05 20:11:01'),
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'GitHub', 'https://github.com/tomurashigaraki22', 1, '2025-09-05 20:11:01'),
(4, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Discord', 'https://discord.gg/ddwaa12', 1, '2025-09-18 23:07:10'),
(5, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'TikTok', 'https://tiktok.com/@_devTomiwa', 1, '2025-09-23 18:20:27');


-- Table structure for storefront_backgrounds
DROP TABLE IF EXISTS `storefront_backgrounds`;
CREATE TABLE `storefront_backgrounds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `storefront_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `background_url` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_storefront_id` (`storefront_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_backgrounds
INSERT INTO `storefront_backgrounds` (`id`, `storefront_id`, `background_url`, `created_at`, `updated_at`, `is_active`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759167447/tomiwa_k5khc9.jpg', '2025-09-29 17:01:11', '2025-09-29 17:37:32', 1),
(2, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759396285/24_ptmfig.jpg', '2025-09-30 20:26:31', '2025-10-02 09:11:36', 1);


-- Table structure for storefront_effects
DROP TABLE IF EXISTS `storefront_effects`;
CREATE TABLE `storefront_effects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `storefront_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `effect_type` enum('blur','brightness','contrast','saturate','hue-rotate','sepia','grayscale','invert','opacity','drop-shadow') COLLATE utf8mb4_general_ci NOT NULL,
  `effect_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `effect_config` json DEFAULT NULL,
  `intensity` int DEFAULT '50',
  `is_active` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_storefront_effect` (`storefront_id`,`effect_type`,`effect_name`),
  KEY `idx_storefront_id` (`storefront_id`),
  KEY `idx_effect_type` (`effect_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_effects
INSERT INTO `storefront_effects` (`id`, `storefront_id`, `effect_type`, `effect_name`, `effect_config`, `intensity`, `is_active`, `created_at`, `updated_at`) VALUES
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', 'drop-shadow', 'drop-shadow', NULL, 79, 1, '2025-09-29 20:06:51', '2025-09-29 20:06:51'),
(4, '8966824e-28e4-4829-afb6-663ac276b7ad', 'brightness', 'brightness', NULL, 27, 1, '2025-09-29 20:29:01', '2025-09-29 20:30:08');


-- Table structure for storefront_followers
DROP TABLE IF EXISTS `storefront_followers`;
CREATE TABLE `storefront_followers` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `follower_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_owner_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_follow` (`follower_id`,`storefront_id`),
  KEY `idx_follower` (`follower_id`),
  KEY `idx_storefront` (`storefront_id`),
  KEY `idx_owner` (`storefront_owner_id`),
  CONSTRAINT `storefront_followers_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `storefront_followers_ibfk_2` FOREIGN KEY (`storefront_owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_followers
INSERT INTO `storefront_followers` (`id`, `follower_id`, `storefront_id`, `storefront_owner_id`, `created_at`, `updated_at`) VALUES
('ae2c2ee1-1c7e-424a-88a2-86211157a6b6', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-09-22 17:11:29', '2025-09-22 17:11:29'),
('e1330176-388d-4ed9-ae3b-af2fa5f63e68', '4ad3e3a2-2d99-4aaf-b788-17881362a0fd', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-10-02 16:05:34', '2025-10-02 16:05:34'),
('e19381d4-c7f0-4f54-9aa8-3c0cdc0481d6', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', '2025-09-09 03:27:27', '2025-09-09 03:27:27');


-- Table structure for storefront_fonts
DROP TABLE IF EXISTS `storefront_fonts`;
CREATE TABLE `storefront_fonts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `storefront_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `font_family` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `is_selected` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_storefront_font` (`storefront_id`),
  KEY `idx_storefront_id` (`storefront_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_fonts
INSERT INTO `storefront_fonts` (`id`, `storefront_id`, `font_family`, `is_selected`, `created_at`, `updated_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', 'Playfair Display', 1, '2025-09-29 18:10:54', '2025-09-29 19:48:40'),
(2, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'Libre Baskerville', 1, '2025-09-30 15:23:32', '2025-10-01 13:41:28');


-- Table structure for storefront_logins
DROP TABLE IF EXISTS `storefront_logins`;
CREATE TABLE `storefront_logins` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `generated_password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL,
  `expired` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_storefront` (`user_id`),
  CONSTRAINT `storefront_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_logins
INSERT INTO `storefront_logins` (`id`, `user_id`, `email`, `generated_password`, `created_at`, `updated_at`, `expires_at`, `expired`) VALUES
('032d559c-cbe0-4a19-87b9-5a55d3b68f18', 'fa7cffc8-0383-4988-898e-900eadd6388f', 'familyonly89@yahoo.com', 'm9lyAl6@Rn1I^WZz', '2025-08-21 22:04:25', '2025-08-21 22:04:25', '2025-09-21 22:04:26', 0),
('03ea9738-e337-415b-9f34-149eaf784604', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 'ripplebids@outlook.com', 'kO@&Rd*a1hre@eeU', '2025-08-01 21:59:46', '2025-08-01 21:59:46', '2026-08-01 21:59:47', 0),
('0c59e540-7905-4932-b5c2-2d549c12494a', 'a5a64899-d629-4242-88df-b645677374ed', 'chuckiectg1987@gmail.com', 'LW2B45Oe9GduYE%B', '2025-09-13 18:53:00', '2025-09-13 18:53:00', '2025-10-13 18:53:00', 0),
('0f6eabd3-d55b-43d0-8c0c-1eefc2aa3f5d', 'ce4b5368-add3-4edb-997d-85dc1e1fc2b6', 'holmoby53@gmail.com', '&Cd20gRf^X&jNP7N', '2025-08-04 18:14:19', '2025-08-04 18:14:19', '2025-09-04 18:14:19', 0),
('12ec4194-1463-45a1-b5e5-185e1ed7e14d', '2e37faa3-b60c-4c5a-b914-3abedbb1a96e', 'rickmontes1@gmail.com', '^BX*D!7eFh!O2uOO', '2025-08-04 18:15:04', '2025-08-04 18:15:04', '2025-09-04 18:15:04', 0),
('14ea2185-3698-415f-9a4e-e0fe7597548e', 'e001cc3e-819c-402f-8ca7-07b854377103', 'avinash.ajugia@icloud.com', 'KSV51iK69Wme14xq', '2025-08-02 21:15:33', '2025-08-04 18:17:31', '2025-09-04 18:17:31', 0),
('15811ace-4ecc-49ac-890c-eaea70ee7fbe', '25e1ec3d-8e06-4c94-a634-b87ced0e5e96', 'esthereniayo@gmail.com', 'cw^z#24a%w2^W5ZJ', '2025-08-01 22:21:46', '2025-08-01 22:21:46', '2025-09-01 22:21:47', 0),
('1c377b4b-9a67-4543-8577-f2f979bf603c', 'f7a15ecc-ebec-4ff5-87a3-c6e517c8fac8', 'billsun4567@hotmail.com', 'Jrkks^ac5Asv^!mU', '2025-08-15 23:46:03', '2025-08-15 23:46:03', '2025-09-15 23:46:03', 0),
('1d2d5189-27c4-47df-a70f-4810a5847cc8', '6bc1bc70-9797-40b6-83a8-f4f54c434c69', 'info@zonetect.com', '^p45vBDuLJNjI5Xt', '2025-08-18 11:50:16', '2025-08-18 11:50:16', '2025-09-18 11:50:17', 0),
('1d37620c-ec13-4a50-86a2-7d2e8cc3585f', '234f4b06-158b-46b3-a549-c834345afbc1', 'cartervail@icloud.com', 'Ey$d5U9MJick7!^I', '2025-08-15 23:46:19', '2025-08-15 23:46:19', '2025-09-15 23:46:19', 0),
('1f3bde87-669b-4242-93ae-35fb4fc0a8ae', 'bfbde9b2-f63b-44a2-8ae0-b06f3bcebd01', 'mr.shepardsonbrewster@gmail.com', 'G&7WttgO6Ak5$fq4', '2025-08-04 18:15:10', '2025-09-05 15:46:47', '2025-09-04 18:15:11', 1),
('2883ac71-76b9-4b21-927c-63569f245de8', '14e63306-0162-4ff9-98df-77ade30b5f88', 'erotokritosmichaelides@gmail.com', 'QrVTJIPn8kZ0L3b1', '2025-08-15 23:48:13', '2025-08-15 23:48:13', '2025-09-15 23:48:14', 0),
('299b202b-befd-45e9-8736-63def651aede', '7708d7df-2ffb-4532-8a15-fe270bb1c109', 'awanderingponderer@yahoo.com', 'Zrk#xwfROgPe^JTh', '2025-09-13 18:41:43', '2025-09-13 18:41:43', '2025-10-13 18:41:44', 0),
('2c7be234-8faa-472b-8386-ce8ccae79e3f', '6a0d2b0c-3de1-473e-9391-8853a60279e1', 'dominic.bradley29@gmail.com', 's#T2Y3zN$vwXU@4e', '2025-08-04 18:14:11', '2025-08-04 18:14:11', '2025-09-04 18:14:11', 0),
('2d2d8ae3-33f1-4fe3-9909-35bd9c21c3ff', '4fe6ce1d-2f4c-4ed2-aea0-4180efec058e', 'ddcabella@gmail.com', 'h4KGxQC*&kXVd7vL', '2025-08-18 11:50:30', '2025-08-18 11:50:30', '2025-09-18 11:50:30', 0),
('2dd59e09-15a0-4629-946a-91cd7c5b1f5f', '75c36d48-1328-4a50-9ed5-77730e9cc567', 'teddy.tadios777@gmail.com', 'RxyigY0lTdncW5$Y', '2025-09-13 18:53:19', '2025-09-13 18:53:19', '2025-10-13 18:53:19', 0),
('2f74dbf1-3dc9-4483-811f-53dee493fd2e', '511533db-014a-4a92-b8e9-25ba2d11845d', 'brazilianbbqboys@gmail.com', '%NzVL*rRBIr9vfOc', '2025-08-05 23:39:47', '2025-08-05 23:39:47', '2025-09-05 23:39:47', 0),
('30e854bf-457d-41de-9083-277adef6a4b0', 'ecc60e75-15a1-4468-bfde-192f9ffe8fcd', 'xpnakin@proton.me', 'h7HO#QGTBoVglwSq', '2025-08-01 23:44:22', '2025-08-01 23:44:22', '2025-09-01 23:44:22', 0),
('369042d8-9f82-4533-bac4-0d932ac56fd4', '315a7c50-1fa5-4705-add1-cecefad26e3c', 'stathamjason618@gmail.com', 'BLKR9H5MwFjnzEl6', '2025-09-13 18:41:27', '2025-09-13 18:41:27', '2025-10-13 18:41:27', 0),
('386ee8d4-6e05-4883-b020-ee60e37db06e', '75507571-3c75-4261-b994-0f8a6f6e19f2', 'ogfomo1@gmail.com', '4o@5QORdrQfUt%5M', '2025-08-04 18:21:59', '2025-08-04 18:21:59', '2025-09-04 18:21:59', 0),
('39140162-1676-4bef-b67f-9dd1f0d81f9e', 'c697b17e-74af-492e-abe5-258ae1f85cee', 'tomb3169@gmail.com', '71kjzrnHA#RAMDni', '2025-08-15 23:49:20', '2025-08-15 23:49:20', '2025-09-15 23:49:21', 0),
('3927dcbd-c2bd-437f-bd64-98c1bb1555cb', 'bc2ebd7e-7cf7-4352-aa9a-50c2f7dd85d5', 'heyitskuni@gmail.com', 'FnRTXhpfJ0B&M2or', '2025-08-04 18:20:28', '2025-08-04 18:20:28', '2025-09-04 18:20:29', 0),
('3bd14445-efb1-4eba-b204-4957b42b9bcc', 'c7cd7ec3-4b68-4a17-aeab-c3be3ba4adf4', 'bukkyhassan80@gmail.com', 'oGz#dCa65nzWsZKD', '2025-08-15 23:46:55', '2025-08-15 23:46:55', '2025-09-15 23:46:55', 0),
('3e213d19-83e9-48fa-a866-58bd0a79ae66', '52ad2b71-965c-4dd3-a027-575b93980c2c', 'hoangtinh1023@gmail.com', '8Z!x4T9qZgEeTqKg', '2025-08-01 23:43:41', '2025-08-01 23:43:41', '2025-09-01 23:43:42', 0),
('4000e387-ddd9-4ec9-870d-9cab65ef4235', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'tvarocht@gmail.com', 'riVTg*Oc4pQx51U6', '2025-08-01 22:19:50', '2025-09-10 00:29:26', '2025-09-05 12:26:16', 1),
('40a04cbd-679b-4294-835a-a8a4af034af6', '2b3819c7-6b99-4ce5-9ab6-733cd6d89c79', 'aaronjamesoverend@gmail.com', '@IlFfMNPy9trv%dF', '2025-08-02 21:15:41', '2025-08-04 18:17:39', '2025-09-04 18:17:39', 0),
('4500463a-44b0-48bd-b72f-d63a7f8091ed', '18aca1f3-fe5c-4e5a-84db-d9a38fa3c31d', 'ArizonaMountainWater@gmail.com', 'wkg9qnv4eKvtKSzf', '2025-08-28 01:10:11', '2025-08-28 01:10:11', '2025-09-28 01:10:12', 0),
('4593940d-e127-496c-9b65-d4f7df29155d', 'c1812920-c6e7-4d4b-a8be-4fb4df09a2eb', 'trekoutdoorco@gmail.com', 'acjB!De7mW7Wjfp0', '2025-08-27 12:02:14', '2025-08-27 12:02:14', '2025-09-27 12:02:15', 0),
('45e582f9-9546-4c2a-ab08-a82e201ff646', '1314b0cf-559b-43db-b13c-507a12d8e520', 'akame4473@gmail.com', 'qr$mQj#egUYZ8HY8', '2025-08-04 18:13:57', '2025-08-04 18:13:57', '2025-09-04 18:13:57', 0),
('499ab7c2-2da1-48cb-a796-3306ea8f9800', 'f8bacc1b-39ef-462c-b55c-e962c603e9fb', 'silvertreeprod@gmail.com', 'y6%uCE6!kIuNrzWW', '2025-08-15 23:48:42', '2025-08-15 23:48:42', '2025-09-15 23:48:42', 0),
('4cfdc834-e997-4b0a-97a8-b7bb79042847', 'c95b9071-c7aa-4c05-8db1-b3208ec42f94', 'stevewheeler_26@outlook.com', 'MZ**Rftqem&^@jml', '2025-08-01 22:20:50', '2025-08-01 22:20:50', '2025-09-01 22:20:50', 0),
('4f0dfa85-61c3-4012-9667-3081f2fddda0', '05a3018b-498d-464f-a31c-0857c55a6a89', 'Nalatransit@gmail.com', 'L3ZfLDh1I2WuqOzq', '2025-08-15 23:45:46', '2025-08-15 23:45:46', '2025-09-15 23:45:46', 0),
('4faa5614-83a4-4d01-81f3-4d93321c46d5', '9e84ae99-d7d0-4ced-ae75-4753175e494d', 'corvetsr@aol.com', 'zNzeWwKXuc&9IEw@', '2025-08-21 22:04:09', '2025-08-21 22:04:09', '2025-09-21 22:04:09', 0),
('5177c97e-489c-486d-84bc-c6a6a7f75ba1', 'cba7d6c9-8845-4f60-9a16-fd58213338bd', 'jethro.pelamonia@gmail.com', 'ouUUPnV17y%s6HVH', '2025-08-04 18:15:56', '2025-08-04 18:15:56', '2025-09-04 18:15:56', 0),
('5680d03a-0c30-4776-81c8-87491462269f', '5c36c202-d883-4280-95cf-d1b53d510939', 'simonsamuel195@gmail.com', 'h%uRr%jJSRxP0#Te', '2025-09-13 18:41:38', '2025-09-13 18:41:38', '2025-10-13 18:41:38', 0),
('5f82f128-733d-4ada-a0a9-833087d59f39', 'a46dd041-50e7-42b5-b613-ca407ab9188b', 'gdgsatx15@yahoo.com', 'p7doK@BG6vogpar%', '2025-08-01 22:21:18', '2025-08-01 22:21:18', '2025-09-01 22:21:18', 0),
('5f9b84be-8981-4699-ae3e-53a7874446f4', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'blockcred.ng@gmail.com', '8A2aEO#7AMIw2G7z', '2025-08-01 16:24:36', '2025-09-09 01:00:22', '2026-09-09 01:00:22', 0),
('603bd110-ac4b-488b-a646-644ac321dd6b', '49944aa2-f8a9-4f49-a295-c0742c213662', 'surreal.elysium@gmail.com', 'G^WhVuETLAnkPC6E', '2025-08-01 22:19:02', '2025-08-01 22:19:02', '2025-09-01 22:19:02', 0),
('626e84dd-a7e9-440e-af82-515c114c014c', 'b57b6a59-e35c-4781-81be-28ca97c213fa', 'maxjeffofweb3@gmail.com', 'S$t0*No!KuLH6iZc', '2025-08-01 22:21:07', '2025-08-01 22:21:07', '2025-09-01 22:21:08', 0),
('653fa165-8bca-4f9d-a7ac-d433897801b7', 'ec4d0260-1c2e-47d5-8c04-8fd665186b8f', 'coxgarrett24@gmail.com', '36A!wm*P4T3sUYXs', '2025-08-04 18:14:34', '2025-08-04 18:14:34', '2025-09-04 18:14:35', 0),
('670abc38-c8a7-4ad5-ad43-9eb5c2c4e58a', 'b34a8e57-18ad-4adf-a3e1-a34743be6a6b', 'lemaitrestudio@gmail.com', 'sKi8%d%djpbPOR8@', '2025-08-25 16:47:37', '2025-08-25 16:47:37', '2025-09-25 16:47:37', 0),
('689cf7f6-e2ee-4097-ac91-655c1f6490aa', 'f0841792-c385-4c41-a5e9-cf1210d853e6', 'dufganshopping@gmail.com', 'W^1LTSBWZC62vtyX', '2025-08-15 23:46:38', '2025-08-15 23:46:38', '2025-09-15 23:46:39', 0),
('6c9b1c68-b217-4c0c-87b6-59b9e721783b', '2364093f-06d2-46df-84b2-203a0e72099c', 'muarsool1997@gmail.com', 'aNpLBBJT!#IPStx8', '2025-08-21 22:04:35', '2025-08-21 22:04:35', '2025-09-21 22:04:35', 0),
('6e0b9c2e-5ce9-443c-9015-bd86e9f772ac', 'b92baae1-b21c-48f2-b34a-1be23fbe19b8', 'johnsiochi03@gmail.com', '$oHdL7H2oxcqf1np', '2025-08-01 22:20:33', '2025-08-01 22:20:33', '2025-09-01 22:20:33', 0),
('7079b8ea-e137-48a4-9949-579e29b6ba54', 'c790a6ca-3091-4e41-82b0-c5e9b896a8cd', 'burnxrp@hotmail.com', '1jlpjJ1c1aaWxh@m', '2025-08-04 18:14:27', '2025-08-04 18:14:27', '2025-09-04 18:14:27', 0),
('712e214d-82c8-4999-bbe6-cd946eb9c8a4', '2990fbe4-d652-48f4-baef-0b31ad30bb2a', 'mike.harbison@aol.com', 'wNLiIQckF3S8tQU8', '2025-08-01 22:19:32', '2025-08-01 22:19:32', '2025-09-01 22:19:33', 0),
('7186e8e3-fb33-42f0-9896-ed0fdd0bd0f9', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'namangwl2005@gmail.com', 'U%DBTka9z#ISkW8^', '2025-08-15 23:48:52', '2025-08-15 23:48:52', '2025-09-15 23:48:53', 0),
('71b72c00-8ce8-4d4f-b069-fdc2fefad44a', 'f150bf83-2211-468b-9268-626e54068b45', 'bobbyisactive@outlook.com', 'Es$SMJ!O8yd0jO4m', '2025-08-15 23:47:14', '2025-08-15 23:47:14', '2025-09-15 23:47:15', 0),
('7746e320-e73e-40ed-b418-1435f9564630', '1173c738-8d51-43bf-9240-0a8cc50d9098', 'sebamoeckel@gmail.com', 'vdqj^1Ief&JmUd2I', '2025-08-02 21:15:49', '2025-08-04 18:17:58', '2025-09-04 18:17:59', 0),
('7868a595-1a10-49d2-8759-1fee75bf5ef0', 'cac3677b-65c5-4ccc-b975-41e9ca944e53', 'jhaas11.jh@gmail.com', 'Mlj^XGBwAveHx2de', '2025-08-01 22:20:14', '2025-08-01 22:20:14', '2025-09-01 22:20:14', 0),
('7c1f28f5-85b9-48e2-8b02-4314f9b0f072', '6727cb79-0093-4812-b02b-438b48fdf19f', 'cardonarolando24@gmail.com', 'g7GhD#iHiz0EI!AX', '2025-08-04 18:20:18', '2025-08-04 18:20:18', '2025-09-04 18:20:18', 0),
('7c699ebc-7aac-485a-ba32-6687610f9941', '9bb3fd9f-8082-4f82-83d4-b2b12cef42af', 'dlsgh3760@gmail.com', 'YbdED!lF92Llbjj%', '2025-08-29 02:23:47', '2025-08-29 02:23:47', '2025-09-29 02:23:47', 0),
('7e369db5-2142-43a8-8a7d-d320e61174d6', 'ba39d346-9a3b-494a-8ad7-08254038271f', 'nemesioaleon@gmail.com', '!zn0l8B&!1A$Atrz', '2025-08-04 18:18:10', '2025-08-04 18:18:10', '2025-09-04 18:18:10', 0),
('830aaa4e-6af7-4b02-8618-44318f9898a9', 'a2c1667d-4de4-418f-bb54-1d6496c6661c', 'aaron.eigenman@gmail.com', '08saYOiA5K0@kWe2', '2025-08-04 18:21:27', '2025-08-04 18:21:27', '2025-09-04 18:21:28', 0),
('8a6119d9-dc10-46ab-a8b4-88bedafca3e6', 'bc3ec134-3139-4c62-81cc-eead774b9410', 'mohammedolaoye09@gmail.com', 'J@KUpuoFUxFPQjbj', '2025-08-04 18:20:40', '2025-08-04 18:20:40', '2025-09-04 18:20:40', 0),
('8b523965-0d69-48bf-8128-3d7dcaf993f8', 'd2db09ed-1b3c-4786-a50f-f8e13f3399d4', 'marektwarog@hotmail.ca', 't5SB4YcH$gufEnyT', '2025-08-04 18:19:17', '2025-08-04 18:19:17', '2025-09-04 18:19:18', 0),
('8e801f7b-b1e1-4263-96d9-34800e18e5f5', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'muarsool@gmail.com', 'xYCO15Rq5CbrQxeH', '2025-08-15 23:49:49', '2025-08-15 23:49:49', '2025-09-15 23:49:49', 0),
('8fd7065a-e869-44de-89b6-5d87fba91a86', 'eb7a98ff-4020-4131-902a-7542a84146ba', 'wilshireralphxiii@gmail.com', 'j7IqjvA%pUB5MZy&', '2025-09-13 18:53:24', '2025-09-13 18:53:24', '2025-10-13 18:53:25', 0),
('928965cd-3a54-4a83-8664-bdc3cb493a22', '7a870eb8-50f2-4396-9185-58fc0a0d6b29', 'drophunter28@gmail.com', '4gTagvrLK4vhr!Wt', '2025-08-04 18:19:09', '2025-08-04 18:19:09', '2025-09-04 18:19:09', 0),
('956ed058-2cb7-46e5-8df0-f0f203080bb9', '401ab372-d223-4780-acf0-dfbb2adf09ee', 'hipomap2010@gmail.com', 'eZPbK^XVvskULKCD', '2025-08-04 18:14:56', '2025-08-04 18:14:56', '2025-09-04 18:14:56', 0),
('969c5536-91db-4a17-9b55-0f5db7bfbace', 'c8a91109-10d1-4b90-9513-06152b7c9cfc', 'bt@tenet.fit', 'n@fptrwA3ld7vhA9', '2025-08-01 23:43:51', '2025-08-01 23:43:51', '2025-09-01 23:43:52', 0),
('97cb51d8-0aee-4a06-ac60-98114bcc53b5', 'e117634a-ac12-4de9-af85-09ddf6028c1d', 'joezeal20@gmail.com', '*pau$nvdxD^4lBU!', '2025-08-04 18:19:53', '2025-08-04 18:19:53', '2025-09-04 18:19:54', 0),
('a0a65026-d757-41e9-8798-661966987326', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'nicolas.padovani@wanadoo.fr', 'ao&351x#I1fVgCqp', '2025-08-01 22:19:58', '2025-09-07 22:07:43', '2025-10-07 22:07:44', 0),
('a373d7ae-00ee-49bb-9249-df847779bf76', '039d7712-5163-4dd6-8fd9-887e6f8289a9', 'deerfieldcolony1@gmail.com', 'g5Kzsl8C*4%$ZF@1', '2025-08-04 18:18:24', '2025-08-04 18:18:24', '2025-09-04 18:18:24', 0),
('a412cb7f-5619-413f-a7c5-bcba219d8e70', '8ed0386a-6467-41fd-8ab3-c50d2813f0fd', 'achinchic@gmail.com', 'zfERtnygMw43dAlh', '2025-08-01 22:19:15', '2025-08-01 22:19:15', '2025-09-01 22:19:16', 0),
('a436d3df-7ed5-4a39-a4bc-0365be920934', 'cc8c5195-9583-4a2e-b707-1fc8c0f86d71', 'Liquidassetsboca@gmail.com', 'aeG2hdqiAB9*y!4#', '2025-08-16 22:39:38', '2025-08-16 22:39:38', '2025-09-16 22:39:39', 0),
('a7711c1b-3970-4b01-9a34-30e4463986da', '8d7cc243-ad53-4144-bcf3-2058658ad213', 'derrikphicks@gmail.com', '56PN*akJDR3LALwE', '2025-08-15 23:46:10', '2025-08-15 23:46:10', '2025-09-15 23:46:10', 0),
('a9fa7e80-c134-4807-b6fa-bacd33e1ab22', '2a46ff9e-eb44-4dbb-9f9b-c5600f5fa827', 'Andrewstarling1007@gmail.com', 'ZC2uCfgNJVz6SWKl', '2025-08-04 18:15:18', '2025-09-09 12:12:27', '2025-09-04 18:15:18', 1),
('b1150d19-8d7b-4678-afa3-aa0f0bd18e6b', '7793b9f4-ae0b-433f-8019-b3b3902e6dd1', 'binsuwaidan.ss@gmail.com', 'OvTv5JUc%lkNrPC7', '2025-08-15 23:45:55', '2025-08-15 23:45:55', '2025-09-15 23:45:55', 0),
('b19904ee-1e9b-46f7-ad35-b39aaf685cfc', '7381718b-b0d1-4dbd-809c-540bffd8a931', 'zipperwhippet@gmail.com', 'mcw1tNYgUm4h$#uP', '2025-08-04 18:15:33', '2025-08-04 18:15:33', '2025-09-04 18:15:33', 0),
('b1c7943c-2853-470a-a953-ed8c694c02b4', 'ec80c3e6-ee1e-472d-9d3f-29074f144aea', 'jshelton352@gmail.com', 'KeEaxsAjBegJT9Os', '2025-08-19 11:45:16', '2025-08-19 11:45:16', '2025-09-19 11:45:16', 0),
('b6f72555-c572-4e53-bee3-d0a9302f9054', '75d2f82a-bd10-4cea-8aec-98518d667e7b', 'cryptosphere34@hotmail.com', 'G6caRKLB8ePUr5*R', '2025-08-15 23:46:27', '2025-08-15 23:46:27', '2025-09-15 23:46:27', 0),
('b71dce32-b7f6-4f81-82e6-974a89d67f1f', 'e500d3d5-d2bf-4395-b5a5-86a18c147677', 'Jndv2611@gmail.com', '4%VyuJdoeWjdRJ&f', '2025-08-04 18:20:04', '2025-08-04 18:20:04', '2025-09-04 18:20:05', 0),
('b97926e9-ca5f-4bb7-809d-4511b8aba492', 'd606f7b9-f445-4559-9bdd-28f8c881693c', 'dylincarter99@gmail.com', 'ISvDbnUU&Nqj%q*$', '2025-08-15 23:48:32', '2025-08-15 23:48:32', '2025-09-15 23:48:33', 0),
('bb11c3ba-90d0-47c2-853f-2fb465a92abf', 'a7ef51c5-58d4-40bc-b90c-936c5d5738af', 'tegaakpoyibo14@gmail.com', '8*AkjuXfc0&WH&b!', '2025-08-28 01:10:06', '2025-08-28 01:10:06', '2025-09-28 01:10:07', 0),
('bc551f73-18a5-4080-acf2-12fab9541b5d', '4db4233d-fa69-4ab6-9126-74339c8fecd4', 'utunkarim2@gmail.com', 'i9QSUjkFysCHcXR3', '2025-08-17 05:31:36', '2025-08-17 05:31:36', '2025-09-17 05:31:36', 0),
('bd2ca973-3db5-4a6f-9c66-46195b082ec8', '4ad3e3a2-2d99-4aaf-b788-17881362a0fd', 'charli3maddocks@gmail.com', 'H3NgEQ9GVv@k#4@e', '2025-08-01 22:20:24', '2025-08-01 22:20:24', '2025-09-01 22:20:24', 0),
('c1cd7dd0-4bbf-4519-a571-17f6f0b74c6c', '0d495d79-e9c5-49f6-a568-aff7e202f88f', 'Seanrasheen@gmail.com', 'Uuz8J0ysYyDCCa56', '2025-08-04 18:21:18', '2025-08-04 18:21:18', '2025-09-04 18:21:18', 0),
('c56b4b8e-6bfb-11f0-9610-acde48001122', '8966824e-28e4-4829-afb6-663ac276b7ad', 'devtomiwa9@gmail.com', 'Pityboy@22', '2025-07-28 21:42:34', '2025-08-26 22:02:47', '2026-05-13 04:21:29', 0),
('c9104a40-a3b3-48b2-b169-2015b049d06f', 'c40146e5-9ec5-4b57-b204-f464634489bb', 'britneykristine24@gmail.com', '2rczC9l5F#kM%@Vu', '2025-08-21 22:04:03', '2025-08-21 22:04:03', '2025-09-21 22:04:03', 0),
('cd93e84b-a68f-4f03-82b2-3c96297aaefa', '499a84ec-b8fe-4470-908d-1f14500ccfe5', 'jynxzi1776@yahoo.com', 'wx990#cv&mgAz$2^', '2025-08-04 18:20:50', '2025-08-04 18:20:50', '2025-09-04 18:20:51', 0),
('cff7c9be-d2ec-498b-a316-d4168c6c3693', '5cdcf895-bf38-4214-aa4e-a46de215516c', 'daanretrodev@gmail.com', 'gvLNiIpA2G^o*d7x', '2025-08-01 22:21:26', '2025-08-01 22:21:26', '2025-09-01 22:21:27', 0),
('d0446746-1c4f-44a0-8380-000c2f6cc7d3', '4bad0d5e-92d4-43e2-919a-5d4b8e9eae1a', 'silverandgold4me2@gmail.com', '68z43X$1S^0D#XrY', '2025-08-15 23:46:46', '2025-08-15 23:46:46', '2025-09-15 23:46:47', 0),
('d21df40c-1071-45a9-aeb5-47c2d9e6a2f0', '085a0a9c-a10d-4d0b-86df-74403d3b3690', 'reelrarities1@gmail.com', 'I%5aKIYi13SXK@*%', '2025-08-15 23:49:04', '2025-08-15 23:49:04', '2025-09-15 23:49:05', 0),
('d23b51bf-2eda-4398-a343-ee65e9b416e3', 'b04397fc-e89f-4647-8ed4-bf01e0f8a00c', 'hopscotch', 'EQZY8Bu9&f3IhnP4', '2025-08-15 23:48:23', '2025-08-15 23:48:23', '2025-09-15 23:48:23', 0),
('d405f3eb-586c-4f02-bb9c-605d2d067246', '1aa7717e-510c-406e-bdd7-d32e90a1603f', 'himesgelo@gmail.com', '53l%DlsuV4nohJ*2', '2025-08-15 23:48:04', '2025-08-15 23:48:04', '2025-09-15 23:48:04', 0),
('d53228f4-805a-4f4f-b9f8-97ce1d87234c', '2fd6bdad-77af-4b8e-8fb4-bb6f6ab0cdfd', 'cornet.remy01@gmail.com', 'jq@ApZ3SJnPZoPDh', '2025-08-04 18:19:27', '2025-08-04 18:19:27', '2025-09-04 18:19:27', 0),
('d62d34a0-bb16-49a5-9e8d-01f78a22d017', 'd1382ea4-9a6f-4fdb-bb88-67e146160cf8', 'shaptefratia@gmail.com', 'tD!n1#HDvr@tvhvB', '2025-09-13 18:41:32', '2025-09-13 18:41:32', '2025-10-13 18:41:33', 0),
('d6f74f48-3366-4642-ba49-2ead1d6dfa6a', '8ff7eae8-631c-4440-ad59-1d40f862ace0', 'drg9123@gmail.com', 'H3nWbm1ZLO5vHC3H', '2025-08-01 23:44:32', '2025-08-01 23:44:32', '2025-09-01 23:44:33', 0),
('d71cf13a-a0f1-4d69-a2b5-e7f75368db27', '8b9b36f6-4be0-477a-89e9-e47e9e77d7a4', 'alghaithaljamel@gmail.com', 'XEyUn6F8ZZJfNFYm', '2025-09-13 18:52:48', '2025-09-13 18:52:48', '2025-10-13 18:52:49', 0),
('dd29949b-473f-4ff8-b8c6-d256db8fedcd', '2b5e79b4-e06c-4315-8e7d-c1416dbbebaf', 'crypto_sid_@hotmail.com', 'cKvGUCCYgMF5Do43', '2025-08-04 18:15:44', '2025-08-04 18:15:44', '2025-09-04 18:15:44', 0),
('e05b7bd5-48c0-4d56-953e-b464e2fc514e', '28f1b5c9-3602-45f1-9b1e-80b352434002', 'Danielletvaroch@gmail.com', 'Arny&#Y!YDHn9k26', '2025-08-01 22:20:41', '2025-08-01 22:20:41', '2025-09-01 22:20:41', 0),
('e383ff7a-249f-4fb8-98bc-f0337662d318', '8eea3a76-97df-438f-9685-f978cadacc77', 'kimberlyrenee244@gmail.com', 'Xi2aM1QERUZicCc0', '2025-08-01 22:20:58', '2025-08-01 22:20:58', '2025-09-01 22:20:58', 0),
('e45a8202-3c17-47af-b19a-b442b96f2680', 'a0630200-7843-4ae4-9d7d-47df03806b31', 'engalipiodaibes@gmail.com', 'f4aGkZ&BvBBwa8Vq', '2025-08-04 18:21:37', '2025-08-04 18:21:37', '2025-09-04 18:21:37', 0),
('e4b1e7bb-c424-4e9b-9160-e16d930bb4e5', 'd181fd42-9ebc-4cf6-847b-9886e20723f8', 'arizonamointainwater@gmail.com', 'v76a%S7IcTBwoAxS', '2025-08-28 01:10:18', '2025-08-28 01:10:18', '2025-09-28 01:10:18', 0),
('e569baa6-848d-488d-9279-bdca5d99f493', '959d1e27-a851-4b61-b029-bebef6942945', 'johnathan.t.butler@gmail.com', 'x9d@WuZky8cRA^P8', '2025-08-15 23:47:04', '2025-08-15 23:47:04', '2025-09-15 23:47:05', 0),
('e5ae2b90-edc0-4e15-af88-a99d03a57a2f', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 'btvaroch13@gmail.com', 'qRtk3UYpSWwhtqIV', '2025-08-01 22:19:40', '2025-08-01 22:19:40', '2025-09-01 22:19:41', 0),
('e68691f8-822e-4533-8acd-fb7f81a7ce90', '1d9db35c-e67d-4915-bf02-54d9e9bc7736', 'remivictor20@gmail.com', 'dVC0s#*s%6kMcpa@', '2025-09-13 18:41:21', '2025-09-13 18:41:21', '2025-10-13 18:41:21', 0),
('e7d11f84-b423-4ace-918a-4e6b9420b16d', 'b0c19acc-8207-41a4-bcf4-316c098ddd9f', 'atrain56@comcast.net', 'b1fOR*WbaesINpUj', '2025-08-01 22:20:06', '2025-08-01 22:20:06', '2025-09-01 22:20:07', 0),
('e94b990a-c9db-4f17-b5a6-26cdddd0671e', '94128f57-09b0-4d6f-89ae-11beb99a8cd1', 'mysupfun@gmail.com', '!QZq@FsjSCE*trBt', '2025-08-04 18:14:47', '2025-08-04 18:14:47', '2025-09-04 18:14:48', 0),
('eab59aca-8f38-4b9b-bc8d-a666915eee55', '6463f773-f9f4-40d3-980a-60c2ae801041', 'elower1976@comcast.net', 'Yd0NMPC$Nzdo56L4', '2025-08-01 23:44:00', '2025-08-01 23:44:00', '2025-09-01 23:44:00', 0),
('f5ab286b-8f38-4b99-a46c-90d8cdd84363', 'a4226274-e795-4d25-939a-f089f3a7d73b', 'dev.steadfast4@gmail.com', '2X&zVh7#4D#moZdE', '2025-08-01 22:21:36', '2025-08-01 22:21:36', '2025-09-01 22:21:36', 0),
('fb95a5cf-2faf-41c1-80b7-4697d0f0f198', '09e61cbe-2562-47df-b517-b893980ca4cd', 'mdrob242@gmail.com', 'bV!aDTFlC1gzDv^o', '2025-08-01 22:19:25', '2025-08-01 22:19:25', '2025-09-01 22:19:25', 0),
('ff7f9641-8d41-4b56-ba98-73ce80b5c320', 'f8e9cf0c-4ef0-4060-b2b2-a61d4e2db1bc', 'folsomhodl@gmail.com', 'VrWO3%8@hCqpBRza', '2025-08-18 11:50:23', '2025-08-18 11:50:23', '2025-09-18 11:50:23', 0);


-- Table structure for storefront_notifications
DROP TABLE IF EXISTS `storefront_notifications`;
CREATE TABLE `storefront_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `to_user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` tinyint(1) DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `read_status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_to_user_id` (`to_user_id`),
  KEY `idx_from_user_id` (`from_user_id`),
  KEY `idx_read_status` (`read_status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_notifications
INSERT INTO `storefront_notifications` (`id`, `from_user_id`, `to_user_id`, `email`, `title`, `description`, `created_at`, `read_status`) VALUES
(19, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-09 02:01:38', 0),
(20, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-09 02:06:49', 0),
(21, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-09 02:11:08', 0),
(30, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '8966824e-28e4-4829-afb6-663ac276b7ad', 1, 'New Follower', 'devt990 started following your storefront', '2025-09-09 04:27:32', 0),
(31, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', '8966824e-28e4-4829-afb6-663ac276b7ad', 1, 'New Follower', 'pinzut17 started following your storefront', '2025-09-22 13:03:41', 0),
(32, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:07', 0),
(33, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:08', 0),
(34, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:09', 0),
(35, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:09', 0),
(36, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:09', 0),
(37, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:11', 0),
(38, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:13', 0),
(39, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:20', 0),
(40, 'system', 'test', 1, 'Test Notification', 'This is a test notification from your storefront', '2025-09-22 16:31:23', 0),
(41, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', '8966824e-28e4-4829-afb6-663ac276b7ad', 0, 'Follower Update', 'pinzut17 unfollowed your storefront', '2025-09-22 17:11:10', 0),
(42, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', '8966824e-28e4-4829-afb6-663ac276b7ad', 1, 'New Follower', 'pinzut17 started following your storefront', '2025-09-22 17:11:31', 0),
(43, '5728dce0-413f-49cb-b08d-76e7f06a01f0', '8966824e-28e4-4829-afb6-663ac276b7ad', 1, 'New Follower', 'RipplebidsCEO started following your storefront', '2025-09-24 19:09:38', 0),
(44, '5728dce0-413f-49cb-b08d-76e7f06a01f0', '8966824e-28e4-4829-afb6-663ac276b7ad', 0, 'Follower Update', 'RipplebidsCEO unfollowed your storefront', '2025-09-24 19:09:49', 0),
(45, '4ad3e3a2-2d99-4aaf-b788-17881362a0fd', '8966824e-28e4-4829-afb6-663ac276b7ad', 1, 'New Follower', 'Charli3 started following your storefront', '2025-10-02 16:05:36', 0);


-- Table structure for storefront_profiles
DROP TABLE IF EXISTS `storefront_profiles`;
CREATE TABLE `storefront_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `picture` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `btc` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `eth` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `xrpbEvm` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `xrpbSol` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `xrpbXrpl` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `background_preference` enum('gradient','image') COLLATE utf8mb4_general_ci DEFAULT 'gradient',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_profiles
INSERT INTO `storefront_profiles` (`id`, `username`, `picture`, `btc`, `eth`, `xrpbEvm`, `xrpbSol`, `xrpbXrpl`, `background_preference`) VALUES
(1, 'Nicpad', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759317705/storefront/profile/profile_1759317856_p9utn.jpg', 'bc1q6vjm6933z0zp2yfdcjzdrh5jeqhsn8sashk80q', '0xb1F963f01eA9625522EF6fb2C75e033fD291F5D4 ', '0xb1F963f01eA9625522EF6fb2C75e033fD291F5D4 ', 'HRPZKnSTkYsjHiRL4sqykhC9cV9HQshk81mi4XLWDjxE', 'rKWyyK5vi4iHC1TzgS2wBnvPinuHYogKzb', 'image');


-- Table structure for storefront_reviews
DROP TABLE IF EXISTS `storefront_reviews`;
CREATE TABLE `storefront_reviews` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rating` int NOT NULL,
  `title` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `helpful_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `idx_storefront_id` (`storefront_id`),
  KEY `idx_rating` (`rating`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_status` (`status`),
  CONSTRAINT `storefront_reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_reviews
INSERT INTO `storefront_reviews` (`id`, `storefront_id`, `customer_name`, `email`, `rating`, `title`, `comment`, `product_name`, `verified`, `helpful_count`, `created_at`, `updated_at`, `status`) VALUES
('1fa33992-f19f-49de-8e09-e4c90474d777', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Tomiwa Raphael', 'blockcred.ng@gmail.com', 3, 'Average', 'It is average', '', 0, 0, '2025-09-12 12:52:35', '2025-09-12 12:52:35', 'pending'),
('253d813b-f153-47a6-b32e-62ba8575e18f', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Dev Tomiwa', 'devtomiwa9@gmail.com', 5, 'Nice Store', 'Very good customer service, and good items - testing', '', 0, 0, '2025-09-10 17:23:15', '2025-09-10 17:23:15', 'pending'),
('457258e3-382d-491f-a868-9deb146b735e', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Dev Tomiwa', 'devtomiwa9@gmail.com', 5, 'Nice Store', 'Very good customer service, and good items', '', 0, 0, '2025-09-10 17:22:01', '2025-09-10 17:22:00', 'pending'),
('debe8982-05de-43d7-96b5-c452c44a3c15', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Tomiwa Raphael', 'devtomiwa9@gmail.com', 2, 'I''m testing', 'This is a test', '', 0, 0, '2025-09-10 19:02:42', '2025-09-10 19:02:42', 'pending'),
('e1208cc7-41e3-4397-bebf-90993bf571b3', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Tomiwa Raphael', 'devtomiwa9@gmail.com', 5, 'This is another test', 'This is a test, don''t take it to heart', '', 0, 0, '2025-09-11 17:51:26', '2025-09-11 17:51:26', 'pending');


-- Table structure for storefront_settings
DROP TABLE IF EXISTS `storefront_settings`;
CREATE TABLE `storefront_settings` (
  `low_stock_alert` tinyint(1) DEFAULT '1',
  `promotional_email_alert` tinyint(1) DEFAULT '1',
  `new_order_alerts` tinyint(1) DEFAULT '1',
  `storefront_design` json DEFAULT NULL,
  `storefront_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`storefront_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for storefront_settings
INSERT INTO `storefront_settings` (`low_stock_alert`, `promotional_email_alert`, `new_order_alerts`, `storefront_design`, `storefront_id`) VALUES
(0, 0, 0, '{}', '8966824e-28e4-4829-afb6-663ac276b7ad'),
(1, 1, 1, '{}', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412'),
(1, 0, 1, '{}', 'undefined');


-- Table structure for storefront_skills
DROP TABLE IF EXISTS `storefront_skills`;
CREATE TABLE `storefront_skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `storefront_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_level` int NOT NULL DEFAULT '0' COMMENT 'Skill level from 0-100',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e.g., Programming, Design, Marketing',
  `years_experience` int DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT '0' COMMENT '1 for featured skills to show first',
  `display_order` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_storefront_id` (`storefront_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_category` (`category`),
  KEY `idx_featured` (`is_featured`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data for storefront_skills
INSERT INTO `storefront_skills` (`id`, `storefront_id`, `owner_id`, `skill_name`, `skill_level`, `category`, `years_experience`, `is_featured`, `display_order`, `created_at`, `updated_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'JavaScript', 90, 'Programming', 5, 1, 1, '2025-09-06 04:25:05', '2025-09-06 04:25:05'),
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'React', 85, 'Programming', 4, 1, 2, '2025-09-06 04:25:05', '2025-09-06 04:25:05'),
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Node.js', 80, 'Programming', 3, 1, 3, '2025-09-06 04:25:05', '2025-09-06 04:25:05'),
(4, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'UI/UX Design', 75, 'Design', 4, 1, 4, '2025-09-06 04:25:05', '2025-09-06 04:25:05'),
(5, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Photoshop', 70, 'Design', 6, 0, 5, '2025-09-06 04:25:05', '2025-09-06 04:25:05'),
(6, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Digital Marketing', 65, 'Marketing', 2, 0, 6, '2025-09-06 04:25:05', '2025-09-06 04:25:05');


-- Table structure for user_memberships
DROP TABLE IF EXISTS `user_memberships`;
CREATE TABLE `user_memberships` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `membership_tier_id` int NOT NULL,
  `price` decimal(20,8) NOT NULL,
  `transaction_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `membership_tier_id` (`membership_tier_id`),
  CONSTRAINT `user_memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_memberships_ibfk_2` FOREIGN KEY (`membership_tier_id`) REFERENCES `membership_tiers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for user_memberships
INSERT INTO `user_memberships` (`id`, `user_id`, `membership_tier_id`, `price`, `transaction_hash`, `expires_at`, `is_active`, `created_at`) VALUES
('02033c14-4d2b-45b0-9b5d-3b8e11336c39', '085a0a9c-a10d-4d0b-86df-74403d3b3690', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:49:05', 1, '2025-08-15 23:49:04'),
('05697005-7ac3-4bb8-9a2f-b81db904c3c5', 'e117634a-ac12-4de9-af85-09ddf6028c1d', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:19:54', 1, '2025-08-04 18:19:53'),
('05ede3d9-97fa-44af-a70d-42d2f6422d31', '2a46ff9e-eb44-4dbb-9f9b-c5600f5fa827', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:18', 1, '2025-08-04 18:15:18'),
('09951ef2-5458-4a8d-9607-6604e804a6af', '7793b9f4-ae0b-433f-8019-b3b3902e6dd1', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:45:55', 1, '2025-08-15 23:45:55'),
('1113681d-dbb1-44ee-8627-90de2cea843c', 'c7cd7ec3-4b68-4a17-aeab-c3be3ba4adf4', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:55', 1, '2025-08-15 23:46:55'),
('128a7aa3-e291-4a69-86ee-6cc8cc2c1ee6', '4ad3e3a2-2d99-4aaf-b788-17881362a0fd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:24', 1, '2025-08-01 22:20:24'),
('13ec338c-18a5-4b9c-a2b8-43c38f9863d6', 'c1812920-c6e7-4d4b-a8be-4fb4df09a2eb', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-27 12:02:15', 1, '2025-08-27 12:02:14'),
('16010ff3-1818-47a5-b1c4-0579f7ed0911', 'e001cc3e-819c-402f-8ca7-07b854377103', 2, '0E-8', 'ADMIN_GRANTED', '2025-08-04 18:17:31', 0, '2025-08-02 21:15:33'),
('16093665-a27d-429f-88e4-37113737c948', 'f150bf83-2211-468b-9268-626e54068b45', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:47:15', 1, '2025-08-15 23:47:14'),
('17a6f4d0-a197-40ad-a856-46a26cdf7be8', '4fe6ce1d-2f4c-4ed2-aea0-4180efec058e', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-18 11:50:30', 1, '2025-08-18 11:50:30'),
('198924ef-4de9-4fda-bf88-19d7ff45ef02', '2364093f-06d2-46df-84b2-203a0e72099c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-21 22:04:35', 1, '2025-08-21 22:04:35'),
('1a505bbb-bed1-48d0-8f0f-a5c5f0afa501', 'bc3ec134-3139-4c62-81cc-eead774b9410', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:20:40', 1, '2025-08-04 18:20:40'),
('1c029324-54d2-42bb-9dda-cbf3182614c9', '9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:53', 1, '2025-08-15 23:48:52'),
('1c1d5397-2cdf-4cb2-bd25-beb377378797', '2b3819c7-6b99-4ce5-9ab6-733cd6d89c79', 2, '0E-8', 'ADMIN_GRANTED', '2025-08-04 18:17:39', 0, '2025-08-02 21:15:41'),
('1dd60cc0-dabb-4be1-8f4f-7d8b32979513', 'cba7d6c9-8845-4f60-9a16-fd58213338bd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:56', 1, '2025-08-04 18:15:56'),
('1e8f2796-e474-4ea9-9a71-60da1d42a47d', 'b56587a6-ad15-4613-b22e-eb8c1cb35b39', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:49:49', 1, '2025-08-15 23:49:49'),
('1e98d883-7f46-4984-b23e-538e2d22b61c', '7708d7df-2ffb-4532-8a15-fe270bb1c109', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:41:44', 1, '2025-09-13 18:41:43'),
('208439c6-a3e8-42ef-8731-22626bd4f90b', 'd181fd42-9ebc-4cf6-847b-9886e20723f8', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-28 01:10:18', 1, '2025-08-28 01:10:18'),
('240dddb5-add6-417f-a739-b76a4199448a', '0d495d79-e9c5-49f6-a568-aff7e202f88f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:21:18', 1, '2025-08-04 18:21:18'),
('2440c242-e919-4207-b263-a3436ad61b2b', 'f7a15ecc-ebec-4ff5-87a3-c6e517c8fac8', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:03', 1, '2025-08-15 23:46:03'),
('2508bcd1-fc31-41ae-9abf-bf5c1967075c', 'b04397fc-e89f-4647-8ed4-bf01e0f8a00c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:23', 1, '2025-08-15 23:48:23'),
('2615de78-79e2-43f0-8d66-3abcfc1edacd', '7381718b-b0d1-4dbd-809c-540bffd8a931', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:33', 1, '2025-08-04 18:15:33'),
('28925b80-e9ef-48fb-9638-16811d24c5a5', 'b0c19acc-8207-41a4-bcf4-316c098ddd9f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:07', 1, '2025-08-01 22:20:06'),
('2c6e6c24-5349-42eb-a6e4-3bbc8a81e7b0', 'b34a8e57-18ad-4adf-a3e1-a34743be6a6b', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-25 16:47:37', 1, '2025-08-25 16:47:37'),
('2e9f8e78-0fc5-4fcf-b26f-0effdc222725', '2fd6bdad-77af-4b8e-8fb4-bb6f6ab0cdfd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:19:27', 1, '2025-08-04 18:19:27'),
('32178a3b-6f56-43b6-aa9f-d9f0030e7f1f', '49944aa2-f8a9-4f49-a295-c0742c213662', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:19:02', 1, '2025-08-01 22:19:02'),
('351fb1f0-4d03-42e5-8fcb-4c6201992af3', '9e84ae99-d7d0-4ced-ae75-4753175e494d', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-21 22:04:09', 1, '2025-08-21 22:04:09'),
('352832e2-aaac-4820-8293-8fc68fcb03f2', '234f4b06-158b-46b3-a549-c834345afbc1', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:19', 1, '2025-08-15 23:46:18'),
('364f3056-ab08-40ca-92eb-c50203f29116', 'b57b6a59-e35c-4781-81be-28ca97c213fa', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:21:08', 1, '2025-08-01 22:21:07'),
('39ecdd1d-9c5a-429e-ba5e-c6869d5d190e', 'c40146e5-9ec5-4b57-b204-f464634489bb', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-21 22:04:03', 1, '2025-08-21 22:04:03'),
('3a0dec20-c787-4550-a56d-7e950fdd9306', 'a2c1667d-4de4-418f-bb54-1d6496c6661c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:21:28', 1, '2025-08-04 18:21:27'),
('3ab55907-6336-4b03-8fd4-af01079397e7', '6727cb79-0093-4812-b02b-438b48fdf19f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:20:18', 1, '2025-08-04 18:20:18'),
('3e4e19ee-b307-4fc7-9406-fdbd55d354be', '401ab372-d223-4780-acf0-dfbb2adf09ee', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:56', 1, '2025-08-04 18:14:56'),
('41e8c8a7-cef3-4b3a-8211-27c523c6cac9', 'a5a64899-d629-4242-88df-b645677374ed', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:53:00', 1, '2025-09-13 18:53:00'),
('4290dc30-4f3c-4969-b601-68f85913a098', '14e63306-0162-4ff9-98df-77ade30b5f88', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:14', 1, '2025-08-15 23:48:13'),
('43af8d5f-fac5-42c7-b536-78fb2ab25db1', '75507571-3c75-4261-b994-0f8a6f6e19f2', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:21:59', 1, '2025-08-04 18:21:59'),
('47a2abc6-2dbf-4d5b-9a66-7544695535cd', '315a7c50-1fa5-4705-add1-cecefad26e3c', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:41:27', 1, '2025-09-13 18:41:27'),
('4990715f-f3d3-4f2b-881a-e942dfad1f39', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-07 22:07:44', 1, '2025-09-07 22:07:43'),
('4a14e39f-b0e1-4e21-a4b1-eb5ed9a59ab8', 'c697b17e-74af-492e-abe5-258ae1f85cee', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:49:21', 1, '2025-08-15 23:49:20'),
('4ac62be5-4d82-4f0f-be6f-1e86ce7b66b9', '1aa7717e-510c-406e-bdd7-d32e90a1603f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:04', 1, '2025-08-15 23:48:04'),
('4bd866fa-ff4f-4a74-bc63-55e3fbde702e', '5cdcf895-bf38-4214-aa4e-a46de215516c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:21:27', 1, '2025-08-01 22:21:26'),
('512027b4-3210-4a56-9eaa-cb40ccfa8af3', '8966824e-28e4-4829-afb6-663ac276b7ad', 2, '0E-8', 'ADMIN_GRANTED', '2025-08-15 03:21:30', 0, '2025-08-15 03:19:11'),
('5184adb4-cc6c-4830-baaf-ee409baf34b6', 'e500d3d5-d2bf-4395-b5a5-86a18c147677', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:20:05', 1, '2025-08-04 18:20:04'),
('52e92a0a-1706-4438-90ac-dd8b54219d4b', '8966824e-28e4-4829-afb6-663ac276b7ad', 2, '0E-8', 'ADMIN_GRANTED', '2026-05-13 04:21:29', 1, '2025-08-15 03:21:30'),
('53c6b4a6-fcd4-4388-8f83-77635c56579b', 'd1382ea4-9a6f-4fdb-bb88-67e146160cf8', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:41:33', 1, '2025-09-13 18:41:32'),
('58d56033-dbf8-4ded-926d-face91aa0aa2', '94128f57-09b0-4d6f-89ae-11beb99a8cd1', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:48', 1, '2025-08-04 18:14:47'),
('59318dfa-4c27-4ed7-b298-41bd9f604e0f', 'ec80c3e6-ee1e-472d-9d3f-29074f144aea', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-19 11:45:16', 1, '2025-08-19 11:45:16'),
('5a24353d-1298-4dd0-a0fe-60077d6d3632', '511533db-014a-4a92-b8e9-25ba2d11845d', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-05 23:39:47', 1, '2025-08-05 23:39:47'),
('655929c8-7ce5-4051-892e-c866bf88bec9', '8eea3a76-97df-438f-9685-f978cadacc77', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:58', 1, '2025-08-01 22:20:57'),
('69340496-9463-49cd-9d42-8bcaec9c8210', '05a3018b-498d-464f-a31c-0857c55a6a89', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:45:46', 1, '2025-08-15 23:45:46'),
('6ae9473c-e1ae-46c5-9a68-7face9a056fb', '8ff7eae8-631c-4440-ad59-1d40f862ace0', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 23:44:33', 1, '2025-08-01 23:44:32'),
('6b6a8d74-18ec-4241-86ab-d51a99047d5c', 'f8e9cf0c-4ef0-4060-b2b2-a61d4e2db1bc', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-18 11:50:23', 1, '2025-08-18 11:50:23'),
('6b9e551b-9006-4f4b-b32b-25065379677d', 'c790a6ca-3091-4e41-82b0-c5e9b896a8cd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:27', 1, '2025-08-04 18:14:27'),
('6f0dcb85-88f3-4048-8c0a-ca29c24e9dc1', '2e37faa3-b60c-4c5a-b914-3abedbb1a96e', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:04', 1, '2025-08-04 18:15:04'),
('7700f02f-b2ea-473f-9cc1-27d9a6241464', '499a84ec-b8fe-4470-908d-1f14500ccfe5', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:20:51', 1, '2025-08-04 18:20:50'),
('7c1a545b-55a3-48bc-bde7-6e74d05e1327', 'd606f7b9-f445-4559-9bdd-28f8c881693c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:33', 1, '2025-08-15 23:48:32'),
('7d4034a7-5f75-4fee-9163-8997a9a6b423', '8b9b36f6-4be0-477a-89e9-e47e9e77d7a4', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:52:49', 1, '2025-09-13 18:52:48'),
('82dc695b-562f-430a-a67b-d70ff6c4938e', '6bc1bc70-9797-40b6-83a8-f4f54c434c69', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-18 11:50:17', 1, '2025-08-18 11:50:16'),
('84254c00-6a63-4516-a55a-b83c261c8e17', '1d9db35c-e67d-4915-bf02-54d9e9bc7736', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:41:21', 1, '2025-09-13 18:41:21'),
('87013d79-acf0-4cb2-95bd-0cf205afa16f', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-05 12:26:16', 1, '2025-08-05 12:26:16'),
('87ca3eec-8cf2-4679-8160-d0b212dc421b', '4db4233d-fa69-4ab6-9126-74339c8fecd4', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-17 05:31:36', 1, '2025-08-17 05:31:36'),
('87f73f85-a6f6-4402-85c9-d8144f74f05d', '1314b0cf-559b-43db-b13c-507a12d8e520', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:13:57', 1, '2025-08-04 18:13:57'),
('8963c6b7-f198-491b-a9de-02bcb5ea99ab', 'd2db09ed-1b3c-4786-a50f-f8e13f3399d4', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:19:18', 1, '2025-08-04 18:19:17'),
('8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 2, '50.00000000', NULL, '2025-08-15 03:19:11', 0, '2025-07-28 23:04:16'),
('8d26c8db-db5e-454c-8c1c-fe05d15801bb', 'ba39d346-9a3b-494a-8ad7-08254038271f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:18:10', 1, '2025-08-04 18:18:10'),
('8eb0eda8-6ec7-49c1-bc53-b690b0979b2b', 'ec4d0260-1c2e-47d5-8c04-8fd665186b8f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:35', 1, '2025-08-04 18:14:34'),
('9339cf0d-3f33-42ce-9199-bb143e57a183', '1173c738-8d51-43bf-9240-0a8cc50d9098', 2, '0E-8', 'ADMIN_GRANTED', '2025-08-04 18:17:58', 0, '2025-08-02 21:15:49'),
('93bb1d90-ddca-4511-bcab-28b62813cb0a', '52ad2b71-965c-4dd3-a027-575b93980c2c', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 23:43:42', 1, '2025-08-01 23:43:41'),
('94517c89-b4d9-4f16-ad73-5167d1732717', 'e001cc3e-819c-402f-8ca7-07b854377103', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:17:31', 1, '2025-08-04 18:17:31'),
('96105f52-50b2-411e-ae21-8df5003f0136', 'f008acde-97c6-4aa8-ab43-4d642e5112c6', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:19:41', 1, '2025-08-01 22:19:40'),
('98ec77c7-fead-4fd8-9e00-d4052b81d567', '959d1e27-a851-4b61-b029-bebef6942945', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:47:05', 1, '2025-08-15 23:47:04'),
('9d6ad217-e237-4a38-b802-77ffb48efb6d', '75d2f82a-bd10-4cea-8aec-98518d667e7b', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:27', 1, '2025-08-15 23:46:27'),
('9fb06c3c-d1ac-4799-98d5-fb2ba3d3aa43', '9bb3fd9f-8082-4f82-83d4-b2b12cef42af', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-29 02:23:47', 1, '2025-08-29 02:23:47'),
('a1bd530c-c5ab-4af9-9b82-3ada2313a630', 'c95b9071-c7aa-4c05-8db1-b3208ec42f94', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:50', 1, '2025-08-01 22:20:50'),
('a2a0a567-03f3-4fe3-9736-fc7c343660b9', 'a0630200-7843-4ae4-9d7d-47df03806b31', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:21:37', 1, '2025-08-04 18:21:37'),
('a931148e-97ed-49e1-9b88-1021de941c5e', 'a7ef51c5-58d4-40bc-b90c-936c5d5738af', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-28 01:10:07', 1, '2025-08-28 01:10:06'),
('ac2d8f67-b0e3-430a-a5b7-e4c2f83b2b7b', '18aca1f3-fe5c-4e5a-84db-d9a38fa3c31d', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-28 01:10:12', 1, '2025-08-28 01:10:11'),
('ae2cbd26-c2a6-419e-8432-749e67d5d798', 'a46dd041-50e7-42b5-b613-ca407ab9188b', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:21:18', 1, '2025-08-01 22:21:17'),
('aea18297-d0e4-4fb3-85e1-b0f966bbebd4', 'ecc60e75-15a1-4468-bfde-192f9ffe8fcd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 23:44:22', 1, '2025-08-01 23:44:22'),
('b1f7dee1-7486-47b0-bb02-0e3f7e18650d', 'b92baae1-b21c-48f2-b34a-1be23fbe19b8', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:33', 1, '2025-08-01 22:20:33'),
('b3106565-cf4f-4187-b96b-70c9c43ce60a', '28f1b5c9-3602-45f1-9b1e-80b352434002', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:41', 1, '2025-08-01 22:20:41'),
('b673ba11-a24e-43c0-b439-a2115b18abfb', 'cac3677b-65c5-4ccc-b975-41e9ca944e53', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:20:14', 1, '2025-08-01 22:20:14'),
('b7fd40a6-b4a7-469d-9cd5-acb27354b6fb', 'bfbde9b2-f63b-44a2-8ae0-b06f3bcebd01', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:11', 1, '2025-08-04 18:15:10'),
('b867fb05-e768-4995-ab9a-2f77ed28e51a', 'eb7a98ff-4020-4131-902a-7542a84146ba', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:53:25', 1, '2025-09-13 18:53:24'),
('bbed1958-5ccd-44fd-8840-a7fa970ae94f', 'a4226274-e795-4d25-939a-f089f3a7d73b', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:21:36', 1, '2025-08-01 22:21:36'),
('bfc92e45-ac44-4ba8-b638-961155d3ad4c', 'f8bacc1b-39ef-462c-b55c-e962c603e9fb', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:48:42', 1, '2025-08-15 23:48:42'),
('c2049336-2c8c-4a4d-9f0f-42a8a8b785f9', '6463f773-f9f4-40d3-980a-60c2ae801041', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 23:44:00', 1, '2025-08-01 23:44:00'),
('c75eebe2-2e55-419c-823c-628abf59d0f9', '09e61cbe-2562-47df-b517-b893980ca4cd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:19:25', 1, '2025-08-01 22:19:25'),
('cba0ef35-4e58-4b12-ad76-8a765d84fced', 'bc2ebd7e-7cf7-4352-aa9a-50c2f7dd85d5', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:20:29', 1, '2025-08-04 18:20:28'),
('d1c0fc52-e300-4a50-8afe-26b5e1e61710', '8ed0386a-6467-41fd-8ab3-c50d2813f0fd', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:19:16', 1, '2025-08-01 22:19:15'),
('d405d7dd-d1ee-4594-a4da-25ba21ee4432', '5728dce0-413f-49cb-b08d-76e7f06a01f0', 3, '0E-8', 'ADMIN_GRANTED', '2026-08-01 21:59:47', 1, '2025-08-01 21:59:46'),
('d42b33b7-4647-41be-9610-dc2a2d8cf361', 'ce4b5368-add3-4edb-997d-85dc1e1fc2b6', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:19', 1, '2025-08-04 18:14:19'),
('d5cec4b5-292d-4bd5-b597-a9fd3ada1b04', '4bad0d5e-92d4-43e2-919a-5d4b8e9eae1a', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:47', 1, '2025-08-15 23:46:46'),
('d7d10ee5-6494-48e3-9dcb-d558ebdc813c', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 2, '25.00000000', '0xc435d61acaf965d7ef483960087f4ade4ec7de16156462b90aa593cf261bafb7', '2025-09-09 01:00:22', 0, '2025-08-01 16:24:36'),
('d896450a-d533-4e12-8a86-681e44778f0f', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-07 22:07:43', 0, '2025-08-01 22:19:58'),
('da9a7d98-0fd1-4be1-be18-4a87fda8ee93', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 2, '0E-8', 'ADMIN_GRANTED', '2026-09-09 01:00:22', 1, '2025-09-09 01:00:22'),
('db99dc7b-1f13-4657-b5f2-be67a71753f3', 'f0841792-c385-4c41-a5e9-cf1210d853e6', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:39', 1, '2025-08-15 23:46:38'),
('e08fc51b-6d79-48ec-8be8-cc152369621a', '1173c738-8d51-43bf-9240-0a8cc50d9098', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:17:59', 1, '2025-08-04 18:17:58'),
('e5d4e38b-cbf7-478c-8b87-236514e745a0', '2b5e79b4-e06c-4315-8e7d-c1416dbbebaf', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:15:44', 1, '2025-08-04 18:15:44'),
('e7388454-7639-46a0-83aa-58936d6c7ef6', '25e1ec3d-8e06-4c94-a634-b87ced0e5e96', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:21:47', 1, '2025-08-01 22:21:46'),
('e7411802-691c-4a64-b127-831fc0763539', 'c8a91109-10d1-4b90-9513-06152b7c9cfc', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 23:43:52', 1, '2025-08-01 23:43:51'),
('e7b15af0-728b-4085-9762-393714e0746a', '75c36d48-1328-4a50-9ed5-77730e9cc567', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:53:19', 1, '2025-09-13 18:53:19'),
('e7c963ac-0ddb-48ad-b440-4c51e62ca6cb', '2b3819c7-6b99-4ce5-9ab6-733cd6d89c79', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:17:39', 1, '2025-08-04 18:17:39'),
('e8a35d75-ca20-4cfe-a3a6-10d8434616a6', '7a870eb8-50f2-4396-9185-58fc0a0d6b29', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:19:09', 1, '2025-08-04 18:19:09'),
('ec233b21-cd89-4587-be97-dd45c08d56c0', '2990fbe4-d652-48f4-baef-0b31ad30bb2a', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-01 22:19:33', 1, '2025-08-01 22:19:32'),
('ed319f29-cf7c-4320-97de-45ecba5f9283', '5c36c202-d883-4280-95cf-d1b53d510939', 2, '0E-8', 'ADMIN_GRANTED', '2025-10-13 18:41:38', 1, '2025-09-13 18:41:38'),
('f390d4a0-9dc1-4c1b-96a7-5e710d112585', 'fa7cffc8-0383-4988-898e-900eadd6388f', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-21 22:04:26', 1, '2025-08-21 22:04:25'),
('f3fcb546-8959-48d1-aed8-915987fc9989', 'fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 2, '0E-8', 'ADMIN_GRANTED', '2025-08-05 12:26:16', 0, '2025-08-01 22:19:50'),
('f47d94cf-2d36-4dee-a90c-bbdf36a07d26', '039d7712-5163-4dd6-8fd9-887e6f8289a9', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:18:24', 1, '2025-08-04 18:18:24'),
('f58a5886-4c63-452d-a088-b76708ae9413', 'cc8c5195-9583-4a2e-b707-1fc8c0f86d71', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-16 22:39:39', 1, '2025-08-16 22:39:38'),
('fd8e9230-a2e6-4bd8-a728-4c38130febee', '6a0d2b0c-3de1-473e-9391-8853a60279e1', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-04 18:14:11', 1, '2025-08-04 18:14:11'),
('ffa20d10-912e-4627-bf38-9f4b25fe20e5', '8d7cc243-ad53-4144-bcf3-2058658ad213', 2, '0E-8', 'ADMIN_GRANTED', '2025-09-15 23:46:10', 1, '2025-08-15 23:46:10');


-- Table structure for user_profiles
DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE `user_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `storefront_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_general_ci,
  `avatar` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cover_image` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `total_sales` int DEFAULT '0',
  `rating` decimal(3,2) DEFAULT '0.00',
  `followers` int DEFAULT '0',
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storefront_id` (`storefront_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_storefront_id` (`storefront_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for user_profiles
INSERT INTO `user_profiles` (`id`, `owner_id`, `storefront_id`, `name`, `title`, `bio`, `avatar`, `cover_image`, `location`, `joined_date`, `total_sales`, `rating`, `followers`, `email`, `phone`, `created_at`, `updated_at`) VALUES
(1, '8966824e-28e4-4829-afb6-663ac276b7ad', '8966824e-28e4-4829-afb6-663ac276b7ad', 'Dev Tomiwa', 'FullStack Web, App and Web3 Developer', 'Passionate about creating innovative digital experiences and building meaningful connections through technology.', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125204/tomiwa_fjws57.jpg', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125219/Drop_RideShare_1024x500_mka7cl.png', 'Port Harcourt, Nigeria', '2025-07-01 00:00:00', 156, '4.90', 2850, 'devtomiwa9@gmail.com', '+2347043127894', '2025-09-05 20:10:43', '2025-10-02 16:05:34'),
(2, '8966824e-28e4-4829-afb6-663ac276b7ad', 'c1da6128-f10a-430f-8d4e-d24f6eba704d', 'Dev Tomiwa', 'FullStack Web, App and Web3 Developer', 'Passionate about creating innovative digital experiences and building meaningful connections through technology.', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125204/tomiwa_fjws57.jpg', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125219/Drop_RideShare_1024x500_mka7cl.png', 'Port Harcourt, Nigeria', '2025-09-06 00:00:00', 0, '0.00', 0, 'devtomiwa9@gmail.com', '+234 807 127 3078', '2025-09-06 01:49:48', '2025-09-06 04:19:53'),
(3, '8966824e-28e4-4829-afb6-663ac276b7ad', 'febc18c8-3053-4e36-bde0-27a395680ddf', 'Dev Tomiwa', 'FullStack Web, App and Web3 Developer', 'Passionate about creating innovative digital experiences and building meaningful connections through technology.', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125204/tomiwa_fjws57.jpg', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757125219/Drop_RideShare_1024x500_mka7cl.png', 'Port Harcourt, Nigeria', '2025-09-06 00:00:00', 0, '0.00', 0, 'devtomiwa9@gmail.com', '+234 807 127 3078', '2025-09-06 01:51:23', '2025-09-06 04:19:53'),
(4, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '1a36e76b-d7af-420b-ace9-d2a9232be05e', 'BlockCred.Sui', 'Founder', 'Blockcred.sui is a credential management system primarily built on sui', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676426/Fries_Remove_Background_qy659i.png', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676449/photo_2025-04-21_15.53.36_ifwwcv.jpg', 'Port harcourt, Nigeria', '2025-09-12 00:00:00', 0, '0.00', 0, 'blockcred.ng@gmail.com', '+2347044831729', '2025-09-12 11:35:14', '2025-09-12 11:35:14'),
(5, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '477a0872-de49-43d0-aa8f-0974b0e4527f', 'BlockCred.Sui', 'Founder', 'Blockcred.sui is a credential management system primarily built on sui', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676426/Fries_Remove_Background_qy659i.png', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676449/photo_2025-04-21_15.53.36_ifwwcv.jpg', 'Port harcourt, Nigeria', '2025-09-12 00:00:00', 0, '0.00', 0, 'blockcred.ng@gmail.com', '+2347044831729', '2025-09-12 11:42:05', '2025-09-12 11:42:05'),
(6, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', '9336abf4-c39e-486a-9248-f61c057a9904', 'BlockCred.Sui', 'Founder', 'Blockcred.sui is a credential management system primarily built on sui', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676426/Fries_Remove_Background_qy659i.png', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676449/photo_2025-04-21_15.53.36_ifwwcv.jpg', 'Port harcourt, Nigeria', '2025-09-12 00:00:00', 0, '0.00', 0, 'blockcred.ng@gmail.com', '+2347044831729', '2025-09-12 11:48:21', '2025-09-12 11:48:21'),
(7, 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'f2c9c487-cfad-4968-b956-d753f17d2ba5', 'BlockCred.Sui', 'Founder', 'Blockcred.sui is a credential management system primarily built on sui', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676426/Fries_Remove_Background_qy659i.png', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1757676449/photo_2025-04-21_15.53.36_ifwwcv.jpg', 'Port harcourt, Nigeria', '2025-09-12 00:00:00', 0, '0.00', 0, 'blockcred.ng@gmail.com', '+2347044831729', '2025-09-12 11:50:53', '2025-09-12 11:56:12'),
(10, 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'd2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'NicPad', 'Fine Art master', 'French Paintings and nice objects', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759309070/1_rhcudk.jpg', 'https://res.cloudinary.com/dlbbjwcwh/image/upload/v1759445020/8_knfpwk.jpg', 'France', '2025-09-16 00:00:00', 0, '0.00', 0, 'nicolas.padovani@wanadoo.fr', '+33781822616', '2025-09-16 19:09:28', '2025-10-06 12:35:38');


-- Table structure for users
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `settings` json DEFAULT NULL,
  `role_id` int DEFAULT '1',
  `membership_tier_id` int DEFAULT '1',
  `status` enum('active','suspended','pending') COLLATE utf8mb4_general_ci DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  KEY `membership_tier_id` (`membership_tier_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`membership_tier_id`) REFERENCES `membership_tiers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for users
INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `updated_at`, `settings`, `role_id`, `membership_tier_id`, `status`) VALUES
('039d7712-5163-4dd6-8fd9-887e6f8289a9', 'FullEarth', 'deerfieldcolony1@gmail.com', '$2b$10$9SiXf7Un8I1k72ibdVdAkeynt5F.sasEr4y.2/YhUgGm7pOUTkMHq', '2025-08-02 11:46:35', '2025-08-16 22:43:11', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 5}, "borderRadius": "none", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": false, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 12, "small": 11, "heading": 51, "subheading": 19}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#000000", "accent": "#c0c0c0", "border": "#4b5563", "primary": "#808080", "surface": "#1a1a1a", "secondary": "#c0c0c0", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "solid", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#ffffff", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 3, 2, 'active'),
('052655f2-ae30-43ad-adb4-04298cd3b117', 'Testing', 'emmanuelhudson355@gmail.com', '$2b$10$6/Xs/L.iO0DSo4QCp4LEheAw6UeDf5KUhniVUpggekhuHhK8kdpzq', '2025-07-31 01:02:24', '2025-07-31 01:02:24', NULL, 1, 1, 'active'),
('05a3018b-498d-464f-a31c-0857c55a6a89', 'Sun33', 'Nalatransit@gmail.com', '$2b$10$PPsx8YQyMS/3FbObWi0m2.0cETAdty4jIdRwhX0mEi6VCD/dcIJau', '2025-08-15 13:19:36', '2025-08-15 23:45:46', NULL, 3, 2, 'active'),
('085a0a9c-a10d-4d0b-86df-74403d3b3690', 'reelrarities', 'reelrarities1@gmail.com', '$2b$10$L.Cayr3mTt98rP1REd.ycORFq7LgGI0eCL4NWKs/tugLiFgWWqMYO', '2025-08-05 11:49:48', '2025-08-15 23:49:04', NULL, 3, 2, 'active'),
('09e61cbe-2562-47df-b517-b893980ca4cd', 'PapiSuave', 'mdrob242@gmail.com', '$2b$10$7alwvC33owLuWKVylr4G6.TaAOz58NM3Gte0ohbuEudQOhogzSgQq', '2025-08-01 19:59:44', '2025-08-01 22:19:25', NULL, 3, 2, 'active'),
('0d495d79-e9c5-49f6-a568-aff7e202f88f', 'Sean Williams ', 'Seanrasheen@gmail.com', '$2b$10$eZ05m.28w.CwGfUq7DqCa.RSVGqGaNslUCLUGa9mPQ25aWVUAY78i', '2025-08-02 00:54:58', '2025-08-04 18:21:18', NULL, 3, 2, 'active'),
('1173c738-8d51-43bf-9240-0a8cc50d9098', 'Zeba1601', 'sebamoeckel@gmail.com', '$2b$10$RK3zhm7uR5S6zLh9YEJfY.1l74zJA18qcW99ApaKEO60C1lnBn1fW', '2025-08-02 16:35:00', '2025-08-02 21:15:49', NULL, 3, 2, 'active'),
('1314b0cf-559b-43db-b13c-507a12d8e520', 'Akame', 'akame4473@gmail.com', '$2b$10$St3uigk1qqelgkGM3NbAsOIVJtWKC5PVxM7NMzzS/P9oadw5q/EbG', '2025-08-04 17:02:50', '2025-08-04 18:13:57', NULL, 3, 2, 'active'),
('14e63306-0162-4ff9-98df-77ade30b5f88', 'ErosCya', 'erotokritosmichaelides@gmail.com', '$2b$10$3vNQjpvpdnTYmoRo2xf88.vifYQKOfgOkTdT0RKzGxnNunGFbRsWC', '2025-08-06 12:46:38', '2025-08-15 23:48:13', NULL, 3, 2, 'active'),
('187fe6c9-ee46-437a-bd21-501a5d8abe1b', 'fraser1104', 'fraserlawson51@gmail.com', '$2b$10$qlpaL/gL4FwYZvZB09.e7ubb769tgmCLqBOnuL2vzaVYvRhxyyntS', '2025-09-14 17:05:55', '2025-09-14 17:05:55', NULL, 3, 1, 'active'),
('18aca1f3-fe5c-4e5a-84db-d9a38fa3c31d', 'AZMountainWater', 'ArizonaMountainWater@gmail.com', '$2b$10$Io/hjnEn1vDw1ppnonJIf..8vBV1bhIsYjmjftlswqtDl7NkgJKLG', '2025-08-27 14:23:40', '2025-08-28 01:10:11', NULL, 3, 2, 'active'),
('1aa7717e-510c-406e-bdd7-d32e90a1603f', 'xrpfather', 'himesgelo@gmail.com', '$2b$10$W/zzpEDfJgvYXnx/GpUFPOBJvmYSHTHfeKxPltl3NjUriDn.ASFMC', '2025-08-06 14:08:01', '2025-08-15 23:48:04', NULL, 3, 2, 'active'),
('1d9db35c-e67d-4915-bf02-54d9e9bc7736', 'Big Remy', 'remivictor20@gmail.com', '$2b$10$MJYFzWz926EFKYfNsS1q3uZsfO4Jyr.iIzSiU10bvrxaCzvHazCN6', '2025-09-12 12:05:14', '2025-09-13 18:41:21', NULL, 3, 2, 'active'),
('234f4b06-158b-46b3-a549-c834345afbc1', 'cartervail2', 'cartervail@icloud.com', '$2b$10$uMsuz6OzLIQ2lC2QLfs90.Eq069Os.0tXp5KicoDAkkdJxg5ydEXe', '2025-08-08 15:38:23', '2025-08-15 23:46:18', NULL, 3, 2, 'active'),
('2364093f-06d2-46df-84b2-203a0e72099c', 'M-BAH', 'muarsool1997@gmail.com', '$2b$10$CXKQG9eggrNH6hZEeogRHeqIBTYseZ/sT6MNE5Bk.wSW.SxRXEbfi', '2025-08-20 06:58:52', '2025-08-21 22:04:35', NULL, 3, 2, 'active'),
('25e1ec3d-8e06-4c94-a634-b87ced0e5e96', 'Esthereniayo', 'esthereniayo@gmail.com', '$2b$10$VQ1FMNQ9/0DvAfRkwu4uTOpVuC3N9Z/xP7UxmJu.Ul8/PTezAAx5e', '2025-08-01 17:23:13', '2025-08-01 22:21:46', NULL, 3, 2, 'active'),
('28f1b5c9-3602-45f1-9b1e-80b352434002', 'Dtvaroch2', 'Danielletvaroch@gmail.com', '$2b$10$d7CZL6dvbA9r5PIC3kkX..UghDRBkq0HbMZbyVqF5VCMy7yVKIFla', '2025-08-01 19:11:41', '2025-08-16 23:03:25', NULL, 1, 2, 'active'),
('2990fbe4-d652-48f4-baef-0b31ad30bb2a', 'Mike H', 'mike.harbison@aol.com', '$2b$10$quLiBEoW.6j5sSEZq47VceDON9cxjquSsXQkIIU5J/yoQPoUiIKvC', '2025-08-01 19:55:53', '2025-08-01 22:19:32', NULL, 3, 2, 'active'),
('2a46ff9e-eb44-4dbb-9f9b-c5600f5fa827', 'DrewFire01', 'Andrewstarling1007@gmail.com', '$2b$10$iZE6k9ozAcjoimGu1L9.Ru2Ma3Iz8J/vHOOe5XOl3Y43vnMpH02O.', '2025-08-03 00:23:01', '2025-08-04 18:15:18', NULL, 3, 2, 'active'),
('2b3819c7-6b99-4ce5-9ab6-733cd6d89c79', 'ELTOPO', 'aaronjamesoverend@gmail.com', '$2b$10$Kg5Lc/HcUMGIgAeWnYrRsOXmTTyn3hDpPjQdx3NP9lZ.k/sKzEI4q', '2025-08-02 17:47:38', '2025-08-02 21:15:41', NULL, 3, 2, 'active'),
('2b5e79b4-e06c-4315-8e7d-c1416dbbebaf', 'Cryptos', 'crypto_sid_@hotmail.com', '$2b$10$PkBTrMyMAjayK6ve7oNon.hA.gWFbslZMrhPMQbMNdGN8DkA68i/a', '2025-08-02 21:58:42', '2025-08-04 18:15:44', NULL, 3, 2, 'active'),
('2e37faa3-b60c-4c5a-b914-3abedbb1a96e', 'Rickemon', 'rickmontes1@gmail.com', '$2b$10$tw3pKFhXHWXTqx24sa4xnucdErKdaDljqLfBCZsNd5gsv1Z/FeUmu', '2025-08-04 02:00:11', '2025-08-04 18:15:04', NULL, 3, 2, 'active'),
('2fd6bdad-77af-4b8e-8fb4-bb6f6ab0cdfd', 'Leoh31130', 'cornet.remy01@gmail.com', '$2b$10$EpCr7tVW1/aGTY9ILx7ze.LKG7D8XW0nXoWFw3R3FIXTGpxzMCMvy', '2025-08-02 09:22:41', '2025-08-04 18:19:27', NULL, 3, 2, 'active'),
('315a7c50-1fa5-4705-add1-cecefad26e3c', 'jason', 'stathamjason618@gmail.com', '$2b$10$bJKJh3S83IFvdhNrSa2T1OQGLuuv9.eY.cXMGOKcfYoHcVbIchKxK', '2025-09-10 01:10:24', '2025-09-13 18:41:27', NULL, 3, 2, 'active'),
('401ab372-d223-4780-acf0-dfbb2adf09ee', 'SKYLON ', 'hipomap2010@gmail.com', '$2b$10$AXR50IJYpVmQIDItmN.mDOWp8yMYj2t2QsyZpjYnUVDG/43.6/zL.', '2025-08-04 02:57:43', '2025-08-04 18:14:56', NULL, 3, 2, 'active'),
('49944aa2-f8a9-4f49-a295-c0742c213662', 'Surreal Elysium', 'surreal.elysium@gmail.com', '$2b$10$PmHnDy5qyVoMRbS.CAbYneKNicMM3RIixorljG5qUN.R20TgC324y', '2025-08-01 21:22:18', '2025-08-01 22:19:02', NULL, 3, 2, 'active'),
('499a84ec-b8fe-4470-908d-1f14500ccfe5', 'Hydra', 'jynxzi1776@yahoo.com', '$2b$10$.zGLeslJobU.fYNLv23zP.bgm.v4mLt.b38wInKuD15xO5SI436s6', '2025-08-02 01:34:43', '2025-08-04 18:20:50', NULL, 3, 2, 'active'),
('4ad3e3a2-2d99-4aaf-b788-17881362a0fd', 'Charli3', 'charli3maddocks@gmail.com', '$2b$10$oz5Db3Ju7/fAE30/CLuz6e7cFyQN70ifuHNSEaJa2Mjsc9PPOIp2O', '2025-08-01 19:13:22', '2025-08-19 01:40:20', NULL, 1, 2, 'active'),
('4bad0d5e-92d4-43e2-919a-5d4b8e9eae1a', 'SilverGoldGpa', 'silverandgold4me2@gmail.com', '$2b$10$C0ngDwdODdjDqfWiDnfeZO4H5JNRc2MbK7oEYO/1.dpuyrxDVopJa', '2025-08-07 16:25:31', '2025-08-15 23:46:46', NULL, 3, 2, 'active'),
('4db4233d-fa69-4ab6-9126-74339c8fecd4', 'utunkarim2', 'utunkarim2@gmail.com', '$2b$10$3.uR/u68quTVbDETyvPKf.V5uQxmQGZe7aK0DkN5OkfTyZQ5TUO/q', '2025-08-17 03:52:39', '2025-08-17 05:31:36', NULL, 3, 2, 'active'),
('4f6103fd-199c-4852-bc09-2bc42693b9c6', 'HunterX', 'cameronengelbrecht@gmail.com', '$2b$10$4gezD4AgTdOiCG1ElQrESOCXNDQwxDukq8oX7Yf2WApqIgz0VPs12', '2025-09-21 18:57:09', '2025-09-21 18:57:09', NULL, 3, 1, 'active'),
('4fe6ce1d-2f4c-4ed2-aea0-4180efec058e', 'ddcabella', 'ddcabella@gmail.com', '$2b$10$3La4.MZItqLno6M06YF4V.1XEuvBP9NN6i7ZBsVaxZ2EIdj0FzYnS', '2025-08-17 09:25:53', '2025-08-18 11:50:30', NULL, 3, 2, 'active'),
('511533db-014a-4a92-b8e9-25ba2d11845d', 'BrazilianBBQBoys', 'brazilianbbqboys@gmail.com', '$2b$10$h2rCgnvuupXAX/gjmXfZlOxtJNkAy/p/cBLqIafGwUR.t.dZCKyne', '2025-08-05 02:11:07', '2025-08-05 23:39:47', NULL, 3, 2, 'active'),
('52ad2b71-965c-4dd3-a027-575b93980c2c', 'Chendy ', 'hoangtinh1023@gmail.com', '$2b$10$1A4.FUBtDTEdqqruNV4v7e0dryy.2k7HjgNlKuVDTFmwa/rIzYwUO', '2025-08-01 23:29:36', '2025-08-01 23:43:41', NULL, 3, 2, 'active'),
('5728dce0-413f-49cb-b08d-76e7f06a01f0', 'RipplebidsCEO', 'ripplebids@outlook.com', '$2b$10$sbdxRGTDacIkVoRayhde0.j.QEwvbRBZsnKVmNOY/5iDqa0swZ91y', '2025-08-01 19:23:52', '2025-09-09 12:57:24', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "sm", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 3, 'active'),
('5c36c202-d883-4280-95cf-d1b53d510939', 'BigSam', 'simonsamuel195@gmail.com', '$2b$12$qWmDUk/7ISTEl7Z908T2Xu3eyzPqCB8AUKsdvbfnMgJQpJntebmde', '2025-09-06 15:22:20', '2025-09-13 18:41:38', NULL, 3, 2, 'active'),
('5cdcf895-bf38-4214-aa4e-a46de215516c', 'ZeroProfit', 'daanretrodev@gmail.com', '$2b$10$c5N4dwdumEn8phkwqh4AMetZMAdzPr/gdasJp2DUG3.r.d0s9Ewi.', '2025-08-01 19:04:30', '2025-08-01 22:21:26', NULL, 3, 2, 'active'),
('6463f773-f9f4-40d3-980a-60c2ae801041', 'HappyBidz', 'elower1976@comcast.net', '$2b$10$e1dGh54f/7reLPSCCTlO1uSe2mNihicYqcoUZsDCDNT05dY/YD1fS', '2025-08-01 22:59:26', '2025-08-01 23:44:00', NULL, 3, 2, 'active'),
('6727cb79-0093-4812-b02b-438b48fdf19f', 'rolcardona', 'cardonarolando24@gmail.com', '$2b$10$7qlKYo89b8ucmZe8rGG9jejRGpLtYhyV/C8YAhLvR8IqtlVvU1PJC', '2025-08-02 04:56:09', '2025-08-04 18:20:18', NULL, 3, 2, 'active'),
('6a0d2b0c-3de1-473e-9391-8853a60279e1', 'Domsdead', 'dominic.bradley29@gmail.com', '$2b$10$fRT2t2YqqQsy3rP6a0S5VO/5QMDXP6ywiJGM4qqidwb4/WMMRjcPS', '2025-08-04 16:54:33', '2025-08-04 18:14:11', NULL, 3, 2, 'active'),
('6bc1bc70-9797-40b6-83a8-f4f54c434c69', 'zonetect', 'info@zonetect.com', '$2b$10$i9guhmUF3oJgOgMfeL8QoOc6RkRa8r83NmMIILFra8pzqg3GAt6o6', '2025-08-17 17:06:21', '2025-08-18 11:50:16', NULL, 3, 2, 'active'),
('7381718b-b0d1-4dbd-809c-540bffd8a931', '8884u', 'zipperwhippet@gmail.com', '$2b$10$aOS8zdEclnpegkw2fMDv0uE2I9mziYsPQwcNn1MZ9dV4iy6UMGiPi', '2025-08-02 22:34:50', '2025-08-04 18:15:33', NULL, 3, 2, 'active'),
('75507571-3c75-4261-b994-0f8a6f6e19f2', 'Cptfomo', 'ogfomo1@gmail.com', '$2b$10$MhvYzBUvCQ2S.SZpmlG3cOlCBDdOEkfZ2KILveGU16NYSH4aNJ396', '2025-08-04 18:16:21', '2025-08-04 18:21:59', NULL, 3, 2, 'active'),
('75c36d48-1328-4a50-9ed5-77730e9cc567', 'Tedyobski777', 'teddy.tadios777@gmail.com', '$2b$10$.0pvEs44qrxVLT8C/RaQ0uaNJZ.InsvM9vWE5eWkCSg1SNucKykNK', '2025-08-30 14:12:29', '2025-09-13 18:53:19', NULL, 3, 2, 'active'),
('75d2f82a-bd10-4cea-8aec-98518d667e7b', 'cryptosphere34', 'cryptosphere34@hotmail.com', '$2b$10$hThMb0l.GFKDdhOx/2/yyuZABbtOCUcE3ZpwuyPVf6urVZD.8J/rS', '2025-08-08 14:41:54', '2025-08-15 23:46:27', NULL, 3, 2, 'active'),
('7708d7df-2ffb-4532-8a15-fe270bb1c109', 'Rufus Toothfist ', 'awanderingponderer@yahoo.com', '$2b$10$QjLaCfpeVVhXyC1QwZrRN.GBVtJaamz8FbxWmcw9xmJzKJH/hB/WS', '2025-09-05 22:17:34', '2025-09-13 18:41:43', NULL, 3, 2, 'active'),
('7793b9f4-ae0b-433f-8019-b3b3902e6dd1', 'Alprinc', 'binsuwaidan.ss@gmail.com', '$2b$10$XHpAOwd44bg03oP1oRKpa.g8p.SKcC5eTZqrTHs27kveuWXSjeWK6', '2025-08-14 20:07:41', '2025-08-15 23:45:55', NULL, 3, 2, 'active'),
('7a870eb8-50f2-4396-9185-58fc0a0d6b29', 'drophunter28@gmail.com', 'drophunter28@gmail.com', '$2b$10$2wNgv9AJwFtNOUnmhbbNE.64nKTZxoeJk5JDPAqEXQJJdo46mYGjG', '2025-08-02 11:26:14', '2025-08-04 18:19:09', NULL, 3, 2, 'active'),
('8966824e-28e4-4829-afb6-663ac276b7ad', 'devtomiwa9', 'devtomiwa9@gmail.com', '$2b$10$vsIWzelYialsTSngJ/H6eeSaHwd8lac2d.n15rsoZ19BqU.0uomNy', '2025-07-25 07:38:45', '2025-08-26 22:02:46', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": false, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 2, 'active'),
('8b9b36f6-4be0-477a-89e9-e47e9e77d7a4', 'alghaithaljamel', 'alghaithaljamel@gmail.com', '$2b$10$p5tcbA.BlSFgZ7yHhK17vOwj7fQvnZK3G6jvWyLN/DrrjPkkBeKDG', '2025-09-01 23:35:57', '2025-09-13 18:52:48', NULL, 3, 2, 'active'),
('8d7cc243-ad53-4144-bcf3-2058658ad213', 'Shinigami117', 'derrikphicks@gmail.com', '$2b$10$N84IYaxhgYdL.xbNZ1Nf/uNZe/5rXevXcR34zbDBbV5WdG6rm6NLW', '2025-08-10 16:38:13', '2025-08-15 23:46:10', NULL, 3, 2, 'active'),
('8e173f46-823d-4e4f-8981-2c30eabde2aa', 'TurboFrankXRPL ', 'fdeschamps115@gmail.com', '$2b$10$vrWddKI08nMNczqI9OZ6SOjbJNwZGU1mFGLjzDM4J/zHxR3vRTXJi', '2025-09-15 01:28:31', '2025-09-15 01:28:31', NULL, 3, 1, 'active'),
('8ed0386a-6467-41fd-8ab3-c50d2813f0fd', 'Chinny', 'achinchic@gmail.com', '$2b$10$C5nTspkia5Ey8nCDXpjZP.ALnkB0qbz6eOVMJRVONIJA3Q3GbFxj2', '2025-08-01 20:07:24', '2025-08-19 01:40:36', NULL, 1, 2, 'active'),
('8eea3a76-97df-438f-9685-f978cadacc77', 'kimmybaby02', 'kimberlyrenee244@gmail.com', '$2b$10$Qc6ie4.qT5WgUaRYSwvIqOEPUGu.MnXEkk05MunULmoy1hyYoUw6m', '2025-08-01 19:09:35', '2025-08-17 14:41:04', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 2, "tablet": 2, "desktop": 4}, "borderRadius": "full", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "purple-haze", "customColors": {"text": "#ffffff", "accent": "#ec4899", "border": "#4c1d95", "primary": "#8b5cf6", "surface": "#1e1b4b", "secondary": "#a855f7", "background": "#0f0f23", "textSecondary": "#c4b5fd"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}, "spotifyPlaylist": {"enabled": true, "autoPlay": true, "position": "top-right"}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 2, 'active'),
('8ff7eae8-631c-4440-ad59-1d40f862ace0', 'David', 'drg9123@gmail.com', '$2b$10$bSuU4pfCBBc/m3sdfK2T7O.gsgSEV1yEp7s3Tdo6nOBovUqM5oase', '2025-08-01 22:47:44', '2025-08-01 23:44:32', NULL, 3, 2, 'active'),
('94128f57-09b0-4d6f-89ae-11beb99a8cd1', 'Coolitems100', 'mysupfun@gmail.com', '$2b$10$rjRrVnm/XeniKPw8zUx5guzlYa.8Y3e6FTNNZgkv7jYF5wgezG5dm', '2025-08-04 04:39:40', '2025-08-04 18:14:47', NULL, 3, 2, 'active'),
('959d1e27-a851-4b61-b029-bebef6942945', 'Chappelle4life', 'johnathan.t.butler@gmail.com', '$2b$10$lLNCAwqMONedMq4uvISJve5CVjT60y2fxoqAJW4AuGAmEGC3dopb2', '2025-08-07 03:16:43', '2025-08-15 23:47:04', NULL, 3, 2, 'active'),
('9bb3fd9f-8082-4f82-83d4-b2b12cef42af', 'INHO', 'dlsgh3760@gmail.com', '$2b$10$H8xlhk1juIYwSp6r.YYE0ud4igeLVeob0CEIx4rw3YAa7t4qfZLKm', '2025-08-28 08:09:08', '2025-08-29 02:23:47', NULL, 3, 2, 'active'),
('9d8a7b4b-53ff-436d-b1ad-7b097978af6c', 'Neo', 'namangwl2005@gmail.com', '$2b$10$uC6IZnGtgnrOQCWkOGPxReiOoVoDicytARtP59TqleQ0bLPVbRVTi', '2025-08-05 14:28:52', '2025-08-18 07:06:23', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": true, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 3, 2, 'active'),
('9e84ae99-d7d0-4ced-ae75-4753175e494d', 'ENPOWERSPORTS ', 'corvetsr@aol.com', '$2b$10$Cg3Y4XspQzwC7V8QtFpe5e8A9dr1kuKX6Oc4pK9lW4IdnzhVMiba6', '2025-08-20 16:57:03', '2025-08-21 22:04:09', NULL, 3, 2, 'active'),
('a0630200-7843-4ae4-9d7d-47df03806b31', 'Victor ', 'engalipiodaibes@gmail.com', '$2b$10$WQYeVAYSBwMA7yA9/IVQj.VFtJGGdI4lwac0kdf8t.IaDYXKXOTFW', '2025-08-01 23:48:39', '2025-08-04 18:21:37', NULL, 3, 2, 'active'),
('a2c1667d-4de4-418f-bb54-1d6496c6661c', 'AaronE', 'aaron.eigenman@gmail.com', '$2b$10$eXVWgyhdDDQfxMoUwkx40eis3xpsKVj59X6KTpeTA8MPn.5qmeJgW', '2025-08-02 00:29:44', '2025-08-04 18:21:27', NULL, 3, 2, 'active'),
('a4226274-e795-4d25-939a-f089f3a7d73b', 'trendingusername09', 'dev.steadfast4@gmail.com', '$2b$10$YSRv3bPrPDOsOX7J1rJLye1sW9zQAG.fJUujRZsZJALx7ip45A06K', '2025-08-01 18:29:53', '2025-08-15 03:52:08', NULL, 1, 2, 'active'),
('a46dd041-50e7-42b5-b613-ca407ab9188b', 'GarGar15', 'gdgsatx15@yahoo.com', '$2b$10$/cJlMzbDVV8Vp2a4DdU1H.eJhMXbQcQArEAyfrpYi0qejWYPIiEeO', '2025-08-01 19:09:01', '2025-08-01 22:21:17', NULL, 3, 2, 'active'),
('a5a64899-d629-4242-88df-b645677374ed', 'Chuckdeez', 'chuckiectg1987@gmail.com', '$2b$10$1EMLIqDUFaC93hdI/nI3v.jwV/7i5YN3XVcOpu.rJB3eXCuO7V/hu', '2025-08-31 22:02:35', '2025-09-13 18:53:00', NULL, 3, 2, 'active'),
('a7ef51c5-58d4-40bc-b90c-936c5d5738af', 'Managewithtega', 'tegaakpoyibo14@gmail.com', '$2b$12$GhUFWySLGM.8qsmNhvKx/.4J.E94R3qMBmE7sSIwXJCOz19ekN8tW', '2025-08-27 20:45:51', '2025-08-28 01:10:06', NULL, 3, 2, 'active'),
('b04397fc-e89f-4647-8ed4-bf01e0f8a00c', 'Hopscotch', 'hopscotch', '$2b$10$bZmAQYkihfNP5zVBDpZPEOfdhZFF4WlUFVx3.2zlqI5BMH08A05iy', '2025-08-06 09:38:05', '2025-08-15 23:48:23', NULL, 3, 2, 'active'),
('b0c19acc-8207-41a4-bcf4-316c098ddd9f', 'AnthonyMirab10', 'atrain56@comcast.net', '$2b$10$NVNhGN0BuLybsedO8RJrFudSL0lXuiwE5sGypcIsZ7sERhXTBBEly', '2025-08-01 19:35:32', '2025-08-23 17:17:34', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755969451/storefront/backgrounds/FF1E4DB1-0C7A-4F27-9C42-5010634CB9C2_2_bkcifr.png", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "image", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755969376/storefront/backgrounds/64D0253F-5BA7-4CE3-A9FE-034E227F3348_pck5pi.png", "blur": 0, "opacity": 0.4}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 2, 'active'),
('b34a8e57-18ad-4adf-a3e1-a34743be6a6b', 'Themojodev', 'lemaitrestudio@gmail.com', '$2b$10$dN.JNhrBt05Fqpvh8iNo4e43/M/g8pp1lJlnMDu1F3ww1HzblnPYS', '2025-08-25 14:25:24', '2025-08-25 16:47:37', NULL, 3, 2, 'active'),
('b56587a6-ad15-4613-b22e-eb8c1cb35b39', 'Mujtaba', 'muarsool@gmail.com', '$2b$10$0CA.KGFEX0HIPmcEGYELqeDP8eEceWzdXzycswXBRgiG49cKfQYqm', '2025-08-05 09:40:46', '2025-08-23 08:19:18', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 3, 2, 'active'),
('b57b6a59-e35c-4781-81be-28ca97c213fa', 'MAX JEFF ', 'maxjeffofweb3@gmail.com', '$2b$10$qtEYvbefpJSipS5nKvwJEuPF5p.t9wIrcuGrLRG.H4rBlO5a5uAvC', '2025-08-01 19:09:25', '2025-08-01 22:21:07', NULL, 3, 2, 'active'),
('b92baae1-b21c-48f2-b34a-1be23fbe19b8', 'JuanTuTri', 'johnsiochi03@gmail.com', '$2b$10$n6kwb5/MUS4cFQvFlQ4Z4Ol3bG.PCvOAbI5yJphajOpfwlJk3AdOK', '2025-08-01 19:11:50', '2025-08-01 22:20:33', NULL, 3, 2, 'active'),
('ba39d346-9a3b-494a-8ad7-08254038271f', 'XRPLifer', 'nemesioaleon@gmail.com', '$2b$10$WQDmT8XVrcrId/2akoquR.KsrJK0V9g1bQwuMhnEbxOexLl/c1cD.', '2025-08-02 14:40:00', '2025-08-04 18:18:10', NULL, 3, 2, 'active'),
('bc2ebd7e-7cf7-4352-aa9a-50c2f7dd85d5', 'heyitskuni', 'heyitskuni@gmail.com', '$2b$10$5AgjRecBMie0dgfhLogvd.k9LVGFlPpROQhs540JHwPDV6ZLMTp2q', '2025-08-02 04:49:28', '2025-08-04 18:20:28', NULL, 3, 2, 'active'),
('bc3ec134-3139-4c62-81cc-eead774b9410', 'Motino', 'mohammedolaoye09@gmail.com', '$2b$10$W8lB.LTk4YsJm3DdATPeaeOOUWbvVyMMaeScJzEykM1FHQGEJsl66', '2025-08-02 04:34:47', '2025-08-04 18:20:40', NULL, 3, 2, 'active'),
('bfbde9b2-f63b-44a2-8ae0-b06f3bcebd01', 'Hatter', 'mr.shepardsonbrewster@gmail.com', '$2b$10$rt7d3go8SH9S5mqh4DSlEuydEQSp6NO/xOP9FUH4IgJbtZ8u2ETSu', '2025-08-03 14:54:35', '2025-08-16 15:20:44', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "sunset-orange", "customColors": {"text": "#ffffff", "accent": "#8b5cf6", "border": "#c2410c", "primary": "#ff6b35", "surface": "#2d1b14", "secondary": "#f59e0b", "background": "#1a0f0a", "textSecondary": "#fed7aa"}, "backgroundType": "gradient", "gradientColors": {"to": "#dc2626", "from": "#f59e0b", "direction": "to-bl"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}, "spotifyPlaylist": {"size": "full", "enabled": true, "autoPlay": true, "playlistId": "37i9dQZF1DZ06evO0D29gc?si=uVwONpMWTqODCbrCxMIdQQ&pi=fe4vcbJLSQyog"}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 3, 2, 'active'),
('c1812920-c6e7-4d4b-a8be-4fb4df09a2eb', 'Trek Outdoor Co', 'trekoutdoorco@gmail.com', '$2b$10$DxAnOYZu/l0IFDcuSRiI4ekmAVt1m1OwsJbnEwMlW.E3kFO68nztu', '2025-08-26 13:58:52', '2025-08-27 12:02:14', NULL, 3, 2, 'active'),
('c40146e5-9ec5-4b57-b204-f464634489bb', 'whit4034', 'britneykristine24@gmail.com', '$2b$10$.tst9Vs6mYic3LSMA71OYuMQpRqLelPIlp3/T7TQi.5EuUBcBYMl.', '2025-08-20 19:00:58', '2025-08-24 14:44:20', NULL, 3, 2, 'active'),
('c61cde9c-197f-45e8-b881-d6f67bc60e6a', 'anonymous_1753797191921', 'c61cde9c-197f-45e8-b881-d6f67bc60e6a@anonymous.local', 'anonymous', '2025-07-29 13:53:11', '2025-07-29 13:53:11', NULL, 1, 1, 'active'),
('c697b17e-74af-492e-abe5-258ae1f85cee', 'tomb3169@gmail.com', 'tomb3169@gmail.com', '$2b$10$Zrv5mbyzHoUPPKLg2HluyOaJwX0zWszmQz67WtDF74LDjhwwcq35u', '2025-08-05 10:10:33', '2025-08-15 23:49:20', NULL, 3, 2, 'active'),
('c790a6ca-3091-4e41-82b0-c5e9b896a8cd', 'BURNXRP', 'burnxrp@hotmail.com', '$2b$10$XZQDQyctbtpu2iaQWWrJyOXtHA35NJtJ4quwAwFZdgudjyLPZ3PWi', '2025-08-04 13:10:10', '2025-08-04 18:14:27', NULL, 3, 2, 'active'),
('c7cd7ec3-4b68-4a17-aeab-c3be3ba4adf4', 'bukkyp', 'bukkyhassan80@gmail.com', '$2b$10$0f5/iBnhah9Uz0Dfz9ZwN.VfWWDeUVED6zKXqzDECWiN3NDVRq.4u', '2025-08-07 15:42:13', '2025-08-15 23:46:55', NULL, 3, 2, 'active'),
('c8a91109-10d1-4b90-9513-06152b7c9cfc', 'iwannagofast', 'bt@tenet.fit', '$2b$10$g5mtiFAYH5Ou.7iZ7IE3NuFgfe/N3r8gWupopdTC.QqO1BlmtkxLm', '2025-08-01 23:04:52', '2025-08-01 23:43:51', NULL, 3, 2, 'active'),
('c95b9071-c7aa-4c05-8db1-b3208ec42f94', 'Stevewheeler777', 'stevewheeler_26@outlook.com', '$2b$10$cDmIPM6xjH.qeJ9wSGm7ve0zP9xbAXOOreYKZlkV1doH9SBZ7.FJO', '2025-08-01 19:10:22', '2025-08-01 22:20:50', NULL, 3, 2, 'active'),
('cac3677b-65c5-4ccc-b975-41e9ca944e53', 'Jhaas11', 'jhaas11.jh@gmail.com', '$2b$10$xAyjYCedRvN3671IvOV6NOACXGvh9VBC.nzV8nJyk0b/oyCLEfIva', '2025-08-01 19:33:36', '2025-08-19 01:40:50', NULL, 1, 2, 'active'),
('cba7d6c9-8845-4f60-9a16-fd58213338bd', 'Jethro1979', 'jethro.pelamonia@gmail.com', '$2b$10$PBjyrRSdofzXtgtP4L1bx.jtlwCRTOlDtYvPhvuTWNQIaxwH85Ut2', '2025-08-02 21:50:38', '2025-08-04 18:15:56', NULL, 3, 2, 'active'),
('cc8c5195-9583-4a2e-b707-1fc8c0f86d71', 'Liquidassetsboca', 'Liquidassetsboca@gmail.com', '$2b$10$HlEFbQlC95wQEXPOoYeKMeG7xmL3M5jKRBgwf/B6bnxrMF03A.afm', '2025-08-16 18:09:35', '2025-08-19 11:56:11', NULL, 1, 2, 'active'),
('ce4b5368-add3-4edb-997d-85dc1e1fc2b6', 'Can', 'holmoby53@gmail.com', '$2b$10$feAPegmcS712T9MPuFf5WOqHob5e5OZYqdNBhwgRKvbrx.y5aVMvu', '2025-08-04 13:45:02', '2025-08-04 18:14:19', NULL, 3, 2, 'active'),
('ce5f0d9f-1e0c-40d6-8594-aee1db571482', 'miawalkergaq', 'miawalkergaq@gmail.com', '$2b$10$M5DKA2t8Dz5ZA3aFe2Bl/ek5GeOQ799PXmWnNQRgVMd/PBF61YKqe', '2025-09-19 08:38:38', '2025-09-19 08:38:38', NULL, 3, 1, 'active'),
('d1382ea4-9a6f-4fdb-bb88-67e146160cf8', 'Alex', 'shaptefratia@gmail.com', '$2b$10$O6ZIcfk/ke1yV7En6g.Kl.Ci1DLlz0ZrvkPd0c8fJa0CV0UiUyg0u', '2025-09-09 05:52:01', '2025-09-13 18:41:32', NULL, 3, 2, 'active'),
('d181fd42-9ebc-4cf6-847b-9886e20723f8', 'AZ Mountain Water', 'arizonamointainwater@gmail.com', '$2b$10$jAhKJMR1lLR1aEDsC85jUuC1r2dTrlRHK5qL9xLfmQQYG7ikFe.Wa', '2025-08-27 14:21:56', '2025-08-28 01:10:18', NULL, 3, 2, 'active'),
('d2db09ed-1b3c-4786-a50f-f8e13f3399d4', 'MKT98', 'marektwarog@hotmail.ca', '$2b$10$q4kyigTs7J3NSAf0FDvyR.OWOz3VUOlRmaN5GqJWIXA5Co61P/.Ve', '2025-08-02 10:28:53', '2025-08-04 18:19:17', NULL, 3, 2, 'active'),
('d2eb3049-9ded-4a0c-a1c8-cc59e4484412', 'pinzut17', 'nicolas.padovani@wanadoo.fr', '$2b$10$uQ1mQPqB9v284mez/ibSh.o1UnRv4EIBb1t1e1RyH0eGv0YwubTGa', '2025-08-01 19:38:05', '2025-09-22 22:36:24', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "cyber-blue", "customColors": {"text": "#ffffff", "accent": "#ff6b35", "border": "#16213e", "primary": "#00d4ff", "surface": "#1a1a2e", "secondary": "#0099cc", "background": "#0a0a0a", "textSecondary": "#b3b3b3"}, "backgroundType": "image", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1758578451/storefront/backgrounds/c2011_gnivfl.jpg", "blur": 0, "opacity": 0.9}, "spotifyPlaylist": {"enabled": true, "showCoverArt": false}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 3, 2, 'active'),
('d606f7b9-f445-4559-9bdd-28f8c881693c', 'Carter', 'dylincarter99@gmail.com', '$2b$10$Up0naPJ59BN1ZKEtpm/.Bu2MGQoRP50dKCAk1ZXaFuxCZc2A8tPAC', '2025-08-05 19:22:17', '2025-08-15 23:48:32', NULL, 3, 2, 'active'),
('e001cc3e-819c-402f-8ca7-07b854377103', 'Okrasubji', 'avinash.ajugia@icloud.com', '$2b$10$cIyWPv3XY/hB3iB.a5asXekyT1NWajBNvf9sdC8whrJ9pC1Uu23t6', '2025-08-02 20:26:04', '2025-08-02 21:15:33', NULL, 3, 2, 'active'),
('e117634a-ac12-4de9-af85-09ddf6028c1d', 'TemkonBids', 'joezeal20@gmail.com', '$2b$10$2nouTZLHpsX6f5wXUn93UO3FiVuh2S.s0ddl.Y5rX5INTL8Koo0yK', '2025-08-02 09:20:19', '2025-08-04 18:19:53', NULL, 3, 2, 'active'),
('e500d3d5-d2bf-4395-b5a5-86a18c147677', 'Grave', 'Jndv2611@gmail.com', '$2b$10$md.SjJvP9yBxGmR1kPq.4.GHBWfdf3gMo69K5J/PmDgqi4vQZhHj2', '2025-08-02 06:38:57', '2025-08-04 18:20:04', NULL, 3, 2, 'active'),
('e7d5cfaa-9414-4154-a9d5-a011ac8812ff', 'RippleMax', 'd1sinner562@gmail.com', '$2b$10$/LvMlVay4dRK3sCh5TonDeh5gIYFyz.SnOsk9xzUFQ1RF1GAIACYG', '2025-09-17 01:48:55', '2025-09-17 01:48:55', NULL, 3, 1, 'active'),
('eb7a98ff-4020-4131-902a-7542a84146ba', 'Wilshire ', 'wilshireralphxiii@gmail.com', '$2b$12$KUTPm3Ax7N3vkyX6m0S3NO/8zACq3WeeUu4kca.LG0nNq3BXvX7xy', '2025-08-29 14:06:07', '2025-09-13 18:53:24', NULL, 3, 2, 'active'),
('ec4d0260-1c2e-47d5-8c04-8fd665186b8f', 'gcc1992', 'coxgarrett24@gmail.com', '$2b$10$vbwuLwZn5m72CndaaTt62OLuRhrvofrQ1IJTfcD5aSR1ugbrtDAIi', '2025-08-04 07:15:27', '2025-08-04 18:14:34', NULL, 3, 2, 'active'),
('ec80c3e6-ee1e-472d-9d3f-29074f144aea', 'Lavish Savant ', 'jshelton352@gmail.com', '$2b$10$R7u/zFLGK0pONGmsL3MtTesqeKQ3wf6V2aKOYMwFU5xBWo4fVeyW6', '2025-08-19 04:07:07', '2025-08-19 11:45:16', NULL, 3, 2, 'active'),
('ecc60e75-15a1-4468-bfde-192f9ffe8fcd', 'xPanakin', 'xpnakin@proton.me', '$2b$10$TSUht3VQW2PRlnpV.6kOZOnkphwWTznWovHRko04QqWZ6RzDDMcZK', '2025-08-01 22:55:33', '2025-08-01 23:44:22', NULL, 3, 2, 'active'),
('f008acde-97c6-4aa8-ab43-4d642e5112c6', 'BrizzyBandz', 'btvaroch13@gmail.com', '$2b$10$9c5VQNFbgJDD2JXPOlnXxu74hDG1LHciEMEwQhTXH019Gp4jjSpmq', '2025-08-01 19:46:30', '2025-08-19 22:51:12', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755643866/storefront/backgrounds/IMG_0122_nvyepa.jpg", "size": "large", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "image", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "https://res.cloudinary.com/dlbbjwcwh/image/upload/v1755643793/storefront/backgrounds/IMG_0377_uk4cb3.webp", "blur": 0, "opacity": 0.7}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": false, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 2, 'active'),
('f0841792-c385-4c41-a5e9-cf1210d853e6', 'Dufgan', 'dufganshopping@gmail.com', '$2b$10$y9kS/Z79Z0em0Mn3nYlSruqVG/cE4dA.VY6a4TLgon6FKSrCemjse', '2025-08-07 18:17:39', '2025-08-24 14:29:00', NULL, 3, 2, 'active'),
('f150bf83-2211-468b-9268-626e54068b45', 'Bobbyy', 'bobbyisactive@outlook.com', '$2b$10$v87icAfZpouKrL04H8kbkumRt7AdtMV/SL9J.VsoAzGvq1bgE3wgO', '2025-08-06 22:18:19', '2025-08-15 23:47:14', NULL, 3, 2, 'active'),
('f2c9c487-cfad-4968-b956-d753f17d2ba5', 'devt990', 'blockcred.ng@gmail.com', '$2b$10$hl4.ez5lQ6mrlY/FZf.6huMRX/rbj9Ap5SL6JGzS.fX1AYALBIyoi', '2025-08-01 16:04:38', '2025-08-01 16:24:36', NULL, 1, 2, 'active'),
('f7a15ecc-ebec-4ff5-87a3-c6e517c8fac8', 'William Sun', 'billsun4567@hotmail.com', '$2b$10$sQrK/5.m2H8/dXYnARNFmO3UrsRGQcfvbqeZgldIXWl.cX/VAL4wC', '2025-08-14 04:07:41', '2025-08-15 23:46:03', NULL, 3, 2, 'active'),
('f8bacc1b-39ef-462c-b55c-e962c603e9fb', 'ToysnMore', 'silvertreeprod@gmail.com', '$2b$10$WVr4ebCYaN5VDqiEYOsd.uZZRyy6LLPhR17mtvBBb02fuD2/qM3tG', '2025-08-05 16:33:41', '2025-08-15 23:48:42', NULL, 3, 2, 'active'),
('f8e9cf0c-4ef0-4060-b2b2-a61d4e2db1bc', 'Woodenarch', 'folsomhodl@gmail.com', '$2b$10$xMWJOVcIYdwaidz9SyThGefIlSp9WGq9e19nFXhCr/ZULVrUDVcVy', '2025-08-17 13:02:53', '2025-08-18 11:50:23', NULL, 3, 2, 'active'),
('fa7cffc8-0383-4988-898e-900eadd6388f', 'Rjdebo', 'familyonly89@yahoo.com', '$2b$10$UONoCif58rOuK8y/laCV2eoJb132rxtxCXLZSYfmM0a0BqB37CZ0y', '2025-08-20 11:18:51', '2025-08-21 22:04:25', NULL, 3, 2, 'active'),
('fc944c93-88b7-4e4c-8f02-2dc69a0ad824', 'JT132724', 'tvarocht@gmail.com', '$2b$10$n.oi/8SoDMWl0QFNhM9Y4OwUmkFSrx5PTvy0r46Iu89monA1ExSZ.', '2025-08-01 19:45:22', '2025-08-20 00:42:46', '{"theme": "dark", "currency": "USD", "language": "en", "timezone": "UTC", "showEmail": false, "showPhone": false, "allowOffers": true, "loginAlerts": true, "businessHours": {"end": "17:00", "start": "09:00", "enabled": false, "timezone": "UTC"}, "twoFactorAuth": false, "autoAcceptOrders": false, "storefrontDesign": {"header": {"style": "floating", "height": "normal", "showStats": true, "showAvatar": true}, "layout": {"spacing": "normal", "gridColumns": {"mobile": 1, "tablet": 2, "desktop": 4}, "borderRadius": "xl", "containerWidth": "full"}, "effects": {"shadows": {"cards": "lg", "buttons": "md"}, "animations": {"enabled": true, "cardHover": "scale", "pageTransition": "fade"}, "glassmorphism": {"blur": "md", "enabled": true, "intensity": "medium"}}, "branding": {"logo": {"url": "", "size": "medium", "position": "header"}, "favicon": "", "socialLinks": {"discord": "", "twitter": "", "website": "", "instagram": ""}}, "typography": {"fontSize": {"body": 16, "small": 14, "heading": 48, "subheading": 24}, "fontFamily": "inter", "fontWeight": {"body": "normal", "heading": "bold"}, "headingFont": "inter"}, "colorScheme": "neon-dark", "customColors": {"text": "#ffffff", "accent": "#3b82f6", "border": "#4b5563", "primary": "#39FF14", "surface": "#1a1a1a", "secondary": "#10b981", "background": "#000000", "textSecondary": "#d1d5db"}, "backgroundType": "gradient", "gradientColors": {"to": "#000000", "from": "#1a1a1a", "direction": "to-br"}, "backgroundColor": "#000000", "backgroundImage": {"url": "", "blur": 0, "opacity": 0.3}}, "profileVisibility": "public", "pushNotifications": {"lowStock": false, "newOrders": true, "orderUpdates": true, "paymentReceived": true}, "emailNotifications": {"lowStock": true, "newOrders": true, "newsletter": false, "promotions": true, "orderUpdates": true, "paymentReceived": true}, "showInventoryCount": true, "requireBuyerMessage": false}', 1, 2, 'active');


-- Table structure for wallet_addresses
DROP TABLE IF EXISTS `wallet_addresses`;
CREATE TABLE `wallet_addresses` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `chain` enum('xrp','evm','solana') COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_chain` (`user_id`,`chain`,`address`),
  CONSTRAINT `wallet_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data for wallet_addresses
INSERT INTO `wallet_addresses` (`id`, `user_id`, `chain`, `address`, `is_primary`, `created_at`, `updated_at`) VALUES
('d5090ace-293c-4d55-ba5e-d41f42312f0e', 'c61cde9c-197f-45e8-b881-d6f67bc60e6a', 'evm', '0x2D9252D712546d647194f5d14293ac3b93D88DcC', 1, '2025-07-29 13:53:11', '2025-07-29 13:53:11');


SET FOREIGN_KEY_CHECKS = 1;
