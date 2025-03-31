import '../../services/remote/db/db_exception.dart';

abstract class PageState<T> {
  final T? model;
  final DBException? exception;

  PageState({this.model, this.exception});
}

class PageInitialState<T> extends PageState<T> {}

class PageLoadingState<T> extends PageState<T> {}

class PageEmptyState<T> extends PageState<T> {}

class PageLoadedState<T> extends PageState<T> {
  PageLoadedState(T model) : super(model: model);
}

class PageErrorState<T> extends PageState<T> {
  PageErrorState(DBException exception) : super(exception: exception);
}
