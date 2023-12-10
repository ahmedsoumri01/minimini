import 'package:flutter/material.dart';
import 'service/dummy_service.dart';

class EditProductPage extends StatefulWidget {
  final int productId;

  const EditProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Map<String, dynamic>> _productData;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productData = DummyService.fetchProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final Map<String, dynamic> product = snapshot.data!;
            _titleController.text = product['title'];
            _descriptionController.text = product['description'];
            _priceController.text = product['price'].toString();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    onChanged: (value) {
                      // Handle title changes
                    },
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    onChanged: (value) {
                      // Handle description changes
                    },
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: _priceController,
                    onChanged: (value) {
                      // Handle price changes
                    },
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _updateProduct(product['id']);
                    },
                    child: const Text('Update Product'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _updateProduct(int productId) async {
    // Get updated data from the UI
    String updatedTitle = _titleController.text.trim();
    String updatedDescription = _descriptionController.text.trim();
    double updatedPrice = double.tryParse(_priceController.text.trim()) ?? 0.0;

    try {
      await DummyService.updateProduct(productId, {
        'title': updatedTitle,
        'description': updatedDescription,
        'price': updatedPrice,
      });
      // Notify the calling page that the product was updated
      Navigator.pop(context, true);
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error updating product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating product. Please try again.'),
        ),
      );
    }
  }
}
