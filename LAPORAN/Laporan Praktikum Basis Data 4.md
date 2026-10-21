Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 4

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 18 Oktober 2026

1. Tujuan Praktikum

Memahami konsep dasar normalisasi basis data mulai dari bentuk unnormalized (UNF), 1NF, 2NF, 3NF, hingga BCNF. Mampu menganalisis ketergantungan fungsional (Functional Dependency) pada suatu himpunan atribut. Mampu mengidentifikasi dan menangani atribut bernilai banyak (multivalued attribute) serta menganalisis anomali pembaruan (update anomaly). Menyusun skema relasional yang optimal dan ternormalisasi untuk proyek basis data Koperasi Mahasiswa (Kopma) Sejahtera.

2. Ringkasan Teori

 Normalisasi merupakan proses sistematis untuk mengorganisasi data dalam basis data guna mengurangi redundansi data dan mencegah terjadinya anomali (Insert, Update, Delete). Unnormalized Form (UNF) adalah bentuk tabel mentah yang mengandung kelompok data berulang (repeating groups). 1NF (First Normal Form) mensyaratkan setiap sel dalam tabel bernilai atomik (tunggal) dan tidak ada kelompok data berulang. 2NF (Second Normal Form) memenuhi 1NF dan setiap atribut bukan kunci harus bergantung penuh pada kunci primer (no partial dependency). 3NF (Third Normal Form) memenuhi 2NF dan tidak ada ketergantungan transitif (no transitive dependency). BCNF (Boyce-Codd Normal Form) adalah bentuk normal yang lebih ketat dari 3NF di mana setiap penentu (determinant) harus merupakan kunci kandidat (candidate key).

3. Tangkapan layar hasil langkah percobaan berada pada folder Image modul_4. 

4. Titik Analisis 

Atribut seperti nomor telepon pemasok yang berjumlah lebih dari satu tidak dapat disimpan dalam satu sel tabel tunggal karena melanggar syarat atomisitas 1NF. Penyimpanan nama anggota secara langsung pada tabel transaksi Penjualan menyebabkan ketergantungan transitif (no_nota -> no_anggota -> nama_anggota). Hal ini memicu terjadinya update anomaly apabila terjadi perubahan data nama anggota di kemudian hari.

5. Hasil Latihan 

Atribut telepon pada tabel Pemasok bersifat multivalued sehingga dipisahkan menjadi tabel terpisah bernama Pemasok_Telepon yang terhubung kembali ke tabel utama Pemasok melalui kode_pemasok sebagai Foreign Key. Skema relasi baru: Pemasok (kode_pemasok [PK], nama_pemasok, alamat) dan Pemasok_Telepon (kode_pemasok [PK, FK], no_telepon [PK]). Terjadi pelanggaran 3NF akibat ketergantungan transitif no_nota -> no_anggota -> nama_anggota. Jika nama anggota diubah, kueri harus memperbarui banyak baris transaksi secara berulang. Kueri UPDATE Penjualan SET nama_anggota = 'Vika Desty Enzelia' WHERE no_anggota = 'A-0457'; memperlihatkan potensi data tidak konsisten jika ada baris yang terlewat.

6. Tugas Mandiri Milestone Proyek Kopma Sejahtera

Bentuk Unnormalisasi (UNF): KOPMA_UNF (no_nota, tanggal_jam, kode_kasir, no_anggota, nim_anggota, { kode_barang, nama_barang, qty, harga_satuan_detail }, subtotal, diskon_anggota, total_bayar, bayar, kembali).

Dependensi Fungsional (FD):
FD1: no_nota -> tanggal_jam, kode_kasir, no_anggota, subtotal, diskon_anggota, total_bayar, bayar, kembali
FD2: no_anggota -> nim_anggota, nama, prodi, no_hp, status_aktif, poin_loyalitas
FD3: kode_barang -> nama_barang, kategori, harga_jual, stok, batas_minimum_stok
FD4: (no_nota, kode_barang) -> qty, harga_satuan_detail
FD5: kode_pemasok -> nama_pemasok, telepon, alamat
FD6: no_faktur -> tanggal, kode_pemasok, kode_barang, qty, harga_beli

Hasil 3NF Akhir:
1. Anggota (no_anggota [PK], nim_anggota, nama, prodi, no_hp, status_aktif, poin_loyalitas)
2. Barang (kode_barang [PK], nama_barang, kategori, harga_jual, stok, batas_minimum_stok)
3. Petugas (kode_petugas [PK], nama_petugas, peran)
4. Pemasok (kode_pemasok [PK], nama_pemasok, alamat)
5. Pemasok_Telepon (kode_pemasok [PK, FK], no_telepon [PK])
6. Penjualan (no_nota [PK], tanggal_jam, kode_kasir [FK], no_anggota [FK], total_bayar)
7. Detail_Penjualan (no_nota [PK, FK], kode_barang [PK, FK], qty, harga_satuan_detail)
8. Pembelian (no_faktur [PK], tanggal, kode_pemasok [FK], kode_barang [FK], qty, harga_beli)

BCNF dan Nilai Turunan: Seluruh tabel telah memenuhi BCNF karena setiap penentu merupakan kunci kandidat. Atribut subtotal, diskon_anggota, total_bayar, dan kembalian dihitung secara dinamis dan tidak disimpan permanen di tabel operasional sesuai aturan bisnis AB-04.

7. Pembahasan dan Kendala 

Proses normalisasi pada proyek Kopma Sejahtera berhasil memecah tabel mentah UNF menjadi 8 tabel relasional yang saling terhubung dengan Primary Key dan Foreign Key tanpa redundansi data. Penulisan naskah laporan menggunakan aplikasi Notepad sehingga memerlukan pengecekan format Markdown secara manual agar tampil dengan baik saat diunggah ke repositori.

8. Kesimpulan 

Melalui praktikum ini, skema basis data Koperasi Mahasiswa Sejahtera telah berhasil dinormalisasi hingga bentuk 3NF dan BCNF. Atribut bernilai banyak (multivalued) telah ditangani dengan benar, serta nilai kalkulasi turunan telah dipisahkan agar tidak menyimpan data redundan.

9. Pernyataan Penggunaan AI 

Saya menggunakan bantuan AI untuk membantu dalam penyusunan struktur laporan baku, analisis anomali 3NF, penyesuaian format Markdown, serta pemeriksaan konsistensi skema relasional Kopma Sejahtera.

10. Bukti Git

Tautan Repositori: https://github.com/vikaenzelia/basisdata-079
Hash Commit Pertemuan 4: 1c661ca

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