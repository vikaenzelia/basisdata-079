-- ============================================================================
-- Berkas Data Lanjutan Kopma (Modul 9)
-- Nama   : Vika Desty Enzelia
-- NPM    : 25430079
-- Kelas  : C
-- ============================================================================

USE kopma_25430079;

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

-- 1. Data Petugas
INSERT INTO petugas (id_petugas, kode_petugas, nama_petugas, peran_petugas) VALUES
(1, 'K01', 'Dimas', 'kasir'),
(2, 'K02', 'Sari', 'kasir'),
(3, 'K03', 'Rina', 'kasir'),
(4, 'G01', 'Joko', 'gudang'),
(5, 'P01', 'Ketua Kopma', 'ketua');

-- 2. Data Anggota
INSERT INTO anggota (id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
(1, 'A-0457', '25430079', 'Vika Desty Enzelia', 'Ilmu Komputer', '081234567890', 'aktif', '2025-09-01'),
(2, 'A-0458', '25430080', 'Nuti Mistiani', 'Ilmu Komputer', '081298765432', 'aktif', '2025-09-02'),
(3, 'A-0459', '25430081', 'Eko Prasetyo', 'Ilmu Komputer', NULL, 'aktif', '2025-09-05'),
(4, 'A-0460', '25430082', 'Dewi Lestari', 'Sistem Informasi', '085611223344', 'nonaktif', '2024-08-10');

-- 3. Data Barang
INSERT INTO barang (id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
(1, 'ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000.00, 120, 20),
(2, 'ATK-002', 'Buku Tulis 58', 'ATK', 6500.00, 80, 20),
(3, 'MNM-001', 'Air Mineral 600', 'minuman', 4000.00, 48, 24),
(4, 'MKN-001', 'Roti Cokelat', 'makanan', 5000.00, 6, 10);

-- 4. Data Pemasok
INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
('CV Sumber ATK', '0725-111222', 'Jl. Sudirman No. 10, Metro'),
('UD Segar Sejahtera', '0725-333444', 'Jl. Ahmad Yani No. 45, Metro');

-- 5. Data Penjualan
INSERT INTO penjualan (id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
(1, 'PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000.00),
(2, 'PJ-2609-0143', '2026-09-24 10:30:00', 3, NULL, 15000.00),
(3, 'PJ-2609-0144', '2026-09-25 09:00:00', 1, 2, 25000.00),
(4, 'PJ-2609-0145', '2026-09-26 11:20:00', 2, 3, 20000.00),
(5, 'PJ-2609-0146', '2026-09-28 14:05:00', 1, 4, 15000.00),
(6, 'PJ-2610-0001', '2026-10-03 08:45:00', 2, 1, 30000.00),
(7, 'PJ-2610-0002', '2026-10-10 13:10:00', 3, NULL, 20000.00),
(8, 'PJ-2610-0003', '2026-10-18 15:30:00', 1, 2, 25000.00);

-- 6. Data Detail Penjualan
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan) VALUES
(1, 1, 3, 4000.00),
(1, 2, 2, 6500.00),
(2, 3, 2, 4000.00),
(3, 4, 2, 5000.00),
(3, 1, 2, 4000.00),
(4, 2, 2, 6500.00),
(4, 3, 1, 4000.00),
(5, 1, 2, 4000.00),
(5, 3, 1, 4000.00),
(6, 2, 3, 6500.00),
(6, 4, 1, 5000.00),
(7, 3, 3, 4000.00),
(8, 1, 3, 4500.00),
(8, 4, 2, 5000.00);

-- 7. Data Pembelian & Detail Pembelian
INSERT INTO pembelian (id_pembelian, no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian) VALUES
(1, 'FK-2026-001', '2026-09-20', 1, 'diterima');

INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian) VALUES
(1, 1, 50, 3200.00);