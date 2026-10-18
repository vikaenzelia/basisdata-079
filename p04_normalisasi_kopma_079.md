# Laporan Normalisasi dan Skema Relasional - Koperasi Mahasiswa Sejahtera

---

## 1. Bentuk Unnormalisasi (UNF - Unnormalized Form)
Berdasarkan dokumen sumber fiktif **Nota Penjualan Kopma**, seluruh atribut dikumpulkan ke dalam satu tabel mentah yang masih memiliki kelompok data berulang (*repeating group* pada daftar barang yang dibeli dalam satu nota):

**KOPMA_UNF** (`no_nota`, `tanggal_jam`, `kode_kasir`, `no_anggota`, `nim_anggota`, `{ kode_barang, nama_barang, qty, harga_satuan_detail }`, `subtotal`, `diskon_anggota`, `total_bayar`, `bayar`, `kembali`)

---

## 2. Dependensi Fungsional (Functional Dependency)
Berdasarkan aturan bisnis (AB-xx) pada dokumen kebutuhan data, diturunkan ketergantungan fungsional sebagai berikut:
* **FD1:** `no_nota` $\rightarrow$ `tanggal_jam`, `kode_kasir`, `no_anggota`, `subtotal`, `diskon_anggota`, `total_bayar`, `bayar`, `kembali` (Atribut transaksi ditentukan oleh Nomor Nota)
* **FD2:** `no_anggota` $\rightarrow$ `nim_anggota`, `nama`, `prodi`, `no_hp`, `status_aktif`, `poin_loyalitas` (Atribut anggota ditentukan oleh Nomor Anggota)
* **FD3:** `kode_barang` $\rightarrow$ `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum_stok` (Atribut barang ditentukan oleh Kode Barang)
* **FD4:** (`no_nota`, `kode_barang`) $\rightarrow$ `qty`, `harga_satuan_detail` (Atribut detail penjualan ditentukan oleh kombinasi No Nota dan Kode Barang)
* **FD5:** `kode_pemasok` $\rightarrow$ `nama_pemasok`, `telepon`, `alamat` (Atribut pemasok ditentukan oleh Kode Pemasok)
* **FD6:** `no_faktur` $\rightarrow$ `tanggal`, `kode_pemasok`, `kode_barang`, `qty`, `harga_beli` (Atribut pembelian stok ditentukan oleh Nomor Faktur)

---

## 3. Tahapan Normalisasi

### A. Bentuk Normal Pertama (1NF)
* **Syarat:** Menghilangkan semua grup berulang dan memastikan setiap nilai dalam sel bersifat atomik (tunggal).
* **Hasil 1NF:** Pengulangan daftar barang pada Nota Penjualan dipisahkan ke dalam baris tersendiri dengan kunci primer komposit `(no_nota, kode_barang)`.

### B. Bentuk Normal Kedua (2NF)
* **Syarat:** Memenuhi 1NF dan tidak ada atribut bukan kunci yang bergantung secara parsial pada sebagian kunci primer komposit.
* **Hasil 2NF:** Atribut yang hanya bergantung pada sebagian kunci komposit (seperti data barang terhadap `kode_barang` atau data kepala nota terhadap `no_nota`) dipisah keluar menjadi relasi tabel tersendiri.

### C. Bentuk Normal Ketiga (3NF)
* **Syarat:** Memenuhi 2NF dan tidak ada ketergantungan transitif (atribut bukan kunci bergantung pada atribut bukan kunci lainnya).
* **Hasil 3NF Akhir:**
  1. **Anggota** (`no_anggota` [PK], `nim_anggota`, `nama`, `prodi`, `no_hp`, `status_aktif`, `poin_loyalitas`)
  2. **Barang** (`kode_barang` [PK], `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum_stok`)
  3. **Petugas** (`kode_petugas` [PK], `nama_petugas`, `peran`)
  4. **Pemasok** (`kode_pemasok` [PK], `nama_pemasok`, `alamat`)
  5. **Pemasok_Telepon** (`kode_pemasok` [PK, FK], `no_telepon` [PK])
  6. **Penjualan** (`no_nota` [PK], `tanggal_jam`, `kode_kasir` [FK], `no_anggota` [FK], `total_bayar`)
  7. **Detail_Penjualan** (`no_nota` [PK, FK], `kode_barang` [PK, FK], `qty`, `harga_satuan_detail`)
  8. **Pembelian** (`no_faktur` [PK], `tanggal`, `kode_pemasok` [FK], `kode_barang` [FK], `qty`, `harga_beli`)

---

## 4. Pemeriksaan Bentuk Normal Boyce-Codd (BCNF)
* Setiap tabel di atas diperiksa apakah setiap penentu (*determinant*) merupakan *candidate key*.
* Seluruh tabel di atas telah memenuhi BCNF karena setiap sisi kiri dari ketergantungan fungsional yang ada merupakan kunci kandidat yang sah.

---

## 5. Keputusan Nilai Turunan
* **Subtotal, Diskon Anggota, Total Bayar, dan Kembalian:** Diputuskan untuk **tidak disimpan** secara permanen sebagai kolom fisik di tabel basis data operasional utama (kecuali total akhir untuk rekam jejak nota jika diperlukan). Nilai-nilai ini dihitung secara dinamis (*dynamic calculation/derived*) menggunakan fungsi aritmatika SQL saat transaksi berlangsung atau laporan dicetak (sesuai AB-04).

---

## 6. Latihan dan Modifikasi

### A. Normalisasi Pemasok dengan Beberapa Nomor Telepon
* **Masalah:** Atribut `telepon` pada tabel `Pemasok` bersifat *multivalued* (satu pemasok memiliki lebih dari satu nomor telepon), yang melanggar aturan **1NF** (persyaratan atomisitas nilai).
* **Solusi Normalisasi:** Atribut `telepon` dipisahkan menjadi tabel terpisah bernama `Pemasok_Telepon` yang terhubung kembali ke tabel utama `Pemasok` melalui `kode_pemasok` sebagai *Foreign Key* (FK).
* **Skema Relasi Baru:**
  1. **`Pemasok`** (`kode_pemasok` [PK], `nama_pemasok`, `alamat`)
  2. **`Pemasok_Telepon`** (`kode_pemasok` [PK, FK], `no_telepon` [PK])

### B. Contoh Pelanggaran 3NF dan Anomali Ubah (Update Anomaly)
- **Masalah Pelanggaran 3NF:** 
  Jika `nama_anggota` disimpan langsung di dalam tabel `Penjualan`, terjadi **ketergantungan transitif** (*transitive dependency*):
  `no_nota` $\rightarrow$ `no_anggota` $\rightarrow$ `nama_anggota`
  `nama_anggota` bergantung pada `no_anggota` (bukan kunci utama `no_nota`), sehingga melanggar syarat 3NF.

- **Contoh Data yang Melanggar 3NF:**
  | no_nota | tanggal_jam | no_anggota | nama_anggota | total_bayar |
  | :--- | :--- | :--- | :--- | :--- |
  | PJ-2609-0142 | 2026-09-10 08:30 | A-0457 | Vika Desty Enzelia | 25000 |
  | PJ-2609-0155 | 2026-09-12 10:15 | A-0457 | Vika Desty Enzelia | 18000 |
  | PJ-2609-0189 | 2026-09-15 14:00 | A-0457 | Vika Desty Enzelia | 42000 |

- **Anomali Ubah (*Update Anomaly*):**
  Jika anggota dengan `no_anggota = 'A-0457'` merubah penulisan nama profilnya di sistem, kueri harus memperbarui banyak baris transaksi lama secara berulang. Jika ada satu baris yang terlewat, data nama anggota menjadi tidak konsisten (*inconsistent data*).

- **Kueri Ubah (UPDATE) yang Memperlihatkan Anomali:**
  ```sql
  -- Kueri ini berisiko menyebabkan inkonsistensi jika ada transaksi yang terlewat
  UPDATE Penjualan 
  SET nama_anggota = 'Vika Desty Enzelia' 
  WHERE no_anggota = 'A-0457';