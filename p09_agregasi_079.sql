-- ============================================================================
-- Modul 9: Meringkas Data dengan Fungsi Agregat dan GROUP BY (Tugas Mandiri)
-- Nama   : Vika Desty Enzelia
-- NPM    : 25430079
-- Kelas  : C
-- Berkas : p09_agregasi_079.sql
-- ============================================================================

USE akad_25430079;

-- Aktifkan mode ketat pengelompokan sesuai ketentuan Modul 9
SET SESSION sql_mode = CONCAT(@@sql_mode, ', ONLY_FULL_GROUP_BY');

-- ----------------------------------------------------------------------------
-- Laporan 1 (Kaitannya dengan KI-01 / rekap pengambilan MK & SKS)
-- Pertanyaan: Berapa jumlah entri detail KRS, total nilai angka, dan rata-rata nilai
--             per status persetujuan KRS?
-- Hasil yang diharapkan: Muncul kelompok status_krs ('disetujui', 'draf', 'ditolak')
--                        beserta jumlah baris, rata-rata nilai, dan nilai min/maks.
-- ----------------------------------------------------------------------------
SELECT
    k.status_krs,
    COUNT(*) AS jumlah_baris_detail,
    COUNT(d.nilai_angka_detail_krs) AS jumlah_bernilai,
    ROUND(AVG(d.nilai_angka_detail_krs), 2) AS rata_rata_nilai,
    MIN(d.nilai_angka_detail_krs) AS nilai_terendah,
    MAX(d.nilai_angka_detail_krs) AS nilai_tertinggi
FROM krs k
JOIN detail_krs d ON d.id_krs = k.id_krs
GROUP BY k.status_krs
ORDER BY k.status_krs;

-- ----------------------------------------------------------------------------
-- Laporan 2 (Kaitannya dengan KI-01 / beban SKS per program studi)
-- Pertanyaan: Berapa total SKS yang diambil dan rata-rata SKS per mata kuliah
--             untuk setiap program studi mahasiswa?
-- Hasil yang diharapkan: Tampil per prodi_mahasiswa dengan total SKS dan rata-rata
--                        (mengabaikan baris detail_krs yang bernilai NULL).
-- ----------------------------------------------------------------------------
SELECT
    m.prodi_mahasiswa,
    COUNT(DISTINCT k.id_krs) AS jumlah_krs,
    SUM(mk.sks_mata_kuliah) AS total_sks_diambil,
    ROUND(AVG(mk.sks_mata_kuliah), 2) AS rata_rata_sks_mk
FROM mahasiswa m
JOIN krs k ON k.id_mahasiswa = m.id_mahasiswa
JOIN detail_krs d ON d.id_krs = k.id_krs
JOIN kelas kl ON kl.id_kelas = d.id_kelas
JOIN mata_kuliah mk ON mk.id_mata_kuliah = kl.id_mata_kuliah
GROUP BY m.prodi_mahasiswa
ORDER BY total_sks_diambil DESC;

-- ----------------------------------------------------------------------------
-- Laporan 3 (Memakai HAVING - Kaitannya dengan KI-04 / sebaran peserta kelas)
-- Pertanyaan: Kelas mana saja yang memiliki minimal 2 mahasiswa terdaftar di
--             detail_krs, serta berapa rata-rata nilai akhirnya?
-- Hasil yang diharapkan: Hanya menampilkan kelas dengan jumlah peserta >= 2
--                        setelah proses pengelompokan (GROUP BY).
-- ----------------------------------------------------------------------------
SELECT
    kl.kode_kelas,
    mk.nama_mata_kuliah,
    COUNT(d.id_krs) AS jumlah_peserta,
    ROUND(AVG(d.nilai_angka_detail_krs), 2) AS rata_rata_nilai
FROM kelas kl
JOIN mata_kuliah mk ON mk.id_mata_kuliah = kl.id_mata_kuliah
JOIN detail_krs d ON d.id_kelas = kl.id_kelas
GROUP BY kl.id_kelas, kl.kode_kelas, mk.nama_mata_kuliah
HAVING COUNT(d.id_krs) >= 2
ORDER BY jumlah_peserta DESC;

-- ----------------------------------------------------------------------------
-- Laporan 4 (Memakai WITH ROLLUP - Kaitannya dengan KI-05 / sebaran nilai)
-- Pertanyaan: Bagaimana rekap jumlah mata kuliah dan rata-rata nilai per hari
--             perkuliahan beserta total keseluruhannya?
-- Hasil yang diharapkan: Tampil per hari_kelas dan satu baris ringkasan total
--                        dengan nilai NULL pada kolom hari_kelas.
-- ----------------------------------------------------------------------------
SELECT
    kl.hari_kelas,
    COUNT(d.id_krs) AS jumlah_pengambilan,
    ROUND(AVG(d.nilai_angka_detail_krs), 2) AS rata_rata_nilai
FROM kelas kl
JOIN detail_krs d ON d.id_kelas = kl.id_kelas
GROUP BY kl.hari_kelas WITH ROLLUP;

-- ----------------------------------------------------------------------------
-- Laporan 5 (Kaitannya dengan KI-02 / rekap nilai per mahasiswa)
-- Pertanyaan: Berapa jumlah mata kuliah diambil, total SKS, dan rata-rata nilai
--             tiap mahasiswa yang memiliki catatan di detail_krs?
-- Hasil yang diharapkan: Tampil per mahasiswa dengan jumlah MK, total SKS, dan
--                        rata-rata nilai (nilai NULL diabaikan oleh AVG).
-- ----------------------------------------------------------------------------
SELECT
    m.nim_mahasiswa,
    m.nama_mahasiswa,
    COUNT(d.id_kelas) AS jumlah_mk,
    SUM(mk.sks_mata_kuliah) AS total_sks,
    ROUND(AVG(d.nilai_angka_detail_krs), 2) AS rata_rata_nilai
FROM mahasiswa m
JOIN krs k ON k.id_mahasiswa = m.id_mahasiswa
JOIN detail_krs d ON d.id_krs = k.id_krs
JOIN kelas kl ON kl.id_kelas = d.id_kelas
JOIN mata_kuliah mk ON mk.id_mata_kuliah = kl.id_mata_kuliah
GROUP BY m.id_mahasiswa, m.nim_mahasiswa, m.nama_mahasiswa
ORDER BY rata_rata_nilai DESC;