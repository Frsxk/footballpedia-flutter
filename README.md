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

**Navigator.push()** mendorong halaman baru ke atas stack sehingga halaman lama tetap tersimpan. Saya memakainya untuk navigasi "sekali jalan" seperti membuka `ProductFormPage` atau `ProductListPage` dari grid `ItemCard`. Pengguna bisa menekan tombol back untuk kembali ke beranda tanpa perlu memuat ulang state.

**Navigator.pushReplacement()** mengganti halaman aktif dengan halaman baru dan menghapus halaman lama dari stack. Pola ini saya pakai di `LeftDrawer` dan saat berpindah dari `LoginPage` ke `MyHomePage` agar tidak ada tumpukan halaman login yang membuat tombol back membawa user kembali ke layar autentikasi setelah berhasil masuk.

#### Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Setiap halaman utama (`LoginPage`, `ProductListPage`, `ProductFormPage`, hingga `ProductDetailPage`) dibangun di atas `Scaffold` sehingga memiliki area body, snackbar host, dan floating widgets yang sama. `AppBar` selalu memakai `Theme.of(context).colorScheme.primary` dengan teks putih sehingga identitas Footballpedia konsisten. `LeftDrawer` disusun sekali dan direuse pada halaman yang butuh navigasi utama (Home, Daftar Produk, Create Product, Logout) sehingga struktur navigasi lateral terasa sama di seluruh aplikasi.

#### Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

`Padding` memberikan ruang bernafas untuk tiap `TextFormField` di `ProductFormPage`, membuat 9 input berbeda tetap mudah dibaca. `SingleChildScrollView` membungkus form agar pengguna tetap bisa menggulir halaman ketika keyboard muncul atau layar kecil—tanpa scroll view, form akan overflow. `ListView` dipakai pada `ProductListPage` untuk menampilkan daftar produk dari backend secara efisien sekaligus mendukung pull-to-refresh dan lazy building item card.

#### Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Di `main.dart` saya membangkitkan tema dengan `ColorScheme.fromSeed(seedColor: Colors.blue)` lalu seluruh komponen mengambil warna primer melalui `Theme.of(context).colorScheme.primary`. AppBar, tombol aksi (Login, Save, Register), badge featured, dan header drawer otomatis memakai palet yang sama sehingga tidak perlu meng-hardcode warna satu per satu. Pendekatan ini menjaga konsistensi dan memudahkan penggantian warna brand di masa depan.

### Melakukan add, commit, dan push ke GitHub.
Selesai.
