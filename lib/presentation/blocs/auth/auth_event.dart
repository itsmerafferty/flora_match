part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to send OTP to phone number
class SendPhoneOTPEvent extends AuthEvent {
  final String phoneNumber;

  const SendPhoneOTPEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Event to verify OTP code
class VerifyPhoneOTPEvent extends AuthEvent {
  final String otp;
  final String verificationId;

  const VerifyPhoneOTPEvent({
    required this.otp,
    required this.verificationId,
  });

  @override
  List<Object?> get props => [otp, verificationId];
}

class UpdateUserRoleEvent extends AuthEvent {
  final String role;

  const UpdateUserRoleEvent({required this.role});

  @override
  List<Object?> get props => [role];
}

/// Event to sign out
class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}
