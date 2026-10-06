# LAPORAN PRAKTIKUM BASIS DATA

**Nama:** Vika Desty Enzelia

**NPM:** 25430079

**Kelas:** C

**Pertemuan:** 1

**Dosen Pengampu:** Dedi Irawan, S.Kom., M.T.I.

**Tanggal:** 3 Oktober 2026


### 1. Tujuan Praktikum

Setelah menyelesaikan modul ini, mahasiswa mampu:

* Menjalankan dan menghentikan layanan MariaDB melalui XAMPP Control Panel serta memeriksa status dan port server.
* Terhubung ke server MariaDB menggunakan CLI (*Command Line Interface*) dan phpMyAdmin serta memahami perbedaan operasional keduanya.
* Mengamankan akun `root` dengan kata sandi dan mengonfigurasi akun kerja dengan privilese terbatas pada basis data tertentu.
* Membangun basis data pertama dan mengelola perubahan proyek menggunakan Git dan GitHub.


### 2. Ringkasan Dasar Teori

Database Management System (DBMS) bertindak sebagai pengelola terpusat untuk menyimpan, mengamankan, dan memanipulasi data secara konsisten. MariaDB beroperasi dengan arsitektur klien-server pada port default `3306`. Klien seperti CLI dan phpMyAdmin mengirimkan kueri SQL ke proses server (`mysqld`), yang kemudian mengeksekusi instruksi dan mengembalikan hasilnya.

CLI menawarkan keunggulan berupa eksekusi skrip yang dapat diulang (*reproducible*) dan dicatat dalam kendali versi Git, sedangkan phpMyAdmin menyediakan antarmuka berbasis web. Untuk alasan keamanan, sistem menerapkan prinsip hak akses minimum (*least privilege*) dengan membatasi privilese akun kerja hanya pada basis data yang dikelola.


### 3. Hasil Langkah Percobaan

Tangkapan layar hasil percobaan tersimpan di folder `Image`, memuat verifikasi Server dan Kueri Identitas.

Setelah mengaktifkan layanan MySQL pada XAMPP Control Panel, perintah verifikasi dijalankan melalui CLI:

```sql
SELECT VERSION(), CURRENT_USER();
SELECT @@sql_mode;

```

**Konfigurasi Akun Kerja dan Pembatasan Hak Akses:**

* Pembuatan basis data `kopma_079` dan pembuatan pengguna `mhs_079` dengan hak akses terbatas.
* Verifikasi hak akses basis data saat login menggunakan akun `mhs_079`:
```sql
SHOW DATABASES;

```

* Pengujian pengaksesan basis data sistem `mysql`:
```sql
USE mysql;

```


### 4. Jawaban Titik Analisis

* **Titik Analisis 1:** Walaupun tombol pada XAMPP berlabel "MySQL", server yang aktif sebenarnya adalah MariaDB 10.4.32. Dokumentasi MySQL digunakan untuk rujukan sintaks SQL standar, sedangkan dokumentasi MariaDB wajib dirujuk untuk arsitektur, konfigurasi `my.ini`, mesin penyimpanan Aria, dan penanganan galat internal.
* **Titik Analisis 2:** Menjalankan perintah `mysql -u root` tanpa argumen `-p` setelah kata sandi dikonfigurasi akan menghasilkan `ERROR 1045 (28000)`. Frasa `(using password: NO)` menandakan bahwa klien mencoba terhubung ke server tanpa mengoperkan parameter kata sandi.
* **Titik Analisis 3:** Akun `mhs_079` dapat mengakses `information_schema` karena tabel tersebut berisi metadata standar sesuai hak akses pengguna. Sebaliknya, akses ke basis data `mysql` ditolak (`ERROR 1044`) karena memuat kredensial global. Perbedaannya: **ERROR 1044** adalah kegagalan hak akses pada objek/basis data, sedangkan **ERROR 1045** adalah kegagalan autentikasi identitas/kata sandi.
* **Titik Analisis 4:** Mode `auth_type = 'cookie'` pada phpMyAdmin lebih aman karena mewajibkan pendaftaran masuk (*login*) di tiap sesi peramban baru, berbeda dengan mode `config` yang menyimpan kredensial dalam bentuk teks polos (*plain text*) di dalam berkas `config.inc.php`.


### 5. Hasil Latihan

Tangkapan layar hasil galat tersimpan pada folder `Image`.

* **Latihan E1 (Pembuatan Pengguna Tamu & Uji Hak Akses):** Pengguna `tamu_079` dibuat dengan izin akses hanya untuk membaca (`SELECT`) pada basis data `kopma_079`. Ketika mencoba membuat tabel (`CREATE TABLE`), sistem menolak aksi tersebut dengan pesan `ERROR 1142`, yang membuktikan bahwa pembatasan hak akses berhasil diterapkan.
* **Latihan E2 (Skrip Re-executable):** Skrip `p01_lingkungan_25430079.sql` diperbaiki dengan menambahkan klausa `IF NOT EXISTS` agar skrip dapat dijalankan berulang kali tanpa menghasilkan galat duplikasi.


### 6. Tugas Mandiri: Milestone Proyek 1

1. Pembuatan basis data proyek `akademik_akad`.
2. Pembuatan akun pengembang `dev_079` dengan hak penuh (*full privileges*) ke basis data proyek.
3. Penambahan identitas proyek di dalam berkas `README.md` dan pembuatan berkas `.gitignore`.


### 7. Pembahasan dan Kendala

Selama pengerjaan praktikum terdapat beberapa kendala dan galat. Namun, setelah mempelajari buku panduan dari dosen pengampu serta berkonsultasi dan diarahkan oleh AI, seluruh proses konfigurasi dan eksekusi skrip dapat diselesaikan dengan baik.


### 8. Kesimpulan

Lingkungan kerja MariaDB 10.4.32 pada XAMPP dan Git telah berhasil dikonfigurasi serta diverifikasi. Pembedaan antara akun administrator (`root`) dan akun kerja (`mhs_079`, `dev_079`) berhasil mengimplementasikan prinsip privilese minimum (*least privilege*) untuk menjaga keamanan data. Seluruh riwayat perubahan skrip dan dokumentasi proyek telah terstruktur dan diunggah ke repositori GitHub.


### 9. Pernyataan Penggunaan AI

Saya menggunakan bantuan AI untuk memahami buku panduan, mencari referensi dalam penulisan laporan, serta mengonfirmasi apakah langkah-langkah yang saya lakukan sudah sesuai dengan panduan praktikum.


### 10. Bukti Git

* **Tautan Repositori:** [https://github.com/vikaenzelia/basisdata-079](https://github.com/vikaenzelia/basisdata-079)
* **Hash Commit Pertemuan 1:** `7765927`


### Checklist Completeness

* [x] Identitas Laporan Lengkap
* [x] Tujuan Praktikum Ditulis Ulang
* [x] Ringkasan Dasar Teori Murni Pemahaman Sendiri
* [x] Tangkapan Layar / Teks Hasil Percobaan Disertakan
* [x] Seluruh Titik Analisis (1–4) Dijawab Berurutan
* [x] Latihan E1 dan E2 Diselesaikan
* [x] Milestone Proyek 1 Diselesaikan
* [x] Pembahasan dan Kendala Dicatat
* [x] Kesimpulan Tersusun
* [x] Pernyataan Penggunaan AI Disertakan
* [x] Bukti Tautan Git dan Hash Commit Valid