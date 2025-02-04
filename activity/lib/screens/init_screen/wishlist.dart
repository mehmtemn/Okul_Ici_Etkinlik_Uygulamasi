import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity/providers/wishlist_provider.dart';
import 'package:activity/screens/cart/empty_bag.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/products/product_widget.dart';
import 'package:activity/widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = "/WishlistScreen";

  const WishlistScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);

    return wishListProvider.getWishLists.isEmpty
        ? Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                title: const TitleTextWidget(label: "Favoriler")),
            body: EmptyBagWidget(
                imagePath: AssetsManager.kalp2,
                title: "Favori Etkinlikleriniz Boş",
                subtitle: "Etkinlikler de Gezinmeni tavsiye ederim",
                buttonText: "Hadi Başlayalım"))
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                title: TitleTextWidget(
                    label: "Wishlist ${wishListProvider.getWishLists.length}")),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: wishListProvider.getWishLists.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: wishListProvider.getWishLists.length,
              crossAxisCount: 2,
            ));
  }
}
