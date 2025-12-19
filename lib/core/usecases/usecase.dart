
import '../error_handling/resource.dart';

/// Base interface for all use cases
///
/// [T] - The return type of the use case
/// [Params] - The parameters required by the use case
abstract class UseCase<T, Params> {
  /// Execute the use case with the given parameters
  Future<Resource<T>> call(Params params);
}
