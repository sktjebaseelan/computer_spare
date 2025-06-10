import 'package:flutter_test/flutter_test.dart';
import '../lib/models/spare_part.dart';
import '../lib/services/inventory_service.dart';

void main() {
  group('InventoryService Tests', () {
    late InventoryService service;

    setUp(() {
      service = InventoryService();
    });

    test('should initialize with default spare parts', () {
      // Act
      final parts = service.getAllSpareParts();

      // Assert
      expect(parts.length, greaterThan(0));
      expect(service.totalParts, greaterThan(0));
    });

    test('should identify low stock parts correctly', () {
      // Act
      final lowStockParts = service.getLowStockParts();

      // Assert
      expect(lowStockParts.every((part) => part.stockQuantity <= 6), isTrue);
    });

    test('should identify out of stock parts correctly', () {
      // Act
      final outOfStockParts = service.getOutOfStockParts();

      // Assert
      expect(outOfStockParts.every((part) => part.stockQuantity == 0), isTrue);
    });

    test('should update stock quantity correctly', () {
      // Arrange
      final parts = service.getAllSpareParts();
      final firstPart = parts.first;
      final newQuantity = 100;

      // Act
      service.updateStock(firstPart.id, newQuantity);

      // Assert
      final updatedPart = service.getSparePartById(firstPart.id);
      expect(updatedPart!.stockQuantity, equals(newQuantity));
    });

    test('should return null for non-existent spare part', () {
      // Act
      final result = service.getSparePartById('non-existent-id');

      // Assert
      expect(result, isNull);
    });

    test('should calculate inventory statistics correctly', () {
      // Act
      final totalValue = service.totalInventoryValue;
      final lowStockCount = service.lowStockCount;
      final outOfStockCount = service.outOfStockCount;

      // Assert
      expect(totalValue, greaterThanOrEqualTo(0));
      expect(lowStockCount, greaterThanOrEqualTo(0));
      expect(outOfStockCount, greaterThanOrEqualTo(0));
    });

    test('should maintain data integrity after stock updates', () {
      // Arrange
      final parts = service.getAllSpareParts();
      final originalCount = parts.length;
      final testPart = parts.first;

      // Act
      service.updateStock(testPart.id, 999);

      // Assert
      expect(service.getAllSpareParts().length, equals(originalCount));
      expect(
        service.getSparePartById(testPart.id)!.name,
        equals(testPart.name),
      );
      expect(
        service.getSparePartById(testPart.id)!.price,
        equals(testPart.price),
      );
    });
  });
}
