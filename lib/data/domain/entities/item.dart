

import '../../../src/models/item_model.dart';

abstract class ItemRepository {
  Future<void> insertItem(ItemModel item);
  Future<List<ItemModel>> getItems();
  Future<void> updateItem(ItemModel item);
  Future<void> deleteItem(String id);
}
