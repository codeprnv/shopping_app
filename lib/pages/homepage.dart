import 'package:flutter/material.dart';
import 'package:shopping_practice_app/pages/cart_page.dart';
import 'package:shopping_practice_app/widgets/product_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPage = 0;
  List<Widget> pages = const [ProductList(), CartPage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        iconSize: 30,
        unselectedFontSize: 0,
        backgroundColor: Theme.of(context).bottomAppBarTheme.shadowColor,
        currentIndex: currentPage,
        onTap: (value) {
          setState(
            () {
              currentPage = value;
            },
          );
        },
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).bottomAppBarTheme.color,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
