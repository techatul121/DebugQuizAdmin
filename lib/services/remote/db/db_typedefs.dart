import '../../../../common/utils/either.dart';
import 'db_exception.dart';

typedef DBResponse<T> = Future<Either<DBException, T>>;
