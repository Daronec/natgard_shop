import 'package:shared/core/architecture/domain/entity/result.dart';

import 'failure.dart';

/// Typedef for all methods that may fail.
/// These are mostly repository methods.
typedef RequestOperation<T> = Future<Result<T, Failure>>;
