class HttpRequestCallback {
  /// Called when http request is completed
  final void Function() onCompleted;

  /// Called when http request is successful
  ///  * [message] is a dynamic object returned by the http server response
  final void Function(dynamic message) onSuccess;

  /// Called when http request fail
  ///  * [message] is a dynamic object returned by the http server response
  final void Function(dynamic message) onError;

  HttpRequestCallback(
      {required this.onCompleted,
      required this.onSuccess,
      required this.onError});
}
