

import '../../../src/models/item_model.dart';
import '../entities/item.dart';

class GetItems {
  final ItemRepository repository;

  GetItems(this.repository);

  Future<List<ItemModel>> call() async {
    try {
      return await repository.getItems();
    } catch (e) {
      return [];
    }
  }
}
