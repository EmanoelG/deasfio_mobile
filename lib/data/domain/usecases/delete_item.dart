
import '../entities/item.dart';

class DeleteItem {
  final ItemRepository repository;

  DeleteItem(this.repository);

  Future<bool> call(String id) async {
    try {
      await repository.deleteItem(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
