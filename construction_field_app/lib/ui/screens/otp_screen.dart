import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import 'role_selection_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  late AuthService service;

  @override
  void initState() {
    super.initState();
    service = AuthService(AuthRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter OTP',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Use 123456 for demo'),

            const SizedBox(height: 24),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: () async {
                final ok = await service.verifyOtp(otpController.text);
                if (!ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid OTP')),
                  );
                  return;
                }

                await service.saveLogin(widget.phone);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RoleSelectionScreen(),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Verify & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
