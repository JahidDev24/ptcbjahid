import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';
import 'package:ptcbjahid/data/repositories/deal_repository.dart';
import 'package:ptcbjahid/logic/deal/deal_bloc.dart';

// Generate a Mock class for DealRepository
@GenerateMocks([DealRepository])
import 'deal_bloc_test.mocks.dart';

void main() {
  setUpAll(() {
    // 1. Initialize Hive with a temporary path for testing
    // Since unit tests run on Dart VM (not device), we assign a simple temp path.
    final path = Directory.systemTemp.path;
    Hive.init(path);
  });
  late MockDealRepository mockRepository;
  late DealBloc dealBloc;

  // dummy data for testing
  final mockDeals = [DealData(id: 1, title: "Test Deal", storeName: "Amazon")];

  setUp(() {
    mockRepository = MockDealRepository();
    dealBloc = DealBloc(repository: mockRepository, type: DealType.top);
  });

  tearDown(() {
    dealBloc.close();
  });

  group('DealBloc Tests', () {
    // Test 1: Initial State
    test('Initial state should be DealInitial', () {
      expect(dealBloc.state, DealInitial());
    });

    // Test 2: Successful Fetch
    blocTest<DealBloc, DealState>(
      'emits [DealLoaded] when FetchDeals is added and repository success',
      build: () {
        // Arrange: Tell the mock to return data when called
        when(
          mockRepository.fetchDeals(type: DealType.top, page: 1),
        ).thenAnswer((_) async => mockDeals);
        return dealBloc;
      },
      act: (bloc) => bloc.add(FetchDeals()),
      expect:
          () => [
            // Verify we get a Loaded state with data
            DealLoaded(deals: mockDeals, hasReachedMax: false, page: 1),
          ],
    );

    // Test 3: Failure
    blocTest<DealBloc, DealState>(
      'emits [DealError] when FetchDeals fails',
      build: () {
        // Arrange: Tell the mock to throw an error
        when(
          mockRepository.fetchDeals(type: DealType.top, page: 1),
        ).thenThrow("Network Failure");
        return dealBloc;
      },
      act: (bloc) => bloc.add(FetchDeals()),
      expect: () => [DealError("Network Failure")],
    );
  });
}
