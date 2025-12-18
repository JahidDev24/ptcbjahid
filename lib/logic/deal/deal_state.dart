part of 'deal_bloc.dart';

sealed class DealState extends Equatable {
  const DealState();

  @override
  List<Object> get props => [];
}

class DealInitial extends DealState {}

class DealLoaded extends DealState {
  final List<DealData> deals;
  final bool hasReachedMax;
  final int page;

  DealLoaded({
    required this.deals,
    required this.hasReachedMax,
    required this.page,
  });

  DealLoaded copyWith({List<DealData>? deals, bool? hasReachedMax, int? page}) {
    return DealLoaded(
      deals: deals ?? this.deals,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [deals, hasReachedMax, page];
}

class DealError extends DealState {
  final String message;
  DealError(this.message);
}
