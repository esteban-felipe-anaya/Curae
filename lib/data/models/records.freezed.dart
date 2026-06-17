// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VitalReading {

 String get date; double get value;
/// Create a copy of VitalReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VitalReadingCopyWith<VitalReading> get copyWith => _$VitalReadingCopyWithImpl<VitalReading>(this as VitalReading, _$identity);

  /// Serializes this VitalReading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VitalReading&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value);

@override
String toString() {
  return 'VitalReading(date: $date, value: $value)';
}


}

/// @nodoc
abstract mixin class $VitalReadingCopyWith<$Res>  {
  factory $VitalReadingCopyWith(VitalReading value, $Res Function(VitalReading) _then) = _$VitalReadingCopyWithImpl;
@useResult
$Res call({
 String date, double value
});




}
/// @nodoc
class _$VitalReadingCopyWithImpl<$Res>
    implements $VitalReadingCopyWith<$Res> {
  _$VitalReadingCopyWithImpl(this._self, this._then);

  final VitalReading _self;
  final $Res Function(VitalReading) _then;

/// Create a copy of VitalReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? value = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VitalReading].
extension VitalReadingPatterns on VitalReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VitalReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VitalReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VitalReading value)  $default,){
final _that = this;
switch (_that) {
case _VitalReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VitalReading value)?  $default,){
final _that = this;
switch (_that) {
case _VitalReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VitalReading() when $default != null:
return $default(_that.date,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double value)  $default,) {final _that = this;
switch (_that) {
case _VitalReading():
return $default(_that.date,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double value)?  $default,) {final _that = this;
switch (_that) {
case _VitalReading() when $default != null:
return $default(_that.date,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VitalReading implements VitalReading {
  const _VitalReading({required this.date, required this.value});
  factory _VitalReading.fromJson(Map<String, dynamic> json) => _$VitalReadingFromJson(json);

@override final  String date;
@override final  double value;

/// Create a copy of VitalReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VitalReadingCopyWith<_VitalReading> get copyWith => __$VitalReadingCopyWithImpl<_VitalReading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VitalReadingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VitalReading&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value);

@override
String toString() {
  return 'VitalReading(date: $date, value: $value)';
}


}

/// @nodoc
abstract mixin class _$VitalReadingCopyWith<$Res> implements $VitalReadingCopyWith<$Res> {
  factory _$VitalReadingCopyWith(_VitalReading value, $Res Function(_VitalReading) _then) = __$VitalReadingCopyWithImpl;
@override @useResult
$Res call({
 String date, double value
});




}
/// @nodoc
class __$VitalReadingCopyWithImpl<$Res>
    implements _$VitalReadingCopyWith<$Res> {
  __$VitalReadingCopyWithImpl(this._self, this._then);

  final _VitalReading _self;
  final $Res Function(_VitalReading) _then;

/// Create a copy of VitalReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? value = null,}) {
  return _then(_VitalReading(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$VitalSeries {

 String get type; String get unit; List<VitalReading> get readings;
/// Create a copy of VitalSeries
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VitalSeriesCopyWith<VitalSeries> get copyWith => _$VitalSeriesCopyWithImpl<VitalSeries>(this as VitalSeries, _$identity);

  /// Serializes this VitalSeries to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VitalSeries&&(identical(other.type, type) || other.type == type)&&(identical(other.unit, unit) || other.unit == unit)&&const DeepCollectionEquality().equals(other.readings, readings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,unit,const DeepCollectionEquality().hash(readings));

@override
String toString() {
  return 'VitalSeries(type: $type, unit: $unit, readings: $readings)';
}


}

/// @nodoc
abstract mixin class $VitalSeriesCopyWith<$Res>  {
  factory $VitalSeriesCopyWith(VitalSeries value, $Res Function(VitalSeries) _then) = _$VitalSeriesCopyWithImpl;
@useResult
$Res call({
 String type, String unit, List<VitalReading> readings
});




}
/// @nodoc
class _$VitalSeriesCopyWithImpl<$Res>
    implements $VitalSeriesCopyWith<$Res> {
  _$VitalSeriesCopyWithImpl(this._self, this._then);

  final VitalSeries _self;
  final $Res Function(VitalSeries) _then;

/// Create a copy of VitalSeries
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? unit = null,Object? readings = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,readings: null == readings ? _self.readings : readings // ignore: cast_nullable_to_non_nullable
as List<VitalReading>,
  ));
}

}


/// Adds pattern-matching-related methods to [VitalSeries].
extension VitalSeriesPatterns on VitalSeries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VitalSeries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VitalSeries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VitalSeries value)  $default,){
final _that = this;
switch (_that) {
case _VitalSeries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VitalSeries value)?  $default,){
final _that = this;
switch (_that) {
case _VitalSeries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String unit,  List<VitalReading> readings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VitalSeries() when $default != null:
return $default(_that.type,_that.unit,_that.readings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String unit,  List<VitalReading> readings)  $default,) {final _that = this;
switch (_that) {
case _VitalSeries():
return $default(_that.type,_that.unit,_that.readings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String unit,  List<VitalReading> readings)?  $default,) {final _that = this;
switch (_that) {
case _VitalSeries() when $default != null:
return $default(_that.type,_that.unit,_that.readings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VitalSeries implements VitalSeries {
  const _VitalSeries({required this.type, this.unit = '', final  List<VitalReading> readings = const <VitalReading>[]}): _readings = readings;
  factory _VitalSeries.fromJson(Map<String, dynamic> json) => _$VitalSeriesFromJson(json);

@override final  String type;
@override@JsonKey() final  String unit;
 final  List<VitalReading> _readings;
@override@JsonKey() List<VitalReading> get readings {
  if (_readings is EqualUnmodifiableListView) return _readings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readings);
}


/// Create a copy of VitalSeries
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VitalSeriesCopyWith<_VitalSeries> get copyWith => __$VitalSeriesCopyWithImpl<_VitalSeries>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VitalSeriesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VitalSeries&&(identical(other.type, type) || other.type == type)&&(identical(other.unit, unit) || other.unit == unit)&&const DeepCollectionEquality().equals(other._readings, _readings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,unit,const DeepCollectionEquality().hash(_readings));

@override
String toString() {
  return 'VitalSeries(type: $type, unit: $unit, readings: $readings)';
}


}

/// @nodoc
abstract mixin class _$VitalSeriesCopyWith<$Res> implements $VitalSeriesCopyWith<$Res> {
  factory _$VitalSeriesCopyWith(_VitalSeries value, $Res Function(_VitalSeries) _then) = __$VitalSeriesCopyWithImpl;
@override @useResult
$Res call({
 String type, String unit, List<VitalReading> readings
});




}
/// @nodoc
class __$VitalSeriesCopyWithImpl<$Res>
    implements _$VitalSeriesCopyWith<$Res> {
  __$VitalSeriesCopyWithImpl(this._self, this._then);

  final _VitalSeries _self;
  final $Res Function(_VitalSeries) _then;

/// Create a copy of VitalSeries
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? unit = null,Object? readings = null,}) {
  return _then(_VitalSeries(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,readings: null == readings ? _self._readings : readings // ignore: cast_nullable_to_non_nullable
as List<VitalReading>,
  ));
}


}


/// @nodoc
mixin _$LabReport {

 String get id; String get name; String get date; String get status; String get summary; String get ordering;
/// Create a copy of LabReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabReportCopyWith<LabReport> get copyWith => _$LabReportCopyWithImpl<LabReport>(this as LabReport, _$identity);

  /// Serializes this LabReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabReport&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.ordering, ordering) || other.ordering == ordering));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,status,summary,ordering);

@override
String toString() {
  return 'LabReport(id: $id, name: $name, date: $date, status: $status, summary: $summary, ordering: $ordering)';
}


}

/// @nodoc
abstract mixin class $LabReportCopyWith<$Res>  {
  factory $LabReportCopyWith(LabReport value, $Res Function(LabReport) _then) = _$LabReportCopyWithImpl;
@useResult
$Res call({
 String id, String name, String date, String status, String summary, String ordering
});




}
/// @nodoc
class _$LabReportCopyWithImpl<$Res>
    implements $LabReportCopyWith<$Res> {
  _$LabReportCopyWithImpl(this._self, this._then);

  final LabReport _self;
  final $Res Function(LabReport) _then;

/// Create a copy of LabReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? date = null,Object? status = null,Object? summary = null,Object? ordering = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,ordering: null == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LabReport].
extension LabReportPatterns on LabReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabReport value)  $default,){
final _that = this;
switch (_that) {
case _LabReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabReport value)?  $default,){
final _that = this;
switch (_that) {
case _LabReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String date,  String status,  String summary,  String ordering)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabReport() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.status,_that.summary,_that.ordering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String date,  String status,  String summary,  String ordering)  $default,) {final _that = this;
switch (_that) {
case _LabReport():
return $default(_that.id,_that.name,_that.date,_that.status,_that.summary,_that.ordering);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String date,  String status,  String summary,  String ordering)?  $default,) {final _that = this;
switch (_that) {
case _LabReport() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.status,_that.summary,_that.ordering);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LabReport implements LabReport {
  const _LabReport({required this.id, required this.name, this.date = '', this.status = 'Normal', this.summary = '', this.ordering = ''});
  factory _LabReport.fromJson(Map<String, dynamic> json) => _$LabReportFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String date;
@override@JsonKey() final  String status;
@override@JsonKey() final  String summary;
@override@JsonKey() final  String ordering;

/// Create a copy of LabReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabReportCopyWith<_LabReport> get copyWith => __$LabReportCopyWithImpl<_LabReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabReport&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.ordering, ordering) || other.ordering == ordering));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,status,summary,ordering);

@override
String toString() {
  return 'LabReport(id: $id, name: $name, date: $date, status: $status, summary: $summary, ordering: $ordering)';
}


}

/// @nodoc
abstract mixin class _$LabReportCopyWith<$Res> implements $LabReportCopyWith<$Res> {
  factory _$LabReportCopyWith(_LabReport value, $Res Function(_LabReport) _then) = __$LabReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String date, String status, String summary, String ordering
});




}
/// @nodoc
class __$LabReportCopyWithImpl<$Res>
    implements _$LabReportCopyWith<$Res> {
  __$LabReportCopyWithImpl(this._self, this._then);

  final _LabReport _self;
  final $Res Function(_LabReport) _then;

/// Create a copy of LabReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? date = null,Object? status = null,Object? summary = null,Object? ordering = null,}) {
  return _then(_LabReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,ordering: null == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Prescription {

 String get id; String get medication; String get dosage; String get frequency; String get doctor; String get date; bool get active;
/// Create a copy of Prescription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrescriptionCopyWith<Prescription> get copyWith => _$PrescriptionCopyWithImpl<Prescription>(this as Prescription, _$identity);

  /// Serializes this Prescription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Prescription&&(identical(other.id, id) || other.id == id)&&(identical(other.medication, medication) || other.medication == medication)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.doctor, doctor) || other.doctor == doctor)&&(identical(other.date, date) || other.date == date)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,medication,dosage,frequency,doctor,date,active);

@override
String toString() {
  return 'Prescription(id: $id, medication: $medication, dosage: $dosage, frequency: $frequency, doctor: $doctor, date: $date, active: $active)';
}


}

/// @nodoc
abstract mixin class $PrescriptionCopyWith<$Res>  {
  factory $PrescriptionCopyWith(Prescription value, $Res Function(Prescription) _then) = _$PrescriptionCopyWithImpl;
@useResult
$Res call({
 String id, String medication, String dosage, String frequency, String doctor, String date, bool active
});




}
/// @nodoc
class _$PrescriptionCopyWithImpl<$Res>
    implements $PrescriptionCopyWith<$Res> {
  _$PrescriptionCopyWithImpl(this._self, this._then);

  final Prescription _self;
  final $Res Function(Prescription) _then;

/// Create a copy of Prescription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? medication = null,Object? dosage = null,Object? frequency = null,Object? doctor = null,Object? date = null,Object? active = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,medication: null == medication ? _self.medication : medication // ignore: cast_nullable_to_non_nullable
as String,dosage: null == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String,doctor: null == doctor ? _self.doctor : doctor // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Prescription].
extension PrescriptionPatterns on Prescription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Prescription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Prescription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Prescription value)  $default,){
final _that = this;
switch (_that) {
case _Prescription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Prescription value)?  $default,){
final _that = this;
switch (_that) {
case _Prescription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String medication,  String dosage,  String frequency,  String doctor,  String date,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Prescription() when $default != null:
return $default(_that.id,_that.medication,_that.dosage,_that.frequency,_that.doctor,_that.date,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String medication,  String dosage,  String frequency,  String doctor,  String date,  bool active)  $default,) {final _that = this;
switch (_that) {
case _Prescription():
return $default(_that.id,_that.medication,_that.dosage,_that.frequency,_that.doctor,_that.date,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String medication,  String dosage,  String frequency,  String doctor,  String date,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _Prescription() when $default != null:
return $default(_that.id,_that.medication,_that.dosage,_that.frequency,_that.doctor,_that.date,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Prescription implements Prescription {
  const _Prescription({required this.id, required this.medication, this.dosage = '', this.frequency = '', this.doctor = '', this.date = '', this.active = true});
  factory _Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);

@override final  String id;
@override final  String medication;
@override@JsonKey() final  String dosage;
@override@JsonKey() final  String frequency;
@override@JsonKey() final  String doctor;
@override@JsonKey() final  String date;
@override@JsonKey() final  bool active;

/// Create a copy of Prescription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrescriptionCopyWith<_Prescription> get copyWith => __$PrescriptionCopyWithImpl<_Prescription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrescriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prescription&&(identical(other.id, id) || other.id == id)&&(identical(other.medication, medication) || other.medication == medication)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.doctor, doctor) || other.doctor == doctor)&&(identical(other.date, date) || other.date == date)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,medication,dosage,frequency,doctor,date,active);

@override
String toString() {
  return 'Prescription(id: $id, medication: $medication, dosage: $dosage, frequency: $frequency, doctor: $doctor, date: $date, active: $active)';
}


}

/// @nodoc
abstract mixin class _$PrescriptionCopyWith<$Res> implements $PrescriptionCopyWith<$Res> {
  factory _$PrescriptionCopyWith(_Prescription value, $Res Function(_Prescription) _then) = __$PrescriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String medication, String dosage, String frequency, String doctor, String date, bool active
});




}
/// @nodoc
class __$PrescriptionCopyWithImpl<$Res>
    implements _$PrescriptionCopyWith<$Res> {
  __$PrescriptionCopyWithImpl(this._self, this._then);

  final _Prescription _self;
  final $Res Function(_Prescription) _then;

/// Create a copy of Prescription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? medication = null,Object? dosage = null,Object? frequency = null,Object? doctor = null,Object? date = null,Object? active = null,}) {
  return _then(_Prescription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,medication: null == medication ? _self.medication : medication // ignore: cast_nullable_to_non_nullable
as String,dosage: null == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String,doctor: null == doctor ? _self.doctor : doctor // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HealthRecords {

 List<VitalSeries> get vitals; List<LabReport> get labs; List<Prescription> get prescriptions;
/// Create a copy of HealthRecords
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthRecordsCopyWith<HealthRecords> get copyWith => _$HealthRecordsCopyWithImpl<HealthRecords>(this as HealthRecords, _$identity);

  /// Serializes this HealthRecords to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthRecords&&const DeepCollectionEquality().equals(other.vitals, vitals)&&const DeepCollectionEquality().equals(other.labs, labs)&&const DeepCollectionEquality().equals(other.prescriptions, prescriptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(vitals),const DeepCollectionEquality().hash(labs),const DeepCollectionEquality().hash(prescriptions));

@override
String toString() {
  return 'HealthRecords(vitals: $vitals, labs: $labs, prescriptions: $prescriptions)';
}


}

/// @nodoc
abstract mixin class $HealthRecordsCopyWith<$Res>  {
  factory $HealthRecordsCopyWith(HealthRecords value, $Res Function(HealthRecords) _then) = _$HealthRecordsCopyWithImpl;
@useResult
$Res call({
 List<VitalSeries> vitals, List<LabReport> labs, List<Prescription> prescriptions
});




}
/// @nodoc
class _$HealthRecordsCopyWithImpl<$Res>
    implements $HealthRecordsCopyWith<$Res> {
  _$HealthRecordsCopyWithImpl(this._self, this._then);

  final HealthRecords _self;
  final $Res Function(HealthRecords) _then;

/// Create a copy of HealthRecords
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vitals = null,Object? labs = null,Object? prescriptions = null,}) {
  return _then(_self.copyWith(
vitals: null == vitals ? _self.vitals : vitals // ignore: cast_nullable_to_non_nullable
as List<VitalSeries>,labs: null == labs ? _self.labs : labs // ignore: cast_nullable_to_non_nullable
as List<LabReport>,prescriptions: null == prescriptions ? _self.prescriptions : prescriptions // ignore: cast_nullable_to_non_nullable
as List<Prescription>,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthRecords].
extension HealthRecordsPatterns on HealthRecords {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthRecords value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthRecords() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthRecords value)  $default,){
final _that = this;
switch (_that) {
case _HealthRecords():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthRecords value)?  $default,){
final _that = this;
switch (_that) {
case _HealthRecords() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VitalSeries> vitals,  List<LabReport> labs,  List<Prescription> prescriptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthRecords() when $default != null:
return $default(_that.vitals,_that.labs,_that.prescriptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VitalSeries> vitals,  List<LabReport> labs,  List<Prescription> prescriptions)  $default,) {final _that = this;
switch (_that) {
case _HealthRecords():
return $default(_that.vitals,_that.labs,_that.prescriptions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VitalSeries> vitals,  List<LabReport> labs,  List<Prescription> prescriptions)?  $default,) {final _that = this;
switch (_that) {
case _HealthRecords() when $default != null:
return $default(_that.vitals,_that.labs,_that.prescriptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthRecords implements HealthRecords {
  const _HealthRecords({final  List<VitalSeries> vitals = const <VitalSeries>[], final  List<LabReport> labs = const <LabReport>[], final  List<Prescription> prescriptions = const <Prescription>[]}): _vitals = vitals,_labs = labs,_prescriptions = prescriptions;
  factory _HealthRecords.fromJson(Map<String, dynamic> json) => _$HealthRecordsFromJson(json);

 final  List<VitalSeries> _vitals;
@override@JsonKey() List<VitalSeries> get vitals {
  if (_vitals is EqualUnmodifiableListView) return _vitals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vitals);
}

 final  List<LabReport> _labs;
@override@JsonKey() List<LabReport> get labs {
  if (_labs is EqualUnmodifiableListView) return _labs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labs);
}

 final  List<Prescription> _prescriptions;
@override@JsonKey() List<Prescription> get prescriptions {
  if (_prescriptions is EqualUnmodifiableListView) return _prescriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prescriptions);
}


/// Create a copy of HealthRecords
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthRecordsCopyWith<_HealthRecords> get copyWith => __$HealthRecordsCopyWithImpl<_HealthRecords>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthRecordsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthRecords&&const DeepCollectionEquality().equals(other._vitals, _vitals)&&const DeepCollectionEquality().equals(other._labs, _labs)&&const DeepCollectionEquality().equals(other._prescriptions, _prescriptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vitals),const DeepCollectionEquality().hash(_labs),const DeepCollectionEquality().hash(_prescriptions));

@override
String toString() {
  return 'HealthRecords(vitals: $vitals, labs: $labs, prescriptions: $prescriptions)';
}


}

/// @nodoc
abstract mixin class _$HealthRecordsCopyWith<$Res> implements $HealthRecordsCopyWith<$Res> {
  factory _$HealthRecordsCopyWith(_HealthRecords value, $Res Function(_HealthRecords) _then) = __$HealthRecordsCopyWithImpl;
@override @useResult
$Res call({
 List<VitalSeries> vitals, List<LabReport> labs, List<Prescription> prescriptions
});




}
/// @nodoc
class __$HealthRecordsCopyWithImpl<$Res>
    implements _$HealthRecordsCopyWith<$Res> {
  __$HealthRecordsCopyWithImpl(this._self, this._then);

  final _HealthRecords _self;
  final $Res Function(_HealthRecords) _then;

/// Create a copy of HealthRecords
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vitals = null,Object? labs = null,Object? prescriptions = null,}) {
  return _then(_HealthRecords(
vitals: null == vitals ? _self._vitals : vitals // ignore: cast_nullable_to_non_nullable
as List<VitalSeries>,labs: null == labs ? _self._labs : labs // ignore: cast_nullable_to_non_nullable
as List<LabReport>,prescriptions: null == prescriptions ? _self._prescriptions : prescriptions // ignore: cast_nullable_to_non_nullable
as List<Prescription>,
  ));
}


}

// dart format on
