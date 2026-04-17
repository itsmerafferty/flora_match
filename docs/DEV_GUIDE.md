# Flora Match - Development Guide

**Version:** 1.0 | **Last Updated:** March 18, 2026 | **Phase:** 0 (Foundation)

---

## Quick Start

### 1. Prerequisites

- Flutter SDK 3.7+ → [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (bundled with Flutter)
- Firebase CLI → `npm install -g firebase-tools`
- Git
- Android Studio or VS Code

### 2. Initial Setup

```bash
# Clone the repository
git clone https://github.com/your-org/flora_match.git
cd flora_match

# Install Flutter dependencies
flutter pub get

# Generate code (Hive models, etc.)
flutter pub run build_runner build

# Configure Firebase for your dev environment
firebase init
firebase use --add  # Select 'flora-match-ph-dev' project

# Set up Android/iOS for Firebase (first time only)
flutterfire configure --project=flora-match-ph-dev
```

### 3. Run the App

```bash
# Run on connected device/emulator
flutter run

# Run in dev mode with debug logs
flutter run -v

# Run on web (development)
flutter run -d chrome
```

---

## Project Structure

### App Architecture (Clean Architecture)

```
lib/
├── main.dart                    # Entry point
├── config/                      # Configuration files
│   ├── environment_config.dart
│   ├── firebase_config.dart
│   └── payment_config.dart
├── core/                        # Core functionality (no features depend on this level)
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── constants/
│   │   └── app_constants.dart
│   └── utils/
│       ├── logger.dart
│       ├── validators.dart
│       └── formatters.dart
├── features/                    # Feature modules
│   ├── auth/
│   │   ├── data/               # Data layer (API, database, local)
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/             # Domain layer (business logic, entities)
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/       # Presentation layer (UI, BLoC)
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── buyer/                  # Buyer-specific features
│   ├── seller/                 # Seller-specific features
│   ├── payments/               # Payment handling
│   ├── orders/                 # Order management
│   └── admin/                  # Admin features
└── shared/                      # Shared utilities
    ├── models/
    ├── widgets/
    └── repositories/
```

### Layers Explanation

**Presentation Layer:**
- UI widgets, pages, dialogs
- BLoC/Provider state management
- Receives user input, displays results

**Domain Layer:**
- Business logic (entities, use cases, abstract repositories)
- No dependencies on external libraries
- Defines contracts (interfaces)

**Data Layer:**
- Firestore queries, API calls, local storage
- Concrete repository implementations
- Models (data transfer objects)

---

## Development Workflow

### 1. Creating a New Feature

**Example: Implementing Buyer Browse Products**

```bash
# Create feature structure
mkdir -p lib/features/buyer/browse/{data,domain,presentation}
mkdir -p lib/features/buyer/browse/data/{datasources,models,repositories}
mkdir -p lib/features/buyer/browse/domain/{entities,repositories,usecases}
mkdir -p lib/features/buyer/browse/presentation/{bloc,pages,widgets}
```

### 2. Implementation Order (Per Feature)

1. **Define Entity** (`domain/entities/product_entity.dart`)
   ```dart
   class Product {
     final String id;
     final String name;
     final double price;
     // ...
   }
   ```

2. **Define Repository Interface** (`domain/repositories/product_repository.dart`)
   ```dart
   abstract class ProductRepository {
     Future<List<Product>> getProducts();
   }
   ```

3. **Create Use Case** (`domain/usecases/get_products_usecase.dart`)
   ```dart
   class GetProductsUseCase {
     final ProductRepository repository;
     
     Future<List<Product>> call() => repository.getProducts();
   }
   ```

4. **Create Data Model** (`data/models/product_model.dart`)
   ```dart
   class ProductModel extends Product {
     ProductModel.fromJson(Map<String, dynamic> json)
       : super(
           id: json['id'],
           name: json['name'],
           // ...
         );
   }
   ```

5. **Implement Datasource** (`data/datasources/product_datasource.dart`)
   ```dart
   class ProductDataSource {
     Future<List<ProductModel>> getProducts() async {
       return FirebaseFirestore.instance
         .collection('products')
         .get()
         .then((snapshot) => snapshot.docs
           .map((doc) => ProductModel.fromJson(doc.data()))
           .toList());
     }
   }
   ```

6. **Implement Repository** (`data/repositories/product_repository_impl.dart`)
   ```dart
   class ProductRepositoryImpl extends ProductRepository {
     final ProductDataSource datasource;
     
     @override
     Future<List<Product>> getProducts() async {
       return datasource.getProducts();
     }
   }
   ```

7. **Create BLoC** (`presentation/bloc/product_bloc.dart`)
   ```dart
   class ProductBloc extends Bloc<ProductEvent, ProductState> {
     final GetProductsUseCase getProductsUseCase;
     
     ProductBloc({required this.getProductsUseCase})
       : super(const ProductState.initial()) {
       on<GetProductsEvent>(_onGetProducts);
     }
     
     Future<void> _onGetProducts(...) async {
       // Emit loading, then success or error
     }
   }
   ```

8. **Create UI** (`presentation/pages/products_page.dart`)
   ```dart
   class ProductsPage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return BlocBuilder<ProductBloc, ProductState>(
         builder: (context, state) {
           // Handle loading, success, error states
         },
       );
     }
   }
   ```

### 3. State Management with BLoC

**Event:**
```dart
abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent {}
```

**State:**
```dart
@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.success(List<Product> products) = _Success;
  const factory ProductState.error(String message) = _Error;
}
```

**BLoC:**
```dart
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.getProductsUseCase})
    : super(const ProductState.initial()) {
    on<GetProductsEvent>(_onGetProducts);
  }

  final GetProductsUseCase getProductsUseCase;

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    
    try {
      final products = await getProductsUseCase();
      emit(ProductState.success(products));
    } catch (e) {
      emit(ProductState.error(e.toString()));
    }
  }
}
```

---

## Firestore Best Practices

### 1. Query Optimization

**❌ Bad: N+1 queries**
```dart
final orders = await firestore.collection('orders').get();
for (var doc in orders.docs) {
  final user = await firestore.collection('users').doc(doc['uid']).get();
  // Process user...
}
```

**✅ Good: Single query with denormalization**
```dart
// Store user data in order document
final orders = await firestore
  .collection('orders')
  .where('status', isEqualTo: 'paid')
  .get();
```

### 2. Security Rules

Always validate at the rules level (not just in code):

```javascript
// ✅ Good: Rules enforce buyer can only view own orders
match /orders/{orderId} {
  allow read: if resource.data.uid == request.auth.uid;
}

// ❌ Bad: Client-side check only
if (order.uid == currentUser.uid) {
  // Display order
}
```

### 3. Pagination

```dart
Query query = firestore
  .collection('products')
  .orderBy('createdAt', descending: true)
  .limit(20);

// First page
final firstBatch = await query.get();

// Next page
if (firstBatch.docs.isNotEmpty) {
  final nextQuery = query
    .startAfterDocument(firstBatch.docs.last)
    .get();
}
```

### 4. Batch Writes

```dart
WriteBatch batch = firestore.batch();

batch.set(ref1, data1);
batch.update(ref2, data2);
batch.delete(ref3);

await batch.commit();
```

---

## Logging & Debugging

### 1. Enable Logging

```dart
import 'package:flora_match/core/utils/logger.dart';

logger.info('Fetching products...');
logger.error('Failed to load products', e, stackTrace);
```

### 2. Firebase Emulator (Local Development)

```bash
# Start emulator
firebase emulators:start

# Run app connected to emulator (set ENV variable)
export FIREBASE_EMULATOR_HOST=localhost:8080
flutter run
```

### 3. View Logs

```bash
# Real-time logs from Cloud Functions
firebase functions:log --follow

# View Firestore logs in Cloud Console
gcloud logging read \
  "resource.type=cloud_firestore_database" \
  --limit 50 --format json
```

---

## Testing

### Unit Tests

```dart
// test/features/buyer/browse/get_products_usecase_test.dart
void main() {
  group('GetProductsUseCase', () {
    late GetProductsUseCase usecase;
    late MockProductRepository mockRepository;

    setUp(() {
      mockRepository = MockProductRepository();
      usecase = GetProductsUseCase(mockRepository);
    });

    test('should get products from repository', () async {
      final products = [
        const Product(id: '1', name: 'Plant 1', price: 100),
      ];

      when(mockRepository.getProducts())
        .thenAnswer((_) async => products);

      final result = await usecase();

      expect(result, products);
      verify(mockRepository.getProducts()).called(1);
    });
  });
}
```

### Integration Tests

```dart
// test/features/buyer/browse/products_page_test.dart
void main() {
  group('ProductsPage Integration', () {
    testWidgets('displays products', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(ProductsPage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ProductTile), findsWidgets);
    });
  });
}
```

---

## Git Workflow

### Branch Naming

```
feature/PROJ-001-buyer-browse-products
fix/PROJ-002-cart-calculation-bug
docs/update-readme
chore/upgrade-dependencies
```

### Commit Message Format

```
[PROJ-001] feat: Add product browse feature

- Implement ProductBloc for state management
- Add GetProductsUseCase
- Create ProductsPage UI with pagination

Fixes #123
```

### PR Checklist

- [ ] Feature is tested (unit + integration)
- [ ] No console errors/warnings
- [ ] Firebase rules reviewed (if applicable)
- [ ] Performance impact assessed
- [ ] Updated relevant docs

---

## CI/CD Pipeline

Located in `.github/workflows/`

### Test Pipeline
```
push to feature/ → lint → unit tests → integration tests
```

### Deploy Pipeline
```
merge to main → build → deploy to staging → manual approval → deploy to production
```

---

## Common Issues & Solutions

### Issue: Firebase Authentication fails

**Solution:**
```dart
// Check Firebase project ID
firebase projects:list

// Re-run configuration
flutterfire configure --project=flora-match-ph-dev --ios-out=ios/Runner --android-out=android/app
```

### Issue: Firestore queries slow

**Solution:**
1. Create composite indexes (Firebase will suggest)
2. Limit results with `.limit(20)`
3. Use cursor pagination
4. Denormalize frequently-accessed data

### Issue: BLoC events not firing

**Solution:**
```dart
// Ensure BLoC is properly provided
BlocProvider(
  create: (context) => ProductBloc(getProductsUseCase: instance())
    ..add(const GetProductsEvent()),
  child: ProductsPage(),
)
```

---

## Phase 0 Checklist (Sprint 1–2)

- [ ] Firebase projects created (dev/staging/prod)
- [ ] flutterfire configured locally
- [ ] CI/CD pipeline working
- [ ] Authentication skeleton implemented
- [ ] Firestore schema created
- [ ] Security rules deployed
- [ ] Logger & error handling setup
- [ ] Team onboarding complete

---

## Useful Links

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/clean-architecture)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)

---

## Support & Questions

- **Slack:** #flora-match-dev
- **GitHub Issues:** [flora_match/issues](https://github.com/your-org/flora_match/issues)
- **Tech Lead:** [tech-lead@example.com](mailto:tech-lead@example.com)

