Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 6

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 24 Oktober 2026

1.Tujuan Praktikum

Memahami dan mengimplementasikan perintah Data Manipulation Language (DML) seperti INSERT, UPDATE, DELETE, dan SELECT pada basis data relasional. Memahami penerapan aturan integritas data (constraints) meliputi PRIMARY KEY, UNIQUE, CHECK, dan FOREIGN KEY. Memahami penggunaan mode pengamanan pembaruan data sql_safe_updates pada MySQL/MariaDB. Mampu melakukan manipulasi data kompleks seperti pengarsipan record (CREATE TABLE ... LIKE & INSERT ... SELECT) dan pembaruan berbasis fungsi matematika/pembulatan (ROUND). Menyusun dan mendokumentasikan skenario pengujian integritas data (uji positif, negatif, dan identifikasi utang desain).

2.Ringkasan Teori

Data Manipulation Language (DML) merupakan kumpulan perintah SQL yang digunakan untuk memanipulasi dan mengelola data di dalam tabel, seperti menambah data (INSERT), menampilkan data (SELECT), memperbarui data (UPDATE), dan menghapus data (DELETE). Untuk menjaga keandalan dan validitas data, diterapkan aturan integritas (constraints) seperti PRIMARY KEY untuk identifikasi unik baris, UNIQUE untuk mencegah duplikasi kolom, CHECK untuk memvalidasi kondisi logis nilai, serta FOREIGN KEY untuk memelihara hubungan relasional antar tabel. Fitur keamanan sql_safe_updates pada MariaDB mencegah operasi UPDATE atau DELETE tanpa klausa WHERE berbasis kolom kunci agar tidak terjadi pembaruan massal yang tidak disengaja. Selain itu, teknik pengarsipan data memindahkan record nonaktif ke tabel arsip untuk menjaga efisiensi performa query tanpa kehilangan histori data.

3.Hasil Langkah Percobaan

Pemuatan skrip data awal pada basis data akad_25430079 dan kopma_25430079 berhasil dieksekusi tanpa kendala dari kondisi awal. Pengujian penambahan data mahasiswa baru bernama Siti Rahma berhasil dimasukkan dan diverifikasi pada tabel mahasiswa. Pengujian perintah UPDATE dengan mengaktifkan mode sql_safe_updates = 1 berhasil diperbarui menggunakan klausa WHERE berbasis kolom kunci. Seluruh bukti hasil tangkapan layar eksekusi terminal berada pada folder image modul 6.

4.Jawaban Titik Analisis

Perintah UPDATE tanpa klausa WHERE ditolak saat sql_safe_updates = 1 karena fitur ini dirancang untuk mencegah kecelakaan fatal berupa pembaruan seluruh record tabel secara tidak sengaja, sehingga MariaDB mewajibkan klausa WHERE yang merujuk pada kolom berindeks atau kunci. Penggunaan CREATE TABLE ... LIKE lebih unggul dibanding CREATE TABLE ... AS SELECT untuk tabel arsip karena menduplikasi seluruh struktur tabel secara presisi termasuk tipe data, default value, PRIMARY KEY, UNIQUE, dan INDEX, sedangkan AS SELECT tidak menyalin constraint dan kunci indeks. Pembatasan kuantitas stok dinamis saat transaksi tidak cukup dengan CHECK (stok >= 0) karena constraint CHECK bersifat statis pada baris yang sedang diproses dan tidak dapat membandingkan nilai transaksi baru secara dinamis dengan sisa stok master barang sebelum transaksi diselesaikan.

5.Hasil Latihan dan Modifikasi

Pada latihan E.1, dilakukan pengarsipan data anggota berstatus nonaktif yang mendaftar sebelum tahun 2025 (Dewi Lestari) dengan membuat tabel anggota_arsip menggunakan perintah CREATE TABLE ... LIKE, memindahkan record via INSERT INTO ... SELECT, dan menghapus record asli pada tabel anggota. Pada latihan E.2, dilakukan penyesuaian harga jual seluruh barang kategori makanan sebesar 5% dengan pembulatan ke ratusan terdekat menggunakan fungsi matematika ROUND(harga_jual_barang * 1.05, -2), seperti pada produk Roti Cokelat yang harganya diperbarui dari Rp5.000 menjadi Rp5.300.

6.Tugas Mandiri: Milestone Proyek 06

Pengembangan skrip data p06_data_079.sql dan p06_data_kopma_079.sql telah diselesaikan dan teruji reproducible dari kondisi database kosong. Dokumentasi pengujian dilakukan melalui p06_uji_079.md dan p06_uji_kopma_079.md yang masing-masing memuat 10 skenario uji (3 positif, 6 negatif, dan 1 uji gagal utang desain). Uji negatif membuktikan sistem berhasil menolak duplikasi NIM (uq_mahasiswa_nim), stok negatif (ck_barang_stok), dan SKS melebihi batas (ck_matakuliah_sks). Uji gagal pada pembatasan transaksi dinamis dicatat sebagai Utang Desain untuk diselesaikan pada Modul 14 via kendaly blok Transaksi.

7.Pembahasan dan Kendala

Praktikum Modul 6 berhasil menunjukkan peran aturan integritas basis data dalam menolak manipulasi data yang tidak valid di tingkat server database secara otomatis. Penggunaan sql_safe_updates dan fungsi ROUND melatih ketelitian dalam manipulasi DML. Kendala yang dihadapi adalah batasan constraint statis yang tidak dapat memvalidasi aturan bisnis dinamis lintas tabel (seperti cek sisa stok sebelum transaksi), sehingga solusinya dicatat sebagai Utang Desain (Design Debt) yang akan ditangani menggunakan transaksi majemuk pada Modul 14.

8.Kesimpulan

Operasional DML (INSERT, UPDATE, DELETE, SELECT) merupakan fondasi pengelolaan data yang dikawal ketat oleh aturan constraint untuk menjaga integritas data. Fitur sql_safe_updates memberikan perlindungan efektif terhadap risiko kehilangan data massal akibat ketiadaan klausa batasan. Pengarsipan data dengan CREATE TABLE ... LIKE berhasil memisahkan data historis tanpa merusak struktur dan kunci tabel utama. Aturan bisnis dinamis lintas tabel memerlukan mekanimse kendali transaksi yang lebih komprehensif pada modul mendatang.

9.Pernyataan Penggunaan AI

Laporan dan praktikum ini disusun dengan bantuan AI sebagai mitra diskusi logis dan pendampingan teknis dalam memverifikasi sintaks ekspresi SQL (ROUND, CREATE TABLE LIKE, INSERT ... SELECT), mendiskusikan analisis constraint, dan menyesuaikan format laporan. Seluruh eksekusi di MariaDB, pengujian terminal, pengambilan tangkapan layar, dan penyusunan akhir dilakukan secara mandiri oleh praktikan.

10.Bukti Git

Tautan Repositori: https://github.com/vikaenzelia/basisdata-079
Hash Commit Terakhir: 797e6b5

Checklist
- [x] Laporan ditulis dengan format Markdown dalam folder laporan/
- [x] Penamaan file sesuai format p06_laporan_25430079.md
- [x] Semua screenshot terminal telah disertakan dengan keterangan
- [x] Jawaban titik analisis diisi lengkap
- [x] Hasil latihan dan modifikasi (Bagian E) disertakan
- [x] File skenario uji p06_uji_25430079.md dan p06_uji_kopma_079.md lengkap
- [x] Skrip DDL dan data teruji reproducible
- [x] Seluruh perubahan telah di-commit dan di-push ke GitHub