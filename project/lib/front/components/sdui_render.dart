import 'package:flutter/material.dart';
import 'package:project/back/objectives.dart';

class SDUIRenderer {
  static Widget render({
    required Map<String, dynamic> json,
    required Map<String, num> data,
    required BuildContext context,
  }) {
    switch (json['type']) {
      case 'goal_card':
        return Column(
          children: (json['items'] as List)
              .map(
                (item) => GoalItemWidget(
                  title: item['title'],
                  target: item['target'],
                  value: data[item['valueKey']] ?? 0,
                  context: context,
                ),
              )
              .toList(),
        );
      default:
        return const SizedBox();
    }
  }
}
