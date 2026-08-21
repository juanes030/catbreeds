import 'package:bloc_test/bloc_test.dart';
import 'package:catbreeds/core/error/failures/failure.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed_measurement.dart';
import 'package:catbreeds/features/breeds/domain/usecases/get_breeds.dart';
import 'package:catbreeds/features/breeds/domain/usecases/search_breeds.dart';
import 'package:catbreeds/features/breeds/presentation/bloc/breeds/breeds_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBreeds extends Mock implements GetBreeds {}

class MockSearchBreeds extends Mock implements SearchBreeds {}

void main() {
  late MockGetBreeds mockGetBreeds;
  late MockSearchBreeds mockSearchBreeds;

  setUp(() {
    mockGetBreeds = MockGetBreeds();
    mockSearchBreeds = MockSearchBreeds();
  });

  Breed createBreed({String id = 'abys', String name = 'Abyssinian'}) {
    return Breed(
      id: id,
      name: name,
      lifeSpan: '14-17',
      temperament: 'Active, Intelligent, Adaptable',
      origin: 'Egypt',
      description: 'A friendly cat breed.',
      history: 'An ancient breed.',
      weight: const BreedMeasurement(imperial: '8-12', metric: '3.6-5.4'),
      height: const BreedMeasurement(imperial: '10-12', metric: '25-30'),
    );
  }

  group('BreedsStarted', () {
    blocTest<BreedsBloc, BreedsState>(
      'emits loading and success when breeds are loaded successfully',
      setUp: () {
        when(() => mockGetBreeds(page: 0, limit: 10))
            .thenAnswer((_) async => [createBreed()]);
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      act: (bloc) => bloc.add(const BreedsStarted()),
      expect: () => [
        const BreedsState(status: BreedsStatus.loading),
        BreedsState(
          status: BreedsStatus.success,
          breeds: [createBreed()],
          currentPage: 0,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<BreedsBloc, BreedsState>(
      'emits failure when loading breeds fails',
      setUp: () {
        when(() => mockGetBreeds(page: 0, limit: 10))
            .thenThrow(const NetworkFailure());
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      act: (bloc) => bloc.add(const BreedsStarted()),
      expect: () => [
        const BreedsState(status: BreedsStatus.loading),
        const BreedsState(
          status: BreedsStatus.failure,
          errorMessage: 'Please check your internet connection.',
        ),
      ],
    );
  });

  group('BreedsLoadMore', () {
    blocTest<BreedsBloc, BreedsState>(
      'loads and appends the next page',
      setUp: () {
        when(() => mockGetBreeds(page: 1, limit: 10))
            .thenAnswer((_) async => [createBreed(id: 'beng', name: 'Bengal')]);
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      seed: () => BreedsState(
        status: BreedsStatus.success,
        breeds: [createBreed()],
        currentPage: 0,
        hasReachedMax: false,
      ),
      act: (bloc) => bloc.add(const BreedsLoadMore()),
      expect: () => [
        BreedsState(
          status: BreedsStatus.success,
          breeds: [createBreed()],
          currentPage: 0,
          hasReachedMax: false,
          isLoadingMore: true,
        ),
        BreedsState(
          status: BreedsStatus.success,
          breeds: [
            createBreed(),
            createBreed(id: 'beng', name: 'Bengal'),
          ],
          currentPage: 1,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<BreedsBloc, BreedsState>(
      'does not load more when the maximum has been reached',
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      seed: () => BreedsState(
        status: BreedsStatus.success,
        breeds: [createBreed()],
        currentPage: 0,
        hasReachedMax: true,
      ),
      act: (bloc) => bloc.add(const BreedsLoadMore()),
      expect: () => <BreedsState>[],
      verify: (_) {
        verifyNever(
          () => mockGetBreeds(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          ),
        );
      },
    );
  });

  group('BreedsSearch', () {
    blocTest<BreedsBloc, BreedsState>(
      'emits loading and success when search succeeds',
      setUp: () {
        when(() => mockSearchBreeds(query: 'abyssinian'))
            .thenAnswer((_) async => [createBreed()]);
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      act: (bloc) => bloc.add(const BreedsSearch('abyssinian')),
      expect: () => [
        const BreedsState(
          status: BreedsStatus.loading,
          searchQuery: 'abyssinian',
        ),
        BreedsState(
          status: BreedsStatus.success,
          breeds: [createBreed()],
          currentPage: 0,
          hasReachedMax: true,
          searchQuery: 'abyssinian',
        ),
      ],
    );

    blocTest<BreedsBloc, BreedsState>(
      'emits failure when search fails',
      setUp: () {
        when(() => mockSearchBreeds(query: 'abyssinian'))
            .thenThrow(const ServerFailure());
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      act: (bloc) => bloc.add(const BreedsSearch('abyssinian')),
      expect: () => [
        const BreedsState(
          status: BreedsStatus.loading,
          searchQuery: 'abyssinian',
        ),
        const BreedsState(
          status: BreedsStatus.failure,
          searchQuery: 'abyssinian',
          errorMessage: 'Something went wrong with the server.',
        ),
      ],
    );

    blocTest<BreedsBloc, BreedsState>(
      'returns to the initial list when search query is empty',
      setUp: () {
        when(() => mockGetBreeds(page: 0, limit: 10))
            .thenAnswer((_) async => [createBreed()]);
      },
      build: () => BreedsBloc(mockGetBreeds, mockSearchBreeds),
      seed: () => BreedsState(
        status: BreedsStatus.success,
        breeds: [createBreed(id: 'beng', name: 'Bengal')],
        searchQuery: 'bengal',
      ),
      act: (bloc) => bloc.add(const BreedsSearch('')),
      expect: () => [
        BreedsState(
          status: BreedsStatus.loading,
          breeds: [createBreed(id: 'beng', name: 'Bengal')],
          currentPage: 0,
          hasReachedMax: false,
          searchQuery: '',
        ),
        BreedsState(
          status: BreedsStatus.success,
          breeds: [createBreed()],
          currentPage: 0,
          hasReachedMax: true,
          searchQuery: '',
        ),
      ],
    );
  });
}
