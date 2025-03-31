abstract class Either<L, R> {
  fold(Function(L l) onLeft, Function(R r) onRight);
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);

  @override
  dynamic fold(Function(L l) onLeft, Function(R r) onRight) => onLeft(value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);

  @override
  dynamic fold(Function(L l) onLeft, Function(R r) onRight) => onRight(value);
}

Either<L, R> left<L, R>(L value) => Left<L, R>(value);

Either<L, R> right<L, R>(R value) => Right<L, R>(value);
