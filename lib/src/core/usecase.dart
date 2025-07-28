abstract interface class UseCase<R, P> {
  Future<R> call(P params);
}

abstract interface class StreamUseCase<R, P> {
  Stream<R> call(P params);
}

abstract interface class VoidUseCase<P> {
  void call(P params);
}

abstract interface class VoidNoParamUseCase {
  void call();
}