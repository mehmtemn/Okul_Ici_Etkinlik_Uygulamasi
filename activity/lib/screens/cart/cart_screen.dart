import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/screens/cart/bottom_checkout.dart';
import 'package:activity/screens/cart/cart_widget.dart';
import 'package:activity/screens/cart/empty_bag.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath:
                    isDarkMode ? AssetsManager.cart10 : AssetsManager.cart11,
                title: "Etkinlik Sayfan Boş",
                subtitle: "Etkinliklere Göz Atmalısın",
                buttonText: "Etkinliklere göz atmalısın"))
        : Scaffold(
            bottomSheet: CartBottomSheetWidget(),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              title: TitleTextWidget(
                  label: "Cart (${cartProvider.getCartItems.length})"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      cartProvider.clearLocalCart();
                    },
                    icon: const Icon(Icons.delete_forever_rounded,
                        color: Colors.red))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: cartProvider.getCartItems.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItems.values
                                .toList()[index],
                            child: const CardWidget(),
                          );
                        }))
              ],
            ));
  }
}
