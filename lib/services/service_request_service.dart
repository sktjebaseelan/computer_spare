import 'package:computer_spares_service/models/service_request.dart';

class ServiceRequestService {
  final List<ServiceRequest> _serviceRequests = [
    ServiceRequest(
      id: '1',
      customerName: 'John Doe',
      customerPhone: '+91 9876543210',
      deviceType: 'Laptop',
      issueDescription: 'Screen not working, possible LCD issue',
      status: ServiceStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      estimatedCost: 5000.0,
      requiredParts: ['LCD Screen', 'Display Cable'],
    ),
    ServiceRequest(
      id: '2',
      customerName: 'Jane Smith',
      customerPhone: '+91 9876543211',
      deviceType: 'Desktop',
      issueDescription: 'Computer not booting, RAM issue suspected',
      status: ServiceStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      estimatedCost: 3000.0,
      requiredParts: ['RAM 8GB DDR4'],
    ),
  ];

  List<ServiceRequest> getAllServiceRequests() {
    return List.unmodifiable(_serviceRequests);
  }

  List<ServiceRequest> getServiceRequestsByStatus(ServiceStatus status) {
    return _serviceRequests.where((req) => req.status == status).toList();
  }

  void addServiceRequest(ServiceRequest request) {
    _serviceRequests.add(request);
  }

  void updateServiceRequestStatus(String id, ServiceStatus newStatus) {
    final index = _serviceRequests.indexWhere((req) => req.id == id);
    if (index != -1) {
      _serviceRequests[index] = _serviceRequests[index].copyWith(
        status: newStatus,
        completedAt: newStatus == ServiceStatus.completed
            ? DateTime.now()
            : null,
      );
    }
  }

  ServiceRequest? getServiceRequestById(String id) {
    try {
      return _serviceRequests.firstWhere((req) => req.id == id);
    } catch (e) {
      return null;
    }
  }

  int get totalRequests => _serviceRequests.length;
  int get pendingRequests =>
      getServiceRequestsByStatus(ServiceStatus.pending).length;
  int get inProgressRequests =>
      getServiceRequestsByStatus(ServiceStatus.inProgress).length;
  int get completedRequests =>
      getServiceRequestsByStatus(ServiceStatus.completed).length;
}
