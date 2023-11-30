import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/config/locator.dart';
import 'package:sample/model/HomeResponseModel.dart';
import 'package:sample/services/repositories/home_repo.dart';
import 'package:sample/src/bloc/product_event.dart';

import '../../utils/generic_exception.dart';
import '../../utils/logger.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductPageEvent, ProductPageState> {

  ProductBloc() : super(ProductPageInitialState()) {

    on<productPageInitialEvent>(ProductInitialEventfun);
    on<productPageloadingEvent>(ProductLoadingEventfun);
  }

  final HomeRepository _homeRepository = locator<HomeRepository>();

  //Model
  HomeResponseModel? _homeResponseModel;

  List<Product>? products = [];
  int? userId;

  // ProductBloc(ProductState initialState) : super(initialState);

  @override
  ProductPageState get initialState => ProductPageInitialState();


  Future<FutureOr<void>> ProductInitialEventfun(productPageInitialEvent event,Emitter<ProductPageState> emit,) async {

    emit.call(ProductPageLoadingState());

    try {
      var data = await _homeRepository.fetchHome();
      if (data != null) {
        _homeResponseModel = data;
        // products.add(data.products);
        print("data::${data.products![0].title}");
        products!.addAll(data.products!.toList());
        print("prouctdata::${products}");
        //Success State
        emit.call(ProductPageSuccessState());
      }else{
        //Failed
        //Failure State
        emit.call(ProductPageLoadingState());
      }
    } on AppException catch (appException) {
      Logger.appLogs('errorType:: ${appException.type}');
      Logger.appLogs('onFailure:: $appException');
       var snackdemo = SnackBar(
        content: Text(appException.type.toString(),style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF9575CD),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      BuildContext? context;
      ScaffoldMessenger.of(context!).showSnackBar(snackdemo);

      //Failed
      //Idle / Failure State
      emit.call(ProductPageLoadingState());
    }

    // user = await PreferenceHelper.getUser();
    // MyFavouriteResponse _myFavouriteResponse =
    // await StudentEventRepository.getFavouriteList(userId);
    //
    // if (_myFavouriteResponse.errors != null) {
    //   emit.call(MyFavouriteErrorState(_myFavouriteResponse.errors));
    // } else {
    //   eventDetailsList = _myFavouriteResponse.favoutiteListResponse!.reversed
    //       .map((e) => e.favouriteEvent)
    //       .toList();
    //   emit.call(MyFavouriteSuccessState());
    // }

  }
  Future<FutureOr<void>> ProductLoadingEventfun(productPageloadingEvent event,Emitter<ProductPageState> emit,) async {

  }
  }





