import 'package:json_annotation/json_annotation.dart';

/// This allows the `ApiResponseModel` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star symbol denotes the source file name.
part 'api_response_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class ApiResponseModel {
  bool success;
  dynamic message;

  ApiResponseModel({
    this.success = false,
    this.message,
  });

  /// A necessary factory constructor for creating a new ApiResponseModel instance
  /// from a map. Pass the map to the generated `_$ApiResponseModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, ApiResponseModel.
  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ApiResponseModelToJson`.
  Map<String, dynamic> toJson() => _$ApiResponseModelToJson(this);
}
