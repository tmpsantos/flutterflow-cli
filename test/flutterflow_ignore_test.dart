import 'package:flutterflow_cli/src/flutterflow_ignore.dart';

import 'package:test/test.dart';

void main() {
  test('does not match when file is not found', () {
    var ignore = FlutterFlowIgnore(path: '/this/path/is/wrong/');

    expect(ignore.matches('file'), false);
  });

  test('basic globbing syntax', () {
    var ignore = FlutterFlowIgnore(path: 'test/fixtures');

    expect(ignore.matches('file'), true);
    expect(ignore.matches('dir/foo'), true);
    expect(ignore.matches('dir/bar'), true);

    expect(ignore.matches('dir_recursive/foo/file'), true);
    expect(ignore.matches('dir_recursive/foo/bar/file'), true);
    expect(ignore.matches('dir_recursive/foo/bar/foo/file'), true);

    expect(ignore.matches('file_not_found'), false);
    expect(ignore.matches('dir_not_found/foo'), false);
    expect(ignore.matches('dir_not_found/bar'), false);

    expect(ignore.matches('dir_recursive/foo/file_not_found'), false);
    expect(ignore.matches('dir_recursive/foo/bar/file_not_found'), false);
    expect(ignore.matches('dir_recursive/foo/bar/foo/file_not_found'), false);
  });

  test('does not match empty paths', () {
    var ignore = FlutterFlowIgnore(path: 'test/fixtures');

    expect(ignore.matches(''), false);
  });

  test('ignores leading and trailing spaces', () {
    var ignore = FlutterFlowIgnore(path: 'test/fixtures');

    expect(ignore.matches('LEADING_SPACES.md'), true);
    expect(ignore.matches('TRAILING_SPACES.md'), true);
    expect(ignore.matches('LEADING_AND_TRAILING_SPACES.md'), true);
  });
}
