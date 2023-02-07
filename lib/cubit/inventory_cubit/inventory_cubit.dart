import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/repository/inventory_repository/inventory_repository.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryDataRepository _inventoryDataRepository;

  InventoryCubit(this._inventoryDataRepository)
      : super(const InventoryInitial());

  Future<void> getInventoryData(String orgId) async {
    try {
      emit(const InventoryLoading());
      final inventoryData =
          await _inventoryDataRepository.fetchInventoryData(orgId);
      emit(InventoryLoaded(inventoryData));
    } on Exception {
      emit(const InventoryError("Couldn't Fetch data!"));
    }
  }
}
