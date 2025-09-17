

/*
now the data is seprated and no violation 
either for Single Responsibility Principle
nor Open-Closed Principle
 */

abstract class ContentModel {
  final String data;
  const ContentModel(this.data);
}

class TextContent extends ContentModel {
  const TextContent(super.data);
}

class ImageContent extends ContentModel {
  const ImageContent(super.data);
}

class VideoContent extends ContentModel {
  const VideoContent(super.data);
}
