import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';
import 'package:footballpedia_flutter/services/username_service.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductEntry product;
  static const String _proxyBaseUrl = 'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id/proxy-image/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
                        label: Text(product.rating.toStringAsFixed(1)),
                        avatar: const Icon(Icons.star, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Chip(label: Text('${product.quantity} sold')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Description', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.straighten),
                    title: const Text('Size'),
                    subtitle: Text(product.size),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Seller'),
                    subtitle: _SellerName(product: product, request: request),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Product List'),
                    ),
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

class _SellerName extends StatelessWidget {
  const _SellerName({required this.product, required this.request});

  final ProductEntry product;
  final CookieRequest request;

  @override
  Widget build(BuildContext context) {
    final cachedName = product.ownerUsername;
    if (cachedName != null && cachedName.isNotEmpty) {
      return Text(cachedName);
    }

    final ownerId = product.userId;
    if (ownerId == null) {
      return const Text('Unknown');
    }

    return FutureBuilder<String?>(
      future: UsernameService.getUsername(request: request, userId: ownerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Text('Loading...');
        }

        final sellerName = snapshot.data;
        if (sellerName != null && sellerName.isNotEmpty) {
          product.ownerUsername ??= sellerName;
          return Text(sellerName);
        }

        if (snapshot.hasError) {
          return const Text('Error loading username');
        }

        return const Text('Unknown');
      },
    );
  }
}
