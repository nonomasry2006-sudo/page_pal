import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool showGlowOrbs;
  final bool showFireflies;
  final String imagePath;
  final double blurSigma;
  final double darkenAmount;

  const GradientBackground({
    super.key,
    required this.child,
    this.showGlowOrbs = true,
    this.showFireflies = true,
    this.imagePath = 'assets/images/enchanted_forest.jpg',
    this.blurSigma = 6,
    this.darkenAmount = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        ),
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            color: Colors.black.withValues(alpha: darkenAmount),
          ),
        ),
        if (showGlowOrbs) ...[
          Positioned(
            top: -100,
            right: -80,
            child: _GlowOrb(
              color: AppColors.primary.withValues(alpha: 0.35),
              size: 260,
            ),
          ),
          Positioned(
            bottom: -120,
            left: -80,
            child: _GlowOrb(
              color: AppColors.secondary.withValues(alpha: 0.28),
              size: 300,
            ),
          ),
          Positioned(
            top: 300,
            right: -100,
            child: _GlowOrb(
              color: AppColors.accent.withValues(alpha: 0.2),
              size: 220,
            ),
          ),
        ],
        if (showFireflies) const _Fireflies(),
        child,
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _Fireflies extends StatefulWidget {
  const _Fireflies();

  @override
  State<_Fireflies> createState() => _FirefliesState();
}

class _FirefliesState extends State<_Fireflies>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            painter: _FireflyPainter(
              progress: _controller.value,
              color: AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _FireflyPainter extends CustomPainter {
  final double progress;
  final Color color;

  _FireflyPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const count = 30;
    final rand = math.Random(42);

    for (var i = 0; i < count; i++) {
      final baseX = rand.nextDouble() * size.width;
      final baseY = rand.nextDouble() * size.height;
      final phase = rand.nextDouble() * math.pi * 2;
      final speed = 0.3 + rand.nextDouble() * 0.7;
      final radius = 1.5 + rand.nextDouble() * 2.0;

      final dx = math.sin(progress * math.pi * 2 * speed + phase) * 34;
      final dy = math.cos(progress * math.pi * 2 * speed + phase) * 24;
      final flicker =
          0.4 + 0.6 * (0.5 + 0.5 * math.sin(progress * math.pi * 8 + phase));

      final paint = Paint()
        ..color = color.withValues(alpha: 0.6 * flicker)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

      canvas.drawCircle(Offset(baseX + dx, baseY + dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FireflyPainter old) => old.progress != progress;
}