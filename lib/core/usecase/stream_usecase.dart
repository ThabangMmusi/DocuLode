import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

abstract interface class StreamUsecase<SuccessType, Params> {
  Stream<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
