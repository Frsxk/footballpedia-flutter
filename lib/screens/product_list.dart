import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/models/product_entry.dart';
import 'package:footballpedia_flutter/screens/product_detail.dart';
import 'package:footballpedia_flutter/services/username_service.dart';
import 'package:footballpedia_flutter/widgets/left_drawer.dart';
import 'package:footballpedia_flutter/widgets/product_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final ProductFilterOption initialFilter;

  const ProductListPage({
    super.key,
    this.initialFilter = ProductFilterOption.all,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static const String _baseApiUrl =
      'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id';
  late Future<List<ProductEntry>> _futureProducts;
  late ProductFilterOption _filterOption;

  @override
  void initState() {
    super.initState();
    _filterOption = widget.initialFilter;
  }

  Future<List<ProductEntry>> _fetchProducts(CookieRequest request) async {
    final response = await request.get('$_baseApiUrl/json/');
    return productEntryListFromDynamic(response);
  }

  Future<List<ProductEntry>> _filterMyProducts(
    CookieRequest request,
    List<ProductEntry> products,
  ) async {
    final loggedUsername = request.jsonData['username']?.toString();
    if (loggedUsername == null) return [];

    final results = await Future.wait(
      products.map((product) async {
        if (product.userId == null) return null;
        final username = await UsernameService.getUsername(
          request: request,
          userId: product.userId!,
        );
        if (username == loggedUsername) return product;
        return null;
      }),
    );

    return results.whereType<ProductEntry>().toList();
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
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                DropdownButtonHideUnderline(
                  child: DropdownButton<ProductFilterOption>(
                    value: _filterOption,
                    items: const [
                      DropdownMenuItem(
                        value: ProductFilterOption.all,
                        child: Text('All Products'),
                      ),
                      DropdownMenuItem(
                        value: ProductFilterOption.mine,
                        child: Text('My Products'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _filterOption = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
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
                        child: Text(
                          'Failed to load products: ${snapshot.error}',
                        ),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];
                  final loggedUsername = request.jsonData['username']
                      ?.toString();

                  return FutureBuilder<List<ProductEntry>>(
                    future: _filterOption == ProductFilterOption.mine
                        ? _filterMyProducts(request, products)
                        : Future.value(products),
                    builder: (context, filterSnapshot) {
                      if (filterSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final displayedProducts = filterSnapshot.data ?? [];

                      if (displayedProducts.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              _filterOption == ProductFilterOption.mine
                                  ? (loggedUsername == null
                                        ? 'Please login to view your products.'
                                        : 'No products owned by $loggedUsername. Add products using the Create Product button.')
                                  : 'No products available on Footballpedia at the moment.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: displayedProducts.length,
                        itemBuilder: (context, index) {
                          final product = displayedProducts[index];
                          return ProductEntryCard(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ProductFilterOption { all, mine }
