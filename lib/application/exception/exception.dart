import 'resource.dart';

/// UseCase層のException
class UseCaseException implements Exception {
  UseCaseException({
    required this.message,
    this.innerException,
  });

  final String message;
  final Exception? innerException;

  @override
  String toString() =>
      '${UseCaseResource.title}$message${innerException != null ? ': $innerException' : ''}';
}
