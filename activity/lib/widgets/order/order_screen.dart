import 'package:flutter/material.dart';
import 'package:activity/screens/cart/empty_bag.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/order/order_widget.dart';
import 'package:activity/widgets/title_text.dart';

class OrderScreen extends StatefulWidget {
  static const routName = "/OrderScreen";

  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Event> events = [
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
    Event(
      imagePath: AssetsManager.gezi,
      title: "Gezi",
      price: "\$11.00",
      quantity: 20,
    ),
  ];

  bool get isEmptyOrders => events.isEmpty;

  void _removeEvent(Event event) {
    setState(() {
      events.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
        title: const TitleTextWidget(label: "Tüm Etkinliklerim"),
      ),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath:
                  isDarkMode ? AssetsManager.tiket : AssetsManager.tiket2,
              title: "Hiç katıldığın etkinlik yok",
              subtitle: " ",
              buttonText: "Hadi Etkinliklere",
            )
          : OrdersWidgetFree(
              events: events,
              onRemove: _removeEvent,
            ),
    );
  }
}
