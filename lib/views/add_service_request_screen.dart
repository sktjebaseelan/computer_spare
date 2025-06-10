import 'package:computer_spares_service/models/service_request.dart';
import 'package:computer_spares_service/services/service_request_service.dart';
import 'package:flutter/material.dart';

class AddServiceRequestScreen extends StatefulWidget {
  final ServiceRequestService serviceRequestService;

  const AddServiceRequestScreen({Key? key, required this.serviceRequestService})
    : super(key: key);

  @override
  State<AddServiceRequestScreen> createState() =>
      _AddServiceRequestScreenState();
}

class _AddServiceRequestScreenState extends State<AddServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _deviceTypeController = TextEditingController();
  final _issueDescriptionController = TextEditingController();
  final _estimatedCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Service Request'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty == true
                    ? 'Please enter customer name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _customerPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Customer Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deviceTypeController,
                decoration: const InputDecoration(
                  labelText: 'Device Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter device type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _issueDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Issue Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty == true ? 'Please describe the issue' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _estimatedCostController,
                decoration: const InputDecoration(
                  labelText: 'Estimated Cost (₹)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty == true)
                    return 'Please enter estimated cost';
                  if (double.tryParse(value!) == null)
                    return 'Please enter valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create Service Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = ServiceRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerName: _customerNameController.text,
        customerPhone: _customerPhoneController.text,
        deviceType: _deviceTypeController.text,
        issueDescription: _issueDescriptionController.text,
        status: ServiceStatus.pending,
        createdAt: DateTime.now(),
        estimatedCost: double.parse(_estimatedCostController.text),
        requiredParts: [],
      );

      widget.serviceRequestService.addServiceRequest(request);
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _deviceTypeController.dispose();
    _issueDescriptionController.dispose();
    _estimatedCostController.dispose();
    super.dispose();
  }
}
