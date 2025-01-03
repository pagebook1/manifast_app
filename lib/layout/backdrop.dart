import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class StarryBackground extends StatefulWidget {
  const StarryBackground({Key? key}) : super(key: key);

  @override
  _StarryBackgroundState createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _starPositions;
  late List<Offset> _starVelocities;
  late List<double> _starRadii;

  final int _starCount = 20;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // 1. Create the animation controller for a smooth 60fps-ish loop.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
      // The duration doesn't matter much because we'll repeat forever.
    )
      ..addListener(() {
        // This callback fires on each animation tick
        _updateStarPositions();
      })
      ..repeat(); // Make the animation run indefinitely

    // 2. Initialize star data (positions, velocities, sizes).
    _initStarData();
  }

  void _initStarData() {
    final screenSize = WidgetsBinding.instance.window.physicalSize /
        WidgetsBinding.instance.window.devicePixelRatio;

    _starPositions = List.generate(_starCount, (i) {
      final dx = _random.nextDouble() * screenSize.width;
      final dy = _random.nextDouble() * screenSize.height;
      return Offset(dx, dy);
    });

    _starVelocities = List.generate(_starCount, (i) {
      // Random velocity in X and Y
      // We keep them small for a slow movement
      final vx = (_random.nextDouble() - 0.5) * 0.3; // range ~ -0.15..0.15
      final vy = (_random.nextDouble() - 0.5) * 0.3;
      return Offset(vx, vy);
    });

    _starRadii = List.generate(_starCount, (i) {
      // Random radius from 10 to 50, for example
      return 10 + _random.nextDouble() * 2;
    });
  }

  void _updateStarPositions() {
    final screenSize = WidgetsBinding.instance.window.physicalSize /
        WidgetsBinding.instance.window.devicePixelRatio;

    setState(() {
      for (int i = 0; i < _starCount; i++) {
        // Move each star by its velocity
        final newPos = _starPositions[i] + _starVelocities[i];
        double dx = newPos.dx;
        double dy = newPos.dy;

        // If it goes off screen, wrap around
        if (dx < 0) dx = screenSize.width;
        if (dx > screenSize.width) dx = 0;
        if (dy < 0) dy = screenSize.height;
        if (dy > screenSize.height) dy = 0;

        _starPositions[i] = Offset(dx, dy);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _StarPainter(
        starPositions: _starPositions,
        starRadii: _starRadii,
        theme: Theme.of(context),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  final List<Offset> starPositions;
  final List<double> starRadii;
  final ThemeData theme;

  _StarPainter({
    required this.starPositions,
    required this.starRadii,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Choose color based on theme brightness
    final paint = Paint()
      ..color = theme.brightness == Brightness.dark
          ? Colors.grey.withOpacity(0.5)
          : Colors.deepPurple.shade100
      ..style = PaintingStyle.fill;

    // Draw each star
    for (int i = 0; i < starPositions.length; i++) {
      final starPath = _createStarPath(
        center: starPositions[i],
        outerRadius: starRadii[i],
        innerRadius: starRadii[i] * 0.5, // Inner "valley" of the star
        points: 5,
      );
      canvas.drawPath(starPath, paint);
    }
  }

  /// Creates a 5-point star [Path].
  /// [outerRadius] is the tip radius, [innerRadius] the inner valley radius.
  Path _createStarPath({
    required Offset center,
    required double outerRadius,
    required double innerRadius,
    required int points,
  }) {
    final path = Path();
    final angleStep = pi / points; // e.g. for 5 points, angle step is pi/5
    double angle = -pi / 2; // Start at the top

    // Move to the first outer tip
    path.moveTo(
      center.dx + outerRadius * cos(angle),
      center.dy + outerRadius * sin(angle),
    );

    // For a 5-point star, we iterate 10 times (outer tip, inner valley, outer tip, etc.)
    for (int i = 1; i < points * 2; i++) {
      // Alternate outer/inner radius
      final isEven = i % 2 == 0;
      final radius = isEven ? outerRadius : innerRadius;

      angle += angleStep;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      path.lineTo(x, y);
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) => true;
}
