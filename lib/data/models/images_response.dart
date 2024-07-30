class ImagesResponse {
  int? id;
  String? title;
  String? description;
  String? imagePath;
  String? type;
  String? imageFileName;

  ImagesResponse(
      {this.id,
      this.title,
      this.description,
      this.imagePath,
      this.type,
      this.imageFileName});

  ImagesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imagePath = json['imagePath'];
    type = json['type'];
    imageFileName = json['imageFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imagePath'] = this.imagePath;
    data['type'] = this.type;
    data['imageFileName'] = this.imageFileName;
    return data;
  }
}
