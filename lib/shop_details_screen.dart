// lib/shop_details_screen.dart
import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> mall;

  const ShopDetailsScreen({super.key, required this.mall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mall['name']),
      ),
      body: ListView.builder(
        itemCount: (mall['shops'] as List).length,
        itemBuilder: (context, index) {
          final shopName = (mall['shops'] as List)[index];
          String shopDescription = ''; // Default description
          String shopImage = ''; // Default image

          // Sample data for shops (you'll likely replace this with a database or API)
          if (mall['name'] == 'South City Mall') {
            if (shopName == 'Pantaloons') {
              shopDescription = 'Apparel and accessories';
              shopImage =
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ46SNqhJWrI2Ns15yo3iyB9njA8AbyuIAPew&';
            } else if (shopName == 'Shoppers Stop') {
              shopDescription = 'Department store';
              shopImage =
                  'https://www.chittorgarh.net/images/ipo/shoppers-stop-rights-issue.jpg';
            } else if (shopName == 'INOX') {
              shopDescription = 'Movie theater';
              shopImage =
                  'data:image/png;base64,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';
            } else if (shopName == 'Starbucks') {
              shopDescription = 'Coffee shop';
              shopImage =
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5QgoP_chL5EYZVF1MkQ_UNEj1CFpebDow_w&s';
            }
          } else if (mall['name'] == 'Quest Mall') {
            if (shopName == 'Zara') {
              shopDescription = 'Fashion apparel';
              shopImage =
                  'https://brandlogos.net/wp-content/uploads/2022/04/zara-logo-brandlogos.net_.png';
            } else if (shopName == 'H&M') {
              shopDescription = 'Clothing and accessories';
              shopImage =
                  'https://brandslogos.com/wp-content/uploads/images/large/hm-logo-black-and-white-1.png';
            } else if (shopName == 'Rolex') {
              shopDescription = 'Luxury watches';
              shopImage =
                  'https://images.seeklogo.com/logo-png/29/2/rolex-logo-png_seeklogo-291388.png';
            } else if (shopName == 'Chai Break') {
              shopDescription = 'Cafe and snacks';
              shopImage =
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQydq8D9X_H6ZtSsvZb5EY1CI8wD_oeydZD6w&s';
            }
          }
          // Add similar logic for other malls and shops...

          return ListTile(
              leading: shopImage.isNotEmpty
                  ? Image.network(shopImage, width: 50, height: 50)
                  : null, // Display image if available
              title: Text(shopName),
              subtitle: Text(shopDescription),
              onTap: () {
                Navigator.pushNamed(context, '/productDetails',
                    arguments: shopName);
              });
        },
      ),
    );
  }
}
