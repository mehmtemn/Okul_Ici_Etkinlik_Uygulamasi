import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/subtitle.dart';
import 'package:activity/widgets/title_text.dart';

// Model sınıfı etkinlikleri temsil eder
class Event {
  final String imagePath;
  final String title;
  final String price;
  final int quantity;

  Event({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class OrdersWidgetFree extends StatefulWidget {
  final List<Event> events;
  final void Function(Event) onRemove;

  const OrdersWidgetFree({
    super.key,
    required this.events,
    required this.onRemove,
  });

  @override
  _OrdersWidgetFreeState createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final event = widget.events[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  event.imagePath,
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TitleTextWidget(
                              label: event.title,
                              fontSize: 15,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.onRemove(event);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TitleTextWidget(label: "Price"),
                          const SizedBox(width: 15),
                          Flexible(
                            child: SubTitleTextWidget(label: event.price),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      SubTitleTextWidget(
                        label: "Qty: ${event.quantity}",
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
