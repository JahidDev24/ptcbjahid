part of 'deal_bloc.dart';

sealed class DealEvent extends Equatable {
  const DealEvent();

  @override
  List<Object> get props => [];
}

class FetchDeals extends DealEvent {}

class RefreshDeals extends DealEvent {}
