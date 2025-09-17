import 'package:flutter/widgets.dart';
import 'package:mentorship_week_one_tasks/questions/question_one/hard_optimum_answer/models/content_models.dart';


/*
let's explain what we're doing here:
to solve the problem of both decide what is the content type and using if statement
and which widget to use to display the content.
insted of using if statement we can use a registry and insted of decide on
compile time we decide on run time.
- we have a registry of content builders
- we register content builders for different content types
- we use the registry to build content

so we solve a lot of problem here and now give more ability for extensibility and flexibility


 */

typedef ContentBuilder<T extends ContentModel> = Widget Function(BuildContext context, T model);

class ContentRegistry {
  static final Map<Type, ContentBuilder> _registry = {};

  static void register<T extends ContentModel>(ContentBuilder<T> builder) {
    _registry[T] = (context, model) => builder(context, model as T);
  }

  static Widget build(BuildContext context, ContentModel model) {
    final builder = _registry[model.runtimeType];
    if (builder != null) {
      return builder(context, model);
    }
    return const SizedBox.shrink(); 
  }
}
