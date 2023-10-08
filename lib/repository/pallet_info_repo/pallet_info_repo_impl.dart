import 'package:warehouse_app/models/pallet_info/pallet_info.dart';
import 'package:warehouse_app/repository/pallet_info_repo/pallet_info_repository.dart';

import '../../service/web_service.dart';

class PalletInfoRepoImpl implements PalletInfoRepository {
  @override
  Future<PalletInfo> fetchPalletInfo(String palletId) {
    return WebService().getPalletInfo(palletId);
  }
}
