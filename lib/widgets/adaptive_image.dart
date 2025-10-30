import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

/// A small helper that displays either an asset image (when the path starts
/// with `assets/`) or a network image otherwise. Keeps call sites simple and
/// centralizes any placeholder/error handling.
class AdaptiveImage extends StatelessWidget {
  final String? src;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AdaptiveImage(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (src == null) return const SizedBox.shrink();

    if (src!.startsWith('assets/')) {
      return Image.asset(src!, fit: fit, width: width, height: height);
    }

    // Support data URIs created from picked files (data:image/..;base64,...)
    if (src!.startsWith('data:')) {
      try {
        final comma = src!.indexOf(',');
        final base64Part = src!.substring(comma + 1);
        final bytes = base64Decode(base64Part);
        return Image.memory(bytes, fit: fit, width: width, height: height);
      } catch (_) {
        // fall through to network placeholder
      }
    }

    // If it's a local file path, show it using Image.file.
    try {
      final file = File(src!);
      if (file.existsSync()) {
        return Image.file(file, fit: fit, width: width, height: height);
      }
    } catch (_) {
      // ignore and fall back to network
    }

    return Image.network(
      src!,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: Icon(Icons.broken_image)),
        );
      },
    );
  }
}
