/// Support for doing something awesome.
///
/// More dartdocs go here.
library calendar_controller;

export 'src/calendar_dart_base.dart';

// TODO: Export any libraries intended for clients of this package.

/// A Class generates a calendar of one month.

void main() {
  var calendarController = CalendarController();
  print(calendarController.build(DateTime.now()));
}

class CalendarController {

  /// Set a boolean; if true, it means a start of week is Monday, or Sunday.
  late bool startFromMonday = false;

  /// Generate a calendar of one month which includes [date].
  List<List<int?>> build(DateTime date) {
    
    final calendar = <List<int?>>[];

    final firstWeekday = getFirstWeekday(DateTime.now());
    final previousMonthLastDay = getLastDays(DateTime.now())['previous'] as int;
    final baseMonthLastDay = getLastDays(DateTime.now())['base'] as int;

    /// 1週間の始まりが月曜日の場合
    if (startFromMonday) {

      final firstWeek = List.generate(7, (index) {
        final i = index + 1;
        final diff = i - firstWeekday;
        // 下記の`.. lastDayLastMonth..`について、diffに1を足して前月末の日から計算させて前月の並びの数値を調整
        return i < firstWeekday ? previousMonthLastDay + (diff + 1) : 1 + diff; 
      });

      calendar.add(firstWeek);

    } else {

      final firstWeek = List.generate(7, (index) {
        final i = index;
        final diff = i - firstWeekday;
        return i < firstWeekday ? previousMonthLastDay + (diff + 1) : 1 + diff;
      });

      calendar.add(firstWeek);
    }

    return calendar;
  }


  /// Returns a weekday(Type of int; 1 = Monday, 7 = Sunday)
  /// of [date] belongs to.
  int getFirstWeekday(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  /// Returns last days for both of a base month(set as the argument) and its previous one.
  Map<String, int> getLastDays(DateTime date) {

    const Map<String, int> mapData = {};
    
    final int previousMonthLastDay = DateTime(date.year, date.month, 0).day;
    final int baseMonthLastDay = DateTime(date.year, date.month + 1, 0).day;

    mapData['previous'] = previousMonthLastDay;
    mapData['base'] = baseMonthLastDay;

    return mapData;
  }

}