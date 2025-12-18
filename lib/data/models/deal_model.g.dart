// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealDataAdapter extends TypeAdapter<DealData> {
  @override
  final int typeId = 0;

  @override
  DealData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DealData(
      id: fields[0] as int?,
      commentsCount: fields[1] as int?,
      createdAt: fields[2] as String?,
      createdAtInMillis: fields[3] as int?,
      imageMedium: fields[4] as String?,
      title: fields[5] as String?,
      storeName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DealData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentsCount)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.createdAtInMillis)
      ..writeByte(4)
      ..write(obj.imageMedium)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.storeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealResponse _$DealResponseFromJson(Map<String, dynamic> json) => DealResponse(
  seoSettings:
      json['seo_settings'] == null
          ? null
          : SeoSettings.fromJson(json['seo_settings'] as Map<String, dynamic>),
  deals:
      (json['deals'] as List<dynamic>?)
          ?.map((e) => DealData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DealResponseToJson(DealResponse instance) =>
    <String, dynamic>{
      'seo_settings': instance.seoSettings,
      'deals': instance.deals,
    };

SeoSettings _$SeoSettingsFromJson(Map<String, dynamic> json) => SeoSettings(
  seoTitle: json['seo_title'] as String?,
  webUrl: json['web_url'] as String?,
);

Map<String, dynamic> _$SeoSettingsToJson(SeoSettings instance) =>
    <String, dynamic>{
      'seo_title': instance.seoTitle,
      'web_url': instance.webUrl,
    };

DealData _$DealDataFromJson(Map<String, dynamic> json) => DealData(
  id: (json['id'] as num?)?.toInt(),
  commentsCount: (json['comments_count'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  createdAtInMillis: (json['created_at_in_millis'] as num?)?.toInt(),
  imageMedium: json['image_medium'] as String?,
  title: json['title'] as String?,
  storeName: json['storeName'] as String?,
);

Map<String, dynamic> _$DealDataToJson(DealData instance) => <String, dynamic>{
  'id': instance.id,
  'comments_count': instance.commentsCount,
  'created_at': instance.createdAt,
  'created_at_in_millis': instance.createdAtInMillis,
  'image_medium': instance.imageMedium,
  'title': instance.title,
  'storeName': instance.storeName,
};

Store _$StoreFromJson(Map<String, dynamic> json) =>
    Store(name: json['name'] as String?);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
};
