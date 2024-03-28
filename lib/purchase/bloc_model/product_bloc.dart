import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikaru_e_shop/purchase/bloc_model/product_model.dart';
import 'package:hikaru_e_shop/repository/hs_repository.dart';

abstract class GetProductState {}

abstract class GetProductEvent {}

class PostGetAllProduct extends GetProductEvent {}

class PostGetCategoryProduct extends GetProductEvent {
  final String category;

  PostGetCategoryProduct({required this.category});
}

class InitialGetProduct extends GetProductState {}

class LoadingGetProduct extends GetProductState {}

class SuccessfulGetAllProduct extends GetProductState {
  final ProductModel? output;

  SuccessfulGetAllProduct({this.output});
}

class SuccessfulGetCategoryProduct extends GetProductState {
  final ProductModel? output;

  SuccessfulGetCategoryProduct({this.output});
}

class FailedGetProduct extends GetProductState {
  final String msg;

  FailedGetProduct({required this.msg});
}

class ErrorGetProduct extends GetProductState {}

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  GetProductBloc() : super(InitialGetProduct()) {
    on<PostGetAllProduct>(_onPostGetAllProduct);
    on<PostGetCategoryProduct>(_onPostGetCategoryProduct);
  }
  _onPostGetAllProduct(
      PostGetAllProduct event, Emitter<GetProductState> emit) async {
    HikaShopRepository mRepo = HikaShopRepository();

    emit(
      LoadingGetProduct(),
    );
    try {
      final result = await mRepo.fetchAllProducts();
      final output = ProductModel.fromJson(
        jsonDecode(result),
      );
      emit(
        SuccessfulGetAllProduct(output: output),
      );
    } catch (err) {
      emit(
        ErrorGetProduct(),
      );
    }
  }

  _onPostGetCategoryProduct(
      PostGetCategoryProduct event, Emitter<GetProductState> emit) async {
    HikaShopRepository mRepo = HikaShopRepository();

    emit(
      LoadingGetProduct(),
    );
    try {
      final result = await mRepo.fetchProductByCategory(event.category);
      final output = ProductModel.fromJson(
        jsonDecode(result),
      );
      emit(
        SuccessfulGetCategoryProduct(output: output),
      );
    } catch (err) {
      emit(
        ErrorGetProduct(),
      );
    }
  }
}
