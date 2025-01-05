import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? name,
    String? surname,
    String? patronymic,
    String? avatar,
    String? email,
    @JsonKey(
      fromJson: _fromJsonTimestamp,
      toJson: _toJsonTimestamp,
      includeIfNull: false,
    )
    DateTime? birthday,
    String? gender,
    String? phone,
    String? address,
    bool? isAdmin,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

DateTime? _fromJsonTimestamp(Timestamp? value) {
  return value != null ? DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch) : null;
}

Timestamp? _toJsonTimestamp(DateTime? value) {
  return value != null ? Timestamp.fromDate(value) : null;
}
