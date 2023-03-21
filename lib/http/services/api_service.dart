import 'package:motivator/models/quote_model.dart';

import '../../callbacks/http_request_callback.dart';
import '../../http/http_client.dart';
import '../../models/api_response_model.dart';
import '../../utils/constants_util.dart';

class ApiService {
  final HttpClient httpClient;

  ApiService(this.httpClient);

  void handleReponse(ApiResponseModel response, HttpRequestCallback? callback) {
    try {
      callback?.onCompleted();
      if (response.success) {
        callback?.onSuccess(response.message);
      } else {
        callback?.onError(response.message);
      }
    } catch (ex) {
      //..
    }
  }

  Future<void> getFaqs({HttpRequestCallback? callback}) async {
    var response = await httpClient.doGet(ApiEndpoints.getQuotes, isAuth: true);
    try {
      callback?.onCompleted();
      if (response.success) {
        callback?.onSuccess((response.message as List<dynamic>?)
            ?.map((e) => QuoteModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        callback?.onError(response.message);
      }
    } catch (ex) {
      print(ex);
    }
  }
}
