import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilApp {
  static Future<void> launchUrlApp(String url) async {
    if (url.isEmpty) return;
    
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error al abrir URL: $e');
    }
  }

  static Future<void> launchYoutubeVideo(String videoUrl) async {
    if (videoUrl.isEmpty) return;
    
    final normalizedUrl = videoUrl
        .replaceAll('https://www.youtube.com/embed/', 'https://www.youtube.com/watch?v=')
        .replaceAll('https://youtu.be/', 'https://www.youtube.com/watch?v=');

    final uri = Uri.tryParse(normalizedUrl);
    if (uri == null) return;

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error al abrir video de YouTube: $e');
    }
  }  
}