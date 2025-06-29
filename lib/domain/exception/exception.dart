import 'resource.dart';

/// ドメイン層のException
class DomainException implements Exception {
  DomainException({
    required this.message,
    this.innerException,
  });

  final String message;
  final Exception? innerException;

  @override
  String toString() =>
      '${DomainResource.title}$message${innerException != null ? ': $innerException' : ''}';
}
