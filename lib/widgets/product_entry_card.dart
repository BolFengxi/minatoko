import 'package:flutter/material.dart';
import 'package:minatoko/model/product_entry.dart';
import 'package:minatoko/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Card(
          elevation: 3,
          color: const Color(0xFFF0F8FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- BADGES ROW ---
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Row(
                  children: [
                    _buildBadge("BOOT", Colors.blue),
                    const SizedBox(width: 8),
                    _buildBadge("Featured", Colors.orange),
                  ],
                ),
              ),

              // --- PRODUCT IMAGE ---
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              // --- CONTENT AREA ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "View",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
