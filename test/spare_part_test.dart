import 'package:flutter_test/flutter_test.dart';
import '../lib/models/spare_part.dart';

void main() {
  group('SparePart Model Tests', () {
    test('should create spare part with all required fields', () {
      // Arrange & Act
      final part = SparePart(
        id: 'part-123',
        name: 'Test Part',
        category: 'Test Category',
        price: 1500.0,
        stockQuantity: 10,
        description: 'Test description',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(part.id, equals('part-123'));
      expect(part.name, equals('Test Part'));
      expect(part.category, equals('Test Category'));
      expect(part.price, equals(1500.0));
      expect(part.stockQuantity, equals(10));
      expect(part.description, equals('Test description'));
      expect(part.imageUrl, equals('https://example.com/image.jpg'));
    });

    test('should correctly identify low stock items', () {
      // Arrange
      final lowStockPart = SparePart(
        id: '1',
        name: 'Low Stock Part',
        category: 'Test',
        price: 100.0,
        stockQuantity: 3,
        description: 'Test',
      );

      final normalStockPart = SparePart(
        id: '2',
        name: 'Normal Stock Part',
        category: 'Test',
        price: 100.0,
        stockQuantity: 10,
        description: 'Test',
      );

      // Assert
      expect(lowStockPart.isLowStock, isTrue);
      expect(normalStockPart.isLowStock, isFalse);
    });

    test('should correctly identify out of stock items', () {
      // Arrange
      final outOfStockPart = SparePart(
        id: '1',
        name: 'Out of Stock Part',
        category: 'Test',
        price: 100.0,
        stockQuantity: 0,
        description: 'Test',
      );

      final inStockPart = SparePart(
        id: '2',
        name: 'In Stock Part',
        category: 'Test',
        price: 100.0,
        stockQuantity: 5,
        description: 'Test',
      );

      // Assert
      expect(outOfStockPart.isOutOfStock, isTrue);
      expect(inStockPart.isOutOfStock, isFalse);
    });

    test('should create copy with modified fields using copyWith', () {
      // Arrange
      final originalPart = SparePart(
        id: 'original-123',
        name: 'Original Part',
        category: 'Original Category',
        price: 1000.0,
        stockQuantity: 5,
        description: 'Original description',
      );

      // Act
      final modifiedPart = originalPart.copyWith(
        stockQuantity: 20,
        price: 1200.0,
      );

      // Assert
      expect(modifiedPart.id, equals(originalPart.id));
      expect(modifiedPart.name, equals(originalPart.name));
      expect(modifiedPart.category, equals(originalPart.category));
      expect(modifiedPart.stockQuantity, equals(20));
      expect(modifiedPart.price, equals(1200.0));
      expect(modifiedPart.description, equals(originalPart.description));
      expect(
        originalPart.stockQuantity,
        equals(5),
      ); // Original should remain unchanged
      expect(
        originalPart.price,
        equals(1000.0),
      ); // Original should remain unchanged
    });

    test('should handle edge cases for stock status', () {
      // Test boundary conditions
      final exactlyLowStock = SparePart(
        id: '1',
        name: 'Exactly Low Stock',
        category: 'Test',
        price: 100.0,
        stockQuantity: 5, // Exactly at low stock threshold
        description: 'Test',
      );

      final justAboveLowStock = SparePart(
        id: '2',
        name: 'Just Above Low Stock',
        category: 'Test',
        price: 100.0,
        stockQuantity: 6, // Just above low stock threshold
        description: 'Test',
      );

      // Assert
      expect(exactlyLowStock.isLowStock, isTrue);
      expect(justAboveLowStock.isLowStock, isFalse);
      expect(exactlyLowStock.isOutOfStock, isFalse);
      expect(justAboveLowStock.isOutOfStock, isFalse);
    });
  });
}
