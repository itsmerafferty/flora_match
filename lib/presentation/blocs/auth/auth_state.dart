part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial auth state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Currently sending OTP to phone
class SendingPhoneOTP extends AuthState {
  const SendingPhoneOTP();
}

/// OTP has been sent to phone
class PhoneOTPSent extends AuthState {
  final String verificationId;

  const PhoneOTPSent({required this.verificationId});

  @override
  List<Object?> get props => [verificationId];
}

/// Currently verifying the OTP code
class VerifyingPhoneOTP extends AuthState {
  const VerifyingPhoneOTP();
}

/// OTP has been verified successfully
class OTPVerified extends AuthState {
  const OTPVerified();
}

class AuthSuccess extends AuthState {
  final model.UserModel user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authentication failed with error
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}