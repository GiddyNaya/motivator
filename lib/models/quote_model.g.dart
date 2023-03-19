// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) => QuoteModel(
    id: json['id'] as int?,
    quote: json['quote'] as String?,
    author: json['author'] as String?,
    categoryId: json['categoryId'] as int?);

Map<String, dynamic> _$QuoteModelToJson(QuoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'quote': instance.quote,
      'categoryId': instance.categoryId
    };
