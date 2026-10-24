# Laporan Praktikum Basis Data - Pertemuan 06
**Nama:** Vika Desty Enzelia  
**NIM:** 25430079  
**Kelas:** C  
**Tanggal:** 24 Oktober 2026

## 1. Tujuan Praktikum
1. Memahami dan mengimplementasikan perintah Data Manipulation Language (DML) seperti `INSERT`, `UPDATE`, `DELETE`, dan `SELECT` pada basis data relasional.
2. Memahami penerapan aturan integritas data (*constraints*) meliputi `PRIMARY KEY`, `UNIQUE`, `CHECK`, dan `FOREIGN KEY`.
3. Memahami penggunaan mode pengamanan pembaruan data `sql_safe_updates` pada MySQL/MariaDB.
4. Mampu melakukan manipulasi data kompleks seperti pengarsipan record (`CREATE TABLE ... LIKE` & `INSERT ... SELECT`) dan pembaruan berbasis fungsi matematika/pembulatan (`ROUND`).
5. Menyusun dan mendokumentasikan skenario pengujian integritas data (uji positif, negatif, dan identifikasi utang desain).

## 2. Ringkasan Dasar Teori
* **Data Manipulation Language (DML):** Perintah SQL yang digunakan untuk memanipulasi data di dalam tabel. Utama mencakup `INSERT` (menambah data), `SELECT` (menampilkan data), `UPDATE` (memperbarui data), dan `DELETE` (menghapus data).
* **Integritas Data & Constraints:** Aturan yang diterapkan pada kolom tabel untuk menjaga kualitas dan validitas data.
  * `PRIMARY KEY`: Mengidentifikasi secara unik setiap baris data.
  * `UNIQUE`: Memastikan seluruh nilai dalam satu kolom berbeda/unik.
  * `CHECK`: Memvalidasi agar nilai yang dimasukkan memenuhi kondisi/ekspresi logis tertentu.
  * `FOREIGN KEY`: Memelihara hubungan relasional referensial antar tabel induk dan anak.
* **Mode `sql_safe_updates`:** Fitur keamanan pada MySQL/MariaDB yang mencegah eksekusi perintah `UPDATE` atau `DELETE` tanpa adanya kondisi `WHERE` yang merujuk pada kolom kunci (`PRIMARY KEY` atau `INDEX`).
* **Pengarsipan Data:** Teknik memindahkan record lama atau tidak aktif dari tabel transaksi utama ke tabel arsip untuk menjaga performa query tanpa kehilangan histori data.

## 3. Hasil Langkah Percobaan
Seluruh bukti pengerjaan berada di folder image modul 6.

## 4. Jawaban Titik Analisis
1. **Mengapa perintah `UPDATE` tanpa klausa `WHERE` ditolak saat `sql_safe_updates = 1`?**  
   *Jawaban:* Fitur `sql_safe_updates` dirancang untuk mencegah kecelakaan fatal hilangnya atau berubahnya seluruh record dalam satu tabel secara tidak sengaja. Ketika mode ini aktif, MariaDB/MySQL mewajibkan klausa `WHERE` memuat kolom berindeks atau kunci (`PRIMARY KEY`/`UNIQUE`).
2. **Apa keunggulan penggunaan `CREATE TABLE ... LIKE` dibanding `CREATE TABLE ... AS SELECT` untuk tabel arsip?**  
   *Jawaban:* Perintah `CREATE TABLE ... LIKE` menduplikasi seluruh struktur tabel secara presisi termasuk tipe data, default value, `PRIMARY KEY`, `UNIQUE`, dan `INDEX`, sedangkan `AS SELECT` hanya menyalin data dan struktur tipe kolom tanpa menyalin constraint/kunci indeksnya.
3. **Mengapa pembatasan kuantitas stok dinamis saat transaksi tidak cukup dengan `CHECK (stok >= 0)` saja?**  
   *Jawaban:* Constraint `CHECK` bersifat statis pada baris yang sedang di-insert/update. CHECK tidak bisa membandingkan secara dinamis antara nilai `qty` yang diminta pada transaksi baru dengan sisa `stok` yang ada di tabel master barang sebelum transaksi diselesaikan.

## 5. Hasil Latihan dan Modifikasi
### E.1 Pengarsipan Anggota Nonaktif (Kopma)
Memindahkan anggota berstatus `nonaktif` yang mendaftar sebelum tahun 2025 (Dewi Lestari) ke tabel `anggota_arsip` dan menghapusnya dari tabel utama `anggota`.

### E.2 Pembaruan Harga Barang Kategori Makanan (Kopma)
Menaikkan harga semua barang kategori `makanan` sebesar 5% dengan pembulatan ke ratusan terdekat menggunakan ekspresi `ROUND(harga_jual_barang * 1.05, -2)`.

## 6. Tugas Mandiri: Milestone Proyek 06
* **Skrip Data:** File `p06_data_079.sql` (Akademik) dan `p06_data_kopma_079.sql` (Kopma) telah dikembangkan dan teruji *reproducible* dari database kosong.
* **Pengujian Constraint Akademik:** Tersebar dalam file `p06_uji_079.md` yang memuat 10 skenario uji (3 positif, 6 negatif, dan 1 uji utang desain).
* **Pengujian Constraint Kopma:** Tersebar dalam file `p06_uji_kopma_079.md` yang memuat 10 skenario uji (3 positif, 6 negatif, dan 1 uji utang desain).

### Ringkasan Rangkuman Uji Utama:
| Kode Uji | Domain | Jenis Uji | Target / Constraint | Status |
| :--- | :--- | :--- | :--- | :--- |
| UJ-01 | Akademik | Positif | INSERT Mahasiswa Baru Valid | LULUS |
| UJ-03 | Akademik | Negatif | Duplicate Entry NIM (`uq_mahasiswa_nim`) | LULUS |
| UJ-04 | Akademik | Negatif | SKS Matakuliah > 6 (`ck_matakuliah_sks`) | LULUS |
| UJ-10 | Akademik | Utang Desain | Batas Maksimal SKS/KRS per Transaksi | GAGAL (Utang Modul 14) |
| UJ-03 | Kopma | Negatif | Stok Barang Negatif (`ck_barang_stok`) | LULUS |
| UJ-10 | Kopma | Utang Desain | Pembelian Melebihi Sisa Stok Dinamis | GAGAL (Utang Modul 14) |

## 7. Pembahasan dan Kendala
* **Pembahasan:** Praktikum Modul 6 berhasil menunjukkan efektivitas aturan integritas basis data dalam menolak manipulasi data yang tidak sah secara otomatis di tingkat server database. Penggunaan `sql_safe_updates` dan pembulatan `ROUND` juga melatih ketelitian dalam mengeksekusi operasi DML.
* **Kendala:** Pada pengujian aturan bisnis tingkat transaksi majemuk (seperti validasi ketersediaan stok dinamis atau batas SKS per KRS), *constraint* kolom biasa tidak mampu menanganinya secara mandiri.
* **Solusi:** Aturan bisnis dinamis lintas tabel dicatat sebagai **Utang Desain (Design Debt)** yang nantinya akan ditangani menggunakan blok Transaksi (`START TRANSACTION` / `ROLLBACK`) pada Modul 14.

## 8. Kesimpulan
1. Perintah DML (`INSERT`, `UPDATE`, `DELETE`, `SELECT`) merupakan fondasi utama operasional basis data yang dikendalikan oleh aturan *constraint* (`PRIMARY KEY`, `UNIQUE`, `CHECK`, `FOREIGN KEY`).
2. Mode `sql_safe_updates` memberikan perlindungan signifikan terhadap integritas data dari kerusakan yang disebabkan oleh perintah pembaruan massal tanpa klausa batasan.
3. Teknik pengarsipan data menggunakan `CREATE TABLE ... LIKE` dan `INSERT ... SELECT` berhasil memisahkan record historis tanpa merusak integritas tabel utama.
4. Terdapat batasan pada *constraint* statis dalam menjaga aturan bisnis dinamis lintas tabel, sehingga memerlukan mekanisme kendali transaksi yang lebih komprehensif pada tahap pengembangan berikutnya.

## 9. Pernyataan Penggunaan AI
Laporan dan praktikum ini disusun dengan bantuan AI (Gemini) sebagai mitra diskusi logis dan pendampingan teknis. AI digunakan untuk:
* Membantu memverifikasi sintaks ekspresi SQL (`ROUND`, `CREATE TABLE LIKE`, `INSERT ... SELECT`).
* Mendiskusikan analisis error *constraint* dan struktur penyusunan tabel skenario uji (`p06_uji_079.md` & `p06_uji_kopma_079.md`).
* Memeriksa kesesuaian kerangka laporan dengan Struktur Baku Laporan Modul 6.
Seluruh eksekusi perintah di MariaDB, pengujian terminal, pengambilan tangkapan layar, dan penyusunan isi akhir dilakukan secara mandiri oleh praktikan.

## 10. Bukti Git
* **Tautan Repositori:** `https://github.com/vikadestyenzelia-lang/basisdata-079`
* **Hash Commit Terakhir:

## Checklist
- [x] Laporan ditulis dengan format Markdown dalam folder `laporan/`
- [x] Penamaan file sesuai format `p06_laporan_25430079.md`
- [x] Semua screenshot terminal telah disertakan dengan keterangan
- [x] Jawaban titik analisis diisi lengkap
- [x] Hasil latihan dan modifikasi (Bagian E) disertakan
- [x] File skenario uji `p06_uji_25430079.md` dan `p06_uji_kopma_079.md` lengkap
- [x] Skrip DDL dan data teruji *reproducible*
- [x] Seluruh perubahan telah di-commit dan di-push ke GitHub