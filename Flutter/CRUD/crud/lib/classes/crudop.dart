class CrudOperations {
  final List<Map<String, dynamic>> _items = [];

  void createItem(String name, String description) {
    final newItem = {
      'id': _items.length + 1,
      'name': name,
      'description': description,
    };
    _items.add(newItem);
  }

  List<Map<String, dynamic>> readItems() {
    return _items;
  }

  void updateItem(int id, String name, String description) {
    final index = _items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _items[index] = {
        'id': id,
        'name': name,
        'description': description,
      };
    }
  }

  void deleteItem(int id) {
    _items.removeWhere((item) => item['id'] == id);
  }
}
