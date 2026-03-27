import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CatalogScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  Product({required this.name, required this.price, required this.imageUrl});
}

final List<Product> products = [
  Product(
    name: 'Laptop',
    price: 999.99,
    imageUrl: 'https://picsum.photos/id/0/200/150',
  ),
  Product(
    name: 'Smartphone',
    price: 599.99,
    imageUrl: 'https://picsum.photos/id/1/200/150',
  ),
  Product(
    name: 'Headphones',
    price: 199.99,
    imageUrl: 'https://picsum.photos/id/2/200/150',
  ),
  Product(
    name: 'Keyboard',
    price: 89.99,
    imageUrl: 'https://picsum.photos/id/3/200/150',
  ),
  Product(
    name: 'Mouse',
    price: 39.99,
    imageUrl: 'https://picsum.photos/id/4/200/150',
  ),
  Product(
    name: 'Monitor',
    price: 299.99,
    imageUrl: 'https://picsum.photos/id/5/200/150',
  ),
];

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Catalog')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 0.7, // makes the cards rectangular (taller)
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length, // 6 items -> 3 rows
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductCard(product: product);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(product.name),
              content: Text('Price: \$${product.price.toStringAsFixed(2)}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Product name and price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
