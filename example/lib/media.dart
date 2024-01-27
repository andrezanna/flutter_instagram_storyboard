
class Media {
  String? id;
  String? name;
  String? file_name;
  String? url;
  String? thumb;
  String? wide_thumb;
  String? icon;
  String? size;
  String? mime_type;
  String? collection;
  bool isVideo=false;

  Media() {

    mime_type="image/png";
    collection='unknown';
  }

  Media.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      file_name=jsonMap['file_name'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      wide_thumb = jsonMap['wide_thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formated_size'];
      mime_type=jsonMap['mime_type'];
      isVideo=mime_type?.startsWith("video")??false;
      collection=jsonMap['collection_name'];
    } catch (e,stack) {
      print(e);
      print(stack);

      mime_type="image/png";
      collection='unknown';
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["wide_thumb"] = wide_thumb;
    map["icon"] = icon;
    map["formated_size"] = size;
    return map;
  }

  bool isDefault(){
    return false;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
