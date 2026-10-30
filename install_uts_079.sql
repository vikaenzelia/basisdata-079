-- ============================================================================
-- Berkas : install_uts_079.sql
-- NAMA   : Vika Desty Enzelia (NPM: 25430079)
-- DESKRIPSI: Skrip Pemasangan Bersih Basis Data Akademik (UTS)
-- ============================================================================

-- 1. Buat Basis Data Bersih
DROP DATABASE IF EXISTS akad_25430079;
CREATE DATABASE akad_25430079 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE akad_25430079;

-- 2. Panggil Struktur DDL (Modul 5)
SOURCE D:/basisdata-079/p05_ddl_079.sql;

-- 3. Panggil Pengisian Data Sampel (Modul 6)
SOURCE D:/basisdata-079/p06_data_079.sql;

-- 4. Verifikasi Hasil Instalasi
SELECT 'INSTALASI BERSIH UTS BERHASIL!' AS status;
SELECT TABLE_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'akad_25430079';
SELECT COUNT(*) AS total_detail_krs FROM detail_krs;