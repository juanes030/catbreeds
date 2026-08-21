import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/usecases/get_breeds.dart';
import 'package:injectable/injectable.dart';

part 'breeds_event.dart';
part 'breeds_state.dart';

@injectable
class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  static const int _pageSize = 10;

  final GetBreeds getBreeds;

  BreedsBloc(this.getBreeds) : super(const BreedsInitial()) {
    on<BreedsStarted>(_onStarted);
    on<BreedsLoadMore>(_onLoadMore);
  }

  Future<void> _onStarted(
    BreedsStarted event,
    Emitter<BreedsState> emit,
  ) async {
    emit(state.copyWith(status: BreedsStatus.loading, errorMessage: null));

    try {
      final breeds = await getBreeds(page: 0, limit: _pageSize);

      emit(
        state.copyWith(
          status: BreedsStatus.success,
          breeds: breeds,
          currentPage: 0,
          hasReachedMax: breeds.length < _pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BreedsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    BreedsLoadMore event,
    Emitter<BreedsState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;

      final newBreeds = await getBreeds(page: nextPage, limit: _pageSize);

      emit(
        state.copyWith(
          status: BreedsStatus.success,
          breeds: [...state.breeds, ...newBreeds],
          currentPage: nextPage,
          hasReachedMax: newBreeds.length < _pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }
}
