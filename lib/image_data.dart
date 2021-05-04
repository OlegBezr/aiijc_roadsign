class ImageData {
  String name;
  String apiKey;
  String url;

  ImageData(this.name, this.apiKey, this.url);

  factory ImageData.fromJson(Map<String, dynamic> json) {
    var name = json['img_name'];
    var apiKey = json['api_key'];
    var url = json['img_link'];

    return ImageData(name, apiKey, url);
  }
}

class SubmissionImageData {
  String name;
  String apiKey;
  String className;
  bool save;

  SubmissionImageData(this.name, this.apiKey, this.className, this.save);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['img_name'] = name;
    json['api_key'] = apiKey;
    json['status'] = save? 'save' : 'delete';
    json['class'] = className;

    return json;
  }
}