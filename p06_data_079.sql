-- ============================================================================
-- Nama   : Vika Desty Enzelia
-- NIM    : 25430079
-- Kelas  : C
-- Tema   : Akademik (akad_079)
-- Berkas : p06_data_079.sql
-- ============================================================================

USE akad_25430079;

-- Nonaktifkan sementara pemeriksaan foreign key untuk pemuatan awal jika diperlukan
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE detail_krs;
TRUNCATE TABLE krs;
TRUNCATE TABLE kelas;
TRUNCATE TABLE mata_kuliah;
TRUNCATE TABLE dosen;
TRUNCATE TABLE mahasiswa;
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- 1. MENGISI DATA TABEL INDUK (MASTER)
-- ----------------------------------------------------------------------------

-- A. Data Dosen (Minimal 5 baris)
INSERT INTO dosen (nidn_dosen, nama_dosen, email_dosen) VALUES
('0011018501', 'Dedi Irawan, S.Kom., M.T.I.', 'dedimti@metro.ac.id'),
('0022028802', 'Ahmad Fauzi, M.Kom.', 'ahmad.fauzi@metro.ac.id'),
('0033039003', 'Siti Aminah, M.T.', 'siti.aminah@metro.ac.id'),
('0044047504', 'Budi Santoso, Ph.D.', 'budi.santoso@metro.ac.id'),
('0055059205', 'Rina Wati, M.Cs.', 'rina.wati@metro.ac.id');

-- B. Data Mahasiswa (Minimal 5 baris, termasuk contoh nonaktif/cuti)
INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, no_hp_mahasiswa, status_mahasiswa, thn_masuk_mahasiswa) VALUES
('25430079', 'Vika Desty Enzelia', 'Ilmu Komputer', '081234567890', 'aktif', 2025),
('25430080', 'Nuti Mistiani', 'Ilmu Komputer', '081298765432', 'aktif', 2025),
('25430081', 'Eko Prasetyo', 'Ilmu Komputer', NULL, 'aktif', 2025),
('25430082', 'Dewi Lestari', 'Sistem Informasi', '085611223344', 'cuti', 2024),
('25430083', 'Rian Hidayat', 'Teknik Informatika', '087899887766', 'nonaktif', 2023);

-- C. Data Mata Kuliah (Minimal 5 baris, SKS antara 1-6 sesuai AB-04)
INSERT INTO mata_kuliah (kode_mata_kuliah, nama_mata_kuliah, sks_mata_kuliah, semester_mata_kuliah) VALUES
('IF2101', 'Basis Data', 4, 3),
('IF2102', 'Struktur Data', 3, 3),
('IF2103', 'Pemrograman Berorientasi Objek', 4, 3),
('IF3101', 'Sistem Operasi', 3, 5),
('IF3102', 'Jaringan Komputer', 3, 5);

-- ----------------------------------------------------------------------------
-- 2. MENGISI DATA TABEL OPERASIONAL & TRANSAKSI (ANAK)
-- ----------------------------------------------------------------------------

-- A. Data Kelas (Menghubungkan matakuliah dan dosen)
INSERT INTO kelas (kode_kelas, id_mata_kuliah, id_dosen, tahun_akademik_kelas, semester_kelas, hari_kelas, kuotas_kelas) VALUES
('IF-3C', 1, 1, '2026/2027', 'ganjil', 'Senin', 40),
('IF-3A', 2, 2, '2026/2027', 'ganjil', 'Selasa', 40),
('IF-3B', 3, 3, '2026/2027', 'ganjil', 'Rabu', 35),
('IF-5A', 4, 4, '2026/2027', 'ganjil', 'Kamis', 40),
('IF-5B', 5, 5, '2026/2027', 'ganjil', 'Jumat', 40);

-- B. Data Kepala KRS (Tabel krs)
-- Menggunakan parameter P = 8 untuk jumlah baris transaksi minimal (10 * 8 = 80 baris detail atau mencakup minimal beberapa KRS)
INSERT INTO krs (no_krs, tgl_krs, id_mahasiswa, tahun_akademik_krs, semester_krs, status_krs) VALUES
('KRS-20261-079', '2026-08-15 08:30:00', 1, '2026/2027', 'ganjil', 'disetujui'),
('KRS-20261-080', '2026-08-15 09:15:00', 2, '2026/2027', 'ganjil', 'disetujui'),
('KRS-20261-081', '2026-08-16 10:00:00', 3, '2026/2027', 'ganjil', 'draf'),
('KRS-20261-082', '2026-08-17 11:20:00', 4, '2026/2027', 'ganjil', 'ditolak'),
('KRS-20261-083', '2026-08-18 13:00:00', 5, '2026/2027', 'ganjil', 'draf');

-- C. Data Detail KRS (Tabel detail_krs)
INSERT INTO detail_krs (id_krs, id_kelas, nilai_angka_detail_krs, nilai_huruf_detail_krs) VALUES
(1, 1, 88.50, 'A'),
(1, 2, 80.00, 'B+'),
(1, 3, 75.50, 'B'),
(2, 1, 90.00, 'A'),
(2, 2, 85.00, 'A'),
(3, 3, 70.00, 'B'),
(3, 4, 65.00, 'C+'),
(4, 5, NULL, NULL),
(5, 2, NULL, NULL);

-- ----------------------------------------------------------------------------
-- 3. CONTOH PENGUJIAN AMAN DENGAN SQL_SAFE_UPDATES
-- ----------------------------------------------------------------------------
SET SESSION sql_safe_updates = 1;

-- Contoh UPDATE yang aman menggunakan kolom kunci (PRIMARY KEY / UNIQUE)
UPDATE mahasiswa 
SET no_hp_mahasiswa = '081234567899' 
WHERE nim_mahasiswa = '25430079' AND id_mahasiswa > 0;