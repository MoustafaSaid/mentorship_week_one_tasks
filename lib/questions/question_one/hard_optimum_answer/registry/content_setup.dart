import 'package:flutter/material.dart';
import 'package:mentorship_week_one_tasks/questions/question_one/easy_fast_answer/task_one.dart';
import 'package:mentorship_week_one_tasks/questions/question_one/hard_optimum_answer/models/content_models.dart';
import 'package:mentorship_week_one_tasks/questions/question_one/hard_optimum_answer/registry/content_registry.dart';


/*

now you can use the registry to build content
and add more content types as you need

 */

void setupContentRenderers() {
  ContentRegistry.register<TextContent>(
    (context, model) => Text(model.data),
  );

  ContentRegistry.register<ImageContent>(
    (context, model) => Image.network(model.data),
  );

  ContentRegistry.register<VideoContent>(
    (context, model) => VideoPlayer(data: model.data),
  );
}
