import 'package:warehouse_app/models/pallet_info/pallet_info.dart';

abstract class PalletInfoRepository {
  Future<PalletInfo> fetchPalletInfo(String palletId);
}