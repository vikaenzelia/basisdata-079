Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 7

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 26 Oktober 2026

1.Tujuan Praktikum

Memahami dan mengimplementasikan kueri pencarian data dasar menggunakan klausa SELECT, FROM, WHERE, ORDER BY, dan LIMIT pada basis data relasional. Memahami penggunaan operator pembanding, pencarian pola (LIKE), penyaringan rentang (BETWEEN), himpunan (IN), dan penanganan nilai kosong (IS NULL). Mampu memanfaat fungsi skalar string (CONCAT, UPPER), tanggal (DATE_FORMAT), numerik (ROUND, FORMAT), serta percabangan logika CASE. Mampu menganalisis urutan evaluasi logis kueri SQL dan mengidentifikasi kesalahan semantik pada logika penyaringan syarat WHERE.

2.Ringkasan Teori

Kueri SELECT satu tabel merupakan mekanisme utama untuk mengambil dan menyaring data dari basis data relasional. Secara sintaksis kueri ditulis mulai dari SELECT, namun mesin MariaDB/MySQL mengevaluasi klausa secara logis dengan urutan: FROM untuk menentukan tabel sumber data, WHERE untuk menyaring baris berdasarkan syarat kriteria, SELECT untuk memilih kolom/fungsi skalar, ORDER BY untuk mengurutkan hasil (ASC/DESC), dan LIMIT untuk membatasi jumlah baris akhir. Pemahaman urutan evaluasi ini krusial untuk mencegah galat semantik, yaitu kueri yang berhasil berjalan tanpa kesalahan sistem tetapi menghasilkan data yang keliru secara logika bisnis, seperti penggabungan syarat OR dan AND tanpa tanda kurung karena operator AND memiliki prioritas evaluasi yang lebih tinggi dibanding OR.

3.Hasil Langkah Percobaan

Eksekusi kueri pembacaan data pada basis data akad_25430079 dan kopma_25430079 berhasil dieksekusi melalui terminal MariaDB Shell XAMPP. Seluruh bukti hasil tangkapan layar eksekusi terminal berada pada folder image modul 7.

4.Jawaban Titik Analisis

Alias kolom yang dibuat pada klausa SELECT tidak dapat digunakan di dalam klausa WHERE karena klausa WHERE dievaluasi oleh mesin SQL terlebih dahulu sebelum klausa SELECT diproses, sehingga pada saat penyaringan syarat dilakukan nama alias tersebut belum dikenali oleh sistem. Perilaku WHERE kolom = NULL akan selalu menghasilkan nilai UNKNOWN atau FALSE karena NULL melambangkan ketiadaan nilai sehingga tidak dapat dibandingkan dengan operator kesamaan (=), sehingga perbandingan yang benar wajib menggunakan operator khusus IS NULL atau IS NOT NULL. Fungsi agregat seperti COUNT, SUM, atau AVG belum disarankan dicampur langsung dengan kolom non-agregat tanpa GROUP BY karena fungsi agregat meringkas banyak baris menjadi satu baris ringkasan, sedangkan kolom non-agregat menampilkan nilai per individu baris sehingga menimbulkan konflik skala data.

5.Hasil Latihan dan Modifikasi

Pada latihan E.1, dilakukan pengujian fungsi skalar UPPER dan FORMAT pada basis data Kopma (kopma_25430079) untuk menampilkan nama barang berhuruf kapital dan harga jual berformat rupiah RpX.XXX menggunakan FORMAT(harga_jual_barang, 0, 'id_ID'), serta pada basis data Akademik (akad_25430079) untuk menampilkan nama mata kuliah kapital dan bobot SKS. Pada latihan E.2, dilakukan simulasi kueri yang salah secara semantik dengan menggabungkan syarat OR dan AND tanpa tanda kurung yang menghasilkan 5 baris data (karena memanggil seluruh mahasiswa Ilmu Komputer tanpa memedulikan status), kemudian diperbaiki dengan menambahkan tanda kurung (prodi_mahasiswa = 'Ilmu Komputer' OR prodi_mahasiswa = 'Sistem Informasi') AND status_mahasiswa = 'cuti' yang secara akurat menyaring 1 baris data mahasiswa yang sedang cuti.

6.Tugas Mandiri: Milestone Proyek 07

Penyusunan berkas kueri p07_kueri_079.sql (Akademik) dan p07_kueri_kopma_079.sql (Koperasi Mahasiswa) telah diselesaikan dan teruji reproducible. Berkas kueri mencakup 10 Kebutuhan Informasi (KI-01 s.d. KI-10) yang menerapkan variasi klausa DISTINCT untuk pencarian kategori unik, LIKE untuk pencarian pola teks, BETWEEN untuk rentang tanggal transaksi, IN untuk himpunan kriteria SKS/prodi, IS NULL untuk mengecek nomor HP kosong, CONCAT dan UPPER untuk format identitas, DATE_FORMAT untuk format tanggal Indonesia, CASE untuk label status deskriptif, ROUND untuk perhitungan estimasi nilai stok barang, serta kombinasi ORDER BY dan LIMIT untuk menampilkan data urutan teratas.

7.Pembahasan dan Kendala

Praktikum Modul 7 berhasil melatih ketelitian dalam menyusun kueri penyaringan data satu tabel. Penggunaan fungsi skalar sangat efektif untuk mengubah tampilan data mentah menjadi bentuk informasi yang siap disajikan. Kendala yang dihadapi adalah sempat terjadi kesalahan galat ERROR 1054 (Unknown column 'nama_mahasiswa' in 'field list') saat uji coba kueri bagian E karena memanggil kolom mahasiswa dari tabel mata_kuliah, yang berhasil diatasi dengan menyelaraskan nama kolom dan tabel sumber data yang dipanggil.

8.Kesimpulan

Kueri SELECT satu tabel memberikan fleksibilitas tinggi dalam menampilkan dan menyaring data sesuai kebutuhan informasi sistem. Penggunaan tanda kurung pada klausa WHERE sangat penting untuk menjaga kebenaran semantik kueri saat menggabungkan logika multi-kondisi OR dan AND. Penerapan fungsi skalar string, tanggal, numerik, dan ekspresi CASE membantu menyajikan informasi basis data secara rapi, komunikatif, dan terstruktur.

9.Pernyataan Penggunaan AI

Laporan dan praktikum ini disusun dengan bantuan AI sebagai mitra diskusi logis dalam menganalisis kesalahan semantik kueri (prioritas operator AND vs OR), memverifikasi sintaks fungsi skalar MariaDB, dan merapikan penyusunan dokumen laporan. Seluruh eksekusi kueri di MariaDB Shell XAMPP, pengujian terminal, pengambilan tangkapan layar, dan penulisan laporan dilakukan secara mandiri oleh praktikan.

10.Bukti Git

Tautan Repositori: https://github.com/vikaenzelia/basisdata-079

Hash Commit Terakhir: 927e0e0

Checklist
- [x] Laporan ditulis dengan format Markdown dalam folder laporan/
- [x] Penamaan file sesuai format p07_laporan_079.md
- [x] Semua screenshot terminal telah disertakan dengan keterangan (p07_akad.png dan p07_kopma.png)
- [x] Jawaban titik analisis diisi lengkap
- [x] Hasil latihan dan modifikasi (Bagian E) disertakan
- [x] File kueri p07_kueri_079.sql dan p07_kueri_kopma_079.sql lengkap
- [x] Seluruh kueri teruji reproducible di terminal MariaDB
- [x] Seluruh perubahan telah di-commit dan di-push ke GitHub