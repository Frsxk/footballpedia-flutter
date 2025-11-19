import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';
import 'package:footballpedia_flutter/services/username_service.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryCard extends StatelessWidget {
  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductEntry product;
  final VoidCallback onTap;

  static const String _proxyBaseUrl = 'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id/proxy-image/';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholder(),
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
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(product.category),
                      const SizedBox(height: 6),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      _SellerInfo(product: product),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade600,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(product.rating.toStringAsFixed(1)),
                          const Spacer(),
                          if (product.isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
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

class _SellerInfo extends StatelessWidget {
  const _SellerInfo({required this.product});

  final ProductEntry product;

  @override
  Widget build(BuildContext context) {
    final cachedName = product.ownerUsername;
    if (cachedName != null && cachedName.isNotEmpty) {
      return Text(
        'Seller: $cachedName',
        style: const TextStyle(color: Colors.black87),
      );
    }

    final ownerId = product.userId;
    if (ownerId == null) {
      return const Text(
        'Seller: Unknown',
        style: TextStyle(color: Colors.black54),
      );
    }

    return Consumer<CookieRequest>(
      builder: (context, request, _) {
        return FutureBuilder<String?>(
          future: UsernameService.getUsername(
            request: request,
            userId: ownerId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Text(
                'Seller: ...',
                style: TextStyle(color: Colors.black54),
              );
            }

            final sellerName = snapshot.data;
            if (sellerName != null && sellerName.isNotEmpty) {
              product.ownerUsername ??= sellerName;
              return Text(
                'Seller: $sellerName',
                style: const TextStyle(color: Colors.black87),
              );
            }

            if (snapshot.hasError) {
              return const Text(
                'Seller: unavailable',
                style: TextStyle(color: Colors.black54),
              );
            }

            return const Text(
              'Seller: Unknown',
              style: TextStyle(color: Colors.black54),
            );
          },
        );
      },
    );
  }
}
