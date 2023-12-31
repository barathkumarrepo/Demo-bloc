import '../../model/HomeResponseModel.dart';
import '../../utils/end_points_constants.dart';
import '../../utils/logger.dart';
import '../dio_client.dart';

class HomeRepository {
  final ApiClient _client = ApiClient();

  Future<HomeResponseModel?> fetchHome() async {
    final response = await _client.get(EndPointConstants.homeScreenUrl);

    Logger.appLogs('callBackResponse:: $response');
    if (response != null) {
      //Success returning data back
      Logger.appLogs('responseRepo:: $response');
      return HomeResponseModel.fromJson(response as Map<String, dynamic>);
    } else {
      //Failed returning null
      Logger.appLogs('errorNull:: $response');
      return null;
    }
  }
}


class HomeScreenException implements Exception {
  HomeScreenException(this.message);

  final String message;
}
