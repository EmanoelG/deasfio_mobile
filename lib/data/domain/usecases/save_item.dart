

import '../../../src/models/item_model.dart';
import '../entities/item.dart';

class SaveItem {
  final ItemRepository repository;

  SaveItem(this.repository);

  Future<bool> call(ItemModel item) async {
    try {
      await repository.insertItem(item);
      return true;
    } catch (e) {
      return false;
    }
  }
}
