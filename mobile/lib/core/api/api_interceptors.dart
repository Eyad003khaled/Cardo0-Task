import 'package:dio/dio.dart';




class ApiInterceptor extends Interceptor {

  ApiInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {



    // Add platform information to the headers
    options.headers['content-type'] = 'application/json';



    super.onRequest(options, handler);
  }
}

