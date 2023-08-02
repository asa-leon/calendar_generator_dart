import 'package:calendar_dart/calendar_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final calendarController = CalendarController();

    setUp(() {
      // Additional setup goes here.
    });

    test('functions in build scope returns accurate number', () {
      expect(calendarController.getFirstWeekday(DateTime.now()), 2);
      expect(calendarController.getLastDays(DateTime.now()), {'previous': 31, 'base': 31});
    });
  });
}
