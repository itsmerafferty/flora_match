import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flora_match/data/models/user_model.dart' as model; // Alias to avoid conflict if any
import 'package:flora_match/data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthBloc({
    FirebaseAuth? firebaseAuth,
    UserRepository? userRepository,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userRepository = userRepository ?? UserRepository(),
        super(const AuthInitial()) {
    on<SendPhoneOTPEvent>(_onSendPhoneOTP);
    on<VerifyPhoneOTPEvent>(_onVerifyPhoneOTP);
    on<UpdateUserRoleEvent>(_onUpdateUserRole);
    on<AuthSignOutEvent>(_onAuthSignOut);
  }

  /// Handle sending OTP to phone number
  Future<void> _onSendPhoneOTP(
    SendPhoneOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const SendingPhoneOTP());

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-sign in (usually for instant verification)
          try {
            await _firebaseAuth.signInWithCredential(credential);
            final user = await _getOrCreateUser();
            emit(AuthSuccess(user: user));
          } catch (e) {
             emit(AuthError(message: e.toString()));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(message: e.message ?? 'Verification failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(PhoneOTPSent(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Just update state if needed, or do nothing
           emit(PhoneOTPSent(verificationId: verificationId));
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handle OTP verification
  Future<void> _onVerifyPhoneOTP(
    VerifyPhoneOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const VerifyingPhoneOTP());

      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );

      await _firebaseAuth.signInWithCredential(credential);
      final user = await _getOrCreateUser();
      
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<model.UserModel> _getOrCreateUser() async {
    final firebaseUser = _firebaseAuth.currentUser!;
    final user = await _userRepository.getUser(firebaseUser.uid);
    if (user != null) {
      return user;
    } else {
      final newUser = model.UserModel(
        uid: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber ?? '',
        createdAt: DateTime.now(),
      );
      await _userRepository.createUser(newUser);
      return newUser;
    }
  }

  Future<void> _onUpdateUserRole(
    UpdateUserRoleEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        await _userRepository.updateUserRole(firebaseUser.uid, event.role);
        final user = await _userRepository.getUser(firebaseUser.uid);
        if (user != null) {
          emit(AuthSuccess(user: user));
        } else {
             emit(const AuthError(message: 'User not found after update'));
        }
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handle sign out
  Future<void> _onAuthSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _firebaseAuth.signOut();
    emit(const AuthInitial());
  }
}