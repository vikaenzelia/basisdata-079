Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 5

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 21 Oktober 2026

1.Tujuan Praktikum
Memahami dan mengimplementasikan perintah Data Definition Language (DDL) lanjutan serta modifikasi struktur tabel dalam basis data relasional. Mampu menerapkan Constraint khusus seperti CHECK untuk memvalidasi batasan nilai data (seperti stok minimum tidak boleh negatif). Mampu mengatur ulang perilaku Foreign Key menggunakan opsi ON DELETE SET NULL untuk menjaga integritas referensial data. Menerapkan konsep manajemen basis data yang selaras dengan prinsip pelindungan data pribadi (UU PDP) dan standar akuntansi koperasi (AB-02) pada proyek Koperasi Mahasiswa (Kopma) Sejahtera.

2.Ringkasan Teori
Modifikasi struktur tabel menggunakan perintah ALTER TABLE memungkinkan pengembang untuk menambah, mengubah, atau menghapus kolom serta batasan (constraint) pada tabel yang sudah ada. Constraint CHECK digunakan untuk memastikan nilai yang dimasukkan ke dalam suatu kolom memenuhi kondisi logika tertentu (misalnya nilai harus >= 0). Selain itu, dalam relasi antar tabel, pengaturan Referential Integrity melalui klausul referensial seperti ON DELETE SET NULL memastikan bahwa ketika data di tabel utama (induk) dihapus, kolom Foreign Key pada tabel anak otomatis diset menjadi NULL, sehingga mencegah kegagalan integritas data sekaligus menjaga anonimitas data historis transaksi.

3.Tangkapan layar hasil langkah percobaan berada pada folder Image modul_5 (p05_1.png, P05_2.png, P05_3.png, P05_4.png).

4.Titik Analisis
Penerapan constraint CHECK pada kolom numerik sangat krusial untuk mencegah masuknya data invalid secara logis (seperti nilai stok atau harga negatif) yang dapat merusak integritas sistem inventaris. Sementara itu, pemilihan aksi referensial seperti ON DELETE SET NULL pada hubungan antara tabel penjualan dan anggota berdampak langsung terhadap bagaimana sistem memperlakukan data historis ketika profil referensi utamanya dihapus dari sistem basis data.

5.Hasil Latihan Modifikasi Tabel barang: Berhasil menambahkan pembatasan nilai melalui perintah ALTER TABLE barang ADD CONSTRAINT chk_stok_min_barang CHECK (stok_min_barang >= 0);. Pengujian dengan menyisipkan nilai -5 pada kolom stok_min_barang terbukti memicu penolakan otomatis dari sistem MariaDB berupa galat error #4025 (p05_1.png). Modifikasi Tabel penjualan: Berhasil mengubah perilaku relasi Foreign Key (id_anggota) dengan perintah ALTER TABLE penjualan DROP FOREIGN KEY fk_penjualan_anggota; (P05_2.png) dilanjutkan dengan ALTER TABLE penjualan ADD CONSTRAINT fk_penjualan_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota) ON DELETE SET NULL; (P05_3.png).

6.Tugas Mandiri Milestone Proyek Kopma Sejahtera
Implementasi DDL Lanjutan & Constraint: Penerapan aturan integritas lanjutan pada skema basis data kopma_079 untuk memastikan validasi domain atribut inventaris barang (stok_min_barang) serta penanganan penghapusan data entitas berelasi (penjualan terhadap anggota) (P05_4.png).
Analisis Kepatuhan Regulasi (UU PDP & AB-02):

7.Kesesuaian dengan UU PDP (Pelindungan Data Pribadi)
Pengaturan ON DELETE SET NULL selaras dengan prinsip pelindungan data pribadi. Saat data anggota dihapus atau ditarik dari sistem, identitas personal pada tabel transaksi diubah menjadi NULL, sehingga data pribadi tidak terekspos secara permanen.

8.Kesesuaian dengan AB-02 (Standar Akuntansi Koperasi)
Dari sudut pandang akuntansi dan audit keuangan koperasi (AB-02), penghilangan referensi ID anggota menjadi NULL memiliki kelemahan karena menyulitkan penelusuran rekam jejak audit transaksi anggota serta perhitungan alokasi Sisa Hasil Usaha (SHU) secara akurat.

9.Pembahasan dan Kendala
Seluruh rangkaian praktikum modifikasi DDL, penerapan CHECK constraint, serta pembaruan aturan Foreign Key (ON DELETE SET NULL) pada database kopma_079 berjalan lancar tanpa kendala berarti. Penyesuaian tipe kolom dan struktur tabel dilakukan secara bertahap melalui antarmuka phpMyAdmin dan divalidasi melalui konsol SQL. Kendala kecil terkait ketidaksesuaian nama kolom pendukung berhasil diatasi dengan memeriksa struktur tabel secara teliti sebelum mengeksekusi kueri pengujian.

10.Kesimpulan
Modul praktikum Pertemuan 05 telah diselesaikan dengan sukses. Skema basis data kopma_079 kini memiliki pengamanan integritas data yang lebih ketat melalui penerapan CHECK constraint pada tabel barang dan konfigurasi Cascading/Set Null Actions (ON DELETE SET NULL) pada tabel penjualan, sehingga sistem siap mendukung operasional basis data yang valid dan konsisten.

11.Pernyataan Penggunaan AI
Saya menggunakan bantuan AI untuk membantu dalam penyusunan struktur laporan baku, merumuskan analisis teks terkait kepatuhan regulasi UU PDP dan standar akuntansi AB-02, serta memastikan konsistensi format penulisan laporan praktikum.

12.Bukti Git
Tautan Repositori: https://github.com/vikaenzelia/basisdata-079
Hash Commit Pertemuan 5: (isi hash commit Git Anda)

Checklist

[x] Laporan disusun sesuai struktur baku.

[x] Memuat identitas Nama, NPM, Kelas, dan Tanggal.

[x] Memuat Ringkasan Dasar Teori.

[x] Memuat Hasil Langkah Percobaan (gambar + keterangan).

[x] Memuat Jawaban Titik Analisis.

[x] Memuat Hasil Latihan dan Modifikasi.

[x] Memuat Tugas Mandiri Milestone Proyek.

[x] Memuat Pembahasan dan Kendala.

[x] Memuat Kesimpulan.

[x] Memuat Pernyataan Penggunaan AI.

[x] Memuat Bukti Git (tautan repositori & hash commit).