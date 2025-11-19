import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footballpedia_flutter/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description  = "";
  String _thumbnail = "";
  String _category = "Other";
  bool _isFeatured = false;
  int _quantity = 0;
  String _size = "";
  double _rating = 0.0;

  final List<String> _categories = [
    'Footwear',
    'Jersey',
    'Shin Guard',
    'Gloves',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Create Product',
            ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Name ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      labelText: "Enter product name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Product name cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Price ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Price",
                      labelText: "Enter product price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _price = int.tryParse(value!) ?? 0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Price cannot be empty!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Price must be a number!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Enter product description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Description cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Thumbnail ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Thumbnail URL",
                      labelText: "Enter thumbnail URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Thumbnail URL cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                  ),
                ),

                // === Quantity ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Enter product quantity",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _quantity = int.tryParse(value!) ?? 0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Quantity cannot be empty!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Quantity must be a number!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Size ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Size",
                      labelText: "Enter product size",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _size = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Size cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Rating ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Rating",
                      labelText: "Enter product rating (0.0 - 5.0)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (String? value) {
                      setState(() {
                        _rating = double.tryParse(value!) ?? 0.0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Rating cannot be empty!";
                      }
                      if (double.tryParse(value) == null) {
                        return "Rating must be a number!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    title: const Text("Featured Product"),
                    value: _isFeatured,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFeatured = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),

                // === Save Button ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                            'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id/create-product-flutter/',
                            jsonEncode({
                              'name': _name,
                              'price': _price,
                              'description': _description,
                              'thumbnail': _thumbnail,
                              'category': _category,
                              'quantity': _quantity,
                              'size': _size,
                              'rating': _rating,
                              'is_featured': _isFeatured,
                            }),
                          );

                          if (!context.mounted) return;

                          final status = response['status'];
                          if (status == 'success' || status == true) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Product saved successfully'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name: $_name'),
                                        Text('Price: $_price'),
                                        Text('Description: $_description'),
                                        Text('Thumbnail: $_thumbnail'),
                                        Text('Category: $_category'),
                                        Text('Quantity: $_quantity'),
                                        Text('Size: $_size'),
                                        Text('Rating: $_rating'),
                                        Text('Featured: $_isFeatured'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _formKey.currentState!.reset();
                                        setState(() {
                                          _category = 'Other';
                                          _isFeatured = false;
                                          _rating = 0.0;
                                          _price = 0;
                                          _quantity = 0;
                                          _size = '';
                                          _thumbnail = '';
                                          _description = '';
                                          _name = '';
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            final message = response['message'] ?? 'Gagal menyimpan produk.';
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(content: Text(message)));
                          }
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}