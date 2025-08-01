import 'package:dio/dio.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  /// Handles error for Dio Class
  static String handleError(DioException? error) {
    String errorDescription = "";
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout";
          break;
        case DioExceptionType.unknown:
          errorDescription = "Check your Internet Connection";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout";
          break;
        case DioExceptionType.badResponse:
          // --- PERUBAHAN DI SINI ---
          // Mencoba untuk mendapatkan pesan error dari respons server.
          if (error.response?.data is Map<String, dynamic>) {
            final responseData = error.response!.data as Map<String, dynamic>;
            // Jika ada field 'message' di dalam respons, gunakan itu.
            if (responseData.containsKey('message')) {
              errorDescription = responseData['message'].toString();
            } else {
              // Jika tidak, kembali ke pesan default.
              errorDescription =
                  "Received invalid status code: ${error.response?.statusCode}";
            }
          } else {
            errorDescription =
                "Received invalid status code: ${error.response?.statusCode}";
          }
          break;
        // --- AKHIR PERUBAHAN ---
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout";
          break;
        case DioExceptionType.badCertificate:
          errorDescription =
              "Check your Internet Connection (Incorrect certificate)";
          break;
        case DioExceptionType.connectionError:
          errorDescription =
              "Check your Internet Connection (Check server IP in settings)";
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }
}
