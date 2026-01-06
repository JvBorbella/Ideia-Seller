import 'package:flutter/material.dart';
import 'package:project/Front/style/style.dart';
import 'package:project/front/components/texts/text_card.dart';

class GoalItemWidget extends StatelessWidget {
  final String title;
  final num target;
  final num value;
  final BuildContext context;

  const GoalItemWidget({
    super.key,
    required this.title,
    required this.target,
    required this.value,
    required this.context,
  });

  @override
  Widget build(BuildContext _) {
    final bool reached = value >= target;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextCard(
              text: title,
              fontSize: Style.height_8(context),
              color: Style.quarantineColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCard(
              text: target.toString(),
              fontSize: Style.height_12(context),
              FontWeight: FontWeight.bold,
            ),
            Icon(
              Icons.check_circle,
              color: reached
                  ? Style.sucefullColor
                  : Style.tertiaryColor,
              size: Style.height_12(context),
            ),
          ],
        ),
      ],
    );
  }
}
