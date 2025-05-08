import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bottle.dart';
import '../providers/cart_provider.dart';

class BottleDetailScreen extends StatefulWidget {
  final Bottle bottle;

  const BottleDetailScreen({super.key, required this.bottle});

  @override
  State<BottleDetailScreen> createState() => _BottleDetailScreenState();
}

class _BottleDetailScreenState extends State<BottleDetailScreen> {
  late String selectedSize;

  final List<String> sizeOptions = ['500ml',  '1L', '1.5L', '2L'];

  @override
  void initState() {
    super.initState();
    selectedSize = widget.bottle.volume; // default selection
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.bottle.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.bottle.imagePath,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.bottle.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(widget.bottle.brand, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),

            const Text('Select Size:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: sizeOptions.map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (_) {
                    setState(() => selectedSize = size);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            Text(
              'Price: \$${widget.bottle.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                onPressed: () {
                  cartProvider.addToCart(widget.bottle);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
