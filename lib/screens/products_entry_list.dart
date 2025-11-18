import 'package:flutter/material.dart';
import 'package:minatoko/model/product_entry.dart';
import 'package:minatoko/model/user_session.dart';
import 'package:minatoko/widgets/left_drawer.dart';
import 'package:minatoko/screens/product_details.dart';
import 'package:minatoko/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final String mode; // "all" / "mine"
  const ProductEntryListPage({super.key, this.mode = "all"});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    final currentUserId = UserSession.userId;

    List<ProductEntry> listProduct = [];
    for (var d in response) {
      if (d != null) {
        if (widget.mode == "all") {
          listProduct.add(ProductEntry.fromJson(d));
        } else if (widget.mode == "mine" &&
            ProductEntry.fromJson(d).userId == currentUserId) {
          listProduct.add(ProductEntry.fromJson(d));
        }
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                'There are no products yet.',
                style: TextStyle(fontSize: 18, color: Color(0xFF555555)),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
