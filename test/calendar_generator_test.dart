import 'package:calendar_generator/calendar_generator.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('functions in build scope returns accurate number', () {

      final DateTime date = DateTime(2023, 8);

      final calendarController = CalendarGenerator();
      calendarController.startFromMonday = false;
      
      final calendarData = calendarController.build(date);

      expect(calendarController.getFirstWeekday(date), 2);

      expect(calendarController.getLastWeekday(date), 4);

      expect(calendarController.getLastDays(date), {'previous': 31, 'base': 31});

      expect(calendarData, [
        [30, 31, 1, 2, 3, 4, 5],
        [6, 7, 8, 9, 10, 11, 12],
        [13, 14, 15, 16, 17, 18, 19],
        [20, 21, 22, 23, 24, 25, 26],
        [27, 28, 29, 30, 31, 1, 2]
      ]);
    });
  });
}
