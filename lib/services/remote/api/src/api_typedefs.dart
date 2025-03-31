import '../../../../common/utils/either.dart';
import 'api_exception.dart';

typedef ApiResponse = Future<Either<ApiException, Map<String, dynamic>>>;
