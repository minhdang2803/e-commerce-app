extension StringExtension on String {
  String parseMoney([String pattern = ',']) {
    String result = '';
    String currentString = trim();
    if (currentString.isEmpty) {
      result = '';
    } else if (!currentString.contains('.')) {
      for (int i = currentString.length - 1; i >= 0; i--) {
        int last = currentString.length - 1 - i;
        if ((last > 0) &&
            (last % 3 == 0) &&
            (currentString[i] != '+') &&
            (currentString[i] != '-')) {
          result = pattern + result;
        }
        result = currentString[i] + result;
      }
    } else {
      int indexOfDot = currentString.indexOf('.');
      String fromStartToDot =
          currentString.substring(0, indexOfDot).replaceAll(',', '');
      String fromDotToEnd =
          currentString.substring(indexOfDot, currentString.length);
      for (int i = fromStartToDot.length - 1; i >= 0; i--) {
        int last = fromStartToDot.length - 1 - i;
        if ((last > 0) &&
            (last % 3 == 0) &&
            (fromStartToDot[i] != '+') &&
            (fromStartToDot[i] != '-')) {
          result = pattern + result;
        }
        result = fromStartToDot[i] + result;
      }
      result = result + fromDotToEnd;
    }
    return result;
  }
}
