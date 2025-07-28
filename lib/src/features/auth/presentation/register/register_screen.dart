import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xchat/src/features/auth/presentation/providers/register_provider.dart';
import 'package:xchat/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:xchat/src/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.hideKeyboard();
      ref
          .read(registerNotifierProvider.notifier)
          .register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(registerNotifierProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registrasi berhasil! Silakan masuk.')),
            );
            context.pop();
          }
        },
        error: (error, stack) {},
        loading: () {},
      );
    });

    final registerState = ref.watch(registerNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 40),
                  Text(
                    "Buat Akun Baru",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Isi data berikut untuk memulai",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: _nameController,
                    labelText: 'Nama Lengkap',
                    suffixIcon: Icon(Icons.person_rounded),
                    validator: (value) =>
                        (value.isBlank) ? 'Nama wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.mail_rounded),
                    validator: (value) => (value.isBlank || !value.isEmail)
                        ? 'Email tidak valid'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    validator: (value) => (value.isBlank)
                        ? 'Password harus diisi'
                        : (value!.length <= 6)
                        ? 'Password minimal 6 karakter'
                        : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: registerState.isLoading ? null : _handleRegister,
                    child: registerState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Daftar'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah punya akun?"),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text("Masuk di sini"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
