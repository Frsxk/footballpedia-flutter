import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductEntry product;
  static const String _proxyBaseUrl =
      'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id/proxy-image/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.thumbnail.isNotEmpty)
              Image.network(
                '$_proxyBaseUrl?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 260,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(product.category),
                        avatar: const Icon(Icons.category, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text('${product.rating.toStringAsFixed(1)} ★'),
                      ),
                      const SizedBox(width: 8),
                      Chip(label: Text('${product.quantity} pcs')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Harga: Rp${product.price}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Deskripsi',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.straighten),
                    title: const Text('Ukuran'),
                    subtitle: Text(product.size),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Featured Product'),
                    subtitle: const Text('Ditampilkan di halaman utama toko'),
                    value: product.isFeatured,
                    onChanged: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
