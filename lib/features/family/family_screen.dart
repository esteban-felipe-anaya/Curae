import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/family_member.dart';
import '../../features/auth/auth_controller.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/states.dart';
import 'family_providers.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = ref.watch(isAuthenticatedProvider);

    if (!isAuth) {
      return Scaffold(
        appBar: AppBar(title: const Text('Family members')),
        body: EmptyView(
          title: 'Sign in to manage family',
          message: 'Add and manage family members to book on their behalf.',
          icon: Icons.family_restroom_outlined,
          action: FilledButton(
            onPressed: () => context.push(
              '${Routes.login}?from=${Uri.encodeComponent(Routes.family)}',
            ),
            child: const Text('Sign in'),
          ),
        ),
      );
    }

    final membersAsync = ref.watch(familyMembersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family members'),
        actions: [
          IconButton(
            tooltip: 'Add member',
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () => _openEditor(context, ref, null),
          ),
          const SizedBox(width: AppTokens.space4),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add member',
        onPressed: () => _openEditor(context, ref, null),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(familyMembersProvider),
        child: AsyncView<List<FamilyMember>>(
          value: membersAsync,
          onRetry: () => ref.invalidate(familyMembersProvider),
          loading: () => const SkeletonList(count: 4, itemHeight: 88),
          data: (members) {
            if (members.isEmpty) {
              return EmptyView(
                title: 'No family members yet',
                message: 'Add a family member to book appointments on their behalf.',
                icon: Icons.family_restroom_outlined,
                action: FilledButton(
                  onPressed: () => _openEditor(context, ref, null),
                  child: const Text('Add member'),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppTokens.space16),
              itemCount: members.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppTokens.space8),
              itemBuilder: (_, index) => _FamilyMemberCard(
                member: members[index],
                onEdit: () => _openEditor(context, ref, members[index]),
                onRemove: () => _confirmRemove(context, ref, members[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openEditor(BuildContext context, WidgetRef ref, FamilyMember? member) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _FamilyEditorSheet(member: member),
    );
  }

  void _confirmRemove(
      BuildContext context, WidgetRef ref, FamilyMember member) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove member?'),
        content:
            Text('${member.name} will be removed from your family list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(familyActionsProvider).remove(member.id);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _FamilyMemberCard extends StatelessWidget {
  const _FamilyMemberCard({
    required this.member,
    required this.onEdit,
    required this.onRemove,
  });

  final FamilyMember member;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final age = Fmt.ageFromDob(member.dob);
    final ageLine = [
      if (age != null) 'Age $age',
      if (member.bloodType.isNotEmpty) member.bloodType,
    ].join(' · ');

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space16,
          vertical: AppTokens.space8,
        ),
        leading: CuraeAvatar(
          url: member.avatar,
          radius: 24,
          fallback: member.name,
        ),
        title: Text(member.name, style: theme.textTheme.titleSmall),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (member.relation.isNotEmpty)
              Text(
                member.relation,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.primary),
              ),
            if (ageLine.isNotEmpty)
              Text(
                ageLine,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
          ],
        ),
        trailing: PopupMenuButton<_MemberAction>(
          onSelected: (action) {
            switch (action) {
              case _MemberAction.edit:
                onEdit();
              case _MemberAction.remove:
                onRemove();
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: _MemberAction.edit,
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: _MemberAction.remove,
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Remove'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _MemberAction { edit, remove }

// ─────────────────────────────────────────────────────────────────────────────
// Family editor bottom sheet
// ─────────────────────────────────────────────────────────────────────────────

const _relations = [
  'Spouse',
  'Child',
  'Son',
  'Daughter',
  'Parent',
  'Mother',
  'Father',
  'Sibling',
  'Other',
];

class _FamilyEditorSheet extends ConsumerStatefulWidget {
  const _FamilyEditorSheet({this.member});

  final FamilyMember? member;

  @override
  ConsumerState<_FamilyEditorSheet> createState() => _FamilyEditorSheetState();
}

class _FamilyEditorSheetState extends ConsumerState<_FamilyEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  String? _relation;
  String? _dob;
  String _gender = 'male';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final m = widget.member;
    _nameController = TextEditingController(text: m?.name ?? '');
    _relation = m?.relation.isNotEmpty == true ? m!.relation : null;
    _dob = m?.dob.isNotEmpty == true ? m!.dob : null;
    _gender = m?.gender ?? 'male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final body = <String, dynamic>{
      'name': _nameController.text.trim(),
      'relation': _relation ?? '',
      'dob': _dob ?? '',
      'gender': _gender,
      'bloodType': widget.member?.bloodType ?? '',
      'avatar': widget.member?.avatar ?? '',
    };

    try {
      if (widget.member == null) {
        await ref.read(familyActionsProvider).add(body);
      } else {
        await ref.read(familyActionsProvider).update(widget.member!.id, body);
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.member == null
                  ? 'Member added successfully'
                  : 'Member updated successfully',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _dob != null
        ? (DateTime.tryParse(_dob!) ?? now)
        : DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null && mounted) {
      setState(() {
        _dob =
            '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isEdit = widget.member != null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.space24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: AppTokens.brSm,
                    ),
                  ),
                ),
                Gaps.v16,
                Text(
                  isEdit ? 'Edit member' : 'Add family member',
                  style: theme.textTheme.titleLarge,
                ),
                Gaps.v24,

                // Name
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: AppTokens.brMd,
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                Gaps.v16,

                // Relation dropdown
                DropdownButtonFormField<String>(
                  initialValue: _relation,
                  decoration: const InputDecoration(
                    labelText: 'Relation',
                    prefixIcon: Icon(Icons.family_restroom_outlined),
                    border: OutlineInputBorder(
                      borderRadius: AppTokens.brMd,
                    ),
                  ),
                  items: _relations
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setState(() => _relation = v),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Relation is required' : null,
                ),
                Gaps.v16,

                // Date of birth
                InkWell(
                  onTap: _pickDate,
                  borderRadius: AppTokens.brMd,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date of birth',
                      prefixIcon: Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(
                        borderRadius: AppTokens.brMd,
                      ),
                    ),
                    child: Text(
                      _dob != null && _dob!.isNotEmpty
                          ? Fmt.fullDate(_dob!)
                          : 'Select date',
                      style: _dob != null && _dob!.isNotEmpty
                          ? theme.textTheme.bodyLarge
                          : theme.textTheme.bodyLarge
                              ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
                Gaps.v16,

                // Gender
                Text('Gender', style: theme.textTheme.labelLarge),
                Gaps.v8,
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'male',
                      label: Text('Male'),
                      icon: Icon(Icons.male),
                    ),
                    ButtonSegment(
                      value: 'female',
                      label: Text('Female'),
                      icon: Icon(Icons.female),
                    ),
                  ],
                  selected: {_gender},
                  onSelectionChanged: (s) =>
                      setState(() => _gender = s.first),
                ),
                Gaps.v24,

                // Save button
                FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTokens.space16,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEdit ? 'Save changes' : 'Add member'),
                ),
                Gaps.v8,
                OutlinedButton(
                  onPressed: _saving ? null : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTokens.space16,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
