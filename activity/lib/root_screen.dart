// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/screens/cart/cart_screen.dart';
import 'package:activity/screens/chat/chat_screen.dart';
import 'package:activity/screens/etkinlik_ols_screen.dart';
import 'package:activity/screens/home_screen.dart';
import 'package:activity/screens/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      ChatScreen(),
      EtkinlikOlusScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.home),
            icon: Icon(CupertinoIcons.home),
            label: "Anasayfa",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.chat_bubble),
            icon: Icon(CupertinoIcons.chat_bubble),
            label: "Mesaj",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.add_circled),
            icon: Icon(CupertinoIcons.add_circled),
            label: "Etkinlik",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.cart),
            icon: Badge(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: Text(cartProvider.getCartItems.length.toString()),
              child: Icon(CupertinoIcons.cart),
            ),
            label: "Sepet",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person),
            icon: Icon(CupertinoIcons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
