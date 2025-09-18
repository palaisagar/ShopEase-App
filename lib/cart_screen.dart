import 'package:flutter/material.dart';
import 'checkout_screen.dart'; // Import the CheckoutScreen

class CartScreen extends StatefulWidget {
  // Pass the cart items and the product data
  final Map<String, CartItem> cartItems;
  final Map<String, Map<String, String>> products;
  final VoidCallback onAddMoreItems;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.products,
    required this.onAddMoreItems,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get _totalPrice {
    double total = 0;
    widget.cartItems.forEach((key, item) {
      final product = widget.products.values.firstWhere(
        (prod) => prod['name'] == item.name,
        orElse: () => {},
      );
      final price = product['price'];
      if (price != null && price.startsWith('₹')) {
        final numericPrice = double.tryParse(price.substring(1)) ?? 0.0;
        total += numericPrice * item.quantity;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.', style: TextStyle(fontSize: 18)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItemId = widget.cartItems.keys.toList()[index];
                      final cartItem = widget.cartItems[cartItemId]!;
                      final product = widget.products.values.firstWhere(
                        (prod) => prod['name'] == cartItem.name,
                        orElse: () => {},
                      );
                      final price = product['price'] ?? '₹0.00';

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.name, style: const TextStyle(fontSize: 16)),
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text('Qty: ${cartItem.quantity}', style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: ₹${_totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: widget.onAddMoreItems,
                              child: const Text('Add More Items'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      totalAmount: _totalPrice,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Checkout'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// Simple data class to represent an item in the cart
class CartItem {
  final String name;
  int quantity;

  CartItem({required this.name, this.quantity = 1});
}