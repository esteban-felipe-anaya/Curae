import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/providers.dart';
import 'core/storage/token_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env (the backend base URL lives here). Optional so the app still runs
  // if the file is absent — it falls back to a --dart-define or platform default.
  await dotenv.load(fileName: '.env', isOptional: true);

  // Load persisted state so providers can read it synchronously.
  final prefs = await SharedPreferences.getInstance();
  const storage = FlutterSecureStorage();
  final tokenStore = TokenStore(storage);
  await tokenStore.load();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        secureStorageProvider.overrideWithValue(storage),
        tokenStoreProvider.overrideWithValue(tokenStore),
      ],
      child: const CuraeApp(),
    ),
  );
}
