import '../../utils/base_equatable.dart';

abstract class ProductPageEvent extends BaseEquatable {}

class productPageInitialEvent extends ProductPageEvent {
  @override
  String toString() {
    return "productPageInitialEvent";
  }
}

class productPageSucessEvent extends ProductPageEvent {
  @override
  String toString() {
    return "productPageSucessEvent";
  }
}
class productPageloadingEvent extends ProductPageEvent {
  @override
  String toString() {
    return "productPageloadingEvent";
  }
}





