import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';
import 'package:ptcbjahid/data/repositories/deal_repository.dart';

part 'deal_event.dart';
part 'deal_state.dart';

// ... imports (flutter_bloc, equatable, repository)
class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepository repository;
  final DealType type;

  DealBloc({required this.repository, required this.type})
    : super(DealInitial()) {
    on<FetchDeals>(_onFetchDeals);
    on<RefreshDeals>(_onRefreshDeals);
  }

  Future<void> _onFetchDeals(FetchDeals event, Emitter<DealState> emit) async {
    try {
      if (state is DealInitial) {
        final deals = await repository.fetchDeals(type: type, page: 1);
        emit(DealLoaded(deals: deals, hasReachedMax: false, page: 1));
      } else if (state is DealLoaded) {
        final currentState = state as DealLoaded;
        if (currentState.hasReachedMax) return;

        final nextPage = currentState.page + 1;
        final newDeals = await repository.fetchDeals(
          type: type,
          page: nextPage,
        );

        emit(
          newDeals.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : currentState.copyWith(
                deals: List.of(currentState.deals)..addAll(newDeals),
                page: nextPage,
              ),
        );
      }
    } catch (e) {
      emit(DealError(e.toString()));
    }
  }

  Future<void> _onRefreshDeals(
    RefreshDeals event,
    Emitter<DealState> emit,
  ) async {
    emit(DealInitial());
    add(FetchDeals());
  }
}
