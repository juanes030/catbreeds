import 'package:catbreeds/core/di/injection.dart';
import 'package:catbreeds/features/breeds/presentation/bloc/breeds/breeds_bloc.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_card.dart';
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breeds')),
      body: BlocBuilder<BreedsBloc, BreedsState>(
        builder: (context, state) {
          if (state.status == BreedsStatus.loading && state.breeds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BreedsStatus.failure && state.breeds.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Something went wrong'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BreedsBloc>().add(const BreedsStarted());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final extraItems = state.isLoadingMore || state.hasMoreError ? 1 : 0;

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
                            state.errorMessage ?? 'Unable to load more breeds.',
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
                  breed: state.breeds[index],
                  onTap: () {
                    context.push('/breed/${breed.id}', extra: breed);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
