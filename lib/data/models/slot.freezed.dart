// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DaySlots {

 String get date; List<String> get slots; String? get doctorId;
/// Create a copy of DaySlots
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DaySlotsCopyWith<DaySlots> get copyWith => _$DaySlotsCopyWithImpl<DaySlots>(this as DaySlots, _$identity);

  /// Serializes this DaySlots to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DaySlots&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(slots),doctorId);

@override
String toString() {
  return 'DaySlots(date: $date, slots: $slots, doctorId: $doctorId)';
}


}

/// @nodoc
abstract mixin class $DaySlotsCopyWith<$Res>  {
  factory $DaySlotsCopyWith(DaySlots value, $Res Function(DaySlots) _then) = _$DaySlotsCopyWithImpl;
@useResult
$Res call({
 String date, List<String> slots, String? doctorId
});




}
/// @nodoc
class _$DaySlotsCopyWithImpl<$Res>
    implements $DaySlotsCopyWith<$Res> {
  _$DaySlotsCopyWithImpl(this._self, this._then);

  final DaySlots _self;
  final $Res Function(DaySlots) _then;

/// Create a copy of DaySlots
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? slots = null,Object? doctorId = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<String>,doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DaySlots].
extension DaySlotsPatterns on DaySlots {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DaySlots value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DaySlots() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DaySlots value)  $default,){
final _that = this;
switch (_that) {
case _DaySlots():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DaySlots value)?  $default,){
final _that = this;
switch (_that) {
case _DaySlots() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<String> slots,  String? doctorId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DaySlots() when $default != null:
return $default(_that.date,_that.slots,_that.doctorId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<String> slots,  String? doctorId)  $default,) {final _that = this;
switch (_that) {
case _DaySlots():
return $default(_that.date,_that.slots,_that.doctorId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<String> slots,  String? doctorId)?  $default,) {final _that = this;
switch (_that) {
case _DaySlots() when $default != null:
return $default(_that.date,_that.slots,_that.doctorId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DaySlots implements DaySlots {
  const _DaySlots({required this.date, final  List<String> slots = const <String>[], this.doctorId}): _slots = slots;
  factory _DaySlots.fromJson(Map<String, dynamic> json) => _$DaySlotsFromJson(json);

@override final  String date;
 final  List<String> _slots;
@override@JsonKey() List<String> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override final  String? doctorId;

/// Create a copy of DaySlots
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaySlotsCopyWith<_DaySlots> get copyWith => __$DaySlotsCopyWithImpl<_DaySlots>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DaySlotsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaySlots&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_slots),doctorId);

@override
String toString() {
  return 'DaySlots(date: $date, slots: $slots, doctorId: $doctorId)';
}


}

/// @nodoc
abstract mixin class _$DaySlotsCopyWith<$Res> implements $DaySlotsCopyWith<$Res> {
  factory _$DaySlotsCopyWith(_DaySlots value, $Res Function(_DaySlots) _then) = __$DaySlotsCopyWithImpl;
@override @useResult
$Res call({
 String date, List<String> slots, String? doctorId
});




}
/// @nodoc
class __$DaySlotsCopyWithImpl<$Res>
    implements _$DaySlotsCopyWith<$Res> {
  __$DaySlotsCopyWithImpl(this._self, this._then);

  final _DaySlots _self;
  final $Res Function(_DaySlots) _then;

/// Create a copy of DaySlots
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? slots = null,Object? doctorId = freezed,}) {
  return _then(_DaySlots(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<String>,doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
