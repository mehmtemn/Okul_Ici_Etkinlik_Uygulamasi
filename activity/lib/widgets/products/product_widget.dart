// ignore_for_file: unused_import

import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/providers/product_provider.dart';
import 'package:activity/widgets/products/heart_btn.dart';
import 'package:activity/widgets/products/product_details.dart';
import 'package:activity/widgets/subtitle.dart';
import 'package:activity/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productsProvider.findByProId(widget.productId);

    return getCurrProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                    context, ProductDetailScreen.routeName,
                    arguments: getCurrProduct.id.toString());
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      getCurrProduct.image,
                      height: size.height * 0.2,
                      width: size.height * 0.2,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 5,
                            child: TitleTextWidget(
                              label: getCurrProduct.name,
                              fontSize: 18,
                            )),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                              productId: getCurrProduct.id.toString()),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: SubTitleTextWidget(
                              label: getCurrProduct.price.toString(),
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            )),
                        Flexible(
                            child: Material(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white70,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              if (cartProvider.isProdinCart(
                                  productId: getCurrProduct.id.toString())) {
                                return;
                              }
                              cartProvider.addProductCart(
                                  productId: getCurrProduct.id.toString());
                            },
                            splashColor: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(cartProvider.isProdinCart(
                                      productId: getCurrProduct.id.toString())
                                  ? Icons.check
                                  : Icons.shopping_cart),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  )
                ],
              ),
            ),
          );
  }
}
