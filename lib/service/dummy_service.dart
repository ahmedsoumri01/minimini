import 'dart:convert';
import 'package:http/http.dart' as http;

class DummyService {
  static const String apiUrl = 'https://dummyjson.com/products';

  static Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);

      if (jsonData is List) {
        return List<Map<String, dynamic>>.from(jsonData);
      } else if (jsonData is Map<String, dynamic> && jsonData.containsKey('products')) {
        final List<dynamic> productList = jsonData['products'];
        return List<Map<String, dynamic>>.from(productList);
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(productData),
      );

      if (response.statusCode == 200) {
        print('New product added successfully');
      } else {
        print('Failed to add a new product');
        throw Exception('Failed to add a new product');
      }
    } catch (e) {
      print('Error adding a new product: $e');
      throw Exception('Error adding a new product');
    }
  }

  static Future<void> deleteProduct(int productId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$productId'));

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        print('Failed to delete product');
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Error deleting product');
    }
  }
  static Future<Map<String, dynamic>> fetchProduct(int productId) async {
  final response = await http.get(Uri.parse('$apiUrl/$productId'));

  if (response.statusCode == 200) {
    final dynamic jsonData = json.decode(response.body);

    if (jsonData is Map<String, dynamic>) {
      return jsonData;
    } else {
      throw Exception('Invalid product data format');
    }
  } else {
    throw Exception('Failed to load product data');
  }
}

static Future<void> updateProduct(int productId, Map<String, dynamic> updatedData) async {
  try {
    final response = await http.put(
      Uri.parse('$apiUrl/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      print('Product updated successfully');
    } else {
      print('Failed to update product');
      throw Exception('Failed to update product');
    }
  } catch (e) {
    print('Error updating product: $e');
    throw Exception('Error updating product');
  }
}
static Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/search?q=$query'));

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else if (jsonData is Map<String, dynamic> && jsonData.containsKey('products')) {
          final List<dynamic> productList = jsonData['products'];
          return List<Map<String, dynamic>>.from(productList);
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Error searching products');
    }
  }
}
