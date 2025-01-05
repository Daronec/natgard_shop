// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      patronymic: json['patronymic'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      birthday: _fromJsonTimestamp(json['birthday'] as Timestamp?),
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'surname': instance.surname,
    'patronymic': instance.patronymic,
    'avatar': instance.avatar,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('birthday', _toJsonTimestamp(instance.birthday));
  val['gender'] = instance.gender;
  val['phone'] = instance.phone;
  val['address'] = instance.address;
  val['isAdmin'] = instance.isAdmin;
  return val;
}
