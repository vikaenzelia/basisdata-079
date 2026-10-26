-- ============================================================================
-- Nama   : Vika Desty Enzelia
-- NIM    : 25430079
-- Kelas  : C
-- Tema   : Akademik (akad_079)
-- Berkas : p07_kueri_079.sql
-- ============================================================================

USE akad_25430079;

-- ----------------------------------------------------------------------------
-- 1. PROYEKSI DASAR, ALIAS, DAN DISTINCT (KI-01)
-- Pertanyaan: Apa saja program studi unik yang ada pada data mahasiswa?
-- Hasil yang diharapkan: Daftar program studi tanpa duplikat, diurutkan abjad.
-- ----------------------------------------------------------------------------
SELECT DISTINCT prodi_mahasiswa AS program_studi
FROM mahasiswa
ORDER BY prodi_mahasiswa ASC;

-- ----------------------------------------------------------------------------
-- 2. PENYARINGAN DENGAN LIKE DAN OPERATOR PEMBANDING (KI-02)
-- Pertanyaan: Mahasiswa siapa saja yang namanya mengandung huruf 'V' atau 'v'?
-- Hasil yang diharapkan: Daftar NIM, nama, dan prodi mahasiswa yang sesuai pola.
-- ----------------------------------------------------------------------------
SELECT nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa
FROM mahasiswa
WHERE nama_mahasiswa LIKE '%v%' OR nama_mahasiswa LIKE '%V%'
ORDER BY nama_mahasiswa ASC;

-- ----------------------------------------------------------------------------
-- 3. PENYARINGAN DENGAN BETWEEN (KI-03)
-- Pertanyaan: KRS mana saja yang dicetak/dibuat pada rentang tanggal 15 s.d. 20 Agustus 2026?
-- Hasil yang diharapkan: Daftar nomor KRS dan tanggal transaksi pada rentang tersebut.
-- ----------------------------------------------------------------------------
SELECT no_krs, tgl_krs, id_mahasiswa
FROM krs
WHERE tgl_krs BETWEEN '2026-08-15 00:00:00' AND '2026-08-20 23:59:59'
ORDER BY tgl_krs ASC;

-- ----------------------------------------------------------------------------
-- 4. PENYARINGAN DENGAN IN (KI-04)
-- Pertanyaan: Mata kuliah apa saja yang memiliki bobot SKS 3 atau 4?
-- Hasil yang diharapkan: Daftar kode, nama, dan jumlah SKS mata kuliah.
-- ----------------------------------------------------------------------------
SELECT kode_mata_kuliah, nama_mata_kuliah, sks_mata_kuliah
FROM mata_kuliah
WHERE sks_mata_kuliah IN (3, 4)
ORDER BY sks_mata_kuliah DESC, nama_mata_kuliah ASC;

-- ----------------------------------------------------------------------------
-- 5. PENYARINGAN DENGAN IS NULL (KI-05)
-- Pertanyaan: Mahasiswa siapa saja yang belum mencantumkan nomor handphone (NULL)?
-- Hasil yang diharapkan: Daftar mahasiswa dengan nomor HP kosong.
-- ----------------------------------------------------------------------------
SELECT nim_mahasiswa, nama_mahasiswa, status_mahasiswa
FROM mahasiswa
WHERE no_hp_mahasiswa IS NULL;

-- ----------------------------------------------------------------------------
-- 6. FUNGSI SKALAR STRING: CONCAT & UPPER (KI-06)
-- Pertanyaan: Bagaimana format identitas lengkap mahasiswa (Nama + NIM) dengan prodi huruf kapital?
-- Hasil yang diharapkan: Gabungan teks identitas dan prodi berhuruf kapital.
-- ----------------------------------------------------------------------------
SELECT 
    CONCAT(nama_mahasiswa, ' (NIM: ', nim_mahasiswa, ')') AS identitas_mahasiswa,
    UPPER(prodi_mahasiswa) AS prodi_kapital
FROM mahasiswa;

-- ----------------------------------------------------------------------------
-- 7. FUNGSI SKALAR TANGGAL: DATE_FORMAT (KI-07)
-- Pertanyaan: Bagaimana tanggal pembuatan KRS ditampilkan dalam format Indonesia (DD-MM-YYYY)?
-- Hasil yang diharapkan: Tanggal terformat rapi.
-- ----------------------------------------------------------------------------
SELECT 
    no_krs,
    DATE_FORMAT(tgl_krs, '%d-%m-%Y %H:%i:%s') AS waktu_krs_indo
FROM krs
ORDER BY tgl_krs DESC;

-- ----------------------------------------------------------------------------
-- 8. KONDISIONAL DENGAN CASE (KI-08)
-- Pertanyaan: Bagaimana status mahasiswa dikelompokkan menjadi keterangan yang lebih deskriptif?
-- Hasil yang diharapkan: Menampilkan label status aktif, cuti, atau non-aktif/lulus.
-- ----------------------------------------------------------------------------
SELECT 
    nim_mahasiswa,
    nama_mahasiswa,
    status_mahasiswa,
    CASE status_mahasiswa 
        WHEN 'aktif' THEN 'Kuliah Aktif'
        WHEN 'cuti' THEN 'Sedang Cuti Akademik'
        ELSE 'Tidak Aktif / Lulus' 
    END AS keterangan_status
FROM mahasiswa;

-- ----------------------------------------------------------------------------
-- 9. FUNGSI SKALAR NUMERIK & PERHITUNGAN BARIS (KI-09)
-- Pertanyaan: Berapa nilai angka detail KRS jika dilakukan pembulatan atau simulasi pengali tertentu?
-- Hasil yang diharapkan: Angka nilai terbulatkan per baris detail KRS.
-- ----------------------------------------------------------------------------
SELECT 
    id_krs,
    id_kelas,
    nilai_angka_detail_krs,
    ROUND(nilai_angka_detail_krs, 0) AS nilai_bulat
FROM detail_krs
WHERE nilai_angka_detail_krs IS NOT NULL;

-- ----------------------------------------------------------------------------
-- 10. KOMBINASI WHERE, ORDER BY, DAN LIMIT (KI-10)
-- Pertanyaan: Apa 3 mata kuliah dengan semester paling awal di kurikulum?
-- Hasil yang diharapkan: 3 data mata kuliah di semester terendah.
-- ----------------------------------------------------------------------------
SELECT kode_mata_kuliah, nama_mata_kuliah, semester_mata_kuliah, sks_mata_kuliah
FROM mata_kuliah
ORDER BY semester_mata_kuliah ASC, sks_mata_kuliah DESC
LIMIT 3;