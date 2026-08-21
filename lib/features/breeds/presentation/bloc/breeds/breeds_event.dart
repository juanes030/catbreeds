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
