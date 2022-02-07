import 'package:slidepuzzle/theme/default.dart';

class LettersTheme extends DefaultTheme{

const LettersTheme() : super();

  @override
  String get name => 'Letters';

  @override
  String tileValue(int value) {
    switch (value) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      case 6:
        return 'F';
      case 7:
        return 'G';
      case 8:
        return 'H';
      case 9:
        return 'I';
      case 10:
        return 'J';
      case 11:
        return 'K';
      case 12:
        return 'L';
      case 13:
        return 'M';
      case 14:
        return 'N';
      case 15:
        return 'O';
      default:
        return '';
    }

  }

}