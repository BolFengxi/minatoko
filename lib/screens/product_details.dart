import 'package:flutter/material.dart';
import 'package:minatoko/model/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (product.thumbnail.isNotEmpty)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Badge
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'FEATURED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price
                  Text(
                    "Rp ${product.price}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),

                  const Divider(height: 32),

                  // Description
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
