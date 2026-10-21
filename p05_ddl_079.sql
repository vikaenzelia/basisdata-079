-- ============================================================================
-- Modul 5: Membangun Struktur dengan DDL dan Constraint (Tugas Mandiri)
-- Nama   : Vika Desty Enzelia
-- NIM    : 25430079
-- Kelas  : C
-- Tema   : Akademik (akad_079)
-- Berkas : p05_ddl_079.sql
-- ============================================================================

USE akad_079;

-- ----------------------------------------------------------------------------
-- 1. PEMBERSIHAN TABEL (DROP TABLE IF EXISTS)
-- Dihapus dari tabel anak ke tabel induk agar tidak melanggar Foreign Key
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS detail_krs;
DROP TABLE IF EXISTS krs;
DROP TABLE IF EXISTS kelas;
DROP TABLE IF EXISTS mata_kuliah;
DROP TABLE IF EXISTS dosen;
DROP TABLE IF EXISTS mahasiswa;

-- ----------------------------------------------------------------------------
-- 2. PEMBUATAN TABEL INDUK (MASTER)
-- ----------------------------------------------------------------------------

-- Tabel 1: mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT NOT NULL AUTO_INCREMENT,
    nim_mahasiswa CHAR(10) NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    prodi_mahasiswa VARCHAR(60) NOT NULL,
    no_hp_mahasiswa VARCHAR(15) NULL, -- Data pribadi (PDP)
    status_mahasiswa ENUM('aktif', 'cuti', 'lulus', 'nonaktif') NOT NULL DEFAULT 'aktif',
    thn_masuk_mahasiswa YEAR NOT NULL,
    PRIMARY KEY (id_mahasiswa),
    UNIQUE KEY uq_mahasiswa_nim (nim_mahasiswa) -- AB-01: NIM bersifat unik
) ENGINE=InnoDB;

-- Tabel 2: dosen
CREATE TABLE dosen (
    id_dosen INT NOT NULL AUTO_INCREMENT,
    nidn_dosen CHAR(10) NOT NULL,
    nama_dosen VARCHAR(100) NOT NULL,
    email_dosen VARCHAR(100) NULL,
    PRIMARY KEY (id_dosen),
    UNIQUE KEY uq_dosen_nidn (nidn_dosen) -- AB-02: NIDN bersifat unik
) ENGINE=InnoDB;

-- Tabel 3: mata_kuliah
CREATE TABLE mata_kuliah (
    id_mata_kuliah INT NOT NULL AUTO_INCREMENT,
    kode_mata_kuliah VARCHAR(10) NOT NULL,
    nama_mata_kuliah VARCHAR(100) NOT NULL,
    sks_mata_kuliah TINYINT NOT NULL,
    semester_mata_kuliah TINYINT NOT NULL,
    PRIMARY KEY (id_mata_kuliah),
    UNIQUE KEY uq_matakuliah_kode (kode_mata_kuliah), -- AB-03: Kode mata kuliah unik
    CONSTRAINT ck_matakuliah_sks CHECK (sks_mata_kuliah BETWEEN 1 AND 6) -- AB-04: SKS antara 1-6
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. PEMBUATAN TABEL OPERASIONAL & TRANSAKSI (ANAK)
-- ----------------------------------------------------------------------------

-- Tabel 4: kelas (Menghubungkan mata kuliah, dosen, dan jadwal)
CREATE TABLE kelas (
    id_kelas INT NOT NULL AUTO_INCREMENT,
    kode_kelas VARCHAR(10) NOT NULL, -- Contoh: KELAS-C, IF-3A
    id_mata_kuliah INT NOT NULL,
    id_dosen INT NOT NULL,
    tahun_akademik_kelas CHAR(9) NOT NULL, -- Contoh: 2026/2027
    semester_kelas ENUM('ganjil', 'genap') NOT NULL,
    hari_kelas ENUM('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu') NOT NULL,
    kuotas_kelas INT NOT NULL DEFAULT 40,
    PRIMARY KEY (id_kelas),
    UNIQUE KEY uq_kelas_kode_ta (kode_kelas, id_mata_kuliah, tahun_akademik_kelas, semester_kelas),
    CONSTRAINT fk_kelas_matakuliah FOREIGN KEY (id_mata_kuliah) REFERENCES mata_kuliah (id_mata_kuliah),
    CONSTRAINT fk_kelas_dosen FOREIGN KEY (id_dosen) REFERENCES dosen (id_dosen),
    CONSTRAINT ck_kelas_kuota CHECK (kuotas_kelas > 0) -- AB-05: Kuota kelas harus positif
) ENGINE=InnoDB;

-- Tabel 5: krs (Kepala Transaksi Pengisian Kartu Rencana Studi)
CREATE TABLE krs (
    id_krs INT NOT NULL AUTO_INCREMENT,
    no_krs VARCHAR(15) NOT NULL, -- Contoh: KRS-20261-001
    tgl_krs DATETIME NOT NULL,
    id_mahasiswa INT NOT NULL,
    tahun_akademik_krs CHAR(9) NOT NULL,
    semester_krs ENUM('ganjil', 'genap') NOT NULL,
    status_krs ENUM('draf', 'disetujui', 'ditolak') NOT NULL DEFAULT 'draf', -- AB-06
    PRIMARY KEY (id_krs),
    UNIQUE KEY uq_krs_no (no_krs),
    CONSTRAINT fk_krs_mahasiswa FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa (id_mahasiswa)
) ENGINE=InnoDB;

-- Tabel 6: detail_krs (Detail Transaksi Mata Kuliah/Kelas yang Diambil)
-- Catatan parameter P: Batas maksimal SKS/matakuliah per transaksi diuji lewat CHECK per baris
-- Batas total baris per KRS (P + 2) ditandai untuk ditangani di Modul 14 via Transaksi.
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_kelas INT NOT NULL,
    nilai_angka_detail_krs DECIMAL(5,2) NULL, -- Nilai akhir (0.00 - 100.00)
    nilai_huruf_detail_krs CHAR(2) NULL, -- A, B+, B, C+, C, D, E
    PRIMARY KEY (id_krs, id_kelas),
    CONSTRAINT fk_detailkrs_krs FOREIGN KEY (id_krs) REFERENCES krs (id_krs) ON DELETE CASCADE,
    CONSTRAINT fk_detailkrs_kelas FOREIGN KEY (id_kelas) REFERENCES kelas (id_kelas),
    CONSTRAINT ck_detailkrs_nilai CHECK (nilai_angka_detail_krs IS NULL OR (nilai_angka_detail_krs BETWEEN 0.00 AND 100.00)) -- AB-07
) ENGINE=InnoDB;