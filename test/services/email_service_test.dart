import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pennypilot/src/services/email_service.dart';
import 'package:pennypilot/src/services/auth_service.dart';
import 'package:pennypilot/src/services/receipt_extraction_service.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';
import 'package:pennypilot/src/services/categorization_service.dart';
import 'package:pennypilot/src/services/privacy_service.dart';
import 'package:isar/isar.dart';

class MockAuthService extends Mock implements AuthService {}
class MockReceiptExtractionService extends Mock implements ReceiptExtractionService {}
class MockSubscriptionIntelligenceService extends Mock implements SubscriptionIntelligenceService {}
class MockCategorizationService extends Mock implements CategorizationService {}
class MockPrivacyService extends Mock implements PrivacyService {}
class MockIsar extends Mock implements Isar {}

void main() {
  late EmailService service;
  late MockAuthService mockAuth;
  late MockReceiptExtractionService mockReceipt;
  late MockSubscriptionIntelligenceService mockSub;
  late MockCategorizationService mockCat;
  late MockPrivacyService mockPrivacy;
  late MockIsar mockIsar;

  setUp(() {
    mockAuth = MockAuthService();
    mockReceipt = MockReceiptExtractionService();
    mockSub = MockSubscriptionIntelligenceService();
    mockCat = MockCategorizationService();
    mockPrivacy = MockPrivacyService();
    mockIsar = MockIsar();

    service = EmailService(
      mockAuth,
      mockReceipt,
      mockSub,
      mockCat,
      mockPrivacy,
      mockIsar,
    );
  });

  group('EmailService Tests', () {
    test('scanEmails returns 0 when no emails connected', () async {
      when(() => mockPrivacy.isLocalOnlyMode).thenReturn(false);
      when(() => mockAuth.connectedEmails).thenReturn({});

      final result = await service.scanEmails();

      expect(result, 0);
      verifyNever(() => mockSub.detectSubscriptions());
    });

    test('scanEmails returns 0 when local-only mode is active', () async {
      when(() => mockPrivacy.isLocalOnlyMode).thenReturn(true);

      final result = await service.scanEmails();

      expect(result, 0);
      verifyNever(() => mockAuth.connectedEmails);
    });

    test('previewScan returns empty list when no emails connected', () async {
      when(() => mockAuth.connectedEmails).thenReturn({});

      final result = await service.previewScan();

      expect(result, isEmpty);
    });
  });
}
