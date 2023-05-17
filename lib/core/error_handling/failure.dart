abstract class Failure {
  final String? message;

  Failure(this.message);

  @override
  String toString() => message ?? 'Unexpected error';
}


class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class ReadFileFailure extends Failure {
  ReadFileFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
