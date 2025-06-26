-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Mar 2023 pada 15.16
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravelaccoun`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer`
--

CREATE TABLE `customer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `piutang` decimal(13,2) NOT NULL DEFAULT 0.00,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal`
--

CREATE TABLE `jurnal` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `jenis_transaksi` enum('Kas','Bank','Memorial') COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_transaksi` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lawan` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` enum('Debit','Kredit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` decimal(13,2) NOT NULL,
  `id_detail` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kode_akun`
--

CREATE TABLE `kode_akun` (
  `kode_akun` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `induk_kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `tipe` enum('Debit','Kredit') COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kode_induk`
--

CREATE TABLE `kode_induk` (
  `kode_induk` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kunci_transaksi`
--

CREATE TABLE `kunci_transaksi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jenis_transaksi` enum('Kas','Bank Memorial') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_mulai_kunci` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kunci_transaksi`
--

INSERT INTO `kunci_transaksi` (`id`, `jenis_transaksi`, `tanggal_mulai_kunci`, `created_at`, `updated_at`) VALUES
(1, 'Kas', '2023-03-03', '2023-03-03 07:15:10', '2023-03-03 07:15:10'),
(2, 'Bank Memorial', '2023-03-03', '2023-03-03 07:15:10', '2023-03-03 07:15:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `memorial`
--

CREATE TABLE `memorial` (
  `kode_memorial` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `tipe` enum('Masuk','Keluar') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(13,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `memorial_detail`
--

CREATE TABLE `memorial_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_memorial` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lawan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal` decimal(13,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_02_09_063930_create_kode_induk_table', 1),
(6, '2022_02_09_182412_create_kode_akun_table', 1),
(7, '2022_02_11_031239_create_kunci_transaksi_table', 1),
(8, '2022_02_11_211433_create_transaksi_kas_table', 1),
(9, '2022_02_12_161324_create_transaksi_kas_detail_table', 1),
(10, '2022_02_12_162427_create_jurnal_table', 1),
(11, '2022_02_12_162454_create_jurnal_detail_table', 1),
(12, '2022_02_15_061322_create_transaksi_bank_table', 1),
(13, '2022_02_15_061647_create_transaksi_bank_detail_table', 1),
(14, '2022_02_15_064242_update_kode_transaksi_bank_foreign_key_to_jurnal_table', 1),
(15, '2022_02_18_124804_alter_id_detail_transaksi_on_jurnal_detail_table', 1),
(16, '2022_02_18_154719_delete_keterangan_transaksi_bank_on_transaksi_kas_and_transaksi_bank_table', 1),
(17, '2022_02_18_162333_drop_jurnal_and_jurnal_detail_table', 1),
(18, '2022_02_18_162400_drop_jurnal_table', 1),
(19, '2022_02_18_164725_create_sequences_table', 1),
(20, '2022_02_18_170757_create_jurnal_baru_table', 1),
(21, '2022_02_18_175935_create_memorial_table', 1),
(22, '2022_02_19_035903_create_memorial_detail_table', 1),
(23, '2022_02_19_065201_drop_saldo_awal_to_kode_akun_table', 1),
(24, '2022_02_19_190237_create_user_activity_table', 1),
(25, '2022_02_20_142331_create_laba_rugi_view', 1),
(26, '2022_02_21_044608_drop_tipe_at_kode_induk_table', 1),
(27, '2022_02_21_044818_add_tipe_at_kode_akun_table', 1),
(28, '2022_02_24_064440_add_role_viewer_on_users_table', 1),
(29, '2022_06_29_151633_create_customer_table', 1),
(30, '2022_06_30_100134_create_supplier_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sequences`
--

CREATE TABLE `sequences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seq_length` tinyint(4) NOT NULL,
  `seq_no` tinyint(4) NOT NULL,
  `kode_akun` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hutang` decimal(13,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_bank`
--

CREATE TABLE `transaksi_bank` (
  `kode_transaksi_bank` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `akun_kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` enum('Masuk','Keluar') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(13,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_bank_detail`
--

CREATE TABLE `transaksi_bank_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_transaksi_bank` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_lawan` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal` decimal(13,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_kas`
--

CREATE TABLE `transaksi_kas` (
  `kode_transaksi_kas` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `akun_kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` enum('Masuk','Keluar') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(13,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_kas_detail`
--

CREATE TABLE `transaksi_kas_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_transaksi_kas` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_lawan` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal` decimal(13,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('Administrator','Accounting','Viewer') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `level`, `remember_token`, `deleted_at`, `deleted_by`, `created_at`, `updated_at`) VALUES
(1, 'Viewer', 'Viewer', 'viewer@mail.com', NULL, '$2y$10$kAsimwotUT8zEKWVce0wBeBkFD/shxG06xtriEtpKbdEQTrjm1TWe', 'Viewer', NULL, NULL, NULL, '2023-03-03 07:13:43', '2023-03-03 07:13:43'),
(2, 'Rifjan Jundila', 'Administrator', 'admin@mail.com', NULL, '$2y$10$eWLbCFMcjnBb6DIe/mNohedArAEGuvb7b9nQxatVzQrDlmM2ua1y6', 'Administrator', NULL, NULL, NULL, '2023-03-03 07:14:53', '2023-03-03 07:14:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_activity`
--

CREATE TABLE `user_activity` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `jenis_transaksi` enum('Kas','Bank','Memorial') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` enum('Insert','Update','Delete') COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_laba_rugi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_laba_rugi` (
`bulan` int(2)
,`tahun` int(4)
,`nominal` decimal(35,2)
,`kode` varchar(15)
,`lawan` varchar(15)
,`tipe` enum('Debit','Kredit')
);

-- --------------------------------------------------------

--
-- Struktur untuk view `view_laba_rugi`
--
DROP TABLE IF EXISTS `view_laba_rugi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laba_rugi`  AS SELECT month(`jurnal`.`tanggal`) AS `bulan`, year(`jurnal`.`tanggal`) AS `tahun`, sum(`jurnal`.`nominal`) AS `nominal`, `jurnal`.`kode` AS `kode`, `jurnal`.`lawan` AS `lawan`, `jurnal`.`tipe` AS `tipe` FROM `jurnal` WHERE `jurnal`.`kode` like '4%' OR `jurnal`.`kode` like '5%' OR `jurnal`.`kode` like '6%' OR `jurnal`.`lawan` like '4%' OR `jurnal`.`lawan` like '5%' OR `jurnal`.`lawan` like '6%' GROUP BY month(`jurnal`.`tanggal`), year(`jurnal`.`tanggal`), `jurnal`.`kode`, `jurnal`.`lawan`, `jurnal`.`tipe` ORDER BY month(`jurnal`.`tanggal`) ASC, year(`jurnal`.`tanggal`) ASC  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jurnal`
--
ALTER TABLE `jurnal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurnal_kode_foreign` (`kode`),
  ADD KEY `jurnal_lawan_foreign` (`lawan`);

--
-- Indeks untuk tabel `kode_akun`
--
ALTER TABLE `kode_akun`
  ADD PRIMARY KEY (`kode_akun`),
  ADD KEY `kode_akun_induk_kode_foreign` (`induk_kode`),
  ADD KEY `kode_akun_deleted_by_foreign` (`deleted_by`);

--
-- Indeks untuk tabel `kode_induk`
--
ALTER TABLE `kode_induk`
  ADD PRIMARY KEY (`kode_induk`),
  ADD KEY `kode_induk_deleted_by_foreign` (`deleted_by`);

--
-- Indeks untuk tabel `kunci_transaksi`
--
ALTER TABLE `kunci_transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `memorial`
--
ALTER TABLE `memorial`
  ADD PRIMARY KEY (`kode_memorial`);

--
-- Indeks untuk tabel `memorial_detail`
--
ALTER TABLE `memorial_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `memorial_detail_kode_foreign` (`kode`),
  ADD KEY `memorial_detail_lawan_foreign` (`lawan`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `sequences`
--
ALTER TABLE `sequences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sequences_kode_akun_foreign` (`kode_akun`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transaksi_bank`
--
ALTER TABLE `transaksi_bank`
  ADD PRIMARY KEY (`kode_transaksi_bank`),
  ADD KEY `transaksi_bank_akun_kode_foreign` (`akun_kode`),
  ADD KEY `transaksi_bank_deleted_by_foreign` (`deleted_by`);

--
-- Indeks untuk tabel `transaksi_bank_detail`
--
ALTER TABLE `transaksi_bank_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_bank_detail_kode_transaksi_bank_foreign` (`kode_transaksi_bank`),
  ADD KEY `transaksi_bank_detail_kode_lawan_foreign` (`kode_lawan`);

--
-- Indeks untuk tabel `transaksi_kas`
--
ALTER TABLE `transaksi_kas`
  ADD PRIMARY KEY (`kode_transaksi_kas`),
  ADD KEY `transaksi_kas_akun_kode_foreign` (`akun_kode`),
  ADD KEY `transaksi_kas_deleted_by_foreign` (`deleted_by`);

--
-- Indeks untuk tabel `transaksi_kas_detail`
--
ALTER TABLE `transaksi_kas_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_kas_detail_kode_transaksi_kas_foreign` (`kode_transaksi_kas`),
  ADD KEY `transaksi_kas_detail_kode_lawan_foreign` (`kode_lawan`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indeks untuk tabel `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_activity_id_user_foreign` (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `customer`
--
ALTER TABLE `customer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jurnal`
--
ALTER TABLE `jurnal`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kunci_transaksi`
--
ALTER TABLE `kunci_transaksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `memorial_detail`
--
ALTER TABLE `memorial_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sequences`
--
ALTER TABLE `sequences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_bank_detail`
--
ALTER TABLE `transaksi_bank_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_kas_detail`
--
ALTER TABLE `transaksi_kas_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jurnal`
--
ALTER TABLE `jurnal`
  ADD CONSTRAINT `jurnal_kode_foreign` FOREIGN KEY (`kode`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `jurnal_lawan_foreign` FOREIGN KEY (`lawan`) REFERENCES `kode_akun` (`kode_akun`);

--
-- Ketidakleluasaan untuk tabel `kode_akun`
--
ALTER TABLE `kode_akun`
  ADD CONSTRAINT `kode_akun_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `kode_akun_induk_kode_foreign` FOREIGN KEY (`induk_kode`) REFERENCES `kode_induk` (`kode_induk`);

--
-- Ketidakleluasaan untuk tabel `kode_induk`
--
ALTER TABLE `kode_induk`
  ADD CONSTRAINT `kode_induk_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `memorial_detail`
--
ALTER TABLE `memorial_detail`
  ADD CONSTRAINT `memorial_detail_kode_foreign` FOREIGN KEY (`kode`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `memorial_detail_lawan_foreign` FOREIGN KEY (`lawan`) REFERENCES `kode_akun` (`kode_akun`);

--
-- Ketidakleluasaan untuk tabel `sequences`
--
ALTER TABLE `sequences`
  ADD CONSTRAINT `sequences_kode_akun_foreign` FOREIGN KEY (`kode_akun`) REFERENCES `kode_akun` (`kode_akun`);

--
-- Ketidakleluasaan untuk tabel `transaksi_bank`
--
ALTER TABLE `transaksi_bank`
  ADD CONSTRAINT `transaksi_bank_akun_kode_foreign` FOREIGN KEY (`akun_kode`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `transaksi_bank_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `transaksi_bank_detail`
--
ALTER TABLE `transaksi_bank_detail`
  ADD CONSTRAINT `transaksi_bank_detail_kode_lawan_foreign` FOREIGN KEY (`kode_lawan`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `transaksi_bank_detail_kode_transaksi_bank_foreign` FOREIGN KEY (`kode_transaksi_bank`) REFERENCES `transaksi_bank` (`kode_transaksi_bank`);

--
-- Ketidakleluasaan untuk tabel `transaksi_kas`
--
ALTER TABLE `transaksi_kas`
  ADD CONSTRAINT `transaksi_kas_akun_kode_foreign` FOREIGN KEY (`akun_kode`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `transaksi_kas_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `transaksi_kas_detail`
--
ALTER TABLE `transaksi_kas_detail`
  ADD CONSTRAINT `transaksi_kas_detail_kode_lawan_foreign` FOREIGN KEY (`kode_lawan`) REFERENCES `kode_akun` (`kode_akun`),
  ADD CONSTRAINT `transaksi_kas_detail_kode_transaksi_kas_foreign` FOREIGN KEY (`kode_transaksi_kas`) REFERENCES `transaksi_kas` (`kode_transaksi_kas`);

--
-- Ketidakleluasaan untuk tabel `user_activity`
--
ALTER TABLE `user_activity`
  ADD CONSTRAINT `user_activity_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
