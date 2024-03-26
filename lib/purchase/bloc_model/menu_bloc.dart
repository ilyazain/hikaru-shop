import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/menu_model.dart';
import 'package:hikaru_e_shop/repository/hs_repository.dart';

abstract class GetMenuState {}

abstract class GetMenuEvent {}

class PostGetMenu extends GetMenuEvent {
  // final String userName;

  // PostGetMenu({required this.userName});
}

class InitialGetMenu extends GetMenuState {}

class LoadingGetMenu extends GetMenuState {}

class SuccessfulGetMenu extends GetMenuState {
  final MenuModel? output;

  SuccessfulGetMenu({this.output});
}

class FailedGetMenu extends GetMenuState {
  final String msg;

  FailedGetMenu({required this.msg});
}

class ErrorGetMenu extends GetMenuState {}

class GetMenuBloc extends Bloc<GetMenuEvent, GetMenuState> {
  GetMenuBloc() : super(InitialGetMenu()) {
    on<PostGetMenu>(_onPostGetMenu);
  }
  _onPostGetMenu(PostGetMenu event, Emitter<GetMenuState> emit) async {
    HikaShopRepository mRepo = HikaShopRepository(
        // client: MyImmClient(
        //   baseUrl: serverHost,
        // ),
        );

    emit(
      LoadingGetMenu(),
    );
    try {
      final result = await mRepo.fetchProducts();
      final json = jsonDecode(result);

      // if (json["status"] == "success") {
      final output = MenuModel.fromJson(
        jsonDecode(result),
      );
      emit(
        SuccessfulGetMenu(output: output),
      );
      // } else {
      // final message = json["message"];
      // emit(
      //   FailedGetMenu(msg: "No output"),
      // );
      // }
    } catch (err) {
      print(
        "error: " + err.toString(),
      );
      emit(
        ErrorGetMenu(),
      );
    }
  }
}
