import 'package:dio/dio.dart';
import 'package:f_set/models/score.dart';
import 'package:supercharged/supercharged.dart';

class ApiClient {
  ApiClient(this._dio);

  // ignore: unused_field
  final Dio _dio;

  Future<List<Score>> getHighScores() async {
    // use _dio to get score from server
    return [
      Score(
        name: 'Enikő',
        time: 2.5.minutes,
      ),
      Score(
        name: 'Sasha',
        time: 3.1.minutes,
      ),
      Score(
        name: 'Oren',
        time: 3.9.minutes,
      ),
    ];
  }
}
