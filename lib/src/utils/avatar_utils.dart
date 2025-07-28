import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarUtils {
  /// Generates a UI avatar URL from a name
  /// Uses the first letter of each word in the name
  /// Example: "John Doe" -> "JD"
  static String generateInitials(String name) {
    if (name.isEmpty) return '';

    final words = name.trim().split(' ');
    if (words.isEmpty) return '';

    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }

    return words
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word.substring(0, 1).toUpperCase())
        .join();
  }

  /// Generates a UI Avatars API URL from a name
  static String generateAvatarUrl(String name, {int size = 200}) {
    if (name.isEmpty) return '';

    final encodedName = Uri.encodeComponent(name);
    return 'https://ui-avatars.com/api/?name=$encodedName&size=$size&background=random&color=fff&rounded=true';
  }

  /// Creates a widget that displays avatar from UI Avatars API
  static Widget createAvatar(String name, {double size = 40}) {
    if (name.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      );
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: generateAvatarUrl(name, size: size.toInt()),
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  generateInitials(name),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  generateInitials(name),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
