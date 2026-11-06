import 'package:flutter/material.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';

/// NODOS "ND - Zinciri Kırma" imza logo bileşeni.
/// Vektörel çizim ve varlık (asset) desteğiyle her boyutta keskin ve modern görünür.
class NodosLogo extends StatelessWidget {
  const NodosLogo({
    super.key,
    this.size = 36,
    this.color,
    this.chainColor,
    this.useAssetImage = false,
  });

  final double size;
  final Color? color;
  final Color? chainColor;
  final bool useAssetImage;

  @override
  Widget build(BuildContext context) {
    if (useAssetImage) {
      return Image.asset(
        'assets/images/nodos_app_logo.jpg',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _buildVectorLogo(context),
      );
    }
    return _buildVectorLogo(context);
  }

  Widget _buildVectorLogo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = color ?? (isDark ? Colors.white : AppColors.nodosDark);
    final linkColor = chainColor ?? AppColors.accent;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _NodosMonogramPainter(
          primaryColor: primaryColor,
          chainColor: linkColor,
        ),
      ),
    );
  }
}

/// "ND" harflerini ve ortasındaki açılı zincir halkasını çizen CustomPainter.
class _NodosMonogramPainter extends CustomPainter {
  _NodosMonogramPainter({
    required this.primaryColor,
    required this.chainColor,
  });

  final Color primaryColor;
  final Color chainColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.12;

    final letterPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final chainPaint = Paint()
      ..color = chainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.95
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // --- "N" Harfi Çizimi (Sol Taraf) ---
    final nPath = Path();
    // N sol dikey çizgi
    nPath.moveTo(w * 0.18, h * 0.82);
    nPath.lineTo(w * 0.18, h * 0.22);
    // N çapraz çizgi
    nPath.lineTo(w * 0.44, h * 0.80);
    // N sağ dikey çizgi
    nPath.lineTo(w * 0.44, h * 0.22);
    canvas.drawPath(nPath, letterPaint);

    // --- "D" Harfi Çizimi (Sağ Taraf) ---
    final dPath = Path();
    // D sol dikey omurga
    dPath.moveTo(w * 0.54, h * 0.82);
    dPath.lineTo(w * 0.54, h * 0.22);
    // D sağ kavis
    dPath.lineTo(w * 0.68, h * 0.22);
    dPath.cubicTo(
      w * 0.92,
      h * 0.22,
      w * 0.92,
      h * 0.82,
      w * 0.68,
      h * 0.82,
    );
    dPath.close();
    canvas.drawPath(dPath, letterPaint);

    // --- Zincir Halkası (Ortada N ve D'yi birbirine bağlayan açılı halka) ---
    canvas.save();
    canvas.translate(w * 0.49, h * 0.52);
    canvas.rotate(-0.55); // ~ -31 derece açı

    final chainRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: w * 0.36,
        height: h * 0.18,
      ),
      Radius.circular(h * 0.09),
    );

    // Halkanın arka planı hafif temizlemesi için alt silgi
    final clearPaint = Paint()
      ..color = primaryColor == Colors.white
          ? AppColors.nodosDark
          : Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRRect(chainRect, clearPaint);

    // Halka dış çizgisi
    canvas.drawRRect(chainRect, chainPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _NodosMonogramPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.chainColor != chainColor;
  }
}

