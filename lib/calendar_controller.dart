/// Support for doing something awesome.
///
/// More dartdocs go here.
library calendar_controller;

export 'src/calendar_controller_base.dart';

// TODO: Export any libraries intended for clients of this package.

/// A Class generates a calendar of one month.
class CalendarController {

  /// Set a boolean; if true, it means a start of week is Monday, or Sunday.
  late bool startFromMonday;

  ///
  /// GENERATE DATA
  /// 
  /// Generate a calendar of one month which includes [date].
  List<List<int?>> build(DateTime date) {
    
    final calendar = <List<int?>>[];

    final firstWeekday = getFirstWeekday(date);
    final lastWeekday = getLastWeekday(date);
    final previousMonthLastDay = getLastDays(date)['previous'] as int;
    final baseMonthLastDay = getLastDays(date)['base'] as int;

    /// 1週間の始まりが月曜日の場合
    if (startFromMonday) {

      final firstWeek = List.generate(7, (index) {
        final i = index + 1;
        final diff = i - firstWeekday;
        // 下記の`.. lastDayLastMonth..`について、diffに1を足して前月末の日から計算させて前月の並びの数値を調整
        return i < firstWeekday ? previousMonthLastDay + (diff + 1) : 1 + diff; 
      });

      calendar.add(firstWeek);

      // Start point of generating weeks after firstWeek.
      while (calendar.last.last! <= baseMonthLastDay) {

        int startOfNextWeek = calendar.last.last! + 1;

        // Generate a week
        final week = List.generate(7, (index) {
          return startOfNextWeek + index;
        });
        
        // If a week contains base month's last day, make last week individually
        if (week.contains(baseMonthLastDay)) {
          
          final lastWeek = List.generate(7, (index) {
            final i = index;
            final diff = i - lastWeekday;
            return i < lastWeekday ? baseMonthLastDay + (diff + 1) : 1 + diff; 
          });

          calendar.add(lastWeek);
          break;
        }

        calendar.add(week);
      }
    } else {

      final firstWeek = List.generate(7, (index) {
        final i = index;
        final diff = i - firstWeekday;
        return i < firstWeekday ? previousMonthLastDay + (diff + 1) : 1 + diff;
      });

      calendar.add(firstWeek);

      // Start point of generating weeks after firstWeek.
      while (calendar.last.last! <= baseMonthLastDay) {

        int startOfNextWeek = calendar.last.last! + 1;

        // Generate a week
        final week = List.generate(7, (index) {
          return startOfNextWeek + index;
        });
        
        // If a week contains base month's last day, make last week individually
        if (week.contains(baseMonthLastDay)) {
          
          final lastWeek = List.generate(7, (index) {
            final i = index;
            final diff = i - lastWeekday;
            return i <= lastWeekday ? baseMonthLastDay + (diff) : diff; 
          });

          calendar.add(lastWeek);
          break;
        }

        calendar.add(week);
      }
    }

    return calendar;
  }

  ///
  /// FUNCTIONS
  /// 
  /// Returns a first weekday(Type of int; 1 = Monday, 7 = Sunday)
  /// of [date] belongs to.
  int getFirstWeekday(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  /// Returns a weekday of last day of [date] belongs to.
  int getLastWeekday(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).weekday;
  }

  /// Returns last days for both of a base month(set as the argument) and its previous one.
  Map<String, int> getLastDays(DateTime date) {

    var mapData = <String, int>{
      'previous': 0,
      'base': 0,
    };
    
    final int previousMonthLastDay = DateTime(date.year, date.month, 0).day;
    final int baseMonthLastDay = DateTime(date.year, date.month + 1, 0).day;

    mapData['previous'] = previousMonthLastDay;
    mapData['base'] = baseMonthLastDay;

    final lastDaysMap = Map<String, int>.unmodifiable(mapData);

    return lastDaysMap;
  }
}