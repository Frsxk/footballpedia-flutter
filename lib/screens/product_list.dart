import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';
import 'package:footballpedia_flutter/screens/product_detail.dart';
import 'package:footballpedia_flutter/widgets/left_drawer.dart';
import 'package:footballpedia_flutter/widgets/product_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static const String _baseApiUrl =
      'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id';
  late Future<List<ProductEntry>> _futureProducts;

  Future<List<ProductEntry>> _fetchProducts(CookieRequest request) async {
    final response = await request.get('$_baseApiUrl/json/');
    return productEntryListFromDynamic(response);
  }

  Future<void> _refreshProducts() async {
    final request = context.read<CookieRequest>();
    setState(() {
      _futureProducts = _fetchProducts(request);
    });
    await _futureProducts;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _futureProducts = _fetchProducts(context.read<CookieRequest>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<ProductEntry>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Gagal memuat produk: ${snapshot.error}'),
                ),
              );
            }

            final products = snapshot.data ?? [];
            if (products.isEmpty) {
              return const Center(
                child: Text('Belum ada produk di Footballpedia.'),
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductEntryCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
