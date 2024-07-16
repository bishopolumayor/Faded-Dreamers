class ProductImagesModel {
  final int id;
  final String src;
  final String name;
  final String alt;

  ProductImagesModel({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImagesModel.fromJson(Map<String, dynamic> json) {
    return ProductImagesModel(
      id: json['id'],
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
      'name': name,
      'alt': alt,
    };
  }

}
