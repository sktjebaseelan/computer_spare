import 'package:flutter/material.dart';

enum ServiceStatus { pending, inProgress, completed, cancelled }

class ServiceRequest {
  final String id;
  final String customerName;
  final String customerPhone;
  final String deviceType;
  final String issueDescription;
  final ServiceStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double estimatedCost;
  final List<String> requiredParts;

  ServiceRequest({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.deviceType,
    required this.issueDescription,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.estimatedCost,
    required this.requiredParts,
  });

  ServiceRequest copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? deviceType,
    String? issueDescription,
    ServiceStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    double? estimatedCost,
    List<String>? requiredParts,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deviceType: deviceType ?? this.deviceType,
      issueDescription: issueDescription ?? this.issueDescription,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      requiredParts: requiredParts ?? this.requiredParts,
    );
  }

  String get statusText {
    switch (status) {
      case ServiceStatus.pending:
        return 'Pending';
      case ServiceStatus.inProgress:
        return 'In Progress';
      case ServiceStatus.completed:
        return 'Completed';
      case ServiceStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case ServiceStatus.pending:
        return Colors.orange;
      case ServiceStatus.inProgress:
        return Colors.blue;
      case ServiceStatus.completed:
        return Colors.green;
      case ServiceStatus.cancelled:
        return Colors.red;
    }
  }
}
