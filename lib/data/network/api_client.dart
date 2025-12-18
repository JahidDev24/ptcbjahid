import 'package:ptcbjahid/core/constants.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Endpoint for "Top" tab
  @GET("/new")
  Future<DealResponse> getTopDeals(
    @Header("X-Desidime-Client") String clientId,
    @Query("per_page") int perPage,
    @Query("page") int page,
    @Query("fields") String fields,
  );

  // Endpoint for "Popular" and "Featured" tabs
  @GET("/discussed")
  Future<DealResponse> getDiscussedDeals(
    @Header("X-Desidime-Client") String clientId,
    @Query("per_page") int perPage,
    @Query("page") int page,
    @Query("fields") String fields,
  );
}
