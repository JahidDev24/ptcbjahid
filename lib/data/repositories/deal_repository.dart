import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ptcbjahid/core/constants.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';
import 'package:ptcbjahid/data/network/api_client.dart';
import '../../core/errors/api_error_handler.dart';
import '../localDB/deal_local_data_source.dart';

enum DealType { top, popular, featured }

class DealRepository {
  late ApiClient _client;

  final DealLocalDataSource _localDataSource = DealLocalDataSource();
  DealRepository({ApiClient? apiClient}) {
    if (apiClient != null) {
      _client = apiClient; // Use the mock passed from tests
    } else {
      final dio = Dio();
      dio.options.headers["Content-Type"] = "application/json";
      _client = ApiClient(dio); // Use real Dio for the app
    }
  }

  Future<List<DealData>> fetchDeals({
    required DealType type,
    required int page,
  }) async {
    try {
      var response;
      // Selecting endpoint based on Tab
      switch (type) {
        case DealType.top:
          response = await _client.getTopDeals(
            AppConstants.clientId,
            10,
            page,
            AppConstants.fields,
          );
          break;
        case DealType.popular:
        case DealType.featured:
          response = await _client.getDiscussedDeals(
            AppConstants.clientId,
            10,
            page,
            AppConstants.fields,
          );
          break;
      }
      log("i am here : $response");
      final remoteDeals = response.deals ?? [];

      // 2. If successful (and it's the first page), save to DB
      if (page == 1 && remoteDeals.isNotEmpty) {
        await _localDataSource.cacheDeals(remoteDeals);
      }

      return remoteDeals;
    } catch (e) {
      // PASS ERROR TO HANDLER
      if (page == 1) {
        // Only load cache for initial view
        try {
          final localDeals = await _localDataSource.getLastDeals();
          if (localDeals.isNotEmpty) {
            return localDeals; // Return cached data
          }
        } catch (_) {
          // If DB fails too, ignore and throw original error
        }
      }

      // 4. Throw original error to be handled by UI
      final String errorMessage = ApiErrorHandler.parseError(e);
      throw errorMessage;
    }
  }
}
