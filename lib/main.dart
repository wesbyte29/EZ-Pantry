import 'package:ez_pantry/scan_page.dart';
import 'package:flutter/material.dart';
import 'pantry_page.dart'; // Import the new pantry page
import 'recipes_page.dart'; // Import the new recipes page
import 'shopping_page.dart'; // Import the new shopping page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EZ Pantry'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // 0 for Pantry, 1 for Recipes, 2 for Shopping

  static const List<Widget> _widgetOptions = <Widget>[
    PantryPage(),
    RecipesPage(),
    ShoppingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScanButtonPressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScanPage()),
    );

    if (result != null) {
      // Here you can handle what to do with the scanned code
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scanned barcode: $result')),
      );

      print('Scanned barcode: $result');

      // TODO: Call API or update pantry items with this barcode
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Shopping',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      // Conditionally render the FloatingActionButton
      floatingActionButton: _selectedIndex == 0 // Show only if Pantry tab (index 0) is selected
          ? FloatingActionButton.extended(
        onPressed: _onScanButtonPressed,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Scan'),
      )
          : null, // Render nothing if not on the Pantry tab
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Or your preferred location
    );
  }
}
