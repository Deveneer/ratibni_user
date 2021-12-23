import 'package:ratibni_user/app/core/constants/app_strings.dart';

extension DateTimeStringProvider on DateTime {
  String provideDateString() {
    return '${TimeProvider.monthList[this.month - 1].substring(0, 3)} ${this.day}, ${this.year}';
  }

  String provideTimeString() {
    return '${this.hour}:${this.minute}';
  }
}

class TimeProvider {
  static List<String> monthList = [
    AppStrings.jan,
    AppStrings.feb,
    AppStrings.mar,
    AppStrings.apr,
    AppStrings.may,
    AppStrings.jun,
    AppStrings.jul,
    AppStrings.aug,
    AppStrings.sep,
    AppStrings.oct,
    AppStrings.nov,
    AppStrings.dec,
  ];

  static String getMonth(String month) {
    int choosenMonthNumber = TimeProvider.monthList.indexOf(month) + 1;
    return choosenMonthNumber.toString().length == 2
        ? choosenMonthNumber.toString()
        : '0$choosenMonthNumber';
  }

  static DateTime getTime(String time) {
    if (time.split(':').length == 3)
      return DateTime.parse('2012-02-27 $time');
    else
      return DateTime.parse('2012-02-27 $time:00');
  }
}
