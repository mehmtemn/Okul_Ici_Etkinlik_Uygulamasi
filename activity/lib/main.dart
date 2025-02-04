// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity/constans/theme_data.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/providers/product_provider.dart';
import 'package:activity/providers/theme_provider.dart';
import 'package:activity/providers/wishlist_provider.dart';
import 'package:activity/root_screen.dart';
import 'package:activity/screens/init_screen/wishlist.dart';
import 'package:activity/screens/login.dart';
import 'package:activity/screens/spalash_screen.dart';
import 'package:activity/widgets/order/order_screen.dart';
import 'package:activity/widgets/products/product_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return CartProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return WishlistProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Etkinlik App ',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),

          //    home:const LoginScreen(),
          //home: SplashScreen(),
          //home:const LoginScreen(),
          home: const RootScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            OrderScreen.routName: (context) => const OrderScreen(),
          },
        );
      }),
    );
  }
}
