# Computer Spares Service App

A Flutter mobile application designed for computer spares service professionals to manage service requests, track inventory, and monitor business operations.

## Features

### 🏠 Dashboard
- **Overview Statistics**: Total requests, pending requests, in-progress requests, and low stock alerts
- **Recent Activity**: Quick view of recent service requests
- **Visual Stats Cards**: Color-coded metrics for quick understanding

### 🔧 Service Request Management
- **View All Requests**: Complete list of service requests with status filtering
- **Add New Requests**: Create new service requests with customer details
- **Status Updates**: Track requests through different stages (Pending → In Progress → Completed)
- **Customer Information**: Store customer contact details and device information
- **Cost Estimation**: Track estimated costs and required parts

### 📦 Inventory Management
- **Spare Parts Catalog**: Complete inventory of available parts
- **Stock Monitoring**: Real-time stock levels with low stock alerts
- **Stock Updates**: Easy stock quantity updates
- **Category Organization**: Parts organized by categories (Display, Memory, Storage, Input)
- **Pricing Information**: Track part prices and total inventory value

### 📊 Business Intelligence
- **Stock Alerts**: Automatic notifications for low stock and out-of-stock items
- **Status Tracking**: Visual status indicators for quick identification
- **Financial Tracking**: Estimated costs and inventory values

## Technical Features

### Architecture
- **Clean Architecture**: Separation of concerns with models, services, and screens
- **State Management**: Efficient state management using Flutter's built-in StatefulWidget
- **Service Layer**: Dedicated services for business logic separation
- **Model Classes**: Well-defined data models with proper encapsulation

### Testing
- **Unit Tests**: Comprehensive unit tests for all services and models
- **Widget Tests**: UI testing for critical user interactions
- **Test Coverage**: Tests for business logic, data integrity, and user workflows

## Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Clone the repository** (or create a new Flutter project)
```bash
flutter create computer_spares_service
cd computer_spares_service
```

2. **Add the provided code files**:
   - Replace `lib/main.dart` with the main application code
   - Create the models, services, and screens directories
   - Add all the provided Dart files to their respective directories

3. **Update pubspec.yaml** with the provided configuration

4. **Install dependencies**:
```bash
flutter pub get
```

5. **Run the application**:
```bash
flutter run
```

## Testing

### Running Unit Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/service_request_service_test.dart

# Run tests with coverage
flutter test --coverage
```

### Test Structure
```
test/
├── models/
│   ├── service_request_test.dart
│   └── spare_part_test.dart
├── services/
│   ├── service_request_service_test.dart
│   └── inventory_service_test.dart
└── widget_test.dart
```

### Test Coverage
- **Service Request Service**: CRUD operations, status updates, filtering
- **Inventory Service**: Stock management, low stock detection, value calculations
- **Models**: Data integrity, validation, copyWith functionality
- **Widgets**: Navigation, UI rendering, user interactions

## Project Structure

```
lib/
├── main.dart                           # App entry point and navigation
├── models/
│   ├── service_request.dart           # Service request data model
│   └── spare_part.dart                # Spare part data model
├── services/
│   ├── service_request_service.dart   # Service request business logic
│   └── inventory_service.dart         # Inventory management logic
└── screens/
    ├── home_screen.dart               # Dashboard screen
    ├── service_requests_screen.dart   # Service requests management
    ├── inventory_screen.dart          # Inventory management
    └── add_service_request_screen.dart # New request form
```

## Key Components

### Models
- **ServiceRequest**: Represents a service request with customer details, device info, and status
- **SparePart**: Represents inventory items with stock levels and pricing

### Services
- **ServiceRequestService**: Manages service request lifecycle and business logic
- **InventoryService**: Handles inventory operations and stock management

### Screens
- **HomeScreen**: Dashboard with key metrics and recent activity
- **ServiceRequestsScreen**: Service request management with filtering
- **InventoryScreen**: Inventory management with stock updates
- **AddServiceRequestScreen**: Form for creating new service requests

## Sample Data

The app comes pre-loaded with sample data for demonstration:

### Service Requests
- John Doe - Laptop screen repair (Pending)
- Jane Smith - Desktop RAM replacement (In Progress)

### Inventory Items
- LCD Screen 15.6" - 3 units (Low Stock)
- RAM 8GB DDR4 - 12 units (Normal Stock)
- Hard Drive 1TB - 2 units (Low Stock)
- Keyboard Replacement - 0 units (Out of Stock)

## Business Logic

### Service Request Workflow
1. **New Request**: Customer brings device, request created with "Pending" status
2. **Start Work**: Technician starts work, status changes to "In Progress"
3. **Complete**: Work finished, status changes to "Completed" with completion date
4. **Cancel**: If needed, request can be cancelled

### Inventory Management
- **Low Stock Alert**: Triggers when stock ≤ 5 units
- **Out of Stock**: When stock = 0 units
- **Stock Updates**: Real-time stock quantity updates
- **Value Calculation**: Automatic inventory value calculation

## Future Enhancements

### Potential Features
- **Database Integration**: SQLite or cloud database for persistent storage
- **Customer History**: Track customer service history
- **Parts Ordering**: Integration with suppliers for automatic reordering
- **Reporting**: Generate business reports and analytics
- **Notifications**: Push notifications for important updates
- **Barcode Scanning**: Quick part identification and stock updates
- **Photo Capture**: Before/after photos for service requests
- **Billing Integration**: Generate invoices and payment tracking

### Technical Improvements
- **State Management**: Redux/Bloc pattern for complex state management
- **API Integration**: REST API for multi-device synchronization
- **Offline Support**: Local storage with sync capabilities
- **User Authentication**: Multi-user support with role-based access
- **Performance**: Pagination for large datasets
- **Accessibility**: Screen reader support and accessibility features

## Testing Strategy

### Unit Tests
- **Service Logic**: All business operations tested
- **Data Models**: Validation and transformation logic
- **Edge Cases**: Boundary conditions and error scenarios

### Integration Tests
- **Service Integration**: Cross-service interactions
- **Data Flow**: End-to-end data flow testing

### Widget Tests
- **UI Components**: Individual widget testing
- **User Interactions**: Tap, scroll, form submissions
- **Navigation**: Screen transitions and state persistence

## Performance Considerations

- **Efficient Rendering**: ListView.builder for large lists
- **Memory Management**: Proper disposal of controllers and resources
- **State Optimization**: Minimal rebuilds with targeted setState calls
- **Image Optimization**: Optimized image loading and caching

## Support

For issues, feature requests, or contributions:
1. Check existing issues and documentation
2. Create detailed bug reports with reproduction steps
3. Include device information and Flutter version
4. Provide relevant code snippets and error messages

## License

This project is created for demonstration purposes. Feel free to use and modify according to your needs.

---

**Note**: This is a mock application created for demonstration purposes. All data is stored in memory and will be reset when the app is restarted. For production use, implement proper database storage and data persistence.