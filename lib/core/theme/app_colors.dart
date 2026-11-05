import 'package:flutter/material.dart';

/// NODOS - Zinciri Kırma marka ve arayüz renk paleti.
/// Görseldeki minimalist, antrasit ve modern stil baz alınarak hazırlanmıştır.
class AppColors {
  AppColors._();

  // --- NODOS Marka & Vurgu Renkleri ---
  /// Logodaki ve merkezi butondaki imza antrasit/kömür rengi
  static const Color nodosDark = Color(0xFF1E222A);
  static const Color nodosCharcoal = Color(0xFF2A2F3A);

  /// Zinciri Kırma / Başarı yeşili
  static const Color accent = Color(0xFF1ABC9C);
  static const Color accentLight = Color(0xFF2ECC71);

  /// Kırılan zincir / uyarı kırmızısı
  static const Color chainAlert = Color(0xFFE74C3C);

  // --- Açık (Light) Tema Renkleri ---
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceSecondary = Color(0xFFF1F3F6);
  static const Color lightTextPrimary = Color(0xFF1A1D24);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextMuted = Color(0xFF9CA3AF);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightNavPill = Color(0xFFE9ECF1);

  // --- Koyu (Dark) Tema Renkleri ---
  static const Color darkBackground = Color(0xFF121418);
  static const Color darkSurface = Color(0xFF1A1D24);
  static const Color darkSurfaceSecondary = Color(0xFF242832);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextMuted = Color(0xFF6B7280);
  static const Color darkBorder = Color(0xFF2E333D);
  static const Color darkNavPill = Color(0xFF282D37);

  // --- Geriye Dönük Uyumluluk ---
  static const Color primaryDark = nodosDark;
  static const Color primaryLight = nodosCharcoal;
}
