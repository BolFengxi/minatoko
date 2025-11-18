import 'package:flutter/material.dart';
import 'package:minatoko/screens/addproduct_form.dart';
import 'package:minatoko/screens/products_entry_list.dart';
import 'package:minatoko/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemHomePage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomePage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomePage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}")),
            );
          if (item.name == "Create Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductPage()),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductEntryListPage(mode: "all"),
              ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductEntryListPage(mode: "mine"),
              ),
            );
          }
        },

        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Menyusun ikon dan teks di tengah kartu.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
