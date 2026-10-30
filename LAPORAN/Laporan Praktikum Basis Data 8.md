Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 8

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 30 Oktober 2026

1.Tujuan Praktikum

Mengonsolidasikan seluruh rangkaian hasil perancangan dan pengimplementasian basis data relasional proyek mandiri dari Pertemuan 1 hingga Pertemuan 7. Membangun dan menguji skrip instalasi bersih (clean installation script) install_uts_079.sql yang mampu menghapus, membuat ulang, mengeksekusi DDL, memuat data sampel DML, serta memverifikasi basis data secara otomatis dan reproducible. Memastikan integritas referensial, constraints, serta kesesuaian skema basis data Sistem Informasi Akademik (akad_25430079).

2.Ringkasan Teori

Clean Installation Script merupakan skrip SQL terintegrasi yang dirancang untuk membangun kembali seluruh lingkungan basis data dari kondisi nol (fresh state) secara otomatis dan konsisten. Dalam pengoperasian DBMS MariaDB, skrip ini menggabungkan perintah Data Definition Language (DDL) dan Data Manipulation Language (DML) menggunakan perintah SOURCE. Pendekatan ini menjamin sifat reproducibility dalam pengembangan perangkat lunak dan basis data, di mana skrip dapat dijalankan berulang kali tanpa menghasilkan galat duplikasi atau orphan data. Selain itu, pengujian instalasi bersih memastikan bahwa aturan integritas data (Primary Key, Foreign Key, CHECK, UNIQUE, dan NOT NULL) serta relasi antar-entitas yang telah dirancang sejak tahap analisis kebutuhan hingga normalisasi berjalan dengan sempurna.

3.Hasil Langkah Percobaan

Eksekusi skrip instalasi bersih install_uts_079.sql pada basis data akad_25430079 berhasil dieksekusi melalui terminal MariaDB Shell XAMPP tanpa ada galat. Seluruh bukti hasil tangkapan layar eksekusi terminal berada pada folder image modul 8.

4.Jawaban Titik Analisis

Perintah DROP DATABASE IF EXISTS digunakan diawal skrip untuk memastikan seluruh struktur atau data lama dihapus secara total dari server, sehingga instalasi benar-benar dimulai dari kondisi bersih tanpa konflik duplikasi. Pemanggilan berkas DDL (p05_ddl_079.sql) wajib dilakukan sebelum DML (p06_data_079.sql) karena struktur tabel dan relasi Foreign Key harus tercipta terlebih dahulu sebelum data dapat dimasukkan. Penggunaan path lengkap direkomendasikan pada perintah SOURCE untuk mencegah galat Failed to open file (error: 2) akibat ketidaksesuaian posisi direktori aktif terminal saat perintah dieksekusi.

5.Hasil Latihan dan Modifikasi

Pada praktikum ini dilakukan pembuatan dan pengujian berkas install_uts_079.sql untuk melakukan instalasi ulang secara otomatis. Isi berkas mencakup penghapusan basis data lama, pembuatan basis data baru akad_25430079, pemanggilan p05_ddl_079.sql, pemanggilan p06_data_079.sql, serta pengujian verifikasi data. Hasil verifikasi menampilkan pesan status 'INSTALASI BERSIH UTS BERHASIL!', 6 tabel terbentuk lengkap (detail_krs, dosen, kelas, krs, mahasiswa, mata_kuliah), dan total data detail_krs sebanyak 9 baris.

6.Tugas Mandiri: Milestone Proyek 08

Rekapitulasi milestone proyek akademik tahap 1 (P01-P07) telah diselesaikan secara lengkap. P01: Konfigurasi lingkungan MariaDB dan pemisahan akun pengembang dev_079. P02: Identifikasi kebutuhan data dan aturan bisnis parameter P=8. P03: Perancangan ERD Fisik 6 entitas utama. P04: Normalisasi basis data hingga bentuk 3NF/BCNF. P05: Implementasi DDL dan constraint pada p05_ddl_079.sql. P06: Manipulasi data sampel DML pada p06_data_079.sql dan pengujian p06_uji_079.md. P07: Penyusunan 10 kueri pencarian data pada p07_kueri_079.sql. Seluruh skrip teruji reproducible.

7.Pembahasan dan Kendala

Praktikum Modul 8 berhasil mengonsolidasikan seluruh hasil kerja proyek tahap 1 menjadi skrip otomatis yang siap didemonstrasikan. Kendala yang dihadapi pada pengujian awal adalah munculnya galat Failed to open file (error: 2) saat menjalankan SOURCE. Solusi dilakukan dengan mengubah path pemanggilan berkas di dalam install_uts_079.sql menggunakan path absolut lengkap (D:/basisdata-079/p05_ddl_079.sql) sehingga skrip dapat tereksekusi mulus tanpa galat.

8.Kesimpulan

Seluruh rangkaian milestone proyek tahap 1 untuk Sistem Informasi Akademik (akad_25430079) telah diselesaikan dan didokumentasikan dengan rapi. Skrip instalasi bersih install_uts_079.sql terbukti berjalan lancar, reproducible, dan mampu membangun kembali seluruh struktur tabel serta data sampel dari kondisi nol secara otomatis.

9.Pernyataan Penggunaan AI

Laporan dan praktikum ini disusun dengan bantuan AI sebagai mitra diskusi logis dalam merangkum rekapitulasi milestone, menganalisis penanganan galat path pada MariaDB, dan menyesuaikan format laporan. Seluruh eksekusi di MariaDB Shell, pengujian terminal, pengambilan tangkapan layar, dan penulisan laporan dilakukan secara mandiri oleh praktikan.

10.Bukti Git

Tautan Repositori: https://github.com/vikaenzelia/basisdata-079

Hash Commit Pertemuan 1: 7765927
Hash Commit Pertemuan 2: d1f8e3b
Hash Commit Pertemuan 3: fffee56
Hash Commit Pertemuan 4: 1c661ca
Hash Commit Pertemuan 5: 332511a
Hash Commit Pertemuan 6: 797e6b5
Hash Commit Pertemuan 7: 927e0e0

Checklist
[x] Laporan ditulis dengan format Markdown dalam folder laporan/
[x] Penamaan file sesuai format p08_laporan_25430079.md
[x] Semua screenshot terminal telah disertakan dengan keterangan
[x] Jawaban titik analisis diisi lengkap
[x] Hasil latihan dan verifikasi instalasi bersih disertakan
[x] Rekapitulasi milestone proyek 1-7 lengkap
[x] Seluruh perubahan telah di-commit dan di-push ke GitHub