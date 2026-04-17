import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora_match/presentation/blocs/auth/auth_bloc.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;

  const OTPVerificationPage({
    super.key,
    required this.verificationId,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  final _otpLength = 6;
  int _secondsRemaining = 300; // 5 minutes
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startTimer();
  }

  void _initializeControllers() {
    _otpControllers = List.generate(
      _otpLength,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      _otpLength,
      (index) => FocusNode(),
    );
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
        _startTimer();
      }
    });
  }

  bool get _isExpired => _secondsRemaining <= 0;

  String get _timerText {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _getOTPCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _handleOTPChange(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyOTP();
      }
    }
  }

  void _handleOTPBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOTP() {
    final otp = _getOTPCode();
    if (otp.length == _otpLength) {
      context.read<AuthBloc>().add(
            VerifyPhoneOTPEvent(
              otp: otp,
              verificationId: widget.verificationId,
            ),
          );
    }
  }

  void _handleResendOTP() {
    // TODO: Implement resend OTP logic in Sprint 2
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resend OTP functionality coming soon')),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Check roles and navigate
            if (state.user.roles.isEmpty || (state.user.roles.length == 1 && state.user.roles.contains('buyer'))) {
                 // Or navigate to role selection if "isProfileComplete" is false.
                 // For now, let's assume we go to Role Selection if new
                 Navigator.of(context).pushNamedAndRemoveUntil('/role-selection', (route) => false);
            } else {
                 // Go to home (for now, let's just go to role selection as per plan, or home if implemented)
                 Navigator.of(context).pushNamedAndRemoveUntil('/buyer-home', (route) => false);
            }
          } else if (state is AuthError) {
            setState(() {
              _errorMessage = state.message;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.verified_user,
                  size: 50,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Enter Verification Code',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'We sent a code to your phone',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _otpLength,
                  (index) => _buildOTPField(index),
                ),
              ),

              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // Timer and Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Code expires in: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    _timerText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _isExpired ? Colors.red : Colors.green,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Resend Button
              TextButton(
                onPressed: _isExpired ? _handleResendOTP : null,
                child: const Text('Resend Code'),
              ),

              const SizedBox(height: 40),

              // Verify Button
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is VerifyingPhoneOTP;

                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (isLoading || _getOTPCode().length < _otpLength)
                          ? null
                          : _verifyOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPField(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.green[700]!,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        style: Theme.of(context).textTheme.headlineSmall,
        onChanged: (value) {
          if (value.isNotEmpty && !RegExp(r'[0-9]').hasMatch(value)) {
            _otpControllers[index].clear();
            return;
          }
          if (value.isNotEmpty) {
            _handleOTPChange(value, index);
          } else {
            _handleOTPBackspace(value, index);
          }
          setState(() {
            _errorMessage = '';
          });
        },
      ),
    );
  }
}
