import 'dart:developer';

import 'package:charchters/constant/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 20 * 1000),
      receiveTimeout: const Duration(milliseconds: 20 * 1000),
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharrachters() async {
    try {
      Response response = await dio.get(
        "species-list",
        queryParameters: {
          "key": "sk-K3Ci66f2cdfc36f606979",
        },
      );
      //log("Response Data: >>>>>>>>>> ${response.data['data']}", name: 'getAllCharrachters');
      return response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
