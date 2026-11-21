-- ============================================================================
-- Modul 9: Meringkas Data dengan Fungsi Agregat dan GROUP BY (Kopma)
-- Nama   : Vika Desty Enzelia
-- NPM    : 25430079
-- Kelas  : C
-- Berkas : p09_agregasi_kopma_079.sql
-- ============================================================================

USE kopma_25430079;

-- D.1 Aktifkan mode ketat pengelompokan dan cek ringkasan awal
-- Hasil yang diharapkan: 8 nota (2026-09-24 10:15:00 s.d. 2026-10-18 15:30:00)
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

SELECT COUNT(*) AS nota, MIN(tgl_penjualan) AS awal, MAX(tgl_penjualan) AS akhir
FROM penjualan;

-- D.2a Total satu nota (contoh PJ-2609-0142)
-- Hasil yang diharapkan: 1 baris total belanja untuk nota PJ-2609-0142 (25000.00)
SELECT
    p.no_nota_penjualan,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS jumlah
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0142'
GROUP BY p.id_penjualan, p.no_nota_penjualan;

-- D.2b (KI-02 / KI-03) Omzet dan unit terjual per kategori barang
-- Hasil yang diharapkan: 3 kategori (ATK: 17 unit / 87000.00, minuman: 7 unit / 28000.00, makanan: 5 unit / 25000.00)
SELECT
    b.kategori_barang,
    SUM(d.qty_detail_penjualan) AS total_unit_terjual,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet_kategori
FROM barang b
JOIN detail_penjualan d ON b.id_barang = d.id_barang
GROUP BY b.kategori_barang
ORDER BY omzet_kategori DESC;

-- D.3a (KI-01) Omzet harian minggu pertama data September (2026-09-24 s.d. 2026-09-28) dengan WITH ROLLUP
-- Hasil yang diharapkan: 4 baris tanggal + 1 baris total NULL (5 nota, omzet 80000.00)
SELECT
    DATE(p.tgl_penjualan) AS tanggal,
    COUNT(DISTINCT p.id_penjualan) AS nota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-24' AND p.tgl_penjualan < '2026-09-29'
GROUP BY DATE(p.tgl_penjualan) WITH ROLLUP;

-- D.3b (KI-01) Omzet bulanan (September & Oktober 2026) dengan WITH ROLLUP
-- Hasil yang diharapkan: 2026-09 (5 nota, 80000.00), 2026-10 (3 nota, 60000.00), NULL (8 nota, 140000.00)
SELECT
    DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
    COUNT(DISTINCT p.id_penjualan) AS nota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m') WITH ROLLUP;

-- Titik Analisis 2: Perbandingan COUNT(DISTINCT p.id_penjualan) vs COUNT(*) pada data September
-- Hasil yang diharapkan: nota_unik = 5, jumlah_baris_detail = 9 (selisih karena relasi 1 nota - banyak detail)
SELECT
    COUNT(DISTINCT p.id_penjualan) AS nota_unik,
    COUNT(*) AS jumlah_baris_detail
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-01' AND p.tgl_penjualan < '2026-10-01';

-- D.4a Penyaringan HAVING: kasir yang melayani lebih dari 20 nota
-- Hasil yang diharapkan: Empty set (karena total nota transaksi saat ini berjumlah 8 nota)
SELECT
    pt.kode_petugas,
    pt.nama_petugas,
    COUNT(*) AS nota
FROM penjualan p
JOIN petugas pt ON pt.id_petugas = p.id_petugas
GROUP BY pt.id_petugas, pt.kode_petugas, pt.nama_petugas
HAVING COUNT(*) > 20;

-- D.4b Penyaringan HAVING: barang yang total qty terjualnya kurang dari 10
-- Hasil yang diharapkan: 3 barang (ATK-002 = 7, MNM-001 = 7, MKN-001 = 5)
SELECT
    b.kode_barang,
    b.nama_barang,
    SUM(d.qty_detail_penjualan) AS total_qty_terjual
FROM barang b
JOIN detail_penjualan d ON d.id_barang = b.id_barang
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
HAVING SUM(d.qty_detail_penjualan) < 10;

-- Titik Analisis 3: Rata-rata belanja per nota khusus anggota (syarat anggota ditaruh di WHERE)
-- Hasil yang diharapkan: 6 nota anggota, total belanja 120000.00, rata-rata 20000.000000 per nota
SELECT
    COUNT(DISTINCT p.id_penjualan) AS jumlah_nota_anggota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS total_belanja_anggota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) / COUNT(DISTINCT p.id_penjualan) AS rata_rata_per_nota
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.id_anggota IS NOT NULL;

-- E.1 Diskon 5% untuk anggota aktif, bandingkan dengan bayar_penjualan, kembalian > Rp4.000
-- Hasil yang diharapkan: 3 nota anggota aktif dengan kembalian > 4000 (PJ-2609-0142, PJ-2609-0144, PJ-2610-0001)
SELECT
    p.no_nota_penjualan,
    a.nama_anggota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS subtotal,
    ROUND(SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95, 2) AS total_setelah_diskon,
    p.bayar_penjualan,
    (p.bayar_penjualan - ROUND(SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95, 2)) AS kembalian
FROM penjualan p
JOIN anggota a ON a.id_anggota = p.id_anggota
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE a.status_anggota = 'aktif'
GROUP BY p.id_penjualan, p.no_nota_penjualan, a.nama_anggota, p.bayar_penjualan
HAVING kembalian > 4000;

-- E.2 Omzet per kategori barang per bulan dengan WITH ROLLUP
-- Hasil yang diharapkan: rincian omzet per (bulan, kategori_barang), subtotal per bulan (kategori = NULL),
--                        dan grand total keseluruhan (bulan = NULL, kategori = NULL)
SELECT
    DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
    b.kategori_barang,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
JOIN barang b ON b.id_barang = d.id_barang
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m'), b.kategori_barang WITH ROLLUP;