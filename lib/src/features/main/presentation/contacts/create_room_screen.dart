import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/main/presentation/providers/chats_provider.dart';
import 'package:xchat/src/features/main/presentation/providers/create_room_provider.dart';
import 'package:xchat/src/features/main/presentation/providers/room_creation_provider.dart';
import 'package:xchat/src/routes/router_config.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      // Memicu rebuild saat teks berubah untuk menampilkan/menyembunyikan daftar kontak
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _createDmRoom(User selectedUser) async {
    final myUser = ref.read(authUserProvider).value;
    if (myUser == null) return;

    final roomName = "${myUser.name} - ${selectedUser.name}";
    await ref
        .read(roomCreationNotifierProvider.notifier)
        .createRoom(name: roomName, userIds: [selectedUser.id]);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(roomCreationNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (room) {
          if (room != null && mounted) {
            // Langsung navigasi ke room yang baru dibuat
            ChatRoute(
              roomId: room.id.toString(),
              $extra: room.name,
            ).go(context);
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Gagal membuat chat: $error')));
        },
      );
    });

    final searchResults = ref.watch(createRoomNotifierProvider);
    final emptyChatsState = ref.watch(chatsNotifierProvider(showEmpty: true));
    final bool isSearching = _searchController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Baru')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Pengguna...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref
                        .read(createRoomNotifierProvider.notifier)
                        .searchUsers(keyword: _searchController.text);
                  },
                ),
              ),
              onSubmitted: (keyword) {
                ref
                    .read(createRoomNotifierProvider.notifier)
                    .searchUsers(keyword: keyword);
              },
            ),
          ),
          Expanded(
            child: isSearching
                ? searchResults.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (users) {
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('Pengguna tidak ditemukan.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                user.profileImage != null &&
                                        user.profileImage!.isNotEmpty
                                    ? user.profileImage!
                                    : 'https://ui-avatars.com/api/?name=${user.name.replaceAll(' ', '+')}&size=150',
                              ),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            onTap: () => _createDmRoom(user),
                          );
                        },
                      );
                    },
                  )
                : emptyChatsState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) =>
                        Center(child: Text('Gagal memuat kontak: $err')),
                    data: (rooms) {
                      return ListView(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.group_add),
                            ),
                            title: const Text('Grup Baru'),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => const CreateGroupBottomSheet(),
                              );
                            },
                          ),
                          const Divider(),
                          if (rooms.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'KONTAK',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ...rooms.map(
                            (room) => ListTile(
                              title: Text(room.name),
                              onTap: () => ChatRoute(
                                roomId: room.id.toString(),
                                $extra: room.name,
                              ).go(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Sheet untuk Membuat Grup ---

class CreateGroupBottomSheet extends ConsumerStatefulWidget {
  const CreateGroupBottomSheet({super.key});

  @override
  ConsumerState<CreateGroupBottomSheet> createState() =>
      _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState
    extends ConsumerState<CreateGroupBottomSheet> {
  final _groupNameController = TextEditingController();
  final _searchController = TextEditingController();
  final List<User> _selectedUsers = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onUserSelected(User user) {
    setState(() {
      if (_selectedUsers.any((selected) => selected.id == user.id)) {
        _selectedUsers.removeWhere((selected) => selected.id == user.id);
      } else {
        _selectedUsers.add(user);
      }
    });
  }

  Future<void> _createRoom() async {
    final roomName = _groupNameController.text.trim();
    final userIds = _selectedUsers.map((u) => u.id).toList();
    await ref
        .read(roomCreationNotifierProvider.notifier)
        .createRoom(name: roomName, userIds: userIds);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(createRoomNotifierProvider);
    final creationState = ref.watch(roomCreationNotifierProvider);

    ref.listen(roomCreationNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (room) {
          if (room != null && mounted) {
            Navigator.of(context).pop();
            ChatRoute(
              roomId: room.id.toString(),
              $extra: room.name,
            ).go(context);
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Gagal membuat grup: $error')));
        },
      );
    });

    bool canCreate() {
      if (creationState.isLoading) return false;
      return _selectedUsers.length >= 2 &&
          _groupNameController.text.trim().isNotEmpty;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Buat Grup Baru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: canCreate() ? _createRoom : null,
                child: creationState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Buat'),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Grup',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari & Pilih Anggota...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => ref
                      .read(createRoomNotifierProvider.notifier)
                      .searchUsers(keyword: _searchController.text),
                ),
              ),
              onSubmitted: (keyword) => ref
                  .read(createRoomNotifierProvider.notifier)
                  .searchUsers(keyword: keyword),
            ),
          ),
          Flexible(
            child: searchResults.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (users) {
                if (users.isEmpty && _searchController.text.isNotEmpty) {
                  return const Center(child: Text('Pengguna tidak ditemukan.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isSelected = _selectedUsers.any(
                      (s) => s.id == user.id,
                    );
                    return CheckboxListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      value: isSelected,
                      onChanged: (bool? value) => _onUserSelected(user),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
