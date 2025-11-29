// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  id: json['id'] as String,
  name: json['name'] as String,
  title: json['title'] as String,
  fraction: json['fraction'] as String?,
  quote: json['quote'] as String?,
  quoteAuthor: json['quote-author'] as String?,
  images: Images.fromJson(json['images'] as Map<String, dynamic>),
  biography: json['biography'] == null
      ? null
      : Biography.fromJson(json['biography'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'title': instance.title,
  'fraction': instance.fraction,
  'quote': instance.quote,
  'quote-author': instance.quoteAuthor,
  'images': instance.images,
  'biography': instance.biography,
};

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
  splash: json['splash'] as String?,
  loading: json['loading'] as String,
  square: json['square'] as String?,
);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'splash': instance.splash,
  'loading': instance.loading,
  'square': instance.square,
};

Biography _$BiographyFromJson(Map<String, dynamic> json) => Biography(
  short: json['short'] as String?,
  full: json['full'] as String?,
  custom: json['custom'] == null
      ? null
      : CustomBiography.fromJson(json['custom'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BiographyToJson(Biography instance) => <String, dynamic>{
  'short': instance.short,
  'full': instance.full,
  'custom': instance.custom,
};

CustomBiography _$CustomBiographyFromJson(Map<String, dynamic> json) =>
    CustomBiography(
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$CustomBiographyToJson(CustomBiography instance) =>
    <String, dynamic>{'title': instance.title, 'content': instance.content};
