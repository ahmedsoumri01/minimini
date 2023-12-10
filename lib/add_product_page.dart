import 'package:flutter/material.dart';
import 'package:minieya/service/dummy_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addProduct();
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

void _addProduct() {
  final String title = _titleController.text.trim();
  final String description = _descriptionController.text.trim();
  final double price = double.tryParse(_priceController.text.trim()) ?? 0.0;

  if (title.isNotEmpty && description.isNotEmpty && price > 0) {
    // Prepare product data
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      // Add other product data as needed
    };

    // Call the DummyService method to add the product
    DummyService.addProduct(productData).then((_) {
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
        ),
      );

      // Navigate back to the home page after adding the product
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors, e.g., show an error message
      print('Error adding product: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding product. Please try again.'),
        ),
      );
    });
  } else {
    // Show an error message if any required field is empty or invalid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all fields with valid data.'),
      ),
    );
  }
}
}
