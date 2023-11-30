import '../../utils/base_equatable.dart';

abstract class ProductPageState extends BaseEquatable {}

class ProductPageInitialState extends ProductPageState {
  @override
  String toString() {
    return "ProductPageInitialState";
  }
}

class ProductPageLoadingState extends ProductPageState {
  @override
  String toString() {
    return "ProductPageLoadingState";
  }
}

class ProductPageSuccessState extends ProductPageState {
  // final String? message;
  // ProductPageSuccessState(this.message);

  @override
  bool operator ==(Object other) => false;

  String toString() {
    return "ProductPageSuccessState";
  }
}


class LoadingState extends ProductPageState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "LoadingState";
  }
}
