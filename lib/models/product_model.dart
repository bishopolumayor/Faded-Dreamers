import 'package:faded_dreamers/models/product_images_model.dart';
import 'package:faded_dreamers/models/products_attributes_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

class ProductModel {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String type;
  final String status;
  final bool featured;
  final String catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final bool purchasable;
  final int totalSales;
  final bool virtual;
  final bool downloadable;
  final String taxStatus;
  final bool manageStock;
  final int stockQuantity;
  final bool backordersAllowed;
  final bool backordered;
  final String weight;
  final ProductDimensions dimensions;
  final bool shippingRequired;
  final bool shippingTaxable;
  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final List<int> relatedIds;
  final List<ProductAttributesModel> attributes;
  final List<ProductImagesModel> images;
  final List<ProductCategoryModel> categories;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateModified,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.taxStatus,
    required this.manageStock,
    required this.stockQuantity,
    required this.backordersAllowed,
    required this.backordered,
    required this.weight,
    required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.relatedIds,
    required this.attributes,
    required this.images,
    required this.categories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
      dateCreated: DateTime.parse(json['date_created']),
      dateModified: DateTime.parse(json['date_modified']),
      type: json['type'],
      status: json['status'],
      featured: json['featured'],
      catalogVisibility: json['catalog_visibility'],
      description: _parseHtmlString(json['description']),
      shortDescription: json['short_description'],
      sku: json['sku'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      onSale: json['on_sale'],
      purchasable: json['purchasable'],
      totalSales: json['total_sales'],
      virtual: json['virtual'],
      downloadable: json['downloadable'],
      taxStatus: json['tax_status'],
      manageStock: json['manage_stock'],
      stockQuantity: json['stock_quantity'] ?? 0,
      backordersAllowed: json['backorders_allowed'],
      backordered: json['backordered'],
      weight: json['weight'],
      dimensions: ProductDimensions.fromJson(json['dimensions']),
      shippingRequired: json['shipping_required'],
      shippingTaxable: json['shipping_taxable'],
      reviewsAllowed: json['reviews_allowed'],
      averageRating: json['average_rating'],
      ratingCount: json['rating_count'],
      relatedIds: List<int>.from(json['related_ids']),
      attributes: (json['attributes'] as List)
          .map((item) => ProductAttributesModel.fromJson(item))
          .toList(),
      images: (json['images'] as List)
          .map((item) => ProductImagesModel.fromJson(item))
          .toList(),
      categories: (json['categories'] as List)
          .map((item) => ProductCategoryModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'permalink': permalink,
      'date_created': dateCreated.toIso8601String(),
      'date_modified': dateModified.toIso8601String(),
      'type': type,
      'status': status,
      'featured': featured,
      'catalog_visibility': catalogVisibility,
      'description': description,
      'short_description': shortDescription,
      'sku': sku,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'on_sale': onSale,
      'purchasable': purchasable,
      'total_sales': totalSales,
      'virtual': virtual,
      'downloadable': downloadable,
      'tax_status': taxStatus,
      'manage_stock': manageStock,
      'stock_quantity': stockQuantity,
      'backorders_allowed': backordersAllowed,
      'backordered': backordered,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'shipping_required': shippingRequired,
      'shipping_taxable': shippingTaxable,
      'reviews_allowed': reviewsAllowed,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'related_ids': relatedIds,
      'attributes': attributes.map((item) => item.toJson()).toList(),
      'images': images.map((item) => item.toJson()).toList(),
      'categories': categories.map((item) => item.toJson()).toList(),
    };
  }

  static String _parseHtmlString(String htmlString) {
    var document = html_parser.parse(htmlString);
    return html_parser.parse(document.body?.text ?? "").documentElement?.text ?? "";
  }
}

class ProductDimensions {
  final String length;
  final String width;
  final String height;

  ProductDimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      length: json['length'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'width': width,
      'height': height,
    };
  }
}

class ProductCategoryModel {
  final int id;
  final String name;
  final String slug;

  ProductCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
