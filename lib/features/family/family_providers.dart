import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/family_member.dart';
import '../auth/auth_controller.dart';

final familyMembersProvider = FutureProvider<List<FamilyMember>>(
  (ref) => ref.watch(contentRepositoryProvider).familyMembers(),
);

/// A bookable patient: the signed-in user ("Myself") plus each family member.
class Patient {
  const Patient({
    required this.id,
    required this.name,
    required this.relation,
    this.avatar = '',
  });

  final String id;
  final String name;
  final String relation;
  final String avatar;
}

class FamilyActions {
  FamilyActions(this.ref);
  final Ref ref;

  Future<void> add(Map<String, dynamic> body) async {
    await ref.read(contentRepositoryProvider).addFamilyMember(body);
    ref.invalidate(familyMembersProvider);
  }

  Future<void> update(String id, Map<String, dynamic> body) async {
    await ref.read(contentRepositoryProvider).updateFamilyMember(id, body);
    ref.invalidate(familyMembersProvider);
  }

  Future<void> remove(String id) async {
    await ref.read(contentRepositoryProvider).removeFamilyMember(id);
    ref.invalidate(familyMembersProvider);
  }
}

final familyActionsProvider = Provider<FamilyActions>((ref) => FamilyActions(ref));

/// Self + family, for the "book on behalf of" picker. Empty until signed in.
final patientsProvider = Provider<List<Patient>>((ref) {
  final user = ref.watch(currentUserProvider);
  final family = ref.watch(familyMembersProvider).value ?? const [];
  return [
    if (user != null)
      Patient(
        id: user.id,
        name: user.name,
        relation: 'Myself',
        avatar: user.avatar ?? '',
      ),
    ...family.map(
      (m) => Patient(
        id: m.id,
        name: m.name,
        relation: m.relation,
        avatar: m.avatar,
      ),
    ),
  ];
});
