import 'package:meta/meta.dart';

import '../../domain_layer/model/domain_model.dart';
import '../../domain_layer/repository/domain_repository.dart';
import '../api/infrastructure_api.dart';

@immutable
class SampleRepository implements ISampleRepository {
  final DbHelper _dbHelper;

  const SampleRepository({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Sample toSample(Map<String, dynamic> data) {
    final id = data['id'].toString();
    final name = data['name'].toString();

    return Sample(
      id: SampleId(id),
      name: SampleName(name),
    );
  }

  @override
  Future<T?> transaction<T>(Future<T> Function() f) async {
    return await _dbHelper.transaction<T>(() async => await f());
  }

  @override
  Future<Sample?> find(BaseId id) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM samples WHERE id = ?',
      <String>[id.value],
    );

    return list == null || list.isEmpty ? null : toSample(list[0]);
  }

  @override
  Future<List<Sample>> findAll() async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM samples ORDER BY name',
    );

    if (list == null || list.isEmpty) {
      return <Sample>[];
    }

    return list.map((data) => toSample(data)).toList();
  }

  @override
  Future<void> save(Sample sample) async {
    await _dbHelper.rawInsert(
      'INSERT OR REPLACE INTO samples (id, name) VALUES (?, ?)',
      <String>[sample.id.value, sample.name.value],
    );
  }

  @override
  Future<void> remove(Sample sample) async {
    await _dbHelper.rawDelete(
      'DELETE FROM samples WHERE id = ?',
      <String>[sample.id.value],
    );
  }
}
