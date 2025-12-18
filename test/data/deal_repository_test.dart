import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';
import 'package:ptcbjahid/data/network/api_client.dart';
import 'package:ptcbjahid/data/repositories/deal_repository.dart';
// Generate Mock for ApiClient
@GenerateMocks([ApiClient])
import 'deal_repository_test.mocks.dart';

void main() {
  late DealRepository repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    // Note: You'll need to update DealRepository constructor to accept an optional
    // ApiClient for testing, or use dependency injection.
    // For this example, assume we injected it:
    repository = DealRepository(apiClient: mockApiClient);
  });

  group('DealRepository Tests', () {
    test('returns list of deals when API call is successful', () async {
      // Arrange
      final mockResponse = DealResponse(
        deals: [DealData(id: 123, title: "Mock Deal")],
      );

      when(
        mockApiClient.getTopDeals(any, any, any, any),
      ).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.fetchDeals(type: DealType.top, page: 1);

      // Assert
      expect(result.length, 1);
      expect(result.first.id, 123);
      verify(mockApiClient.getTopDeals(any, 10, 1, any)).called(1);
    });
  });
}
