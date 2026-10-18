# Laporan Praktikum Basis Data - Pertemuan 04
**Nama:** Vika Desty Enzelia 
**NIM:** 25430079 
**Kelas:** C
**Tanggal:** 18 Oktober 2026

## 1. Tujuan Praktikum
1. Memahami konsep dasar normalisasi basis data mulai dari bentuk unnormalized (UNF), 1NF, 2NF, 3NF, hingga BCNF.
2. Mampu menganalisis ketergantungan fungsional (*Functional Dependency*) pada suatu himpunan atribut.
3. Mampu mengidentifikasi dan menangani atribut bernilai banyak (*multivalued attribute*) serta menganalisis anomali pembaruan (*update anomaly*).
4. Menyusun skema relasional yang optimal dan ternormalisasi untuk proyek basis data Koperasi Mahasiswa (Kopma) Sejahtera.

## 2. Ringkasan Dasar Teori
* **Normalisasi:** Proses sistematis untuk mengorganisasi data dalam basis data guna mengurangi redundansi data dan mencegah terjadinya anomali (Insert, Update, Delete).
* **Unnormalized Form (UNF):** Bentuk tabel mentah yang mengandung kelompok data berulang (*repeating groups*).
* **1NF (First Normal Form):** Setiap sel dalam tabel harus bernilai atomik (tunggal) dan tidak ada kelompok data berulang. Atribut *multivalued* dipisahkan ke tabel terpisah.
* **2NF (Second Normal Form):** Memenuhi 1NF dan setiap atribut bukan kunci harus bergantung penuh pada kunci primer (*no partial dependency*).
* **3NF (Third Normal Form):** Memenuhi 2NF dan tidak ada ketergantungan transitif (*no transitive dependency*), yaitu atribut bukan kunci tidak boleh bergantung pada atribut bukan kunci lainnya.
* **BCNF (Boyce-Codd Normal Form):** Bentuk normal yang lebih ketat dari 3NF di mana setiap penentu (*determinant*) harus merupakan kunci kandidat (*candidate key*).

## 3. Hasil Langkah Percobaan
Bukti tangkapan layar langkah pengerjaan berada di dalam folder gambar image.

## 4. Jawaban Titik Analisis
1. **Analisis Kebutuhan Atomisitas Nilai:** Atribut seperti nomor telepon pemasok yang berjumlah lebih dari satu tidak dapat disimpan dalam satu sel tabel tunggal karena melanggar syarat 1NF.
2. **Analisis Ketergantungan Transitif pada Penjualan:** Penyimpanan nama anggota secara langsung pada tabel transaksi Penjualan menyebabkan `no_nota` $\rightarrow$ `no_anggota` $\rightarrow$ `nama_anggota`. Hal ini memicu terjadinya *update anomaly* apabila terjadi perubahan nama anggota di kemudian hari.

## 5. Hasil Latihan dan Modifikasi

### A. Normalisasi Pemasok dengan Beberapa Nomor Telepon
* **Masalah:** Atribut `telepon` pada tabel `Pemasok` bersifat *multivalued* (satu pemasok memiliki lebih dari satu nomor telepon), yang melanggar aturan **1NF**.
* **Solusi Normalisasi:** Dipisahkan menjadi tabel terpisah bernama `Pemasok_Telepon` yang terhubung kembali ke tabel utama `Pemasok` melalui `kode_pemasok` sebagai *Foreign Key* (FK).
* **Skema Relasi Baru:**
  1. **`Pemasok`** (`kode_pemasok` [PK], `nama_pemasok`, `alamat`)
  2. **`Pemasok_Telepon`** (`kode_pemasok` [PK, FK], `no_telepon` [PK])

### B. Contoh Pelanggaran 3NF dan Anomali Ubah (Update Anomaly)
* **Masalah Pelanggaran 3NF:** 
  Terjadi ketergantungan transitif: `no_nota` $\rightarrow$ `no_anggota` $\rightarrow$ `nama_anggota`.

* **Contoh Data yang Melanggar 3NF:**
  | no_nota | tanggal_jam | no_anggota | nama_anggota | total_bayar |
  | :--- | :--- | :--- | :--- | :--- |
  | PJ-2609-0142 | 2026-09-10 08:30 | A-0457 | Vika Desty Enzelia | 25000 |
  | PJ-2609-0155 | 2026-09-12 10:15 | A-0457 | Vika Desty Enzelia | 18000 |
  | PJ-2609-0189 | 2026-09-15 14:00 | A-0457 | Vika Desty Enzelia | 42000 |

* **Anomali Ubah (*Update Anomaly*):**
  Jika anggota dengan `no_anggota = 'A-0457'` merubah penulisan nama profilnya di sistem, kueri harus memperbarui banyak baris transaksi secara berulang. Jika ada satu baris yang terlewat, data nama anggota menjadi tidak konsisten (*inconsistent data*).

* **Kueri Ubah (UPDATE) yang Memperlihatkan Anomali:**
  ```sql
  UPDATE Penjualan 
  SET nama_anggota = 'Vika Desty Enzelia' 
  WHERE no_anggota = 'A-0457';

## 6. Tugas Mandiri: Milestone Proyek Kopma Sejahtera

### A. Bentuk Unnormalisasi (UNF)
**KOPMA_UNF** (`no_nota`, `tanggal_jam`, `kode_kasir`, `no_anggota`, `nim_anggota`, `{ kode_barang, nama_barang, qty, harga_satuan_detail }`, `subtotal`, `diskon_anggota`, `total_bayar`, `bayar`, `kembali`)

### B. Dependensi Fungsional (FD)
- **FD1:** `no_nota` $\rightarrow$ `tanggal_jam`, `kode_kasir`, `no_anggota`, `subtotal`, `diskon_anggota`, `total_bayar`, `bayar`, `kembali`
- **FD2:** `no_anggota` $\rightarrow$ `nim_anggota`, `nama`, `prodi`, `no_hp`, `status_aktif`, `poin_loyalitas`
- **FD3:** `kode_barang` $\rightarrow$ `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum_stok`
- **FD4:** (`no_nota`, `kode_barang`) $\rightarrow$ `qty`, `harga_satuan_detail`
- **FD5:** `kode_pemasok` $\rightarrow$ `nama_pemasok`, `telepon`, `alamat`
- **FD6:** `no_faktur` $\rightarrow$ `tanggal`, `kode_pemasok`, `kode_barang`, `qty`, `harga_beli`

### C. Hasil 3NF Akhir
1. **Anggota** (`no_anggota` [PK], `nim_anggota`, `nama`, `prodi`, `no_hp`, `status_aktif`, `poin_loyalitas`)
2. **Barang** (`kode_barang` [PK], `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum_stok`)
3. **Petugas** (`kode_petugas` [PK], `nama_petugas`, `peran`)
4. **Pemasok** (`kode_pemasok` [PK], `nama_pemasok`, `alamat`)
5. **Pemasok_Telepon** (`kode_pemasok` [PK, FK], `no_telepon` [PK])
6. **Penjualan** (`no_nota` [PK], `tanggal_jam`, `kode_kasir` [FK], `no_anggota` [FK], `total_bayar`)
7. **Detail_Penjualan** (`no_nota` [PK, FK], `kode_barang` [PK, FK], `qty`, `harga_satuan_detail`)
8. **Pembelian** (`no_faktur` [PK], `tanggal`, `kode_pemasok` [FK], `kode_barang` [FK], `qty`, `harga_beli`)

### D. BCNF dan Nilai Turunan
- **BCNF:** Seluruh tabel telah memenuhi BCNF karena setiap penentu (*determinant*) merupakan kunci kandidat (*candidate key*).
- **Nilai Turunan:** Atribut `subtotal`, `diskon_anggota`, `total_bayar`, dan `kembalian` dihitung secara dinamis (*dynamic calculation*) dan tidak disimpan permanen di tabel operasional sesuai aturan bisnis AB-04.

## 7. Pembahasan dan Kendala
- **Pembahasan:** Proses normalisasi pada proyek Kopma Sejahtera berhasil memecah tabel mentah UNF menjadi 8 tabel relasional yang saling terhubung dengan Primary Key dan Foreign Key tanpa redundansi data.
- **Kendala:** Penulisan naskah laporan menggunakan aplikasi Notepad sehingga memerlukan pengecekan format Markdown secara manual agar tampil dengan baik saat diunggah ke repositori.

## 8. Kesimpulan
Melalui praktikum ini, skema basis data Koperasi Mahasiswa Sejahtera telah berhasil dinormalisasi hingga bentuk 3NF dan BCNF. Atribut bernilai banyak (*multivalued*) telah ditangani dengan benar, serta nilai kalkulasi turunan telah dipisahkan agar tidak menyimpan data redundan.

## 9. Pernyataan Penggunaan AI
Laporan ini disusun dengan bantuan AI (Gemini) untuk membantu dalam penyusunan struktur Laporan Baku, analisis anomali 3NF, penyesuaian format Markdown, serta pemeriksaan konsistensi skema relasional Kopma Sejahtera.

## 10. Bukti Git
- **Tautan Repositori:** `https://github.com/vikaenzelia/basisdata-079`
- **Hash Commit:** 1c661ca

## Checklist
- [x] Laporan disusun sesuai struktur baku.
- [x] Memuat identitas Nama, NIM, Kelas, dan Tanggal.
- [x] Memuat Ringkasan Dasar Teori.
- [x] Memuat Hasil Langkah Percobaan (gambar + keterangan).
- [x] Memuat Jawaban Titik Analisis.
- [x] Memuat Hasil Latihan dan Modifikasi.
- [x] Memuat Tugas Mandiri Milestone Proyek.
- [x] Memuat Pembahasan dan Kendala.
- [x] Memuat Kesimpulan.
- [x] Memuat Pernyataan Penggunaan AI.
- [x] Memuat Bukti Git (tautan repositori & hash commit).
