import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora_match/presentation/blocs/auth/auth_bloc.dart';
import 'package:flora_match/core/utils/validators.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSendOTP() {
    if (_formKey.currentState!.validate()) {
      // Format phone number with +63 prefix
      final phoneNumber = _phoneController.text.trim();
      final formattedPhone = _formatPhoneNumber(phoneNumber);

      context.read<AuthBloc>().add(
            SendPhoneOTPEvent(phoneNumber: formattedPhone),
          );
    }
  }

  String _formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    // If starts with 0, replace with +63
    if (digits.startsWith('0')) {
      return '+63${digits.substring(1)}';
    }

    // If starts with 63, add +
    if (digits.startsWith('63')) {
      return '+$digits';
    }

    // Default: add +63
    return '+63$digits';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
        elevation: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PhoneOTPSent) {
            // Navigate to OTP verification page
            Navigator.of(context).pushNamed(
              '/otp-verify',
              arguments: state.verificationId,
            );
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
          child: Form(
            key: _formKey,
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
                    Icons.phone,
                    size: 50,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Verify Your Phone',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'We\'ll send a code to your phone number',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Phone number input
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '09XX XXX XXXX',
                    prefixIcon: const Icon(Icons.phone),
                    prefixText: '+63 ',
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
                    errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!PhoneValidator.isPhilippinePhone(value)) {
                      return 'Enter a valid Philippine phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _errorMessage = '';
                    });
                  },
                ),
                const SizedBox(height: 40),

                // Send OTP Button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is SendingPhoneOTP;

                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleSendOTP,
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
                                'Send OTP',
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
                const SizedBox(height: 24),

                // Info text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.blue[700],
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You\'ll receive an SMS with a verification code. Standard rates apply.',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
