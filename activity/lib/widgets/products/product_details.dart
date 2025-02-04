import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/providers/product_provider.dart';
import 'package:activity/providers/wishlist_provider.dart';
import 'package:activity/widgets/app_name_text.dart';
import 'package:activity/widgets/products/heart_btn.dart';
import 'package:activity/widgets/subtitle.dart';
import 'package:activity/widgets/title_text.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "/ProductDetailScreen";

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    // final wishlistProvider =
    Provider.of<WishlistProvider>(context); // Yeni eklendi
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrProduct = productsProvider.findByProId(productId!);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    //FancyShimmerImage
                    getCurrProduct.image,
                    height: size.height * 0.35,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getCurrProduct.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TitleTextWidget(
                              label: "Tarih",
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 10),
                            SubTitleTextWidget(label: getCurrProduct.date),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TitleTextWidget(
                              label: "Saat:",
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 10),
                            SubTitleTextWidget(label: getCurrProduct.date),
                          ],
                        ),
                        Row(
                          children: [
                            TitleTextWidget(
                              label: "Açıklama:",
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 10),
                            SubTitleTextWidget(
                              label: getCurrProduct.description ??
                                  "Açıklama mevcut değil",
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeartButtonWidget(
                              productId: getCurrProduct.id.toString(),
                              bkgColor: Colors.transparent,
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (cartProvider.isProdinCart(
                                    productId: getCurrProduct.id.toString())) {
                                  return;
                                }
                                cartProvider.addProductCart(
                                    productId: getCurrProduct.id.toString());
                              },
                              icon: Icon(
                                cartProvider.isProdinCart(
                                        productId: getCurrProduct.id.toString())
                                    ? Icons.check
                                    : Icons.add_shopping_cart_outlined,
                              ),
                              label: Text(
                                cartProvider.isProdinCart(
                                        productId: getCurrProduct.id.toString())
                                    ? "In cart"
                                    : "Add to cart",
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
