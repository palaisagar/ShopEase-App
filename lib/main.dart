import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search_malls_screen.dart';
import 'shop_details_screen.dart'; // Ensure this import exists
import 'product_details_screen.dart'; // Import the product details screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasAcceptedTerms = prefs.getBool('hasAcceptedTerms') ?? false;

  runApp(MyApp(hasAcceptedTerms: hasAcceptedTerms));
}

class MyApp extends StatelessWidget {
  final bool hasAcceptedTerms;

  const MyApp({super.key, required this.hasAcceptedTerms});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          hasAcceptedTerms ? const SearchMallsScreen() : const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/shopDetails': (context) => ShopDetailsScreen(
              mall: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/productDetails': (context) => ProductDetailsScreen(
              shopName: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _termsAccepted = false;

  Future<void> _acceptTerms() async {
    if (_termsAccepted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasAcceptedTerms', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchMallsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please accept the terms and conditions.')),
      );
    }
  }

  void _toggleTerms(bool? value) {
    setState(() {
      _termsAccepted = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Replace with your actual image path
              Image.asset('assets/logo.png',
                  height: 150), // Make sure you have this asset
              const SizedBox(height: 30),
              const Text(
                'Welcome to ShopEase',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore the best shopping options around you',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                "By continuing, you agree to our Terms and Conditions. Already have an account? Log in. ShopEase offers a seamless shopping experience with a wide range of products and exclusive deals.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('I agree to the Terms and Conditions'),
                value: _termsAccepted,
                onChanged: _toggleTerms,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _acceptTerms,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
