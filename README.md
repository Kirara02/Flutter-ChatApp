# XChat - Aplikasi Chat Real-time dengan Flutter

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Riverpod-2.x-blue?logo=riverpod" alt="Riverpod Version">
  <img src="https://img.shields.io/badge/Architecture-Clean-brightgreen" alt="Architecture">
</p>

XChat adalah aplikasi mobile fungsional yang dibangun menggunakan Flutter untuk menyediakan platform perpesanan instan yang modern, cepat, dan andal. Aplikasi ini dirancang dengan arsitektur bersih (_Clean Architecture_) untuk memastikan kode yang mudah dikelola, diskalakan, dan diuji.

## Tampilan Aplikasi

Berikut adalah beberapa tampilan utama dari aplikasi XChat:

<table align="center">
  <tr>
    <td align="center"><strong>Layar Login</strong></td>
    <td align="center"><strong>Layar Registrasi</strong></td>
  </tr>
  <tr>
    <td valign="top"><img src="docs/login_screen.png" alt="Tampilan Layar Login" width="250"/></td>
    <td valign="top"><img src="docs/register_screen.png" alt="Tampilan Layar Registrasi" width="250"/></td>
  </tr>
  <tr>
    <td align="center"><strong>Daftar Chat</strong></td>
    <td align="center"><strong>Ruang Obrolan</strong></td>
  </tr>
  <tr>
    <td valign="top"><img src="docs/chats_screen.png" alt="Tampilan Daftar Chat" width="250"/></td>
    <td valign="top"><img src="docs/chat_screen.png" alt="Tampilan Ruang Obrolan" width="250"/></td>
  </tr>
</table>

## Fitur Utama

- **Autentikasi Pengguna**: Alur lengkap untuk Pendaftaran (_Register_), Masuk (_Login_), dan Keluar (_Logout_).
- **Onboarding**: Pengenalan aplikasi yang ramah bagi pengguna baru.
- **Daftar Chat**: Menampilkan semua ruang obrolan (pribadi dan grup) dengan pesan terakhir dan waktu.
- **Real-time Chat**: Komunikasi dua arah secara instan menggunakan WebSocket.
- **Arsitektur Bersih**: Pemisahan yang jelas antara lapisan Presentasi, Domain, dan Data.
- **Manajemen State Modern**: Menggunakan Riverpod untuk manajemen state yang reaktif dan efisien.
- **Penanganan Error**: Mekanisme penanganan error jaringan yang tangguh.

## Teknologi & Arsitektur

Proyek ini dibangun dengan tumpukan teknologi modern untuk pengembangan aplikasi Flutter:

- **Framework**: [Flutter](https://flutter.dev/)
- **Bahasa**: [Dart](https://dart.dev/)
- **Manajemen State**: [Riverpod](https://riverpod.dev/) dengan [Riverpod Generator](https://pub.dev/packages/riverpod_generator) untuk _boilerplate-free code_.
- **Networking**:
  - [Dio](https://pub.dev/packages/dio) untuk permintaan HTTP (REST API).
  - [web_socket_channel](https://pub.dev/packages/web_socket_channel) untuk komunikasi WebSocket.
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) dengan _Typed Routes_ untuk navigasi yang aman.
- **Arsitektur**: Mengadopsi prinsip **Clean Architecture** dengan lapisan:
  - **Presentation**: UI (Widgets) dan Controller (Notifier).
  - **Domain**: Usecase dan Model entitas.
  - **Data**: Repository dan DataSource (remote/local).

## Memulai Proyek

Untuk menjalankan proyek ini di lingkungan lokal Anda, ikuti langkah-langkah berikut:

### Prasyarat

- Pastikan Anda telah menginstal [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi 3.x atau lebih baru).
- Sebuah IDE seperti VS Code atau Android Studio.

### Instalasi

1.  **Clone repository ini:**

    ```bash
    git clone [https://github.com/URL_PROYEK_ANDA/xchat.git](https://github.com/URL_PROYEK_ANDA/xchat.git)
    cd xchat
    ```

2.  **Install dependensi:**

    ```bash
    flutter pub get
    ```

3.  **Jalankan code generator:**
    Riverpod Generator digunakan untuk menghasilkan _provider_. Jalankan perintah berikut untuk menghasilkan file yang diperlukan (`.g.dart`):

    ```bash
    flutter pub run build_runner watch --delete-conflicting-outputs
    ```

4.  **Jalankan aplikasi:**
    Pastikan Anda memiliki emulator yang berjalan atau perangkat fisik yang terhubung, lalu jalankan:
    ```bash
    flutter run
    ```

## Struktur Proyek

Struktur direktori proyek ini dirancang agar mudah dinavigasi dan diskalakan:

```
lib/
├── src/
│   ├── core/                # Logika inti, seperti networking, result type, dll.
│   ├── features/            # Fitur-fitur utama aplikasi
│   │   ├── auth/            # Fitur autentikasi (login, register)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── main/            # Fitur utama setelah login (chats, chat room)
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   ├── global_providers/    # Provider Riverpod yang bersifat global
│   ├── routes/              # Konfigurasi GoRouter
│   └── utils/               # Utilitas dan ekstensi
└── main.dart                # Titik masuk utama aplikasi
```

## Kontribusi

Kontribusi sangat kami hargai! Jika Anda ingin berkontribusi, silakan _fork_ repository ini dan buat _pull request_. Untuk perubahan besar, mohon buka _issue_ terlebih dahulu untuk mendiskusikan apa yang ingin Anda ubah.

## Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT. Lihat file `LICENSE` untuk detailnya.
