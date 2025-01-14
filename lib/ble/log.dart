import 'package:blelib/blelib.dart';
import 'package:flutter/foundation.dart';

void ekLog(var content) {
  if (!Config.gPrintLog) return;

  if (!kReleaseMode) {
    var now = DateTime.now();
    // ignore: avoid_print
    print('$now $content');
  }
}

errLog(content) {
  var now = DateTime.now();
  debugPrint('err $now $content');
}
