import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _upiIdController = TextEditingController();

  @override
  void dispose() {
    _upiIdController.dispose();
    super.dispose();
  }

  void _payWithGPay() {
    // In a real application, you would integrate with Google Pay here
    print('Initiating payment with Google Pay for ₹${widget.totalAmount.toStringAsFixed(2)}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paying ₹${widget.totalAmount.toStringAsFixed(2)} with Google Pay (Simulated)')),
    );
    // You would likely navigate to a payment status screen here
  }

  void _payWithPhonePe() {
    // In a real application, you would integrate with PhonePe here
    print('Initiating payment with PhonePe for ₹${widget.totalAmount.toStringAsFixed(2)}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paying ₹${widget.totalAmount.toStringAsFixed(2)} with PhonePe (Simulated)')),
    );
    // You would likely navigate to a payment status screen here
  }

  void _payWithCustomUpi() {
    final upiId = _upiIdController.text.trim();
    if (upiId.isNotEmpty) {
      // In a real application, you would use this UPI ID to initiate payment
      print('Initiating payment with UPI ID: $upiId for ₹${widget.totalAmount.toStringAsFixed(2)}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paying ₹${widget.totalAmount.toStringAsFixed(2)} with UPI ID: $upiId (Simulated)')),
      );
      // You would likely navigate to a payment status screen here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your UPI ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Total Amount:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '₹${widget.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _payWithGPay,
              icon: const Icon(Icons.g_mobiledata), // You might want to use a specific GPay icon
              label: const Text('Pay with GPay'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _payWithPhonePe,
              icon: const Icon(Icons.phone_android), // You might want to use a specific PhonePe icon
              label: const Text('Pay with PhonePe'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Or pay with your UPI ID:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _upiIdController,
              decoration: const InputDecoration(
                labelText: 'Enter your UPI ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _payWithCustomUpi,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Pay with UPI ID'),
            ),
            const SizedBox(height: 20),
            const Text(
              '(This is a simplified UI. Real payment integration would require using payment gateway SDKs.)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}