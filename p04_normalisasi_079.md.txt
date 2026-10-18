# Laporan Normalisasi dan Skema Relasional - Sistem Informasi Akademik

---

## 1. Bentuk Unnormalisasi (UNF - Unnormalized Form)

Berdasarkan dokumen sumber fiktif **Kartu Rencana Studi (KRS)**, seluruh atribut dikumpulkan ke dalam satu tabel mentah yang masih memiliki kelompok data berulang (*repeating group* pada daftar mata kuliah yang diambil mahasiswa):

**KRS_UNF** (`nim`, `nama_mahasiswa`, `prodi`, `dosen_pa`, `nip_pa`, `tahun_ajaran`, `semester`, `{ kode_mk, nama_mk, sks, kelas, hari, jam, dosen_pengampu }`, `total_sks`, `status_persetujuan`)

---

## 2. Dependensi Fungsional (Functional Dependency)

Berdasarkan aturan bisnis (AB-xx) pada dokumen kebutuhan data, diturunkan ketergantungan fungsional sebagai berikut:

* **FD1:** `nim` $\rightarrow$ `nama_mahasiswa`, `prodi`, `dosen_pa`, `nip_pa` *(Atribut mahasiswa ditentukan oleh NIM)*
* **FD2:** `nip` $\rightarrow$ `nama_dosen`, `email_dosen`, `no_hp_dosen`, `gelar` *(Atribut dosen ditentukan oleh NIP)*
* **FD3:** `kode_mk` $\rightarrow$ `nama_mk`, `sks`, `semester_penawaran` *(Atribut mata kuliah ditentukan oleh Kode MK)*
* **FD4:** `kode_kelas` $\rightarrow$ `kode_mk`, `nip_dosen`, `hari`, `jam`, `ruangan`, `kuota` *(Atribut kelas ditentukan oleh Kode Kelas)*
* **FD5:** (`id_krs`, `kode_kelas`) $\rightarrow$ `nilai_angka`, `nilai_huruf` *(Detail pengambilan kelas ditentukan oleh kombinasi KRS dan Kelas)*
* **FD6:** `id_krs` $\rightarrow$ `nim`, `tahun_ajaran`, `semester`, `tgl_pengajuan`, `status_persetujuan` *(Kepala KRS ditentukan oleh ID KRS)*

---

## 3. Tahapan Normalisasi

### A. Bentuk Normal Pertama (1NF)
* **Syarat:** Menghilangkan semua grup berulang dan memastikan setiap nilai dalam sel bersifat atomik (tunggal).
* **Hasil 1NF:** Pengulangan daftar mata kuliah pada KRS dipisahkan ke dalam baris tersendiri dengan kunci primer komposit `(id_krs, kode_kelas)`.

### B. Bentuk Normal Kedua (2NF)
* **Syarat:** Memenuhi 1NF dan tidak ada atribut bukan kunci yang bergantung secara parsial pada sebagian kunci primer komposit.
* **Hasil 2NF:** Karena kunci primernya komposit, atribut yang hanya bergantung pada sebagian kunci (misalnya data mata kuliah terhadap `kode_mk` atau data mahasiswa terhadap `nim`) dipisah keluar menjadi tabel independen.

### C. Bentuk Normal Ketiga (3NF)
* **Syarat:** Memenuhi 2NF dan tidak ada ketergantungan transitif (atribut bukan kunci bergantung pada atribut bukan kunci lainnya).
* **Hasil 3NF Akhir:**
  1. **Mahasiswa** (`nim` [PK], `nama_mahasiswa`, `prodi`, `angkatan`, `status_aktif`, `nip_pa` [FK], `email_pribadi`, `no_hp`)
  2. **Dosen** (`nip` [PK], `nama_dosen`, `email_dosen`, `no_hp_dosen`, `gelar`)
  3. **Mata_Kuliah** (`kode_mk` [PK], `nama_mk`, `sks`, `semester_penawaran`)
  4. **Kelas** (`kode_kelas` [PK], `kode_mk` [FK], `nip_dosen` [FK], `hari`, `jam`, `ruangan`, `kuota`)
  5. **KRS** (`id_krs` [PK], `nim` [FK], `tahun_ajaran`, `semester`, `tgl_pengajuan`, `status_persetujuan`)
  6. **Detail_KRS** (`id_krs` [PK, FK], `kode_kelas` [PK, FK], `nilai_angka`, `nilai_huruf`)

---

## 4. Pemeriksaan Bentuk Normal Boyce-Codd (BCNF)

* Setiap tabel di atas diperiksa apakah setiap penentu (*determinant*) merupakan *candidate key*.
* Seluruh tabel di atas telah memenuhi BCNF karena setiap sisi kiri dari ketergantungan fungsional yang ada merupakan kunci kandidat yang sah.

---

## 5. Keputusan Nilai Turunan

* **Total SKS Diambil & Maksimal SKS:** Diputuskan untuk **TIDAK DISIMPAN** secara permanen sebagai kolom fisik di dalam tabel basis data operasional. Nilai ini akan dihitung secara dinamis (*dynamic calculation/derived*) menggunakan fungsi agregat SQL (`SUM(sks)`) saat kueri atau laporan KHS/KRS dicetak. Hal ini mencegah terjadinya inkonsistensi data apabila ada perubahan pengambilan mata kuliah di kemudian hari.