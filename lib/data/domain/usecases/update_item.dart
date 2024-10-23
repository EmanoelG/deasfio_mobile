
import '../../../src/models/item_model.dart';
import '../entities/item.dart';

class UpdateItem {
  final ItemRepository repository;

  UpdateItem(this.repository);

  Future<bool> call(ItemModel item) async {
    try {
      await repository.updateItem(item);
      return true;
    } catch (e) {
      return false;
    }
  }
}
