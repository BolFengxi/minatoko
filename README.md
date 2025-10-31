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

