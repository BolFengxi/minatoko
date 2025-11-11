# minatoko

# Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
=> Widget tree pada Flutter adalah struktur hierarkis yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget anak (children) dan satu widget induk (parent). Hubungan parent-child bekerja seperti struktur pohon, di mana parent widget mengontrol dan mempengaruhi properti dan perilaku child widget-nya.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
=> Widget yang digunakan dalam proyek:
    - `MaterialApp`: Widget root yang menyediakan struktur dasar aplikasi
    - `Scaffold`: Menyediakan struktur layout dasar material design
    - `AppBar`: Menampilkan bar navigasi atas
    - `Text`: Menampilkan teks
    - `Column`: Menyusun widget secara vertikal
    - `Container`: Wadah yang dapat dikustomisasi
    - `Card`: Menampilkan panel dengan tampilan material design
    - `GridView`: Menampilkan widget dalam grid
    - `InkWell`: Membuat area yang dapat diklik

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
=> `MaterialApp` adalah widget yang mengimplementasikan Material Design. Widget ini penting sebagai root karena:
    - Menyediakan navigasi dan tema default
    - Mengatur title aplikasi
    - Mengatur home screen
    - Mengelola routing

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
=> Perbedaan StatelessWidget dan StatefulWidget:
    - StatelessWidget: Widget statis yang tidak dapat berubah setelah dibuat
    - StatefulWidget: Widget dinamis yang dapat memperbarui tampilan saat terjadi perubahan data
    Pilih StatelessWidget untuk UI statis, StatefulWidget untuk UI yang perlu update berkala.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
=> BuildContext adalah handle ke lokasi widget dalam widget tree. Penting karena:
    - Memberikan informasi tentang posisi widget
    - Memungkinkan akses ke widget ancestor
    - Digunakan untuk navigasi dan theming
    Dalam metode build, BuildContext digunakan sebagai parameter untuk mengakses lokasi widget.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
=> Hot Reload vs Hot Restart:
    - Hot Reload: Memperbarui UI dengan mempertahankan state, lebih cepat
    - Hot Restart: Memulai ulang aplikasi dari awal, menghapus semua state

TUGAS 8
### Halaman Form Tambah Produk
- Membuat halaman baru "FormTambahProduk" dengan elemen input:
    - name (String)
    - price (number, int/double)
    - description (String)
    - thumbnail (String - URL)
    - category (String - pilihan/dropdown)
    - isFeatured (bool - switch/checkbox)
- Semua input divalidasi:
    - Tidak boleh kosong.
    - Tipe data sesuai model (price harus numeric; thumbnail berupa URL sederhana; category dipilih dari daftar).
- Terdapat tombol "Save" yang jika valid menampilkan pop-up (AlertDialog) yang merangkum data yang diisi.
- Dari halaman utama, tombol "Tambah Produk" mengarahkan ke halaman form menggunakan Navigator.push().

Checklist fungsi yang dipenuhi:
- [v] Minimal tiga elemen input (name, price, description)
- [v] Elemen input tambahan sesuai model (thumbnail, category, isFeatured)
- [v] Tombol Save menampilkan pop-up berisi data form
- [v] Validasi: tidak kosong dan tipe data sesuai
- [v] Navigasi dari halaman utama ke form saat menekan "Tambah Produk"

### Drawer
- Drawer berisi ddua opsi:
    - Halaman Utama 
    - Tambah Produk
- Pemilihan opsi akan mengarahkan pengguna ke halaman terkait.
- Drawer ditempatkan di Scaffold utama sehingga tersedia di semua halaman yang memerlukan navigasi konsisten.

### Validasi Form
- Setiap field memiliki validator:
    - name, description, category, thumbnail: validator non-empty.
    - price: parse sebagai number; tampilkan pesan jika parsing gagal atau nilai negatif.
    - isFeatured: boolean, tidak perlu validator selain memastikan ada kontrol.
- Saat tombol Save ditekan:
    - Jika form valid -> tampilkan AlertDialog dengan ringkasan (mis. Name, Price, Category, Featured).
    - Jika tidak valid -> tampilkan pesan error per-field.

1. Navigator.push() vs Navigator.pushReplacement()
- Navigator.push():
    - Menambahkan route baru ke stack; pengguna dapat kembali dengan back button.
    - Gunakan saat ingin memungkinkan pengguna kembali ke halaman sebelumnya, mis. dari Home ke FormTambahProduk agar pengguna bisa membatalkan dan kembali.
- Navigator.pushReplacement():
    - Mengganti route saat ini dengan route baru; tidak memungkinkan kembali ke route yang diganti.
    - Gunakan untuk operasi yang tidak boleh kembali, mis. setelah login sukses mengganti layar login, atau when replacing splash screen dengan main screen.
- Football Shop:
    - Navigasi ke form tambah produk: gunakan push() (biarkan pengguna kembali).
    - Setelah men-submit dan ingin langsung menampilkan list terbaru tanpa menumpuk route, gunakan Navigator.pop() dengan result atau gunakan pushReplacement ketika mengganti flow utama.

2. Hierarki widget (Scaffold, AppBar, Drawer)
- Scaffold sebagai kerangka halaman (body, appBar, drawer, floatingActionButton).
- AppBar untuk judul, aksi cepat (mis. tombol cari atau icon cart).
- Drawer untuk navigasi global.
- Pola: setiap halaman utama memakai Scaffold yang konsisten — AppBar + Drawer + body — sehingga struktur UI konsisten di seluruh aplikasi.

3. Keuntungan layout widget saat membuat form (Padding, SingleChildScrollView, ListView)
- Padding: menambah jarak sekitar elemen agar UI rapi dan mudah disentuh.
    - Implementasi: Pada addproduct_form.dart untuk membuat memisahkan input-inputnya
- SingleChildScrollView: mencegah overflow saat keyboard muncul; memungkinkan scroll untuk form pendek.
    - Implementasi: Pada addproduct_form.dart untuk membuat layout inputnya 
- ListView: cocok untuk form panjang atau daftar input karena bawaan scroll dan penghematan memori.
    - Implementasi: Pada drawer


4. Tema dan identitas visual
- Gunakan ThemeData untuk konsistensi:
    - primaryColor / colorScheme.primary untuk warna utama brand. (kuning)
    - secondaryColor untuk aksen (tombol, chip, isFeatured highlights). (Untuk teks menggunakan warna hitam)

