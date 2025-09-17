import 'package:flutter/material.dart';
import 'package:mentorship_week_one_tasks/questions/question_one/hard_optimum_answer/models/content_models.dart';
import '../registry/content_registry.dart';

class ContentDisplay extends StatelessWidget {
  final List<ContentModel> items;
  const ContentDisplay(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => ContentRegistry.build(context, item)).toList(),
    );
  }
}
