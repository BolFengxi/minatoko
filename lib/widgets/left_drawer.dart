import 'package:flutter/material.dart';
import 'package:minatoko/screens/menu.dart';
import 'package:minatoko/screens/addproduct_form.dart';
import 'package:minatoko/screens/products_entry_list.dart';
import 'package:minatoko/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.yellow),
            child: Column(
              children: [
                Text(
                  'Minatoko',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh produk terkece di sini!",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Product List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final response = await request.logout(
                "http://localhost:8000/auth/logout/",
              );

              if (!context.mounted) return;

              final message = response["message"];

              if (response["status"]) {
                final uname = response["username"];

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$message See you again, $uname.")),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
