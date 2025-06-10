import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/models/service_request.dart';

void main() {
  group('ServiceRequest Model Tests', () {
    test('should create service request with all required fields', () {
      // Arrange & Act
      final request = ServiceRequest(
        id: 'test-123',
        customerName: 'Test Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Laptop',
        issueDescription: 'Screen not working',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 5000.0,
        requiredParts: ['LCD Screen'],
      );

      // Assert
      expect(request.id, equals('test-123'));
      expect(request.customerName, equals('Test Customer'));
      expect(request.customerPhone, equals('+91 9999999999'));
      expect(request.deviceType, equals('Laptop'));
      expect(request.issueDescription, equals('Screen not working'));
      expect(request.status, equals(ServiceStatus.pending));
      expect(request.estimatedCost, equals(5000.0));
      expect(request.requiredParts, contains('LCD Screen'));
    });

    test('should return correct status text for each status', () {
      // Test each status
      expect(ServiceStatus.pending.name, equals('pending'));
      expect(ServiceStatus.inProgress.name, equals('inProgress'));
      expect(ServiceStatus.completed.name, equals('completed'));
      expect(ServiceStatus.cancelled.name, equals('cancelled'));
    });

    test('should return appropriate colors for each status', () {
      // Arrange
      final pendingRequest = ServiceRequest(
        id: '1',
        customerName: 'Test',
        customerPhone: '+91 9999999999',
        deviceType: 'Test',
        issueDescription: 'Test',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      final inProgressRequest = pendingRequest.copyWith(
        status: ServiceStatus.inProgress,
      );
      final completedRequest = pendingRequest.copyWith(
        status: ServiceStatus.completed,
      );
      final cancelledRequest = pendingRequest.copyWith(
        status: ServiceStatus.cancelled,
      );

      // Assert
      expect(pendingRequest.statusColor, equals(Colors.orange));
      expect(inProgressRequest.statusColor, equals(Colors.blue));
      expect(completedRequest.statusColor, equals(Colors.green));
      expect(cancelledRequest.statusColor, equals(Colors.red));
    });

    test('should create copy with modified fields using copyWith', () {
      // Arrange
      final originalRequest = ServiceRequest(
        id: 'original-123',
        customerName: 'Original Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Laptop',
        issueDescription: 'Original issue',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      // Act
      final modifiedRequest = originalRequest.copyWith(
        status: ServiceStatus.completed,
        completedAt: DateTime.now(),
      );

      // Assert
      expect(modifiedRequest.id, equals(originalRequest.id));
      expect(
        modifiedRequest.customerName,
        equals(originalRequest.customerName),
      );
      expect(modifiedRequest.status, equals(ServiceStatus.completed));
      expect(modifiedRequest.completedAt, isNotNull);
      expect(
        originalRequest.completedAt,
        isNull,
      ); // Original should remain unchanged
    });
  });
}
