part of 'breeds_bloc.dart';

enum BreedsStatus { initial, loading, success, failure }

class BreedsState extends Equatable {
  final BreedsStatus status;
  final List<Breed> breeds;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;

  const BreedsState({
    this.status = BreedsStatus.initial,
    this.breeds = const [],
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  BreedsState copyWith({
    BreedsStatus? status,
    List<Breed>? breeds,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return BreedsState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    breeds,
    currentPage,
    hasReachedMax,
    isLoadingMore,
    errorMessage,
  ];
}

final class BreedsInitial extends BreedsState {
  const BreedsInitial() : super();
}
