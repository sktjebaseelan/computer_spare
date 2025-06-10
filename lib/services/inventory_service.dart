import 'package:computer_spares_service/models/spare_part.dart';

class InventoryService {
  final List<SparePart> _spareParts = [
    SparePart(
      id: '1',
      name: 'LCD Screen 15.6"',
      category: 'Display',
      price: 4500.0,
      stockQuantity: 3,
      description: 'Compatible with most laptop models',
    ),
    SparePart(
      id: '2',
      name: 'RAM 8GB DDR4',
      category: 'Memory',
      price: 2500.0,
      stockQuantity: 12,
      description: 'High-speed DDR4 memory module',
    ),
    SparePart(
      id: '3',
      name: 'Hard Drive 1TB',
      category: 'Storage',
      price: 3500.0,
      stockQuantity: 2,
      description: 'SATA 7200 RPM hard drive',
    ),
    SparePart(
      id: '4',
      name: 'Keyboard Replacement',
      category: 'Input',
      price: 1200.0,
      stockQuantity: 0,
      description: 'Standard laptop keyboard',
    ),
  ];

  List<SparePart> getAllSpareParts() {
    return List.unmodifiable(_spareParts);
  }

  List<SparePart> getLowStockParts() {
    return _spareParts.where((part) => part.isLowStock).toList();
  }

  List<SparePart> getOutOfStockParts() {
    return _spareParts.where((part) => part.isOutOfStock).toList();
  }

  SparePart? getSparePartById(String id) {
    try {
      return _spareParts.firstWhere((part) => part.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateStock(String id, int newQuantity) {
    final index = _spareParts.indexWhere((part) => part.id == id);
    if (index != -1) {
      _spareParts[index] = _spareParts[index].copyWith(
        stockQuantity: newQuantity,
      );
    }
  }

  int get totalParts => _spareParts.length;
  int get lowStockCount => getLowStockParts().length;
  int get outOfStockCount => getOutOfStockParts().length;
  double get totalInventoryValue => _spareParts.fold(
    0.0,
    (sum, part) => sum + (part.price * part.stockQuantity),
  );
}
