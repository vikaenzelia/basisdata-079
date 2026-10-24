-- ============================================================================
-- Nama   : Vika Desty Enzelia
-- NIM    : 25430079
-- Kelas  : C
-- Berkas : p06_data_kopma_079.sql
-- ============================================================================

USE kopma_25430079;

-- Nonaktifkan sementara pemeriksaan FK untuk pemuatan ulang data
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE detail_pembelian;
TRUNCATE TABLE pembelian;
TRUNCATE TABLE detail_penjualan;
TRUNCATE TABLE penjualan;
TRUNCATE TABLE pemasok;
TRUNCATE TABLE barang;
TRUNCATE TABLE anggota;
TRUNCATE TABLE petugas;
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- 1. MENGISI DATA TABEL INDUK (MASTER)
-- ----------------------------------------------------------------------------

-- A. Data Petugas (Kasir, Gudang, Ketua)
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
('K01', 'Dimas', 'kasir'),
('K02', 'Sari', 'kasir'),
('K03', 'Rina', 'kasir'),
('G01', 'Joko', 'gudang'),
('P01', 'Ketua Kopma', 'ketua');

-- B. Data Anggota (Termasuk contoh nonaktif)
INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
('A-0457', '25430079', 'Vika Desty Enzelia', 'Ilmu Komputer', '081234567890', 'aktif', '2025-09-01'),
('A-0458', '25430080', 'Nuti Mistiani', 'Ilmu Komputer', '081298765432', 'aktif', '2025-09-02'),
('A-0459', '25430081', 'Eko Prasetyo', 'Ilmu Komputer', NULL, 'aktif', '2025-09-05'),
('A-0460', '25430082', 'Dewi Lestari', 'Sistem Informasi', '085611223344', 'nonaktif', '2024-08-10');

-- C. Data Barang (ATK, Makanan, Minuman)
INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
('ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000.00, 120, 20),
('ATK-002', 'Buku Tulis 58', 'ATK', 6500.00, 80, 20),
('MNM-001', 'Air Mineral 600', 'minuman', 4000.00, 48, 24),
('MKN-001', 'Roti Cokelat', 'makanan', 5000.00, 6, 10);

-- D. Data Pemasok
INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
('CV Sumber ATK', '0725-111222', 'Jl. Sudirman No. 10, Metro'),
('UD Segar Sejahtera', '0725-333444', 'Jl. Ahmad Yani No. 45, Metro');

-- ----------------------------------------------------------------------------
-- 2. MENGISI DATA TABEL TRANSAKSI & DETAIL (ANAK)
-- ----------------------------------------------------------------------------

-- A. Data Penjualan (Nota)
-- id_penjualan 1 (Dengan Anggota)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000.00);

-- id_penjualan 2 (Pembeli Umum / id_anggota = NULL)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
('PJ-2609-0143', '2026-09-24 10:30:00', 3, NULL, 15000.00);

-- B. Data Detail Penjualan
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan) VALUES
(1, 1, 3, 4000.00),
(1, 2, 2, 6500.00),
(2, 3, 2, 4000.00);

-- C. Data Pembelian & Detail Pembelian (Pengadaan Stok)
INSERT INTO pembelian (no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian) VALUES
('FK-2026-001', '2026-09-20', 1, 'diterima');

INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian) VALUES
(1, 1, 50, 3200.00);

-- ----------------------------------------------------------------------------
-- 3. CONTOH PENGUJIAN AMAN DENGAN SQL_SAFE_UPDATES
-- ----------------------------------------------------------------------------
SET SESSION sql_safe_updates = 1;

-- Contoh UPDATE aman menggunakan kolom kunci (UNIQUE key: kode_barang)
UPDATE barang 
SET harga_jual_barang = 4500.00 
WHERE kode_barang = 'ATK-001' AND id_barang > 0;