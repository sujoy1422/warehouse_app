part of 'inspection_list_cubit.dart';

abstract class InspectionListState extends Equatable {
  const InspectionListState();

  @override
  List<Object> get props => [];
}

class InspectionListInitial extends InspectionListState {
  const InspectionListInitial();
}

class InspectionListLoading extends InspectionListState {
  const InspectionListLoading();
}

class InspectionListLoaded extends InspectionListState {
  final List<InspectionList> inspectionList;
  const InspectionListLoaded(this.inspectionList);

  @override
  List<Object> get props => [inspectionList];
}

class InspectionListError extends InspectionListState {
  final String message;
  const InspectionListError(this.message);

  @override
  List<Object> get props => [message];
}
