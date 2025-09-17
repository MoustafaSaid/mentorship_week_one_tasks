import 'package:flutter/material.dart';

//Bad code

class ContentItem {
  String type; // e.g., "text", "image"
  String data;
  ContentItem(this.type, this.data);
  Widget build(BuildContext context) {
    if (type == 'text') {
      return Text(data);
    } else if (type == 'image') {
      return Image.network(data);
    }
    return Container();
  }
}

class ContentDisplay extends StatelessWidget {
  final List<ContentItem> items;
  const ContentDisplay(this.items, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => item.build(context)).toList(),
    );
  }
}

//since our answer is c ignoring open closed principle
//explaination

/*
my answer is c and why i know that this code is violated
 alot of solid prenciples but depending on the question
  the relation between the current code and the desiable
   extisibilty solving open close principle
   is the most need since we can say that this code is
    exist for one peropse even it make both model and
     ui but it is not ergent like open colse principle
*/

/*

//good code



in my answer i tried the fast solution and i got this code
make abtract class and make it extensible
so it now can be extensible and not violated the open close principle
but the optimization is not the best
i still need to separate the model and ui
and there is no need to know the type of the content it shoud be automaticly 
be known in the run time without need the if statment
 */

abstract class ContentType {
  String data;
  ContentType(this.data);
  Widget build(BuildContext context);
}

class ContentItemText extends ContentType {
  ContentItemText(super.data);
  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}

class ContentItemImage extends ContentType {
  ContentItemImage(super.data);
  @override
  Widget build(BuildContext context) {
    return Image.network(data);
  }
}

class ContentitemVideo extends ContentType {
  ContentitemVideo(super.data);
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(
      data: data,
    );
  }
}

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text("assume video player for $data");
  }
}

class ContentDisplayFixed extends StatelessWidget {
  final List<ContentType> items;
  const ContentDisplayFixed(this.items, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => item.build(context)).toList(),
    );
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<ContentType> items =
        List<ContentType>.generate(10, (index) => ContentItemText('hello'));
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ContentDisplayFixed(items),
        ),
      ),
    );
  }
}
