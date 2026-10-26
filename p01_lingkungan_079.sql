-- Berkas: p01_lingkungan_079.sql
-- Keterangan: Skrip Inisialisasi Lingkungan Kerja MariaDB & Proyek Mandiri Modul 1
-- Catatan: Password disamarkan menggunakan penanda untuk keamanan repositori Git.

-- ----------------------------------------------------------------------------
-- 1. PENGATURAN BASIS DATA & AKUN PRAKTIKUM (KOPMA)
-- ----------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS kopma_25430079
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_25430079'@'localhost' IDENTIFIED BY '<password_kerja_mhs>';
GRANT ALL PRIVILEGES ON kopma_25430079.* TO 'mhs_25430079'@'localhost';

-- ----------------------------------------------------------------------------
-- 2. PENGATURAN BASIS DATA & AKUN PROYEK MANDIRI (AKADEMIK)
-- ----------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS akad_25430079
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_25430079'@'localhost' IDENTIFIED BY '<password_kerja_dev>';
GRANT ALL PRIVILEGES ON akad_25430079.* TO 'dev_25430079'@'localhost';

-- ----------------------------------------------------------------------------
-- 3. AKUN TAMU UNTUK LATIHAN MODIFIKASI
-- ----------------------------------------------------------------------------

CREATE USER IF NOT EXISTS 'tamu_25430079'@'localhost' IDENTIFIED BY '<password_tamu>';
GRANT SELECT ON kopma_25430079.* TO 'tamu_25430079'@'localhost';

FLUSH PRIVILEGES;