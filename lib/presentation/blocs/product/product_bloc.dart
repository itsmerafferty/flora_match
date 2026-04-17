import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flora_match/data/models/product_model.dart';
import 'package:flora_match/data/repositories/product_repository.dart';

// Events
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

// States
abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await emit.forEach(
        _productRepository.getProducts(),
        onData: (products) => ProductLoaded(products),
        onError: (error, stackTrace) => ProductError(error.toString()),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
