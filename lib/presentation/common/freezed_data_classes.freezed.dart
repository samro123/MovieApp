// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.username, this.password);

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String username, final String password) =
      _$LoginObjectImpl;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get dob => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {String username,
      String password,
      String firstName,
      String lastName,
      String dob});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dob = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterObjectImplCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$RegisterObjectImplCopyWith(_$RegisterObjectImpl value,
          $Res Function(_$RegisterObjectImpl) then) =
      __$$RegisterObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String password,
      String firstName,
      String lastName,
      String dob});
}

/// @nodoc
class __$$RegisterObjectImplCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$RegisterObjectImpl>
    implements _$$RegisterObjectImplCopyWith<$Res> {
  __$$RegisterObjectImplCopyWithImpl(
      _$RegisterObjectImpl _value, $Res Function(_$RegisterObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dob = null,
  }) {
    return _then(_$RegisterObjectImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterObjectImpl implements _RegisterObject {
  _$RegisterObjectImpl(
      this.username, this.password, this.firstName, this.lastName, this.dob);

  @override
  final String username;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String dob;

  @override
  String toString() {
    return 'RegisterObject(username: $username, password: $password, firstName: $firstName, lastName: $lastName, dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterObjectImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, username, password, firstName, lastName, dob);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      __$$RegisterObjectImplCopyWithImpl<_$RegisterObjectImpl>(
          this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      final String username,
      final String password,
      final String firstName,
      final String lastName,
      final String dob) = _$RegisterObjectImpl;

  @override
  String get username;
  @override
  String get password;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get dob;
  @override
  @JsonKey(ignore: true)
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProfileObject {
  String get username => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  File? get avatar => throw _privateConstructorUsedError;
  String get dob => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileObjectCopyWith<ProfileObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileObjectCopyWith<$Res> {
  factory $ProfileObjectCopyWith(
          ProfileObject value, $Res Function(ProfileObject) then) =
      _$ProfileObjectCopyWithImpl<$Res, ProfileObject>;
  @useResult
  $Res call(
      {String username,
      String firstName,
      String lastName,
      File? avatar,
      String dob,
      String city});
}

/// @nodoc
class _$ProfileObjectCopyWithImpl<$Res, $Val extends ProfileObject>
    implements $ProfileObjectCopyWith<$Res> {
  _$ProfileObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? dob = null,
    Object? city = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as File?,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileObjectImplCopyWith<$Res>
    implements $ProfileObjectCopyWith<$Res> {
  factory _$$ProfileObjectImplCopyWith(
          _$ProfileObjectImpl value, $Res Function(_$ProfileObjectImpl) then) =
      __$$ProfileObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String firstName,
      String lastName,
      File? avatar,
      String dob,
      String city});
}

/// @nodoc
class __$$ProfileObjectImplCopyWithImpl<$Res>
    extends _$ProfileObjectCopyWithImpl<$Res, _$ProfileObjectImpl>
    implements _$$ProfileObjectImplCopyWith<$Res> {
  __$$ProfileObjectImplCopyWithImpl(
      _$ProfileObjectImpl _value, $Res Function(_$ProfileObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? dob = null,
    Object? city = null,
  }) {
    return _then(_$ProfileObjectImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as File?,
      null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileObjectImpl implements _ProfileObject {
  _$ProfileObjectImpl(this.username, this.firstName, this.lastName, this.avatar,
      this.dob, this.city);

  @override
  final String username;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final File? avatar;
  @override
  final String dob;
  @override
  final String city;

  @override
  String toString() {
    return 'ProfileObject(username: $username, firstName: $firstName, lastName: $lastName, avatar: $avatar, dob: $dob, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileObjectImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.city, city) || other.city == city));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, username, firstName, lastName, avatar, dob, city);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileObjectImplCopyWith<_$ProfileObjectImpl> get copyWith =>
      __$$ProfileObjectImplCopyWithImpl<_$ProfileObjectImpl>(this, _$identity);
}

abstract class _ProfileObject implements ProfileObject {
  factory _ProfileObject(
      final String username,
      final String firstName,
      final String lastName,
      final File? avatar,
      final String dob,
      final String city) = _$ProfileObjectImpl;

  @override
  String get username;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  File? get avatar;
  @override
  String get dob;
  @override
  String get city;
  @override
  @JsonKey(ignore: true)
  _$$ProfileObjectImplCopyWith<_$ProfileObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
