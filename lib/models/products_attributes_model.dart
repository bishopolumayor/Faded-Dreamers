class ProductAttributesModel {
  final int id;
  final String name;
  final String slug;
  final int position;
  final bool visible;
  final bool variation;
  final List<String> options;

  ProductAttributesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory ProductAttributesModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributesModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      position: json['position'],
      visible: json['visible'],
      variation: json['variation'],
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'position': position,
      'visible': visible,
      'variation': variation,
      'options': options,
    };
  }

}
