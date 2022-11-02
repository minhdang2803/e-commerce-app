import 'dart:convert';
import 'package:dio/dio.dart';
import 'config.dart';
import 'package:crypto/crypto.dart';

class PaymentService {
  late Dio _dio;
  PaymentService() {
    _dio = Dio(BaseOptions(
      baseUrl: vnpUrl,
      connectTimeout: 15000,
      receiveTimeout: 13000,
    ));
    initializeInterceptors();
  }

  Future<Response> getRequest() async {
    Response response;
    try {
      response = await _dio.get(vnpUrl);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest() async {
    Response response;
    try {
      response = await _dio.post(vnpUrl,
          options: Options(responseType: ResponseType.stream));
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) => print(error.message),
      onRequest: (request, handler) => {},
      onResponse: (response, handler) => {print(response)},
    ));
  }
}

String getPaymentUrl(String amount) {
  String url = '';
  final params = <String, String>{
    'vnp_Amount': (int.parse(amount) * 100).toString(),
    'vnp_Command': vnpCommand,
    'vnp_CreateDate': DateTime.now()
        .toString()
        .replaceAll(RegExp(r'-|:| '), '')
        .split('.')
        .first,
    'vnp_CurrCode': 'VND',
    'vnp_IpAddr': vnpIpAddr,
    'vnp_Locale': 'vn',
    'vnp_OrderInfo': 'Payment Sample',
    'vnp_OrderType': 'other',
    'vnp_ReturnUrl': vnpReturnUrl,
    'vnp_TmnCode': vnpTmnCode,
    'vnp_TxnRef': DateTime.now().millisecondsSinceEpoch.toString(),
    'vnp_Version': vnpVersion,
  };
  params.forEach((key, value) {
    if (value.isNotEmpty) {
      url += '$key=$value';
      if (key != 'vnp_Version') {
        url += '&';
      }
    }
  });
  Hmac hmacSha512 = Hmac(sha512, ascii.encode(vnpHashSecret));
  String vnpSecureHash = hmacSha512.convert(ascii.encode(url)).toString();
  sha512.convert;
  url += '&vnp_SecureHash=$vnpSecureHash';
  String paymentUrl = '$vnpUrl?$url';
  return paymentUrl;
}
