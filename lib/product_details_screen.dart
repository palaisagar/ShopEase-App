import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'cart_screen.dart'; // Import the CartScreen

class ProductDetailsScreen extends StatefulWidget {
  final String shopName;

  const ProductDetailsScreen({super.key, required this.shopName});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _scanBarcode = 'Unknown';
  String _manualBarcode = '';
  int _productCount = 0;
  Map<String, dynamic> _productDetails = {};
  MobileScannerController? _scannerController;
  bool _isScanning = true; // Track the scanning state

  // Simple cart implementation within this screen's state for now
  final Map<String, CartItem> _cartItems = {};

  // Sample product data (replace with your actual data source later)
  final Map<String, Map<String, String>> _products = {
    '11111': {
      'name': 'Awesome T-Shirt',
      'description': 'A comfortable and stylish t-shirt made of premium cotton.',
      'price': '₹499',
    },
    '22222': {
      'name': 'Cool Coffee Mug',
      'description': 'A ceramic mug perfect for your morning coffee or tea.',
      'price': '₹299',
    },
    '33333': {
      'name': 'Stylish Backpack',
      'description': 'A durable and spacious backpack for everyday use.',
      'price': '₹999',
    },
    '44444': {
      'name': 'Wireless Headphones',
      'description': 'High-quality wireless headphones with noise cancellation.',
      'price': '₹1999',
    },
    '55555': {
      'name': 'Chocolate Bar',
      'description': 'A delicious milk chocolate bar.',
      'price': '₹99',
    },
  };

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  void _updateProductDetails(String barcode) {
    if (_products.containsKey(barcode)) {
      setState(() {
        _productDetails = _products[barcode]!;
        _productCount = 1; // Reset count when product details are found
      });
    } else {
      setState(() {
        _productDetails = {};
        _productCount = 0;
      });
    }
  }

  void _incrementCount() {
    setState(() {
      _productCount++;
    });
  }

  void _decrementCount() {
    if (_productCount > 0) {
      setState(() {
        _productCount--;
      });
    }
  }

  void _addToCart() {
    if (_productDetails.isNotEmpty && _productCount > 0) {
      final productName = _productDetails['name'] as String;
      if (_cartItems.containsKey(productName)) {
        _cartItems[productName]!.quantity += _productCount;
      } else {
        _cartItems[productName] = CartItem(name: productName, quantity: _productCount);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added $_productCount x $productName to cart.')),
      );
      // Optionally reset the product details and count after adding to cart
      setState(() {
        _productDetails = {};
        _productCount = 0;
        _scanBarcode = 'Unknown';
        _manualBarcode = '';
      });
    } else if (_productDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please scan or enter a barcode first.')),
      );
    } else if (_productCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a quantity to add to cart.')),
      );
    }
  }

void _navigateToCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: _cartItems,
          products: _products, // Pass the products data here
          onAddMoreItems: () {
            Navigator.pop(context); // Go back to the product details screen
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details - ${widget.shopName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _navigateToCartScreen,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 200, // Adjust height as needed
              width: double.infinity,
              child: MobileScanner(
                controller: _scannerController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final barcode = barcodes.first.rawValue;
                    if (barcode != null) {
                      setState(() {
                        _scanBarcode = barcode;
                        _manualBarcode = barcode;
                        _updateProductDetails(barcode);
                      });
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isScanning = !_isScanning;
                  if (_isScanning) {
                    _scannerController?.start();
                  } else {
                    _scannerController?.stop();
                  }
                });
              },
              child: Text(_isScanning ? 'Stop Scan' : 'Start Scan'),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Manual Barcode Entry',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _manualBarcode = value;
                  _updateProductDetails(value);
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Scan Result: $_scanBarcode', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (_productDetails.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product: ${_productDetails['name']}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text('Price: ${_productDetails['price']}',
                      style: const TextStyle(fontSize: 16, color: Colors.green)),
                  const SizedBox(height: 10),
                  Text('Description: ${_productDetails['description']}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementCount,
                      ),
                      Text('$_productCount', style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementCount,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addToCart,
                    child: const Text('Add to Cart'),
                  ),
                ],
              )
            else if (_manualBarcode.isNotEmpty || _scanBarcode != 'Unknown')
              const Text('Product not found.',
                  style: TextStyle(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }
}