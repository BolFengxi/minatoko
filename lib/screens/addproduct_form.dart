import 'package:flutter/material.dart';
import 'package:minatoko/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:minatoko/screens/menu.dart'; // Pastikan MyHomePage diimpor dari sini

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  num _price = 0;
  String _description = "";
  // Inisialisasi awal harus sesuai dengan salah satu pilihan di _categories
  String _category = "Football Boots"; 
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = const [
    'Ball',
    'Football Boots',
    'Kits & Jerseys',
    'Equipment',
    'Accessories',
    'Other Football Items',
  ];

  @override
  Widget build(BuildContext context) {
    // Dapatkan instance CookieRequest (pbp_django_auth)
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add New Product')),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // == Nama Produk ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama produk tidak boleh kosong';
                    }
                    if (value.length < 5) {
                      return 'Nama produk minimal 5 karakter';
                    }
                    if (value.length > 35) {
                      return 'Nama produk maksimal 35 karakter';
                    }
                    return null;
                  },
                ),
              ),

              // == Harga Produk ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Harga Produk',
                    labelText: 'Harga Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // Menggunakan num.tryParse() untuk penanganan input numerik
                      _price = num.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga produk tidak boleh kosong';
                    }
                    if (num.tryParse(value) == null) {
                      return 'Harga produk harus berupa angka';
                    }
                    final price = num.parse(value);
                    if (price <= 0) {
                      return 'Harga produk harus lebih dari 0';
                    }
                    return null;
                  },
                ),
              ),

              // == Kategori Produk ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category, // Menggunakan value untuk initial value
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          // Hanya menampilkan huruf pertama kapital
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // == Deskripsi Produk ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Produk",
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi produk tidak boleh kosong!";
                    }
                    if (value.length > 200) {
                      return "Deskripsi produk maksimal 200 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // == Thumbnail Produk ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Thumbnail produk tidak boleh kosong!";
                    }
                    if (!value.startsWith('https://') && !value.startsWith('http://')) {
                      return "URL harus diawali dengan https:// atau http://";
                    }
                    return null;
                  },
                ),
              ),

              // == Featured Product Switch ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // == Tombol Save (diperbaiki) ==
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.yellow),
                    ),
                    onPressed: () async { // <-- ASYNC FUNCTION
                      if (_formKey.currentState!.validate()) {
                        
                        // Kirim data ke Django
                        final response = await request.postJson(
                          // GANTI URL INI
                          "http://localhost:8000/create-product-flutter/", 
                          jsonEncode({
                            "name": _name, 
                            "price": _price.toInt(), // Konversi ke int
                            "description": _description, 
                            "thumbnail": _thumbnail, 
                            "category": _category, 
                            "is_featured": _isFeatured, 
                            "userId": request.jsonData['id'],
                          }),
                        );
                        
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Product successfully saved!"),
                            ));
                            
                            // Navigasi ke halaman utama
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()), 
                            );
                          } else {
                            // Tampilkan pesan error dari Django (jika ada)
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(response['message'] ?? "Something went wrong, please try again."),
                            ));
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}