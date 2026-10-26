-- ============================================================================
-- Nama   : Vika Desty Enzelia
-- NIM    : 25430079
-- Kelas  : C
-- Tema   : Koperasi Mahasiswa (kopma_079)
-- Berkas : p07_kueri_kopma_079.sql
-- ============================================================================

USE kopma_25430079;

-- ----------------------------------------------------------------------------
-- Kueri 1 (KI-01): Proyeksi Dasar, Alias, dan DISTINCT
-- Pertanyaan: Apa saja kategori barang unik yang dijual di Kopma?
-- Hasil yang diharapkan: Daftar kategori barang tanpa duplikat, diurutkan abjad.
-- ----------------------------------------------------------------------------
SELECT DISTINCT kategori_barang AS kategori_produk
FROM barang
ORDER BY kategori_barang ASC;

-- ----------------------------------------------------------------------------
-- Kueri 2 (KI-02): Penyaringan dengan LIKE dan Operator Pembanding
-- Pertanyaan: Barang apa saja yang nama produknya mengandung kata 'Pulpen'?
-- Hasil yang diharapkan: Daftar kode, nama, kategori, dan harga jual barang.
-- ----------------------------------------------------------------------------
SELECT kode_barang, nama_barang, kategori_barang, harga_jual_barang
FROM barang
WHERE nama_barang LIKE '%Pulpen%'
ORDER BY harga_jual_barang ASC;

-- ----------------------------------------------------------------------------
-- Kueri 3 (KI-03): Penyaringan dengan BETWEEN (Rentang Tanggal & Waktu)
-- Pertanyaan: Transaksi penjualan mana saja yang tercatat pada rentang tanggal 24 September 2026?
-- Hasil yang diharapkan: Daftar nomor nota, tanggal, dan ID petugas kasir.
-- ----------------------------------------------------------------------------
SELECT no_nota_penjualan, tgl_penjualan, id_petugas
FROM penjualan
WHERE tgl_penjualan BETWEEN '2026-09-24 00:00:00' AND '2026-09-24 23:59:59'
ORDER BY tgl_penjualan ASC;

-- ----------------------------------------------------------------------------
-- Kueri 4 (KI-04): Penyaringan dengan IN (Multi-Kondisi Alternatif)
-- Pertanyaan: Anggota mana saja yang berasal dari prodi 'Ilmu Komputer' atau 'Sistem Informasi'?
-- Hasil yang diharapkan: Daftar nomor anggota, nama, dan prodi mahasiswa.
-- ----------------------------------------------------------------------------
SELECT no_anggota, nama_anggota, prodi_anggota
FROM anggota
WHERE prodi_anggota IN ('Ilmu Komputer', 'Sistem Informasi')
ORDER BY prodi_anggota, nama_anggota;

-- ----------------------------------------------------------------------------
-- Kueri 5 (KI-05): Penyaringan dengan IS NULL (Data Kosong)
-- Pertanyaan: Anggota siapa saja yang belum mencantumkan nomor HP di sistem?
-- Hasil yang diharapkan: Daftar nomor anggota dan nama anggota yang kolom HP-nya kosong.
-- ----------------------------------------------------------------------------
SELECT no_anggota, nama_anggota, status_anggota
FROM anggota
WHERE no_hp_anggota IS NULL;

-- ----------------------------------------------------------------------------
-- Kueri 6 (KI-06): Fungsi Skalar String (CONCAT & UPPER)
-- Pertanyaan: Bagaimana format identitas lengkap anggota (Nama + Nomor Anggota) dengan prodi huruf kapital?
-- Hasil yang diharapkan: Gabungan teks identitas dan prodi berhuruf kapital.
-- ----------------------------------------------------------------------------
SELECT 
    CONCAT(nama_anggota, ' (No: ', no_anggota, ')') AS identitas_anggota,
    UPPER(prodi_anggota) AS prodi_kapital
FROM anggota;

-- ----------------------------------------------------------------------------
-- Kueri 7 (KI-07): Fungsi Skalar Tanggal (DATE_FORMAT)
-- Pertanyaan: Bagaimana tanggal pendaftaran anggota ditampilkan dalam format Indonesia (DD-MM-YYYY)?
-- Hasil yang diharapkan: Tanggal terformat rapi.
-- ----------------------------------------------------------------------------
SELECT 
    no_anggota,
    nama_anggota,
    DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tanggal_daftar_indo
FROM anggota
ORDER BY tgl_daftar_anggota DESC;

-- ----------------------------------------------------------------------------
-- Kueri 8 (KI-08): Kondisional dengan CASE
-- Pertanyaan: Bagaimana status keanggotaan dikelompokkan menjadi keterangan diskon yang jelas?
-- Hasil yang diharapkan: Menampilkan keterangan hak diskon 5% atau tanpa diskon (AB-02).
-- ----------------------------------------------------------------------------
SELECT 
    no_anggota,
    nama_anggota,
    status_anggota,
    CASE status_anggota 
        WHEN 'aktif' THEN 'Berhak Diskon 5%'
        ELSE 'Tidak Berhak Diskon' 
    END AS keterangan_diskon
FROM anggota;

-- ----------------------------------------------------------------------------
-- Kueri 9 (KI-09): Fungsi Skalar Numerik & Perhitungan Baris
-- Pertanyaan: Berapa estimasi total nilai stok gudang per jenis barang (stok dikali harga jual)?
-- Hasil yang diharapkan: Nilai aset stok barang terhitung secara matematis per baris.
-- ----------------------------------------------------------------------------
SELECT 
    kode_barang,
    nama_barang,
    stok_barang,
    harga_jual_barang,
    ROUND(stok_barang * harga_jual_barang, 2) AS total_nilai_stok
FROM barang
ORDER BY total_nilai_stok DESC;

-- ----------------------------------------------------------------------------
-- Kueri 10 (KI-10): Kombinasi WHERE, ORDER BY, dan LIMIT
-- Pertanyaan: Apa 3 barang yang memiliki stok paling sedikit di gudang saat ini?
-- Hasil yang diharapkan: 3 data barang dengan jumlah stok terendah untuk pengawasan stok minimum (AB-03).
-- ----------------------------------------------------------------------------
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang
FROM barang
WHERE stok_barang >= 0
ORDER BY stok_barang ASC
LIMIT 3;