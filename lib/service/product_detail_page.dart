import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['thumbnail']),
            const SizedBox(height: 16),
            Text('Description: ${product['description']}'),
            const SizedBox(height: 8),
            Text('Price: \$${product['price']}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
