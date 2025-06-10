import 'package:flutter_test/flutter_test.dart';
import '../lib/models/service_request.dart';
import '../lib/services/service_request_service.dart';

void main() {
  group('ServiceRequestService Tests', () {
    late ServiceRequestService service;

    setUp(() {
      service = ServiceRequestService();
    });

    test('should initialize with default service requests', () {
      // Act
      final requests = service.getAllServiceRequests();

      // Assert
      expect(requests.length, greaterThan(0));
      expect(service.totalRequests, greaterThan(0));
    });

    test('should add new service request successfully', () {
      // Arrange
      final initialCount = service.totalRequests;
      final newRequest = ServiceRequest(
        id: 'test-123',
        customerName: 'Test Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Test Device',
        issueDescription: 'Test issue',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: ['Test Part'],
      );

      // Act
      service.addServiceRequest(newRequest);

      // Assert
      expect(service.totalRequests, equals(initialCount + 1));
      expect(service.getServiceRequestById('test-123'), isNotNull);
      expect(
        service.getServiceRequestById('test-123')!.customerName,
        equals('Test Customer'),
      );
    });

    test('should filter service requests by status correctly', () {
      // Arrange
      final pendingRequest = ServiceRequest(
        id: 'pending-123',
        customerName: 'Pending Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Test Device',
        issueDescription: 'Test issue',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      final completedRequest = ServiceRequest(
        id: 'completed-123',
        customerName: 'Completed Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Test Device',
        issueDescription: 'Test issue',
        status: ServiceStatus.completed,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      service.addServiceRequest(pendingRequest);
      service.addServiceRequest(completedRequest);

      // Act
      final pendingRequests = service.getServiceRequestsByStatus(
        ServiceStatus.pending,
      );
      final completedRequests = service.getServiceRequestsByStatus(
        ServiceStatus.completed,
      );

      // Assert
      expect(pendingRequests.any((r) => r.id == 'pending-123'), isTrue);
      expect(completedRequests.any((r) => r.id == 'completed-123'), isTrue);
      expect(pendingRequests.any((r) => r.id == 'completed-123'), isFalse);
      expect(completedRequests.any((r) => r.id == 'pending-123'), isFalse);
    });

    test('should update service request status correctly', () {
      // Arrange
      final request = ServiceRequest(
        id: 'update-test-123',
        customerName: 'Update Test Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Test Device',
        issueDescription: 'Test issue',
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      service.addServiceRequest(request);

      // Act
      service.updateServiceRequestStatus(
        'update-test-123',
        ServiceStatus.inProgress,
      );

      // Assert
      final updatedRequest = service.getServiceRequestById('update-test-123');
      expect(updatedRequest!.status, equals(ServiceStatus.inProgress));
    });

    test('should set completion date when status updated to completed', () {
      // Arrange
      final request = ServiceRequest(
        id: 'complete-test-123',
        customerName: 'Complete Test Customer',
        customerPhone: '+91 9999999999',
        deviceType: 'Test Device',
        issueDescription: 'Test issue',
        status: ServiceStatus.inProgress,
        createdAt: DateTime.now(),
        estimatedCost: 1000.0,
        requiredParts: [],
      );

      service.addServiceRequest(request);

      // Act
      service.updateServiceRequestStatus(
        'complete-test-123',
        ServiceStatus.completed,
      );

      // Assert
      final completedRequest = service.getServiceRequestById(
        'complete-test-123',
      );
      expect(completedRequest!.status, equals(ServiceStatus.completed));
      expect(completedRequest.completedAt, isNotNull);
    });

    test('should return null for non-existent service request', () {
      // Act
      final result = service.getServiceRequestById('non-existent-id');

      // Assert
      expect(result, isNull);
    });

    test('should calculate request counts correctly', () {
      // Arrange
      service.addServiceRequest(
        ServiceRequest(
          id: 'count-test-1',
          customerName: 'Test Customer 1',
          customerPhone: '+91 9999999999',
          deviceType: 'Test Device',
          issueDescription: 'Test issue',
          status: ServiceStatus.pending,
          createdAt: DateTime.now(),
          estimatedCost: 1000.0,
          requiredParts: [],
        ),
      );

      service.addServiceRequest(
        ServiceRequest(
          id: 'count-test-2',
          customerName: 'Test Customer 2',
          customerPhone: '+91 9999999999',
          deviceType: 'Test Device',
          issueDescription: 'Test issue',
          status: ServiceStatus.inProgress,
          createdAt: DateTime.now(),
          estimatedCost: 1000.0,
          requiredParts: [],
        ),
      );

      // Act & Assert
      expect(service.pendingRequests, greaterThanOrEqualTo(1));
      expect(service.inProgressRequests, greaterThanOrEqualTo(1));
      expect(service.totalRequests, greaterThanOrEqualTo(2));
    });
  });
}
