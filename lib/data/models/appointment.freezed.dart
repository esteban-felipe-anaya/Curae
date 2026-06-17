// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Appointment {

 String get id; String get doctorId; String get doctorName; String get doctorPhoto; String get specialty; String get patientId; String get patientName; String get date; String get slot;@JsonKey(unknownEnumValue: AppointmentType.inPerson) AppointmentType get type; String get reason;@JsonKey(unknownEnumValue: AppointmentStatus.upcoming) AppointmentStatus get status; num get fee; String get currency; String? get createdAt;
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentCopyWith<Appointment> get copyWith => _$AppointmentCopyWithImpl<Appointment>(this as Appointment, _$identity);

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.doctorPhoto, doctorPhoto) || other.doctorPhoto == doctorPhoto)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,doctorName,doctorPhoto,specialty,patientId,patientName,date,slot,type,reason,status,fee,currency,createdAt);

@override
String toString() {
  return 'Appointment(id: $id, doctorId: $doctorId, doctorName: $doctorName, doctorPhoto: $doctorPhoto, specialty: $specialty, patientId: $patientId, patientName: $patientName, date: $date, slot: $slot, type: $type, reason: $reason, status: $status, fee: $fee, currency: $currency, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AppointmentCopyWith<$Res>  {
  factory $AppointmentCopyWith(Appointment value, $Res Function(Appointment) _then) = _$AppointmentCopyWithImpl;
@useResult
$Res call({
 String id, String doctorId, String doctorName, String doctorPhoto, String specialty, String patientId, String patientName, String date, String slot,@JsonKey(unknownEnumValue: AppointmentType.inPerson) AppointmentType type, String reason,@JsonKey(unknownEnumValue: AppointmentStatus.upcoming) AppointmentStatus status, num fee, String currency, String? createdAt
});




}
/// @nodoc
class _$AppointmentCopyWithImpl<$Res>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._self, this._then);

  final Appointment _self;
  final $Res Function(Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? doctorId = null,Object? doctorName = null,Object? doctorPhoto = null,Object? specialty = null,Object? patientId = null,Object? patientName = null,Object? date = null,Object? slot = null,Object? type = null,Object? reason = null,Object? status = null,Object? fee = null,Object? currency = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,doctorName: null == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String,doctorPhoto: null == doctorPhoto ? _self.doctorPhoto : doctorPhoto // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppointmentType,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Appointment].
extension AppointmentPatterns on Appointment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Appointment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Appointment value)  $default,){
final _that = this;
switch (_that) {
case _Appointment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Appointment value)?  $default,){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String doctorId,  String doctorName,  String doctorPhoto,  String specialty,  String patientId,  String patientName,  String date,  String slot, @JsonKey(unknownEnumValue: AppointmentType.inPerson)  AppointmentType type,  String reason, @JsonKey(unknownEnumValue: AppointmentStatus.upcoming)  AppointmentStatus status,  num fee,  String currency,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.doctorId,_that.doctorName,_that.doctorPhoto,_that.specialty,_that.patientId,_that.patientName,_that.date,_that.slot,_that.type,_that.reason,_that.status,_that.fee,_that.currency,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String doctorId,  String doctorName,  String doctorPhoto,  String specialty,  String patientId,  String patientName,  String date,  String slot, @JsonKey(unknownEnumValue: AppointmentType.inPerson)  AppointmentType type,  String reason, @JsonKey(unknownEnumValue: AppointmentStatus.upcoming)  AppointmentStatus status,  num fee,  String currency,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Appointment():
return $default(_that.id,_that.doctorId,_that.doctorName,_that.doctorPhoto,_that.specialty,_that.patientId,_that.patientName,_that.date,_that.slot,_that.type,_that.reason,_that.status,_that.fee,_that.currency,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String doctorId,  String doctorName,  String doctorPhoto,  String specialty,  String patientId,  String patientName,  String date,  String slot, @JsonKey(unknownEnumValue: AppointmentType.inPerson)  AppointmentType type,  String reason, @JsonKey(unknownEnumValue: AppointmentStatus.upcoming)  AppointmentStatus status,  num fee,  String currency,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.doctorId,_that.doctorName,_that.doctorPhoto,_that.specialty,_that.patientId,_that.patientName,_that.date,_that.slot,_that.type,_that.reason,_that.status,_that.fee,_that.currency,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Appointment implements Appointment {
  const _Appointment({required this.id, required this.doctorId, this.doctorName = '', this.doctorPhoto = '', this.specialty = '', required this.patientId, this.patientName = '', required this.date, required this.slot, @JsonKey(unknownEnumValue: AppointmentType.inPerson) this.type = AppointmentType.inPerson, this.reason = '', @JsonKey(unknownEnumValue: AppointmentStatus.upcoming) this.status = AppointmentStatus.upcoming, this.fee = 0, this.currency = 'USD', this.createdAt});
  factory _Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

@override final  String id;
@override final  String doctorId;
@override@JsonKey() final  String doctorName;
@override@JsonKey() final  String doctorPhoto;
@override@JsonKey() final  String specialty;
@override final  String patientId;
@override@JsonKey() final  String patientName;
@override final  String date;
@override final  String slot;
@override@JsonKey(unknownEnumValue: AppointmentType.inPerson) final  AppointmentType type;
@override@JsonKey() final  String reason;
@override@JsonKey(unknownEnumValue: AppointmentStatus.upcoming) final  AppointmentStatus status;
@override@JsonKey() final  num fee;
@override@JsonKey() final  String currency;
@override final  String? createdAt;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentCopyWith<_Appointment> get copyWith => __$AppointmentCopyWithImpl<_Appointment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.doctorPhoto, doctorPhoto) || other.doctorPhoto == doctorPhoto)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,doctorName,doctorPhoto,specialty,patientId,patientName,date,slot,type,reason,status,fee,currency,createdAt);

@override
String toString() {
  return 'Appointment(id: $id, doctorId: $doctorId, doctorName: $doctorName, doctorPhoto: $doctorPhoto, specialty: $specialty, patientId: $patientId, patientName: $patientName, date: $date, slot: $slot, type: $type, reason: $reason, status: $status, fee: $fee, currency: $currency, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AppointmentCopyWith<$Res> implements $AppointmentCopyWith<$Res> {
  factory _$AppointmentCopyWith(_Appointment value, $Res Function(_Appointment) _then) = __$AppointmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String doctorId, String doctorName, String doctorPhoto, String specialty, String patientId, String patientName, String date, String slot,@JsonKey(unknownEnumValue: AppointmentType.inPerson) AppointmentType type, String reason,@JsonKey(unknownEnumValue: AppointmentStatus.upcoming) AppointmentStatus status, num fee, String currency, String? createdAt
});




}
/// @nodoc
class __$AppointmentCopyWithImpl<$Res>
    implements _$AppointmentCopyWith<$Res> {
  __$AppointmentCopyWithImpl(this._self, this._then);

  final _Appointment _self;
  final $Res Function(_Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? doctorId = null,Object? doctorName = null,Object? doctorPhoto = null,Object? specialty = null,Object? patientId = null,Object? patientName = null,Object? date = null,Object? slot = null,Object? type = null,Object? reason = null,Object? status = null,Object? fee = null,Object? currency = null,Object? createdAt = freezed,}) {
  return _then(_Appointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,doctorName: null == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String,doctorPhoto: null == doctorPhoto ? _self.doctorPhoto : doctorPhoto // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppointmentType,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
