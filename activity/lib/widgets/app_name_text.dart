import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:activity/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize = 30});

  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 22),
      baseColor: Colors.redAccent,
      highlightColor: Colors.orange,
      child: TitleTextWidget(
        label: "Etkinlik App",
        fontSize: fontSize,
      ),
    );
  }
}
