import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  final String id;
  final String name;
  final String title;
  
  final String? fraction;
  final String? quote;
  
  @JsonKey(name: 'quote-author')
  final String? quoteAuthor;

  final Images images;
  final Biography? biography;

  Content({
    required this.id,
    required this.name,
    required this.title,
    this.fraction,
    this.quote,
    this.quoteAuthor,
    required this.images,
    this.biography,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Images {
  final String? splash;
  final String loading;
  final String? square;

  Images({
    this.splash,
    required this.loading,
    this.square
    });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class Biography {
  final String? short;
  final String? full;
  final CustomBiography? custom;

  Biography({
    this.short,
    this.full,
    this.custom,
  });

  factory Biography.fromJson(Map<String, dynamic> json) =>
      _$BiographyFromJson(json);
  Map<String, dynamic> toJson() => _$BiographyToJson(this);
}

@JsonSerializable()
class CustomBiography {
  final String? title;
  final String? content;

  CustomBiography({
    this.title,
    this.content
  });

  factory CustomBiography.fromJson(Map<String, dynamic> json) =>
      _$CustomBiographyFromJson(json);
  Map<String, dynamic> toJson() => _$CustomBiographyToJson(this);
}