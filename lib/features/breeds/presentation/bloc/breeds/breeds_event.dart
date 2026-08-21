part of 'breeds_bloc.dart';

sealed class BreedsEvent extends Equatable {
  const BreedsEvent();

  @override
  List<Object> get props => [];
}

final class BreedsStarted extends BreedsEvent {
  const BreedsStarted();
}

final class BreedsLoadMore extends BreedsEvent {
  const BreedsLoadMore();
}

final class BreedsRefresh extends BreedsEvent {
  const BreedsRefresh();
}

final class BreedsSearch extends BreedsEvent {
  final String query;

  const BreedsSearch(this.query);

  @override
  List<Object> get props => [query];
}
