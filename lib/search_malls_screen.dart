import 'package:flutter/material.dart';
import 'shop_details_screen.dart'; // Ensure this import exists

class SearchMallsScreen extends StatefulWidget {
  const SearchMallsScreen({super.key});

  @override
  _SearchMallsScreenState createState() => _SearchMallsScreenState();
}

class _SearchMallsScreenState extends State<SearchMallsScreen> {
  List<Map<String, dynamic>> malls = [
    {
      'name': 'South City Mall',
      'location': 'Prince Anwar Shah Road, Kolkata',
      'shops': ['Pantaloons', 'Shoppers Stop', 'INOX', 'Starbucks'],
    },
    {
      'name': 'Quest Mall',
      'location': 'Syed Amir Ali Avenue, Kolkata',
      'shops': ['Zara', 'H&M', 'Rolex', 'Chai Break'],
    },
    {
      'name': 'Acropolis Mall',
      'location': 'Rajdanga Main Road, Kolkata',
      'shops': ['Reliance Trends', 'PVR', 'KFC', 'Wow! Momo'],
    },
    {
      'name': 'City Centre Salt Lake',
      'location': 'Salt Lake, Kolkata',
      'shops': ['Spencer\'s', 'Adidas', 'Fun Cinemas', 'CCD'],
    },
    {
      'name': 'Mani Square',
      'location': 'EM Bypass, Kolkata',
      'shops': ['Big Bazaar', 'Max', 'Cinemax', 'Barista'],
    },
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String query = searchController.text.toLowerCase();
    final List<Map<String, dynamic>> filteredMalls = malls.where((mall) {
      return mall['name']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Malls')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {}); // Trigger a rebuild to update the filtered list
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMalls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredMalls[index]['name']!),
                  subtitle: Text(filteredMalls[index]['location']!),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/shopDetails',
                      arguments: filteredMalls[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}