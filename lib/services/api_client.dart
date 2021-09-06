import 'package:dio/dio.dart';
import 'package:f_set/models/score.dart';
import 'package:supercharged/supercharged.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<List<Score>> getHighScores() async {
    // use _dio to get scores from server
    return [
      Score(
        name: 'Enikő',
        time: 2.5.minutes,
      ),
      Score(
        name: 'Adél',
        time: 3.1.minutes,
      ),
      Score(
        name: 'Attila',
        time: 3.9.minutes,
      ),
      Score(
        name: 'Zsuzsi',
        time: 4.2.minutes,
      ),
      Score(
        name: 'David',
        time: 4.7.minutes,
      ),
      Score(
        name: 'Jimmy',
        time: 5.12.minutes,
      ),
      Score(
        name: 'Oren',
        time: 7.2.minutes,
      ),
    ];
  }
}
