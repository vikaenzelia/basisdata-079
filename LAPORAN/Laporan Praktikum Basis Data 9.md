Laporan Praktikum Basis Data

Nama: Vika Desty Enzelia

NPM: 25430079

Kelas: C

Pertemuan: 9

Dosen Pengampu: Dedi Irawan, S.Kom., M.T.I.

Tanggal: 21 November 2026

1.Tujuan Praktikum

Memahami dan mengimplementasikan fungsi agregat SQL (`COUNT`, `COUNT(DISTINCT)`, `SUM`, `AVG`, `MIN`, `MAX`), pengelompokan data menggunakan `GROUP BY`, penyaringan kelompok menggunakan `HAVING`, serta pembuatan baris subtotal dan grand total menggunakan `WITH ROLLUP` pada basis data `kopma_25430079` dan proyek mandiri `akad_25430079`. Memastikan aturan pengelompokan berjalan ketat dengan mengaktifkan `ONLY_FULL_GROUP_BY` pada `sql_mode` MariaDB serta menyusun laporan ringkasan yang selaras dengan kebutuhan informasi (KI).

2.Ringkasan Teori

Fungsi agregat pada SQL digunakan untuk meringkas sekumpulan baris data menjadi satu nilai ringkasan, seperti menghitung jumlah baris (`COUNT`), menghitung nilai unik (`COUNT(DISTINCT)`), menjumlahkan nilai (`SUM`), menghitung rata-rata (`AVG`), serta mencari nilai terkecil dan terbesar (`MIN` dan `MAX`). Klausa `GROUP BY` mengelompokkan baris berdasarkan kolom atau ekspresi tertentu sebelum fungsi agregat diterapkan pada tiap kelompok.

Ketika `ONLY_FULL_GROUP_BY` diaktifkan pada `sql_mode` MariaDB, setiap kolom non-agregat pada klausa `SELECT` wajib muncul pada `GROUP BY` atau memiliki ketergantungan fungsional penuh terhadap kolom pengelompokan agar hasil tidak ambigu (`ERROR 1055`). Klausa `WHERE` menyaring baris sebelum proses `GROUP BY` dan agregasi, sedangkan `HAVING` menyaring kelompok setelah proses agregasi berlangsung. Modifier `WITH ROLLUP` pada `GROUP BY` menambahkan baris ringkasan subtotal dan total keseluruhan yang ditandai dengan nilai `NULL` pada kolom grup.

3.Hasil Langkah Percobaan

Seluruh pengujian kueri agregasi pada basis data `kopma_25430079` telah dijalankan melalui terminal MariaDB Shell XAMPP (`p09_agregasi_kopma_079.sql`), dan bukti tangkapan layarnya disimpan pada folder `laporan/img/` (`p09_1.png` hingga `p09_4.png`). Ringkasan awal pada tabel `penjualan` menunjukkan terdapat 8 nota dengan rentang waktu transaksi mulai `2026-09-24 10:15:00` sampai `2026-10-18 15:30:00`.

Pada rekap per `kategori_barang` (`p09_1.png`), kategori `ATK` mencatatkan 17 unit terjual dengan omzet `87000.00`, kategori `minuman` 7 unit dengan omzet `28000.00`, dan kategori `makanan` 5 unit dengan omzet `25000.00`. Pada pengujian omzet harian dengan `WITH ROLLUP` (`p09_1.png` dan `p09_2.png`), rentang tanggal `'2026-09-01'` sampai `'2026-09-08'` menghasilkan `Empty set` karena transaksi pada data `kopma_25430079` baru dimulai pada `2026-09-24`, sedangkan rentang `2026-09-24` sampai `2026-09-28` menghasilkan 5 nota dengan total omzet `80000.00` pada baris `NULL`, dan seluruh data transaksi menghasilkan 8 nota dengan total omzet `140000.00` pada baris `NULL`. Pada rekap bulanan dengan `WITH ROLLUP` (`p09_2.png`), periode `2026-09` menghasilkan 5 nota (`80000.00`), periode `2026-10` menghasilkan 3 nota (`60000.00`), dan baris ringkasan `NULL` menghasilkan 8 nota dengan total omzet `140000.00`.

Pada pengujian `HAVING` (`p09_2.png` dan `p09_3.png`), kueri kasir dengan `HAVING COUNT(*) > 20` menampilkan `Empty set` karena total nota pada data uji berjumlah 8 nota, sedangkan kueri barang dengan `HAVING SUM(d.qty_detail_penjualan) < 10` menampilkan 3 barang yaitu `ATK-002` (`Buku Tulis 58`, total qty 7), `MNM-001` (`Air Mineral 600`, total qty 7), dan `MKN-001` (`Roti Cokelat`, total qty 5). Kaitan laporan terhadap kode KI meliputi KI-01 untuk rekap omzet harian dan bulanan (`WITH ROLLUP`), KI-02/KI-03 untuk rekap unit dan omzet per kategori barang, serta KI-04 untuk penyaringan kelompok hasil agregasi dengan `HAVING`.

4.Jawaban Titik Analisis

Pada Titik Analisis 1, pengaktifan `ONLY_FULL_GROUP_BY` pada `sql_mode` menyebabkan MariaDB menolak kueri yang memilih kolom non-agregat di luar `GROUP BY` (dan tidak bergantung secara fungsional pada kunci grup) dengan memunculkan `ERROR 1055`, sehingga mencegah pengambilan nilai acak dari baris yang tidak terkelompokkan. Pada Titik Analisis 2 (`p09_2.png`), pengujian data bulan September menghasilkan `COUNT(DISTINCT p.id_penjualan)` sebanyak 5 (nota unik) dan `COUNT(*)` sebanyak 9 (baris hasil `JOIN` antara `penjualan` dan `detail_penjualan`). Selisih 4 baris tersebut terjadi karena relasi satu nota–banyak detail (`1:N`), di mana satu nota dapat memiliki lebih dari satu baris detail barang, sehingga `COUNT(DISTINCT p.id_penjualan)` diperlukan agar jumlah nota tidak terhitung ganda.

Pada Titik Analisis 3 (`p09_3.png`), syarat **"anggota saja"** (`WHERE p.id_anggota IS NOT NULL`) diletakkan pada klausa `WHERE`, bukan `HAVING`. Berdasarkan urutan evaluasi logis SQL (`FROM`/`JOIN` -> `WHERE` -> `GROUP BY` -> fungsi agregat -> `HAVING` -> `SELECT` -> `ORDER BY`), `WHERE` menyaring baris transaksi terlebih dahulu sebelum pengelompokan dan perhitungan agregasi dijalankan. Hasil pengujian khusus anggota menunjukkan terdapat 6 nota dengan total belanja `120000.00` dan rata-rata belanja per nota sebesar `20000.000000`. Sementara itu, nilai `NULL` yang muncul pada baris ringkasan `WITH ROLLUP` (termasuk pada rekap kategori per bulan) menandakan baris subtotal atau grand total untuk tingkatan pengelompokan di atasnya, bukan data yang kosong.

5.Hasil Latihan dan Modifikasi

Pada latihan E.1 (`p09_4.png`), kueri perhitungan total nota dengan potongan diskon 5% untuk anggota berstatus `'aktif'` yang dibandingkan dengan `bayar_penjualan` serta disaring dengan `HAVING kembalian > 4000` menghasilkan 3 baris nota, yaitu `PJ-2609-0142` (`subtotal` `25000.00`, `total_setelah_diskon` `23750.00`, `bayar_penjualan` `30000.00`, `kembalian` `6250.00`), `PJ-2609-0144` (`subtotal` `18000.00`, `total_setelah_diskon` `17100.00`, `bayar_penjualan` `25000.00`, `kembalian` `7900.00`), dan `PJ-2610-0001` (`subtotal` `24500.00`, `total_setelah_diskon` `23275.00`, `bayar_penjualan` `30000.00`, `kembalian` `6725.00`). Pada latihan E.2, kueri rekap omzet per kategori barang per bulan dengan `WITH ROLLUP` disusun untuk menampilkan rincian per bulan dan kategori, subtotal per bulan (`kategori_barang` bernilai `NULL`), serta grand total seluruh periode (`bulan` dan `kategori_barang` bernilai `NULL`).

6.Tugas Mandiri: Milestone Proyek 09

Lima laporan agregasi pada basis data proyek mandiri `akad_25430079` telah disusun ke dalam berkas `p09_agregasi_079.sql`. Kelima laporan tersebut mencakup rekap jumlah entri detail KRS, nilai bernilai, rata-rata, serta nilai minimum dan maksimum per `status_krs`; rekap jumlah KRS, total SKS diambil, dan rata-rata SKS per `prodi_mahasiswa`; penyaringan kelas dengan minimal 2 peserta menggunakan `HAVING COUNT(d.id_krs) >= 2`; rekap jumlah pengambilan dan rata-rata nilai per `hari_kelas` menggunakan `WITH ROLLUP`; serta rekap jumlah mata kuliah, total SKS, dan rata-rata nilai per mahasiswa.

7.Pembahasan dan Kendala

Pada pengujian awal rentang tanggal mingguan di `kopma_25430079` (`'2026-09-01'` sampai `'2026-09-08'`), kueri menampilkan `Empty set` karena tanggal transaksi pada data uji dimulai sejak `2026-09-24`. Setelah penyesuaian rentang tanggal menjadi `'2026-09-24'` sampai `'2026-09-29'` serta pengujian tanpa batas tanggal, baris hasil dan baris total `WITH ROLLUP` tampil sesuai harapan. Selain itu, komentar hasil yang diharapkan pada skrip `p09_agregasi_kopma_079.sql` disesuaikan dengan jumlah data aktual milik praktikan (8 nota) agar konsisten dengan hasil eksekusi di MariaDB.

8.Kesimpulan

Fungsi agregat SQL, `GROUP BY`, `WITH ROLLUP`, dan `HAVING` efektif digunakan untuk menyusun laporan ringkasan transaksi pada `kopma_25430079` maupun laporan akademik pada `akad_25430079`. Pemahaman terhadap `ONLY_FULL_GROUP_BY`, perbedaan `COUNT(DISTINCT)` dengan `COUNT(*)`, urutan evaluasi `WHERE` dan `HAVING`, serta makna baris `NULL` pada `WITH ROLLUP` membantu memastikan hasil rekap data akurat dan sesuai kebutuhan informasi.

9.Pernyataan Penggunaan AI

Laporan dan praktikum ini disusun dengan bantuan AI sebagai mitra diskusi dalam merapikan struktur kueri SQL, mencocokkan analisis hasil agregasi dengan keluaran terminal, serta menyesuaikan format laporan. Seluruh eksekusi perintah di MariaDB Shell XAMPP, pengambilan tangkapan layar, dan penulisan laporan dilakukan secara mandiri oleh praktikan.

10.Bukti Git

Tautan Repositori: https://github.com/vikaenzelia/basisdata-079

git push: 4be5948

Checklist
- [x] Laporan ditulis dengan format Markdown dalam folder laporan
- [x] Semua screenshot terminal telah disertakan dengan keterangan
- [x] Jawaban titik analisis diisi lengkap
- [x] Hasil latihan dan modifikasi (Bagian E) disertakan
- [x] File skrip p09_agregasi_kopma_079.sql dan p09_agregasi_079.sql lengkap
- [x] Kueri agregasi, GROUP BY, WITH ROLLUP, dan HAVING teruji dengan ONLY_FULL_GROUP_BY aktif
- [x] Seluruh perubahan telah di-commit dan di-push ke GitHub
