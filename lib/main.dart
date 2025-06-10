// main.dart
import 'package:computer_spares_service/views/add_service_request_screen.dart';
import 'package:computer_spares_service/views/home_screem.dart';
import 'package:computer_spares_service/views/inventory_screen.dart';
import 'package:computer_spares_service/views/service_requests_screen.dart';
import 'package:flutter/material.dart';
import 'models/service_request.dart';
import 'models/spare_part.dart';
import 'services/service_request_service.dart';
import 'services/inventory_service.dart';

void main() {
  runApp(const ComputerSparesApp());
}

class ComputerSparesApp extends StatelessWidget {
  const ComputerSparesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Spares Service',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final ServiceRequestService _serviceRequestService = ServiceRequestService();
  final InventoryService _inventoryService = InventoryService();

  List<Widget> get _screens => [
    HomeScreen(
      serviceRequestService: _serviceRequestService,
      inventoryService: _inventoryService,
    ),
    ServiceRequestsScreen(serviceRequestService: _serviceRequestService),
    InventoryScreen(inventoryService: _inventoryService),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Service Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () => _navigateToAddServiceRequest(),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _navigateToAddServiceRequest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddServiceRequestScreen(
          serviceRequestService: _serviceRequestService,
        ),
      ),
    );
    if (result == true) {
      setState(() {});
    }
  }
}
