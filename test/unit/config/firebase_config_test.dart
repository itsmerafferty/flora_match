// SPRINT 1 - Auth skeleton test file
// Location: test/unit/config/firebase_config_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flora_match/config/environment_config.dart';

void main() {
  group('Environment Config', () {
    test('Should identify current environment', () {
      expect(EnvironmentConfig.isDev, isTrue);
      expect(EnvironmentConfig.isStaging, isFalse);
      expect(EnvironmentConfig.isProd, isFalse);
    });

    test('Should have valid Firebase config for dev', () {
      final config = EnvironmentConfig.activeFirebaseConfig;
      expect(config.projectId, isNotEmpty);
      expect(config.apiKey, isNotEmpty);
      expect(config.appId, isNotEmpty);
    });

    test('Should use dev Xendit API key in dev environment', () {
      expect(EnvironmentConfig.xenditApiKey, contains('development'));
    });
  });
}
