import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member.freezed.dart';
part 'family_member.g.dart';

@freezed
abstract class FamilyMember with _$FamilyMember {
  const factory FamilyMember({
    required String id,
    required String name,
    @Default('') String relation,
    @Default('') String dob,
    @Default('male') String gender,
    @Default('') String avatar,
    @Default('') String bloodType,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
}
