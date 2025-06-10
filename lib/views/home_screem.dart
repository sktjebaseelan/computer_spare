import 'package:computer_spares_service/services/inventory_service.dart';
import 'package:computer_spares_service/services/service_request_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ServiceRequestService serviceRequestService;
  final InventoryService inventoryService;

  const HomeScreen({
    Key? key,
    required this.serviceRequestService,
    required this.inventoryService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Spares Service'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(child: _buildStatsGrid(context)),
            ),

            const SizedBox(height: 20),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildRecentActivity()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    return GridView.count(
      crossAxisCount: screenWidth > 880 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
          'Total Requests',
          serviceRequestService.totalRequests.toString(),
          Icons.build,
          Colors.blue,
        ),
        _buildStatCard(
          'Pending',
          serviceRequestService.pendingRequests.toString(),
          Icons.pending,
          Colors.orange,
        ),
        _buildStatCard(
          'In Progress',
          serviceRequestService.inProgressRequests.toString(),
          Icons.work,
          Colors.blue,
        ),
        _buildStatCard(
          'Low Stock Items',
          inventoryService.lowStockCount.toString(),
          Icons.warning,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust sizes based on available width
        double iconSize = constraints.maxWidth > 400 ? 48 : 28;
        double valueFontSize = constraints.maxWidth > 400 ? 38 : 18;
        double titleFontSize = constraints.maxWidth > 400 ? 26 : 12;
        double padding = constraints.maxWidth > 400 ? 30 : 10;

        return Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize, color: color),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: valueFontSize,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: titleFontSize),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivity() {
    final recentRequests = serviceRequestService
        .getAllServiceRequests()
        .take(3)
        .toList();

    return ListView.builder(
      itemCount: recentRequests.length,
      itemBuilder: (context, index) {
        final request = recentRequests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: request.statusColor,
              child: Text(
                request.customerName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(request.customerName),
            subtitle: Text(
              '${request.deviceType} - ${request.issueDescription}',
            ),
            trailing: Chip(
              label: Text(
                request.statusText,
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: request.statusColor.withOpacity(0.2),
            ),
          ),
        );
      },
    );
  }
}
