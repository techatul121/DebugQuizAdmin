import '../../services/remote/db/db_exception.dart';

abstract class PaginationState<T> {
  final int page;
  final int limit;
  final bool firstPageLoading;
  final DBException? firstPageException;
  final List<T>? data;
  final bool nextPageAvailable;
  final DBException? nextPageException;

  PaginationState({
    this.page = 1,
    this.limit = 10,
    this.firstPageLoading = false,
    this.firstPageException,
    this.data,
    this.nextPageAvailable = true,
    this.nextPageException,
  });
}

class PaginationInitialState<T> extends PaginationState<T> {}

class PaginationLoadingState<T> extends PaginationState<T> {
  PaginationLoadingState({super.firstPageLoading = true});
}

class PaginationEmptyState<T> extends PaginationState<T> {}

class PaginationSuccessState<T> extends PaginationState<T> {
  PaginationSuccessState({
    super.page,
    super.data,
    super.nextPageAvailable,
    super.nextPageException,
  });
}

class PaginationErrorState<T> extends PaginationState<T> {
  PaginationErrorState(DBException? firstPageException)
    : super(firstPageException: firstPageException);
}
