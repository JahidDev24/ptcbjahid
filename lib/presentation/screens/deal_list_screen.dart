import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptcbjahid/logic/deal/deal_bloc.dart';

import '../widgets/deal_list_item.dart';

class DealListScreen extends StatefulWidget {
  const DealListScreen({super.key});
  @override
  State<DealListScreen> createState() => _DealListScreenState();
}

class _DealListScreenState extends State<DealListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<DealBloc>().add(FetchDeals());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<DealBloc>().add(RefreshDeals()),
      child: BlocConsumer<DealBloc, DealState>(
        listener: (context, state) {
          if (state is DealError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DealInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DealError &&
              (context.read<DealBloc>().state.props.isEmpty)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    state.message, // The clean message from ApiErrorHandler
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger Retry
                      context.read<DealBloc>().add(FetchDeals());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          if (state is DealLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  state.hasReachedMax
                      ? state.deals.length
                      : state.deals.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.deals.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DealListItem(deal: state.deals[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
