import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_leaderboard_repository/models/leaderboard_models.dart';

void main() {
  group('LeaderboardEntryModel Parsing', () {
    test('successfully parses global leaderboard JSON with entries key', () {
      final json = {
        "success": true,
        "message": "تم جلب لوحة الشرف بنجاح",
        "data": {
          "title": "أفضل الطلاب في النظام",
          "type": "GLOBAL",
          "entityId": null,
          "entries": [
            {
              "rank": 1,
              "studentId": 1,
              "studentName": "shams hisham sabry string",
              "studentCode": "S0001",
              "score": 46,
              "totalMarks": 71,
              "percentage": 64.93506493506493,
              "quizId": null,
              "quizTitle": null,
              "courseId": null,
              "courseName": null,
              "completedAt": null
            },
            {
              "rank": 2,
              "studentId": 4,
              "studentName": "خالد عمر عبدالعزيز فاروق",
              "studentCode": "S0004",
              "score": 45,
              "totalMarks": 61,
              "percentage": 73.78787878787878,
              "quizId": null,
              "quizTitle": null,
              "courseId": null,
              "courseName": null,
              "completedAt": null
            }
          ],
          "totalParticipants": 10,
          "averageScore": null,
          "highestScore": null,
          "lowestScore": null
        },
        "timestamp": "2026-05-14T11:09:20.927574417"
      };

      // 1. Extract data object
      final dataMap = ModelParser.extractData(json);
      expect(dataMap['title'], equals('أفضل الطلاب في النظام'));

      // 2. Extract entries list
      final entriesList = ModelParser.asList(dataMap);
      expect(entriesList, isNotEmpty);
      expect(entriesList.length, equals(2));

      // 3. Map to models
      final models = entriesList
          .map((e) => LeaderboardEntryModel.fromJson(ModelParser.asMap(e)))
          .toList();

      expect(models[0].rank, equals(1));
      expect(models[0].studentName, equals('shams hisham sabry string'));
      expect(models[0].points, equals(46)); // score field in API maps to points
      expect(models[0].score, closeTo(64.93, 0.01)); // percentage field in API maps to score
      expect(models[0].studentId, equals('1')); // studentId (int) should be parsed as String

      expect(models[1].rank, equals(2));
      expect(models[1].studentName, equals('خالد عمر عبدالعزيز فاروق'));
    });
  });
}
