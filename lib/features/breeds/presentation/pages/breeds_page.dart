import 'package:catbreeds/core/di/injection.dart';
import 'package:catbreeds/features/breeds/presentation/bloc/breeds/breeds_bloc.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.breeds.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.breeds.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final breed = state.breeds[index];

              return BreedCard(breed: breed);
            },
          );
        },
      ),
    );
  }
}
