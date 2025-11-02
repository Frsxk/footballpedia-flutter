# Tugas 7 PBP: Elemen Dasar Flutter

Hello Flutter

# Checklist Tugas
### Membuat sebuah program Flutter baru dengan tema Football shop yang sesuai dengan tugas-tugas sebelumnya.

### Membuat tiga tombol sederhana dengan ikon dan teks untuk product kamu:
- All Products
- My Products
- Create Product

### Mengimplementasikan warna-warna yang berbeda untuk setiap tombol:
- Warna biru untuk tombol All Products
- Warna hijau untuk tombol My Products
- Warna merah untuk tombol Create Product

### Memunculkan Snackbar dengan tulisan:
- "Kamu telah menekan tombol All Products" ketika tombol All Products ditekan.
- "Kamu telah menekan tombol My Products" ketika tombol My Products ditekan.
- "Kamu telah menekan tombol Create Product" ketika tombol Create Product ditekan.

### Jawab pertanyaan-pertanyaan berikut di file README.md pada folder root:

#### Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree adalah struktur hierarki dari widget-widget yang membentuk UI aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai child (anak), membentuk struktur seperti pohon. Hubungan parent-child bekerja dengan cara:
- Parent widget mengontrol posisi dan ukuran child widget
- Child widget mewarisi beberapa properti dari parent (seperti theme, context)
- Perubahan pada parent dapat mempengaruhi semua child di bawahnya
- Data mengalir dari parent ke child melalui constructor parameters

#### Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

1. **MaterialApp**: Widget root yang menyediakan struktur Material Design
2. **Scaffold**: Menyediakan struktur dasar halaman (AppBar, Body, dll)
3. **AppBar**: Bar di bagian atas aplikasi untuk menampilkan judul
4. **Padding**: Memberikan jarak/padding di sekitar widget child
5. **Column**: Menyusun widget secara vertikal
6. **Text**: Menampilkan teks
7. **GridView.count**: Menampilkan widget dalam bentuk grid dengan jumlah kolom tetap
8. **Material**: Memberikan efek visual Material Design
9. **InkWell**: Memberikan efek ripple saat widget ditekan
10. **Container**: Widget untuk styling dan positioning
11. **Icon**: Menampilkan ikon
12. **SnackBar**: Menampilkan pesan sementara di bagian bawah layar
13. **Center**: Menempatkan child widget di tengah
14. **SizedBox**: Memberikan jarak/spacing dengan ukuran tetap

#### Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp adalah widget yang menyediakan berbagai fitur untuk aplikasi Material Design, termasuk *navigator* untuk *routing* antar halaman, *theme* untuk *styling* konsisten, *localization support*, dan Material Design *visual effects*.

Widget ini sering digunakan sebagai root karena:
- Menyediakan konfigurasi dasar aplikasi (title, theme, home)
- Mengatur navigasi dan routing secara otomatis
- Memberikan akses ke Material Design components
- Menyediakan context yang diperlukan widget-widget lain

#### Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

**StatelessWidget**:
- Tidak memiliki state yang bisa berubah
- Immutable (tidak berubah setelah dibuat)
- Build hanya dipanggil sekali atau saat parent rebuild
- Lebih ringan dan efisien

**StatefulWidget**:
- Memiliki state yang bisa berubah
- Mutable (bisa berubah dengan setState())
- Dapat rebuild dirinya sendiri saat state berubah
- Digunakan untuk widget interaktif

**Kapan memilih**:
- Gunakan StatelessWidget untuk UI statis yang tidak berubah
- Gunakan StatefulWidget untuk UI yang perlu update berdasarkan interaksi user atau data yang berubah

#### Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah referensi ke lokasi widget dalam widget tree. BuildContext penting karena menyediakan akses ke widget *ancestor* (parent di atasnya), digunakan untuk mengakses Theme, MediaQuery, Navigator, diperlukan untuk menampilkan SnackBar, Dialog, dll., dan memungkinkan widget berkomunikasi dengan widget lain dalam *tree*.

Penggunaan di metode build:
- Diterima sebagai parameter di method build(BuildContext context)
- Digunakan untuk mengakses inherited widgets: Theme.of(context), Navigator.of(context)
- Digunakan untuk operasi yang memerlukan context seperti ScaffoldMessenger.of(context)

#### Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

**Hot Reload**:
- Memuat ulang kode yang diubah **tanpa kehilangan state** aplikasi
- Sangat cepat (biasanya < 1 detik)
- Mempertahankan data dan posisi UI saat ini
- Cocok untuk perubahan UI dan logic kecil

**Hot Restart**:
- Restart aplikasi dari awal dan **menghapus semua state**
- Lebih lambat dari hot reload
- Menginisialisasi ulang semua variable dan state
- Diperlukan untuk perubahan pada main(), initState(), atau perubahan besar

### Melakukan add-commit-push ke suatu repositori baru di GitHub.
Selesai.
