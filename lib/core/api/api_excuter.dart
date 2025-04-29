import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:noya_app/data/models/common/exceptions/server_error.dart';
import 'package:noya_app/data/models/error_model.dart';
import 'api_result.dart';

Future<ApiResult<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return SuccessApiResult(result);
  } on DioException catch (ex) {
    var errorModel = ErrorModel.fromJson(ex.response?.data);
    log(errorModel.message.toString());
    switch (ex.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        {
          return ErrorApiResult(NetworkError(errorModel: errorModel));
        }
      case DioExceptionType.badResponse:
        {
          var responseCode = ex.response?.statusCode ?? 0;
          var errorData = ex.response?.data;

          var errorModel = (errorData is Map<String, dynamic>)
              ? ErrorModel.fromJson(errorData)
              : ErrorModel(message: "Unknown error");

          if (responseCode != 0 && responseCode >= 400 && responseCode < 500) {
            return ErrorApiResult(ClientError(message: errorModel.message));
          }
          if (responseCode != 0 && responseCode >= 500 && responseCode < 600) {
            return ErrorApiResult(ServerError(errorModel: errorModel));
          }
          return ErrorApiResult(Exception("Unexpected response error"));
        }
      default:
        {
          return ErrorApiResult(Exception("Something went wrong"));
        }
    }
  } on Exception catch (ex) {
    return ErrorApiResult(ex);
  }
}

/*import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/domain/common/exceptions/server_error.dart';
import 'package:flora_mart/domain/entity/error_model.dart';

Future<ApiResult<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return SuccessApiResult(result);
  }


  on DioException catch (ex) {
    var errorModel = ErrorModel.fromJson(ex.response?.data);
    log(errorModel.message.toString());
    switch (ex.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        {
          return ErrorApiResult(NetworkError(errorModel: errorModel));
        }
      case DioExceptionType.badResponse:
        {
          var responseCode = ex.response?.statusCode ?? 0;
          var errorData = ex.response?.data;

          var errorModel = (errorData is Map<String, dynamic>)
              ? ErrorModel.fromJson(errorData)
              : ErrorModel(message: "Unknown error");

          if (responseCode != 0 && responseCode >= 400 && responseCode < 500) {
            print("$responseCode");
            return ErrorApiResult(ClientError(message: errorModel.message));
          }

          if (responseCode != 0 && responseCode >= 500 && responseCode < 600) {
            return ErrorApiResult(ServerError(errorModel: errorModel));
          }
          return ErrorApiResult(Exception("Unexpected response error"));
        }
      default:
        {
          return ErrorApiResult(Exception("Something went wrong"));
        }
    }
  } on Exception catch (ex) {
    print(" $ex 😁🤑👆❤️⭐");
    return ErrorApiResult(ex);
  }
}

/// Executes an API call and handles potential exceptions.
///
/// This function takes an asynchronous function [apiCall] that performs an API request.
/// It executes the request and returns a [Result] object encapsulating either the
/// successful response or an error.
///
//================== Usage ================\\
//
// Future<ApiResult<bool>> verifyResetCode({required String code}) async {
//     return await executeApi<bool>(() async {
//       var apiResponse = await apiManager.postRequest(
//         endPoint: ApiEndpoints.verifyResetCodeEndpoint,
//         body: {
//           "resetCode": code,
//         },
//       );
//       if (apiResponse.data != null && apiResponse.data["status"] == "Success") {
//         print("✅same code✅");
//         return true;
//       } else {
//         return false;
//       }
//     });
//   }

//================== Usage ================\\

///
/// If the request succeeds, it returns `Success<T>` with the result.
/// If an error occurs, it returns an `Error` containing details about the failure.
///
/// Errors handled:
/// - Network-related issues (timeouts, connection errors)
/// - Client errors (HTTP 4xx responses)
/// - Server errors (HTTP 5xx responses)
/// - Unexpected errors
///
/// [T] is the type of data expected in the successful response.
*/