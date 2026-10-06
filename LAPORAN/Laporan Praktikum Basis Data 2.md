Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia
NPM: 25430079
Kelas: C
Pertemuan: 2
Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.
Tanggal: 3 Oktober 2026

1. Tujuan Praktikum
Setelah menyelesaikan modul ini, saya mampu:
a. Mengidentifikasi aktivitas organisasi, aktor, dan proses bisnis dari narasi, wawancara, dan dokumen sumber.
b. Menurunkan elemen data, entitas kandidat, dan aturan bisnis dari dokumen sumber.
c. Menyusun matriks proses–data (CRUD) dan kamus data awal yang mencantumkan penanggung jawab data (data steward).
d. Menulis pernyataan kebutuhan data dan kebutuhan informasi yang spesifik dan dapat diuji.

2. Ringkasan Dasar Teori
Perancangan basis data dimulai dari analisis kebutuhan sebelum melangkah ke desain konseptual, logis, dan fisik. Kesalahan pada tahap analisis merupakan kesalahan paling mahal karena dapat menghilangkan histori data berharga (seperti histori harga jual transaksi atau rekam rekapitulasi nilai KRS/KHS) apabila baru disadari di kemudian hari.
Data diperlakukan sebagai aset organisasi yang memiliki penanggung jawab (data steward), aturan bisnis yang mengikat, dan standar mutu/kualitas yang harus dijaga. Kebutuhan dikelompokkan menjadi kebutuhan data, kebutuhan informasi, aturan bisnis, serta kebutuhan non-fungsional. Pemetaan antara proses bisnis dan kelompok data diuji menggunakan Matriks CRUD (Create, Read, Update, Delete) serta didokumentasikan ke dalam Kamus Data Awal.

3. Hasil Langkah Percobaan (Kasus Studi Kopma - p02_kebutuhan_data_kopma_079.md)
A. Identifikasi Aktor dan Proses Bisnis (Kopma)
PB-01 (Mendaftarkan Anggota): Kasir mendaftarkan anggota atas permintaan mahasiswa.
PB-02 (Mencatat Penjualan): Kasir mencatat transaksi saat pembeli membayar.
PB-03 (Memesan Barang ke Pemasok): Petugas gudang membuat pesanan saat stok berada di bawah batas minimum.
PB-04 (Menerima Barang dari Pemasok): Petugas gudang menerima barang dari pemasok beserta faktur.
PB-05 (Menyusun Laporan Bulanan): Ketua koperasi menyusun rekapitulasi laporan pada awal bulan.
PB-06 (Mengelola Data Pemasok): Petugas gudang/Ketua mendaftarkan atau memperbarui data pemasok baru.

B. Entitas Kandidat dan Aturan Bisnis (Kopma)
Entitas Kandidat: Anggota, Barang, Penjualan, Detail Penjualan, Petugas, Pemasok, Pembelian.
Aturan Bisnis Utama (Disesuaikan dengan Parameter $P=8$):
AB-01: Setiap nota memiliki nomor unik dan minimal berisi satu baris barang, dengan batas maksimal 10 item per transaksi.
AB-02: Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 8%.
AB-03: Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok yang tersedia.
AB-04: Harga jual yang dipakai pada nota disimpan per baris detail transaksi dan tidak berubah meskipun harga barang induk naik.
AB-05: NIM anggota bersifat unik; pencarian anggota dapat dilakukan melalui nomor anggota atau NIM.
AB-06: Pesanan pembelian dibuat otomatis/manual bila stok barang kurang dari batas minimum.
AB-07: Setiap kelipatan Rp10.000 belanja anggota bernilai 1 poin; 50 poin dapat ditukar potongan Rp5.000.
AB-08: Pendaftaran pemasok baru harus dicatat sebelum transaksi pembelian dari pemasok tersebut dapat dilakukan.

C. Kebutuhan Informasi (Kopma)
KI-01: Omzet dan jumlah nota per hari dan per bulan.
KI-02: Lima barang terlaris per bulan berdasarkan total qty terjual.
KI-03: Daftar barang dengan stok di bawah batas minimum.
KI-04: Sepuluh anggota dengan total belanja terbesar per bulan.
KI-05: Laporan rekapitulasi poin loyalitas anggota aktif.

D. Matriks CRUD (Kopma)
| Proses | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** Mendaftarkan anggota | C | | | | | |
| **PB-02** Mencatat penjualan | R | R, U | C | C | | |
| **PB-03** Memesan barang ke pemasok | | R | | | R | C |
| **PB-04** Menerima barang dari pemasok | | U | | | R | U |
| **PB-05** Menyusun laporan bulanan | R | R | R | R | | R |
| **PB-06** Mengelola data pemasok | | | | | C, U | |

 4. Jawaban Titik Analisis
Titik Analisis 1
Soal: Harga barang sudah tersimpan di data master barang. Mengapa nota (detail penjualan) tetap perlu menyimpan harga saat transaksi? Hubungkan jawaban Anda dengan keluhan ketua koperasi dalam kutipan wawancara.
Jawaban: Harga barang master bersifat dinamis dan dapat naik/turun sewaktu-waktu sesuai kebijakan. Jika detail transaksi penjualan tidak menyimpan harga_satuan_detail, maka perhitungan total nilai transaksi nota lama di masa lalu akan berubah ikut membengkak mengikuti harga master barang yang baru naik. Hal ini menyebabkan keluhan ketua koperasi yang bingung saat memeriksa nota lama. Dengan menyimpan harga pada saat transaksi di tabel detail penjualan (AB-04), histori nilai transaksi keuangan di masa lalu tetap akurat, konsisten, dan terisolasi dari perubahan harga master di masa depan.

Titik Analisis 2
Soal: Subtotal dan total adalah nilai turunan. Sebutkan satu alasan untuk tidak menyimpannya dan satu alasan yang mungkin membuat total tetap disimpan.
Jawaban: Alasan tidak menyimpan (Redundansi & Integritas Data): Mengikuti prinsip normalisasi basis data untuk menghindari redundansi data dan risiko inkonsistensi. Nilai subtotal (qty harga_satuan_detail) dan total (penjumlahan subtotal dikurangi diskon) selalu dapat dihitung secara real-time melalui kueri SQL (SUM, perhitungan aritmatika).
Alasan tetap menyimpan (Performa & Audit Trail): Untuk optimasi performa kueri analitis/pelaporan pada tabel berskala jutaan baris agar server DBMS tidak perlu melakukan re-kalkulasi agregasi secara berulang-ulang, serta memberikan jaminan tingkat imutabilitas audit trail keuangan pada nota yang diterbitkan.

Titik Analisis 3
Soal: Hitung parameter $P$ berdasarkan NIM Anda ($P = (NIM \bmod 3) + 1$). 
Tunjukkan langkah perhitungannya dan sebutkan nilai $P$.
Jawaban:  
NIM: 25430079
Perhitungan:  
$$25430079 \bmod 3 = 1$$  
$$P = 1 + 1 = 2$$  
Nilai Parameter $P$ Titik Analisis: 2

5. Hasil Latihan dan Modifikasi
Perbaikan 3 Pernyataan Kebutuhan Kabur
1.Pernyataan Kabur 1: Sistem harus dapat mengelola data anggota dengan baik. Pernyataan Spesifik & Dapat Diuji: Sistem harus mencatat pendaftaran anggota baru dengan menyimpan nomor anggota unik (format A-XXXX), NIM unik (10 digit), nama lengkap, program studi, dan nomor HP. Sistem dapat memperbarui data profil anggota serta mengubah status keanggotaan (aktif/non-aktif).
2.Pernyataan Kabur 2: Stok barang harus selalu akurat dan tidak boleh bermasalah. Pernyataan Spesifik & Dapat Diuji: Sistem harus menolak transaksi penjualan apabila kuantitas (qty) barang yang dibeli melebihi jumlah stok barang yang tersedia (stok_barang). Setiap transaksi penjualan yang berhasil akan mengurangi `stok_barang` secara otomatis, dan transaksi penerimaan barang dari pemasok akan menambah stok_barang.
3.Pernyataan Kabur 3: "Sistem harus menyediakan laporan yang berguna untuk pimpinan. Pernyataan Spesifik & Dapat Diuji: Sistem harus dapat menghasilkan laporan omzet harian/bulanan (KI-01), daftar 5 barang terlaris per bulan berdasarkan kuantitas penjualan (KI-02), daftar barang yang stoknya kurang dari atau sama dengan batas minimum stok (KI-03), daftar 10 anggota dengan total nominal transaksi belanja terbesar per bulan (KI-04), serta laporan rekapitulasi poin loyalitas anggota aktif (KI-05).

6. Tugas Mandiri: Milestone Proyek 2 (Sistem Informasi Akademik - p02_kebutuhan_data_079.md)
Tema Proyek: Sistem Informasi Akademik  
Kode Tema: akademik_akad
Nama Organisasi Fiktif: Sistem Informasi Akademik
Parameter Modulo $P$ Proyek: $(79 \bmod 9) + 1 = \mathbf{8}$
Dokumen kebutuhan data lengkap untuk proyek mandiri ini disimpan dalam berkas p02_kebutuhan_data_079.md di repositori GitHub.

7. Pembahasan dan Kendala
Pada praktikum Modul 2 ini, kegiatan berfokus pada analisis kebutuhan data baik pada kasus studi acuan (Kopma) maupun kasus tugas mandiri (Sistem Informasi Akademik). Tantangan utama yang dihadapi adalah memisahkan antara elemen data yang perlu disimpan secara permanen dengan nilai turunan (seperti IPK/IPS dan SKS diambil pada Akademik, atau total belanja pada Kopma), serta merumuskan aturan bisnis yang dapat diuji (testable requirements). Kendala tersebut diatasi dengan mengidentifikasi entitas master dan transaksi serta memastikan setiap batasan memiliki penanggung jawab data (data steward) yang jelas dalam Kamus Data Awal.

8. Kesimpulan
Analisis kebutuhan data merupakan fondasi terpenting dalam perancangan basis data untuk mencegah kehilangan histori data (baik transaksi keuangan maupun catatan akademis mahasiswa) di kemudian hari.
Setiap elemen data yang lahir dari proses bisnis organisasi harus memiliki batasan aturan bisnis yang spesifik dan jelas penanggung jawab pengelolaannya (data steward).
Matriks CRUD dan Kamus Data Awal berfungsi sebagai alat validasi yang memastikan seluruh entitas terhubung secara logis dengan proses bisnis sebelum melangkah ke tahap Pemodelan ERD.

9. Pernyataan Penggunaan AI
Saya menggunakan bantuan AI untuk memahami buku panduan, mencari referensi dalam penulisan laporan serta bertanya apakah Langkah yang saya lakukan sudah sesuai dengan buku panduan atau belum.

10. Bukti Git
Tautan Repositori: https://github.com/vikadesty/basisdata-25430079
Hash Commit: d1f8e3b

Checklist
[x] Identitas Laporan Lengkap
[x] Tujuan Praktikum Ditulis Ulang
[x] Ringkasan Dasar Teori Murni Pemahaman Sendiri
[x] Tangkapan Layar
[x] Titik Analisis
[x] LatihanDiselesaikan
[x] Milestone Proyek 2 Diselesaikan
[x] Pembahasan dan Kendala Dicatat
[x] Kesimpulan Tersusun
[x] Pernyataan Penggunaan AI Disertakan
[x] Bukti Tautan Git dan Hash Commit Valid
