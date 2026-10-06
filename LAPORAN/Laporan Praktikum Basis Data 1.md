# Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 1

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 3 Oktober 2026

1. Tujuan Praktikum
Menjalankan dan menghentikan layanan MariaDB melalui XAMPP Control Panel serta memeriksa status dan port server.
Terhubung ke server MariaDB menggunakan CLI dan phpMyAdmin serta memahami perbedaan operasional keduanya.
Mengamankan akun root dengan sandi dan mengonfigurasi akun kerja dengan privilese terbatas pada basis data tertentu.
Membangun basis data pertama dan mengelola perubahan proyek menggunakan Git dan GitHub.
2. Ringkasan Teori
DBMS bertindak sebagai pengelola terpusat untuk menyimpan, mengamankan, dan memanipulasi data secara konsisten. MariaDB beroperasi dengan arsitektur klien-server pada port default 3306. Klien seperti CLI dan phpMyAdmin mengirim kueri SQL ke proses server (mysqld), yang mengeksekusi instruksi dan mengembalikan hasilnya. CLI menawarkan keunggulan berupa eksekusi skrip yang dapat diulang (reproducible) dan dicatat dalam kendali versi Git, sedangkan phpMyAdmin menyediakan antarmuka berbasis web. Untuk alasan keamanan, sistem menerapkan prinsip hak akses minimum (least privilege) dengan membatasi privilese akun kerja hanya pada basis data yang dikelola.

3. Langkah Percobaan
Tangkapan layar hasil berada pada folder Image, verivikasi Server dan Kueri Identitas.
Setelah mengaktifkan layanan MySQL pada XAMPP Control Panel, perintah verifikasi di jalankan melalui CLI.

SELECT VERSION(), CURRENT_USER();
SELECT @@sql_mode;

Konfigurasi Akun Kerja dan Pembatasan Hak Akses
Pembuatan basis data kopma_123 dan pembuatan pengguna mhs_123 dengan hak akses terbatas.
Verifikasi hak akses basis data saat login menggunakan mhs_123:
SHOW DATABASES;
Pengujian pengaksesan basis data sistem mysql:
USE mysql;

4. Titik Analisis
Walaupun tombol di XAMPP berlabel "MySQL", server yang aktif adalah MariaDB 10.4.32. Dokumentasi MySQL digunakan untuk sintaks SQL standar, sedangkan dokumentasi MariaDB wajib dirujuk untuk arsitektur, konfigurasi my.ini, mesin penyimpanan Aria, dan penanganan galat internal.
Menjalankan mysql -u root tanpa -p setelah kata sandi dikonfigurasi menghasilkan ERROR 1045 (28000). Frasa (using password: NO) menandakan bahwa klien mencoba terhubung tanpa mengoperkan parameter kata sandi.
Akun mhs_123 dapat mengakses information_schema karena berisi metadata standar sesuai hak akses pengguna. Akses ke mysql ditolak (ERROR 1044) karena memuat kredensial global. Perbedaannya: ERROR 1044 adalah gagal hak akses pada objek/basis data, sedangkan ERROR 1045 adalah gagal otentikasi identitas/sandi.
Mode auth_type = 'cookie' pada phpMyAdmin lebih aman karena mewajibkan pendaftaran masuk tiap sesi peramban dimulai, berbeda dari mode config yang menyimpan kredensial dalam bentuk teks polos (plain text) di berkas config.inc.php.

5. Hasil Latihan
Tangkapan layar hasil Galat berada pada folder Image.

(Pembuatan Pengguna Tamu & Uji Hak Akses): Pengguna tamu_123 dibuat dengan izin akses hanya untuk membaca (SELECT) pada basis data kopma_123. Ketika mencoba membuat tabel (CREATE TABLE), sistem menolak dengan pesan ERROR 1142, yang membuktikan bahwa pembatasan hak akses berhasil.
(Skrip Re-executable): Skrip p01_lingkungan_2301010123.sql diperbaiki dengan menambahkan klausa IF NOT EXISTS agar skrip dapat dijalankan berulang kali tanpa menghasilkan galat duplikasi.

6. Tugas Mandiri:Milestone Proyek 1
Pembuatan basis data proyek akademik_akad
pembuatan akun pengembang dev_079 dengan hak penuh ke basis data projek
penambahan identitas proyek di dalam berkas README.md dan pembuatan berkas .gitiknore

7. Pembahasan dan Kendala
Selama pengerjaan terjadi kendala dan galat, namun setelah memahami buku panduan yang telah di berikan oleh dosen pengampu, serta bertanya dan di arahkan oleh AI maka proses dapat di lakukan dengan baik.

8. Kesimpulan
Lingkungan kerja MariaDB 10.4.32 pada XAMPP dan Git telah berhasil dikonfigurasi dan diverifikasi. Pembedaan antara akun administrator (root) dan akun kerja (mhs_079, dev_079) berhasil mengimplementasikan prinsip privilese minimum untuk menjaga keamanan data. Seluruh riwayat perubahan skrip dan dokumentasi proyek telah terstruktur dan diunggah ke repositori GitHub.

9. Pernyataan Penggunaan AI
Saya menggunakan bantuan AI untuk memahami buku panduan, mencari referensi dalam penulisan laporan serta bertanya apakah Langkah yang saya lakukan sudah sesuai dengan buku panduan atau belum.

10. Bukti Git
Tautan Repositori:https://github.com/vikaenzelia/basisdata-079

Hash Commit Pertemuan 1: 7765927

Checklist
[x] Identitas Laporan Lengkap

[x] Tujuan Praktikum Ditulis Ulang

[x] Ringkasan Dasar Teori Murni Pemahaman Sendiri

[x] Tangkapan Layar / Teks Hasil Percobaan Disertakan

[x] Seluruh Titik Analisis (1-4) Dijawab Berurutan

[x] Latihan E1 dan E2 Diselesaikan

[x] Milestone Proyek 1 Diselesaikan

[x] Pembahasan dan Kendala Dicatat

[x] Kesimpulan Tersusun

[x] Pernyataan Penggunaan AI Disertakan

[x] Bukti Tautan Git dan Hash Commit Valid

