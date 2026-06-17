// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Doctor {

 String get id; String get name; String get specialtyId; String get specialty; String get photo; String get gender; double get rating;@JsonKey(name: 'reviewCount') int get reviewCount;@JsonKey(name: 'experienceYears') int get experienceYears; num get fee; String get currency; List<String> get languages; String get location; String get about; String get bio;
/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorCopyWith<Doctor> get copyWith => _$DoctorCopyWithImpl<Doctor>(this as Doctor, _$identity);

  /// Serializes this Doctor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialtyId, specialtyId) || other.specialtyId == specialtyId)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.location, location) || other.location == location)&&(identical(other.about, about) || other.about == about)&&(identical(other.bio, bio) || other.bio == bio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialtyId,specialty,photo,gender,rating,reviewCount,experienceYears,fee,currency,const DeepCollectionEquality().hash(languages),location,about,bio);

@override
String toString() {
  return 'Doctor(id: $id, name: $name, specialtyId: $specialtyId, specialty: $specialty, photo: $photo, gender: $gender, rating: $rating, reviewCount: $reviewCount, experienceYears: $experienceYears, fee: $fee, currency: $currency, languages: $languages, location: $location, about: $about, bio: $bio)';
}


}

/// @nodoc
abstract mixin class $DoctorCopyWith<$Res>  {
  factory $DoctorCopyWith(Doctor value, $Res Function(Doctor) _then) = _$DoctorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String specialtyId, String specialty, String photo, String gender, double rating,@JsonKey(name: 'reviewCount') int reviewCount,@JsonKey(name: 'experienceYears') int experienceYears, num fee, String currency, List<String> languages, String location, String about, String bio
});




}
/// @nodoc
class _$DoctorCopyWithImpl<$Res>
    implements $DoctorCopyWith<$Res> {
  _$DoctorCopyWithImpl(this._self, this._then);

  final Doctor _self;
  final $Res Function(Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? specialtyId = null,Object? specialty = null,Object? photo = null,Object? gender = null,Object? rating = null,Object? reviewCount = null,Object? experienceYears = null,Object? fee = null,Object? currency = null,Object? languages = null,Object? location = null,Object? about = null,Object? bio = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialtyId: null == specialtyId ? _self.specialtyId : specialtyId // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Doctor].
extension DoctorPatterns on Doctor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Doctor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Doctor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Doctor value)  $default,){
final _that = this;
switch (_that) {
case _Doctor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Doctor value)?  $default,){
final _that = this;
switch (_that) {
case _Doctor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String specialtyId,  String specialty,  String photo,  String gender,  double rating, @JsonKey(name: 'reviewCount')  int reviewCount, @JsonKey(name: 'experienceYears')  int experienceYears,  num fee,  String currency,  List<String> languages,  String location,  String about,  String bio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that.id,_that.name,_that.specialtyId,_that.specialty,_that.photo,_that.gender,_that.rating,_that.reviewCount,_that.experienceYears,_that.fee,_that.currency,_that.languages,_that.location,_that.about,_that.bio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String specialtyId,  String specialty,  String photo,  String gender,  double rating, @JsonKey(name: 'reviewCount')  int reviewCount, @JsonKey(name: 'experienceYears')  int experienceYears,  num fee,  String currency,  List<String> languages,  String location,  String about,  String bio)  $default,) {final _that = this;
switch (_that) {
case _Doctor():
return $default(_that.id,_that.name,_that.specialtyId,_that.specialty,_that.photo,_that.gender,_that.rating,_that.reviewCount,_that.experienceYears,_that.fee,_that.currency,_that.languages,_that.location,_that.about,_that.bio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String specialtyId,  String specialty,  String photo,  String gender,  double rating, @JsonKey(name: 'reviewCount')  int reviewCount, @JsonKey(name: 'experienceYears')  int experienceYears,  num fee,  String currency,  List<String> languages,  String location,  String about,  String bio)?  $default,) {final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that.id,_that.name,_that.specialtyId,_that.specialty,_that.photo,_that.gender,_that.rating,_that.reviewCount,_that.experienceYears,_that.fee,_that.currency,_that.languages,_that.location,_that.about,_that.bio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Doctor implements Doctor {
  const _Doctor({required this.id, required this.name, required this.specialtyId, required this.specialty, required this.photo, this.gender = 'male', this.rating = 0, @JsonKey(name: 'reviewCount') this.reviewCount = 0, @JsonKey(name: 'experienceYears') this.experienceYears = 0, this.fee = 0, this.currency = 'USD', final  List<String> languages = const <String>[], this.location = '', this.about = '', this.bio = ''}): _languages = languages;
  factory _Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

@override final  String id;
@override final  String name;
@override final  String specialtyId;
@override final  String specialty;
@override final  String photo;
@override@JsonKey() final  String gender;
@override@JsonKey() final  double rating;
@override@JsonKey(name: 'reviewCount') final  int reviewCount;
@override@JsonKey(name: 'experienceYears') final  int experienceYears;
@override@JsonKey() final  num fee;
@override@JsonKey() final  String currency;
 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override@JsonKey() final  String location;
@override@JsonKey() final  String about;
@override@JsonKey() final  String bio;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorCopyWith<_Doctor> get copyWith => __$DoctorCopyWithImpl<_Doctor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialtyId, specialtyId) || other.specialtyId == specialtyId)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.location, location) || other.location == location)&&(identical(other.about, about) || other.about == about)&&(identical(other.bio, bio) || other.bio == bio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialtyId,specialty,photo,gender,rating,reviewCount,experienceYears,fee,currency,const DeepCollectionEquality().hash(_languages),location,about,bio);

@override
String toString() {
  return 'Doctor(id: $id, name: $name, specialtyId: $specialtyId, specialty: $specialty, photo: $photo, gender: $gender, rating: $rating, reviewCount: $reviewCount, experienceYears: $experienceYears, fee: $fee, currency: $currency, languages: $languages, location: $location, about: $about, bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$DoctorCopyWith<$Res> implements $DoctorCopyWith<$Res> {
  factory _$DoctorCopyWith(_Doctor value, $Res Function(_Doctor) _then) = __$DoctorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String specialtyId, String specialty, String photo, String gender, double rating,@JsonKey(name: 'reviewCount') int reviewCount,@JsonKey(name: 'experienceYears') int experienceYears, num fee, String currency, List<String> languages, String location, String about, String bio
});




}
/// @nodoc
class __$DoctorCopyWithImpl<$Res>
    implements _$DoctorCopyWith<$Res> {
  __$DoctorCopyWithImpl(this._self, this._then);

  final _Doctor _self;
  final $Res Function(_Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? specialtyId = null,Object? specialty = null,Object? photo = null,Object? gender = null,Object? rating = null,Object? reviewCount = null,Object? experienceYears = null,Object? fee = null,Object? currency = null,Object? languages = null,Object? location = null,Object? about = null,Object? bio = null,}) {
  return _then(_Doctor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialtyId: null == specialtyId ? _self.specialtyId : specialtyId // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
