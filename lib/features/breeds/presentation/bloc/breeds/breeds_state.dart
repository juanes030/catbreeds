part of 'breeds_bloc.dart';

enum BreedsStatus { initial, loading, success, failure }

class BreedsState extends Equatable {
  final BreedsStatus status;
  final List<Breed> breeds;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;
  final bool hasMoreError;
  final String searchQuery;

  const BreedsState({
    this.status = BreedsStatus.initial,
    this.breeds = const [],
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.hasMoreError = false,
    this.searchQuery = '',
  });

  BreedsState copyWith({
    BreedsStatus? status,
    List<Breed>? breeds,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
    bool? hasMoreError,
    String? searchQuery,
    bool clearErrorMessage = false,
  }) {
    return BreedsState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      hasMoreError: hasMoreError ?? this.hasMoreError,
      searchQuery: searchQuery ?? this.searchQuery,
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
    hasMoreError,
    searchQuery,
  ];
}

final class BreedsInitial extends BreedsState {
  const BreedsInitial() : super();
}
