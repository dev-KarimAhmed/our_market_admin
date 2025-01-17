import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market_admin/core/api_services.dart';
import 'package:our_market_admin/core/sensitive_data.dart';
import 'package:our_market_admin/core/shared_pref.dart';
import 'package:our_market_admin/features/products/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final ApiServices _apiServices = ApiServices();

  List<ProductModel> products = [];
  Future<void> getProducts() async {
    emit(GetProductsLoading());
    try {
      String? token = await SharedPref.getToken();

      Response response = await _apiServices.getData("products_table", token);
      for (Map<String, dynamic> product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      emit(GetProductsSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetProductsError());
    }
  }
 String imageUrl = "";
  Future<void> uploadImage(
      {required Uint8List image,
      required String imageName,
      required String bucketName}) async {
    emit(UploadImageLoading());
    const String _storageBaseUrl =
        "https://itjstiahcigzhbrwggfz.supabase.co/storage/v1/object"; 
    const String apiKey = anonKey;
    final String? token = await SharedPref.getToken();
    final String uploadUrl = "$_storageBaseUrl/$bucketName/$imageName";
    final Dio _dio = Dio();
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        image,
        filename: imageName,
      ),
    });
    try {
      Response response = await _dio.post(
        data: formData,
        uploadUrl,
        options: Options(
          headers: {
            "apiKey": apiKey,
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data"
          },
        ),
      );
      if (response.statusCode == 200) {
        imageUrl = "https://itjstiahcigzhbrwggfz.supabase.co/storage/v1/object/public/${response.data["Key"]}";
        emit(UploadImageSuccess());
      } else {

        emit(UploadImageError());
      }
    } catch (e) {
      print(e.toString());
      emit(UploadImageError());
    }
  }
}
