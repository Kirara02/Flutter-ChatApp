import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_params.dart';
import 'package:xchat/src/features/settings/presentation/providers/profile_notifier_provider.dart';
import 'package:xchat/src/utils/image_picker_helper.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  XFile? _profileImageFile;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authUserProvider).value;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePickerHelper();
    final pickedFile = await picker.pickAndProcessImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImageFile = pickedFile;
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final params = UpdateProfileParams(
      name: _nameController.text,
      email: _emailController.text,
      profileImage: _profileImageFile,
    );

    final success = await ref
        .read(profileNotifierProvider.notifier)
        .updateProfile(params);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authUserProvider);
    final profileUpdateState = ref.watch(profileNotifierProvider);

    ref.listen<AsyncValue<void>>(profileNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memperbarui profil: $error')),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            onPressed: profileUpdateState.isLoading ? null : _updateProfile,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Pengguna tidak ditemukan.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (profileUpdateState.isLoading)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20),
                  _buildProfileImage(user.profileImage),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Email tidak boleh kosong';
                      if (!value.contains('@')) return 'Format email salah';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    ImageProvider? backgroundImage;

    if (_profileImageFile != null) {
      // Jika ada file gambar yang baru dipilih
      if (kIsWeb) {
        // Untuk Web, gunakan NetworkImage dengan path dari XFile
        backgroundImage = NetworkImage(_profileImageFile!.path);
      } else {
        // Untuk Mobile (iOS/Android), gunakan FileImage
        backgroundImage = FileImage(File(_profileImageFile!.path));
      }
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      // Jika tidak ada file baru, gunakan URL dari server
      backgroundImage = NetworkImage(imageUrl);
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: backgroundImage,
          child: backgroundImage == null
              ? const Icon(Icons.person, size: 60)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
              onPressed: _pickImage,
            ),
          ),
        ),
      ],
    );
  }
}
