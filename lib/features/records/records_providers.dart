import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/records.dart';

final recordsProvider = FutureProvider<HealthRecords>(
  (ref) => ref.watch(contentRepositoryProvider).records(),
);
