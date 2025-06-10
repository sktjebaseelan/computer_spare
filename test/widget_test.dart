import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('App should start and display main navigation', (
      WidgetTester tester,
    ) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(const ComputerSparesApp());

      // Verify that the app starts with the main navigation
      expect(find.text('Computer Spares Service'), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Service Requests'), findsOneWidget);
      expect(find.text('Inventory'), findsOneWidget);
    });

    testWidgets('Bottom navigation should switch between screens', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const ComputerSparesApp());

      // Initially should be on Dashboard
      expect(find.text('Dashboard Overview'), findsOneWidget);

      // Tap on Service Requests tab
      await tester.tap(find.text('Service Requests'));
      await tester.pumpAndSettle();

      // Should now show Service Requests screen
      expect(find.text('Service Requests'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget); // FAB should be visible

      // Tap on Inventory tab
      await tester.tap(find.text('Inventory'));
      await tester.pumpAndSettle();

      // Should now show Inventory screen
      expect(find.text('Inventory'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing); // FAB should not be visible
    });

    testWidgets('Dashboard should display stats cards', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const ComputerSparesApp());

      // Verify dashboard stats are displayed
      expect(find.text('Dashboard Overview'), findsOneWidget);
      expect(find.text('Total Requests'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);
      expect(find.text('Low Stock Items'), findsOneWidget);
      expect(find.text('Recent Activity'), findsOneWidget);
    });

    testWidgets('Service Requests screen should show existing requests', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const ComputerSparesApp());

      // Navigate to Service Requests
      await tester.tap(find.text('Service Requests'));
      await tester.pumpAndSettle();

      // Should show service requests (there are default ones)
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('Inventory screen should show spare parts', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const ComputerSparesApp());

      // Navigate to Inventory
      await tester.tap(find.text('Inventory'));
      await tester.pumpAndSettle();

      // Should show inventory stats and parts
      expect(find.text('Total Items'), findsOneWidget);
      expect(find.text('Low Stock'), findsOneWidget);
      expect(find.text('Out of Stock'), findsOneWidget);
      expect(find.text('LCD Screen 15.6"'), findsOneWidget);
    });

    testWidgets('FAB should only appear on Service Requests screen', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const ComputerSparesApp());

      // Dashboard - no FAB
      expect(find.byIcon(Icons.add), findsNothing);

      // Service Requests - should have FAB
      await tester.tap(find.text('Service Requests'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Inventory - no FAB
      await tester.tap(find.text('Inventory'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsNothing);
    });
  });
}
