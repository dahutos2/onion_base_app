import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/infrastructure_layer/infrastructure.dart';

import 'sample_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DbHelper>()])
void main() {
  // Sample
  const idValue = 'id';
  final id = SampleId(idValue);
  const nameValue = 'name';
  final name = SampleName(nameValue);
  final sample = Sample(id: id, name: name);

  // Data
  final list = [
    <String, dynamic>{'id': idValue, 'name': nameValue}
  ];

  // Exception
  final testException = Exception('テスト');

  // Mock
  late MockDbHelper dbHelper;

  setUp(() async {
    dbHelper = MockDbHelper();
  });

  test('指定したIdのサンプルモデルが取得できる', () async {
    when(dbHelper
            .rawQuery('SELECT * FROM samples WHERE id = ?', <String>[idValue]))
        .thenAnswer((_) async => list);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.find(id);
    expect(
        actual,
        isA<Sample>()
            .having((actual) => actual, 'sample', sample)
            .having((actual) => actual.name, 'name', name));
  });

  test('指定したIdのサンプルモデルが存在しない時、nullを返す', () async {
    when(dbHelper
            .rawQuery('SELECT * FROM samples WHERE id = ?', <String>[idValue]))
        .thenAnswer((_) async => []);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.find(id);
    verify(dbHelper.rawQuery(
        'SELECT * FROM samples WHERE id = ?', <String>[idValue])).called(1);
    expect(actual, isNull);
  });

  test('指定したIdのサンプルモデルの発見時、DBが存在しない時、nullを返す', () async {
    when(dbHelper
            .rawQuery('SELECT * FROM samples WHERE id = ?', <String>[idValue]))
        .thenAnswer((_) async => null);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.find(id);
    verify(dbHelper.rawQuery(
        'SELECT * FROM samples WHERE id = ?', <String>[idValue])).called(1);
    expect(actual, isNull);
  });

  test('指定したIdのサンプルモデルの発見時、DbHelperでExceptionを吐いた時Exceptionをスローする', () async {
    when(dbHelper
            .rawQuery('SELECT * FROM samples WHERE id = ?', <String>[idValue]))
        .thenThrow(testException);
    final target = SampleRepository(dbHelper: dbHelper);
    expect(
        () async => await target.find(id),
        throwsA(const TypeMatcher<Exception>()
            .having((e) => e, 'testException', testException)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
    verify(dbHelper.rawQuery(
        'SELECT * FROM samples WHERE id = ?', <String>[idValue])).called(1);
  });

  test('全てのサンプルモデルが取得できる', () async {
    when(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).thenAnswer((_) async => list);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.findAll();
    expect(
        actual,
        isA<List<Sample>>()
            .having((actual) => actual.length, 'length', 1)
            .having((actual) => actual.first, 'sample', sample)
            .having((actual) => actual.first.name, 'name', name));
  });

  test('全てのサンプルモデルが存在しない時、空のリストを返す', () async {
    when(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).thenAnswer((_) async => []);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.findAll();
    verify(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).called(1);
    expect(actual, isEmpty);
  });

  test('全てのサンプルモデルの発見時、DBが存在しない時、空のリストを返す', () async {
    when(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).thenAnswer((_) async => []);
    final target = SampleRepository(dbHelper: dbHelper);
    final actual = await target.findAll();
    verify(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).called(1);
    expect(actual, isEmpty);
  });

  test('全てのサンプルモデルの発見時、DbHelperでExceptionを吐いた時Exceptionをスローする', () async {
    when(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).thenThrow(testException);
    final target = SampleRepository(dbHelper: dbHelper);
    expect(
        () async => await target.findAll(),
        throwsA(const TypeMatcher<Exception>()
            .having((e) => e, 'testException', testException)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
    verify(dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    )).called(1);
  });

  test('指定したサンプルモデルが保存できる', () async {
    when(dbHelper.rawInsert(
      'INSERT OR REPLACE INTO samples (id, name) VALUES (?, ?)',
      <String>[idValue, nameValue],
    )).thenAnswer((_) async => null);
    final target = SampleRepository(dbHelper: dbHelper);
    await target.save(sample);
    verify(dbHelper.rawInsert(
      'INSERT OR REPLACE INTO samples (id, name) VALUES (?, ?)',
      <String>[idValue, nameValue],
    )).called(1);
  });

  test('サンプルモデル保存時、DbHelperでExceptionを吐いた時Exceptionをスローする', () async {
    when(dbHelper.rawInsert(
      'INSERT OR REPLACE INTO samples (id, name) VALUES (?, ?)',
      <String>[idValue, nameValue],
    )).thenThrow(testException);
    final target = SampleRepository(dbHelper: dbHelper);
    expect(
        () async => await target.save(sample),
        throwsA(const TypeMatcher<Exception>()
            .having((e) => e, 'testException', testException)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
    verify(dbHelper.rawInsert(
      'INSERT OR REPLACE INTO samples (id, name) VALUES (?, ?)',
      <String>[idValue, nameValue],
    )).called(1);
  });

  test('指定したサンプルモデルが削除できる', () async {
    when(dbHelper.rawDelete(
      'DELETE FROM samples WHERE id = ?',
      <String>[idValue],
    )).thenAnswer((_) async => null);
    final target = SampleRepository(dbHelper: dbHelper);
    await target.remove(sample);
    verify(dbHelper.rawDelete(
      'DELETE FROM samples WHERE id = ?',
      <String>[idValue],
    )).called(1);
  });

  test('サンプルモデル削除時、DbHelperでExceptionを吐いた時Exceptionをスローする', () async {
    when(dbHelper.rawDelete(
      'DELETE FROM samples WHERE id = ?',
      <String>[idValue],
    )).thenThrow(testException);
    final target = SampleRepository(dbHelper: dbHelper);
    expect(
        () async => await target.remove(sample),
        throwsA(const TypeMatcher<Exception>()
            .having((e) => e, 'testException', testException)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
    verify(dbHelper.rawDelete(
      'DELETE FROM samples WHERE id = ?',
      <String>[idValue],
    )).called(1);
  });
}
