import 'package:computer_spares_service/models/service_request.dart';
import 'package:computer_spares_service/services/service_request_service.dart';
import 'package:flutter/material.dart';

class ServiceRequestsScreen extends StatefulWidget {
  final ServiceRequestService serviceRequestService;

  const ServiceRequestsScreen({Key? key, required this.serviceRequestService})
    : super(key: key);

  @override
  State<ServiceRequestsScreen> createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends State<ServiceRequestsScreen> {
  ServiceStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final requests = _selectedStatus == null
        ? widget.serviceRequestService.getAllServiceRequests()
        : widget.serviceRequestService.getServiceRequestsByStatus(
            _selectedStatus!,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Requests'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<ServiceStatus?>(
            onSelected: (status) => setState(() => _selectedStatus = status),
            itemBuilder: (context) => [
              const PopupMenuItem(value: null, child: Text('All Requests')),
              ...ServiceStatus.values.map(
                (status) => PopupMenuItem(
                  value: status,
                  child: Text(status.name.toUpperCase()),
                ),
              ),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: requests.isEmpty
          ? const Center(
              child: Text(
                'No service requests found',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return _buildServiceRequestCard(request);
              },
            ),
    );
  }

  Widget _buildServiceRequestCard(ServiceRequest request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${request.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    request.statusText,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: request.statusColor.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              request.customerName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(request.customerPhone),
            const SizedBox(height: 8),
            Text('Device: ${request.deviceType}'),
            Text('Issue: ${request.issueDescription}'),
            Text(
              'Estimated Cost: ₹${request.estimatedCost.toStringAsFixed(2)}',
            ),
            if (request.requiredParts.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Required Parts:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              ...request.requiredParts.map((part) => Text('• $part')),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (request.status == ServiceStatus.pending)
                  ElevatedButton(
                    onPressed: () =>
                        _updateStatus(request.id, ServiceStatus.inProgress),
                    child: const Text('Start Work'),
                  ),
                if (request.status == ServiceStatus.inProgress) ...[
                  ElevatedButton(
                    onPressed: () =>
                        _updateStatus(request.id, ServiceStatus.completed),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Complete'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () =>
                        _updateStatus(request.id, ServiceStatus.cancelled),
                    child: const Text('Cancel'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateStatus(String id, ServiceStatus newStatus) {
    setState(() {
      widget.serviceRequestService.updateServiceRequestStatus(id, newStatus);
    });
  }
}
