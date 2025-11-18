import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductEntry product;
  final VoidCallback onTap;

  static const String _proxyBaseUrl =
      'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id/proxy-image/';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.thumbnail.isNotEmpty
                        ? Image.network(
                          '$_proxyBaseUrl?url=${Uri.encodeComponent(product.thumbnail)}',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text('Kategori: ${product.category}'),
                      const SizedBox(height: 6),
                      Text('Harga: Rp${product.price}'),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber.shade600, size: 18),
                          const SizedBox(width: 4),
                          Text(product.rating.toStringAsFixed(1)),
                          const Spacer(),
                          if (product.isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Featured',
                                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }
}
