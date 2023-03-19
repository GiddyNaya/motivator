import 'package:json_annotation/json_annotation.dart';

/// This allows the `QuoteModel` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star symbol denotes the source file name.
part 'quote_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class QuoteModel {
  int? id;
  String? quote;
  String? author;
  int? categoryId;
  QuoteModel({
    this.id,
    this.quote,
    this.author,
    this.categoryId,
  });

  /// A necessary factory constructor for creating a new QuoteModel instance
  /// from a map. Pass the map to the generated `_$QuoteModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, QuoteModel.
  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$QuoteModelToJson`.
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);
}
