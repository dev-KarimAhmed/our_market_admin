import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market_admin/core/api_services.dart';

part 'add_admin_state.dart';

class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit() : super(AddAdminInitial());

  ApiServices _apiServices = ApiServices();

  Future<void> createAnAccount(Map<String, dynamic> data) async {
    emit(AddAdminLoading());
    try {
      Response response = await _apiServices.createAnAccount(data);
      if (response.statusCode == 200) {
        emit(AddAdminSuccess());
      } else {
        emit(AddAdminError(message: response.data["msg"]));
      }
      // print(response.data);
    } catch (e) {
      emit(AddAdminError(message: e.toString()));
    }
  }
}
