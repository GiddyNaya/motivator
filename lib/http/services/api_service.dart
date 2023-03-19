import '../../callbacks/http_request_callback.dart';
import '../../http/http_client.dart';
import '../../models/api_response_model.dart';

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

//   Future<void> getFaqs({HttpRequestCallback? callback}) async {
//     var response = await httpClient.doGet(app_constants.ApiEndpoints.GetFaqs,
//         isAuth: true);
//     try {
//       callback?.onCompleted();

//       if (response.success) {
//         callback?.onSuccess((response.message as List<dynamic>?)
//             ?.map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
//             .toList());
//       } else {
//         callback?.onError(response.message);
//       }
//     } catch (ex) {
//       //..
//     }
//   }

// // SystemContact
//   Future<void> createSystemContact(SystemContactModel model,
//       {HttpRequestCallback? callback}) async {
//     var response = await httpClient.doPost(
//         app_constants.ApiEndpoints.CreateSystemContact,
//         isAuth: true,
//         body: model.toJson());
//     handleReponse(response, callback);
//   }
}
