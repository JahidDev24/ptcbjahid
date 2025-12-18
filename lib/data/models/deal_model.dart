import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deal_model.g.dart';

@JsonSerializable()
class DealResponse {
  @JsonKey(name: 'seo_settings')
  final SeoSettings? seoSettings;

  @JsonKey(name: 'deals')
  final List<DealData>? deals;

  DealResponse({this.seoSettings, this.deals});

  factory DealResponse.fromJson(Map<String, dynamic> json) =>
      _$DealResponseFromJson(json);
}

@JsonSerializable()
class SeoSettings {
  @JsonKey(name: 'seo_title')
  final String? seoTitle;
  @JsonKey(name: 'web_url')
  final String? webUrl;

  SeoSettings({this.seoTitle, this.webUrl});

  factory SeoSettings.fromJson(Map<String, dynamic> json) =>
      _$SeoSettingsFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 0) // Unique ID for Hive
class DealData extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  @JsonKey(name: 'comments_count')
  final int? commentsCount;

  @HiveField(2)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @HiveField(3)
  @JsonKey(name: 'created_at_in_millis')
  final int? createdAtInMillis;

  @HiveField(4)
  @JsonKey(name: 'image_medium')
  final String? imageMedium;

  @HiveField(5)
  final String? title; // Note: Not in JSON, handled manually or nullable

  // We flatten the nested "store: {name: ...}" object into a single string
  // This makes it much easier to save in Hive.
  @HiveField(6)
  final String? storeName;

  DealData({
    this.id,
    this.commentsCount,
    this.createdAt,
    this.createdAtInMillis,
    this.imageMedium,
    this.title,
    this.storeName,
  });

  // Custom JSON parsing to handle the nested "Store" object
  factory DealData.fromJson(Map<String, dynamic> json) {
    // 1. Extract Store Name safely
    String? parsedStoreName;
    if (json['store'] is Map) {
      parsedStoreName = json['store']['name'];
    }

    // 2. Return the object
    return DealData(
      id: json['id'] as int?,
      commentsCount: json['comments_count'] as int?,
      createdAt: json['created_at'] as String?,
      createdAtInMillis: json['created_at_in_millis'] as int?,
      imageMedium: json['image_medium'] as String?,
      title: json['title'] as String?, // Might be null based on API
      storeName: parsedStoreName, // The flattened string
    );
  }
}

@JsonSerializable()
class Store {
  final String? name;
  Store({this.name});
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}
