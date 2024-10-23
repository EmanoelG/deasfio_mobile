

import '../../src/models/item_model.dart';
import '../datasources/item_local_data_source.dart';
import '../domain/entities/item.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemLocalDataSource localDataSource;

  ItemRepositoryImpl(this.localDataSource);

  @override
  Future<void> insertItem(ItemModel item) async {
    await localDataSource.insertItem(item);
  }

  @override
  Future<List<ItemModel>> getItems() async {
    return await localDataSource.getItems();
  }

  @override
  Future<void> updateItem(ItemModel item) async {
    await localDataSource.updateItem(item);
  }

  @override
  Future<void> deleteItem(String id) async {
    await localDataSource.deleteItem(id);
  }
}
