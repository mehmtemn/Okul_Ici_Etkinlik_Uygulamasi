// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity/models/cart_model.dart';
import 'package:activity/providers/cart_provider.dart';
import 'package:activity/widgets/subtitle.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key, required this.cartModel});

  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      cartProvider.updateQty(
                          productId: cartModel.productId, qty: index + 1);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SubTitleTextWidget(label: "${index + 1}"),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
