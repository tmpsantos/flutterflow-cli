import 'dart:convert';
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as path_util;

final kIgnoreFile = '.flutterflowignore';

class FlutterFlowIgnore {
  final List<Glob> _globs = [];

  FlutterFlowIgnore({path = '.'}) {
    final String text;

    try {
      text = File(path_util.join(path, kIgnoreFile)).readAsStringSync();
    } catch (e) {
      return;
    }

    if (text.isEmpty) {
      return;
    }

    final lines = LineSplitter().convert(text).map((val) => val.trim());

    for (var line in lines) {
      if (line.isNotEmpty) {
        _globs.add(Glob(line));
      }
    }
  }

  bool matches(String path) {
    for (final glob in _globs) {
      if (glob.matches(path)) {
        return true;
      }
    }

    return false;
  }
}
