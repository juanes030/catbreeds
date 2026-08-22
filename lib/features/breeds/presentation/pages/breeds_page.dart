import 'dart:async';

import 'package:catbreeds/core/di/injection.dart';
import 'package:catbreeds/features/breeds/presentation/bloc/breeds/breeds_bloc.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_card.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_search_field.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breeds_empty_view.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breeds_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BreedsPage extends StatelessWidget {
  const BreedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BreedsBloc>()..add(const BreedsStarted()),
      child: const _BreedsView(),
    );
  }
}

class _BreedsView extends StatefulWidget {
  const _BreedsView();

  @override
  State<_BreedsView> createState() => _BreedsViewState();
}

class _BreedsViewState extends State<_BreedsView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent * 0.8) {
      context.read<BreedsBloc>().add(const BreedsLoadMore());
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) {
        return;
      }

      context.read<BreedsBloc>().add(BreedsSearch(value));
    });
  }

  void _clearSearch() {
    _searchDebounce?.cancel();
    _searchController.clear();

    context.read<BreedsBloc>().add(const BreedsStarted());
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();

    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breeds')),
      body: Column(
        children: [
          BreedSearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onClear: _clearSearch,
          ),
          Expanded(
            child: BlocBuilder<BreedsBloc, BreedsState>(
              builder: (context, state) {
                if (state.status == BreedsStatus.loading &&
                    state.breeds.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == BreedsStatus.failure &&
                    state.breeds.isEmpty) {
                  return BreedsErrorView(
                    message: state.errorMessage,
                    onRetry: () {
                      if (state.searchQuery.isNotEmpty) {
                        context.read<BreedsBloc>().add(
                          BreedsSearch(state.searchQuery),
                        );
                      } else {
                        context.read<BreedsBloc>().add(const BreedsStarted());
                      }
                    },
                  );
                }

                if (state.status == BreedsStatus.success &&
                    state.breeds.isEmpty) {
                  return BreedsEmptyView(isSearching: state.searchQuery.isNotEmpty);
                }

                final extraItems = state.isLoadingMore || state.hasMoreError
                    ? 1
                    : 0;

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<BreedsBloc>().add(const BreedsRefresh());

                    await context.read<BreedsBloc>().stream.firstWhere(
                      (state) =>
                          state.status == BreedsStatus.success ||
                          state.status == BreedsStatus.failure,
                    );
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.breeds.length + extraItems,
                    itemBuilder: (context, index) {
                      if (index >= state.breeds.length) {
                        if (state.hasMoreError) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  state.errorMessage ??
                                      'Unable to load more breeds.',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    context.read<BreedsBloc>().add(
                                      const BreedsLoadMore(),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final breed = state.breeds[index];

                      return BreedCard(
                        breed: breed,
                        onTap: () {
                          context.push('/breed/${breed.id}', extra: breed);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}