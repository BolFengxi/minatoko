import 'package:flutter/material.dart';
import 'package:minatoko/widgets/left_drawer.dart';

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
  String _category = "Football Boots";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Ball',
    'Football Boots',
    'Kits & Jerseys',
    'Equipment',
    'Accessories',
    'Other Football Items',
  ];

  @override
  Widget build(BuildContext context) {
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
                  initialValue: _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
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
                    // final urlPattern = RegExp(
                    //   r'^https?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?$',
                    // );
                    // if (!urlPattern.hasMatch(value)) {
                    //   return "URL thumbnail tidak valid!";
                    // }
                    // if (!value.toLowerCase().endsWith('.jpg') &&
                    //   !value.toLowerCase().endsWith('.jpeg') &&
                    //   !value.toLowerCase().endsWith('.png')) {
                    //   return "URL harus mengarah ke file gambar (jpg/jpeg/png)!";
                    // }
                    return null;
                  },
                ),
              ),

              // == Featured Product ==
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

              // == Tombol Save ==
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.yellow),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Berita berhasil disimpan!"),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama Produk: $_name"),
                                    Text("Harga Produk: $_price"),
                                    Text("Kategori: $_category"),
                                    Text("Deskripsi: $_description"),
                                    Text("Thumbnail URL: $_thumbnail"),
                                    Text("Produk Unggulan: ${_isFeatured ? "Ya" : "Tidak"}"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
