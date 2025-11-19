# Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

Hello Flutter

# Checklist Tugas
### Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.

### Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.

### Membuat halaman login pada proyek tugas Flutter.

### Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.

### Membuat model kustom sesuai dengan proyek aplikasi Django.

### Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.

#### Tampilkan name, price, description, thumbnail, category, dan is_featured dari masing-masing item pada halaman ini (Dapat disesuaikan dengan field yang kalian buat sebelumnya).

### Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
#### Halaman ini dapat diakses dengan menekan salah satu card item pada halaman daftar Item.

#### Tampilkan seluruh atribut pada model item kamu pada halaman ini.

#### Tambahkan tombol untuk kembali ke halaman daftar item.

### Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.

### Menjawab beberapa pertanyaan berikut pada README.md pada root folder (silakan modifikasi README.md yang telah kamu buat sebelumnya; tambahkan subjudul untuk setiap tugas).

#### Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model (terkait validasi tipe, null-safety, maintainability)?
Model Dart menjaga kontrak data tetap eksplisit. Dengan class `ProductEntry` (`lib/models/product_entry.dart`) saya bisa memaksa setiap atribut seperti `price`, `isFeatured`, hingga `ownerUsername` memiliki tipe yang tepat serta konversi khusus (mis. `rating` -> `double`). Jika hanya memakai `Map<String, dynamic>`, kesalahan seperti salah ketik key, nilai null tak terduga, atau perubahan struktur JSON baru akan meledak saat runtime dan sulit dilacak. Model juga memusatkan logika konversi (mis. ekstraksi nama pemilik dari berbagai bentuk field), sehingga ketika backend berubah saya cukup menyentuh satu file.

#### Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
Package `http` menyediakan klien REST dasar (GET/POST tanpa sesi) dan tetap saya butuhkan untuk kasus non-autentikasi. `CookieRequest` dari `pbp_django_auth` membungkus HTTP client sekaligus menyimpan cookie session Django. Saat login di `lib/screens/login.dart`, `request.login()` otomatis menyimpan cookie CSRF/session dan kemudian dipakai di seluruh aplikasi (fetch daftar produk, buat produk, logout) tanpa harus mengelola header manual. Singkatnya: `http` = transport umum; `CookieRequest` = transport + stateful auth khusus Django yang memahami cookie & CSRF.

#### Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Instance `CookieRequest` menyimpan cookie autentikasi serta data tambahan seperti username aktif (`request.jsonData`). Karena seluruh halaman (drawer, daftar produk, form) perlu mengakses cookie yang sama, saya membungkus `MaterialApp` dengan `Provider<CookieRequest>` di `main.dart`. Dengan begitu setiap widget cukup memanggil `context.watch<CookieRequest>()` tanpa harus meneruskan objek lewat constructor. Jika tidak dibagikan, setiap halaman bisa saja memiliki sesi berbeda sehingga request ke backend gagal akibat tidak membawa cookie login.

#### Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Browser/Android emulator mengakses `localhost` Django melalui alamat `10.0.2.2`, sehingga alamat tersebut harus ada pada `ALLOWED_HOSTS` Django supaya request tidak ditolak. Karena Flutter berjalan di domain berbeda, Django perlu mengizinkan CORS dan mengatur cookie (`SameSite=None`, `Secure=True`) agar cookie session boleh dikirim lintas origin. Di sisi Flutter, saya menambahkan `<uses-permission android:name="android.permission.INTERNET" />` pada `AndroidManifest.xml`, jika tidak, semua request jaringan akan gagal dengan error `SocketException`. Tanpa konfigurasi ini integrasi gagal: request diblokir oleh Django atau tidak pernah keluar dari aplikasi.

#### Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Alur tambah produk (`lib/screens/product_form.dart`) dimulai dari input user di `TextFormField`. Setelah validasi lolos, data dikumpulkan dalam map, diubah menjadi JSON dengan `jsonEncode`, lalu dikirim melalui `CookieRequest.postJson()` ke endpoint `create-product-flutter/`. Django menyimpan data dan mengembalikan status. Jika sukses, Flutter menampilkan dialog berisi data yang baru saja dikirim sekaligus mereset form. Ketika halaman daftar (`ProductListPage`) dimuat, Flutter memanggil endpoint JSON yang sama, mengonversinya ke `ProductEntry`, lalu menampilkan atribut seperti `name`, `price`, `description`, `thumbnail`, `category`, dan `isFeatured` melalui `ProductEntryCard`.

#### Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Pada login, pengguna mengisi username/password di `LoginPage`. `CookieRequest.login()` mengirim kredensial ke `.../auth/login/`; Django memverifikasi, mengirim cookie session + JSON balasan (status, username, optional user_id). Saya menyimpan username pada `request.jsonData` agar bisa dipakai untuk filter produk. Setelah itu Navigator mengganti layar menuju `MyHomePage`. Register berjalan mirip, hanya saja `RegisterPage` memanggil `postJson()` ke `.../auth/register/` dan jika sukses diarahkan kembali ke login. Logout dipicu dari drawer: `request.logout()` memanggil endpoint logout Django, backend menghapus sesi, Flutter membersihkan `request.jsonData`, menunjukkan snackbar, lalu mengembalikan user ke `LoginPage`.

#### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
1. **Deployment Django**: memastikan endpoint `json/`, `auth/*`, `create-product-flutter/`, dan `proxy-image/` bisa diakses via domain `muhammad-faza44-footballpedia...` sebelum menyentuh Flutter.
2. **Autentikasi Flutter**: menambahkan dependency (`provider`, `pbp_django_auth`), membungkus `MaterialApp` dengan `Provider<CookieRequest>`, lalu membuat `LoginPage` dan `RegisterPage` yang benar-benar memanggil endpoint milik saya (bukan placeholder). Username yang berhasil login disimpan ke `request.jsonData`.
3. **Drawer & Navigasi**: `LeftDrawer` diupdate agar mengarahkan user ke Home, daftar produk, form produk, dan menyediakan tombol logout yang juga menutup sesi.
4. **Model Kustom**: menyesuaikan `ProductEntry` agar mencerminkan seluruh field backend termasuk `ownerUsername`. Ini memudahkan saya menampilkan atribut lengkap di UI.
5. **Halaman Daftar & Detail**: `ProductListPage` memakai `CookieRequest.get()` untuk mengambil data, mem-filter item agar hanya menampilkan produk milik akun login, dan menampilkan atribut wajib lewat `ProductEntryCard`. Saat card ditekan, `ProductDetailPage` menampilkan seluruh atribut berikut tombol kembali.
6. **Form Tambah Produk**: `ProductFormPage` sekarang mengirim data ke endpoint `create-product-flutter/` menggunakan `CookieRequest`, kemudian menampilkan summary dialog jika sukses.
7. **Dokumentasi & analisis**: menjalankan `flutter analyze` untuk memastikan tidak ada lint error, lalu merangkum jawaban dan bukti implementasi di README ini.

### Melakukan add, commit, dan push ke GitHub.
Selesai.
