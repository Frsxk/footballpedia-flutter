# Tugas 8 PBP: Flutter Navigation, Layouts, Forms, and Input Elements

Hello Flutter

# Checklist Tugas
### Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah produk baru dengan ketentuan sebagai berikut:

#### Memakai minimal tiga elemen input, yaitu name, price, dan description.

#### Tambahkan elemen input lain sesuai dengan model pada aplikasi Football Shop Django yang telah kamu buat (misalnya thumbnail, category, dan isFeatured).

#### Memiliki sebuah tombol Save.

#### Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:
- Setiap elemen input tidak boleh kosong.
- Setiap elemen input harus berisi data dengan tipe data atribut modelnya.

### Mengarahkan pengguna ke halaman form tambah produk baru ketika menekan tombol Tambah Produk pada halaman utama.

### Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman form tambah produk baru.

### Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:

- Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Produk.

- Ketika memilih opsi Halaman Utama, aplikasi akan mengarahkan pengguna ke halaman utama.

- Ketika memilih opsi Tambah Produk, aplikasi akan mengarahkan pengguna ke halaman form tambah produk baru.

### Menjawab beberapa pertanyaan berikut pada README.md pada root folder (silakan modifikasi README.md yang telah kamu buat sebelumnya dan tambahkan subjudul untuk setiap tugas):

#### Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

**Navigator.push()** menambahkan halaman baru ke atas stack navigasi, sehingga pengguna dapat kembali ke halaman sebelumnya dengan tombol back. Contoh penggunaannya di aplikasi Football Shop adalah ketika pengguna menekan tombol "Create Product" di halaman utama untuk membuka form tambah produk - pengguna masih bisa kembali ke halaman utama.

**Navigator.pushReplacement()** mengganti halaman saat ini dengan halaman baru, sehingga halaman sebelumnya dihapus dari stack. Ini digunakan di drawer ketika berpindah antar menu utama (Home dan Create Product) agar tidak terjadi penumpukan halaman yang sama di stack navigasi.

#### Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

**Scaffold** digunakan sebagai struktur dasar setiap halaman, menyediakan kerangka material design dengan AppBar di atas, Drawer di samping, dan body di tengah.

**AppBar** diterapkan di setiap halaman dengan warna primary theme yang sama dan foreground color putih, memberikan identitas visual yang konsisten.

**Drawer** (LeftDrawer) dibuat sebagai widget terpisah yang dapat digunakan di semua halaman, memastikan navigasi yang konsisten dengan opsi Home dan Create Product yang selalu tersedia.

#### Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

**Padding** memberikan jarak antar elemen form agar tidak terlihat rapat dan lebih mudah dibaca. Contoh: setiap TextFormField dibungkus Padding dengan EdgeInsets.all(8.0).

**SingleChildScrollView** memungkinkan form dapat di-scroll ketika konten melebihi tinggi layar, terutama penting untuk form dengan banyak input field seperti form produk yang memiliki 9 input. Ini mencegah overflow error pada layar kecil.

**ListView** cocok untuk menampilkan daftar item yang dinamis. Contoh: digunakan di Drawer untuk menampilkan menu navigasi (Home dan Create Product).

#### Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Di main.dart, saya menggunakan ColorScheme.fromSwatch dengan primarySwatch: Colors.blue sebagai warna utama yang merepresentasikan profesionalisme dan kepercayaan dalam dunia olahraga. Warna ini diterapkan secara konsisten di:
- AppBar background di semua halaman
- Tombol Save di form
- DrawerHeader
- Card items di homepage

Dengan menggunakan Theme.of(context).colorScheme.primary, semua komponen otomatis mengikuti tema yang sama tanpa perlu hardcode warna di setiap widget.

### Melakukan add, commit, dan push ke GitHub.
Selesai.
