part of '../mentorx_ui.dart';

/// A wrapper that provides screenshot protection and a dynamic watermark.
/// 
/// This widget is part of the mentorx_ui kit and should be used to protect
/// sensitive media content like videos and PDFs.
class MentorXSecuredMediaWrapper extends StatefulWidget {
  final Widget child;
  final bool isProtected;
  final String? watermarkText;

  const MentorXSecuredMediaWrapper({
    super.key,
    required this.child,
    this.isProtected = true,
    this.watermarkText,
  });

  @override
  State<MentorXSecuredMediaWrapper> createState() => _MentorXSecuredMediaWrapperState();
}

class _MentorXSecuredMediaWrapperState extends State<MentorXSecuredMediaWrapper> {
  @override
  void initState() {
    super.initState();
    if (widget.isProtected) {
      _enableProtection();
    }
  }

  @override
  void dispose() {
    if (widget.isProtected) {
      _disableProtection();
    }
    super.dispose();
  }

  Future<void> _enableProtection() async {
    try {
      await ScreenProtector.preventScreenshotOn();
      // On iOS, this blurs the screen in the app switcher
      await ScreenProtector.protectDataLeakageWithBlur();
    } catch (e) {
      debugPrint('Error enabling screen protection: $e');
    }
  }

  Future<void> _disableProtection() async {
    try {
      await ScreenProtector.preventScreenshotOff();
      await ScreenProtector.protectDataLeakageOff();
    } catch (e) {
      debugPrint('Error disabling screen protection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isProtected && widget.watermarkText != null)
          Positioned.fill(
            child: IgnorePointer(
              child: _WatermarkOverlay(text: widget.watermarkText!),
            ),
          ),
      ],
    );
  }
}

class _WatermarkOverlay extends StatefulWidget {
  final String text;

  const _WatermarkOverlay({required this.text});

  @override
  State<_WatermarkOverlay> createState() => _WatermarkOverlayState();
}

class _WatermarkOverlayState extends State<_WatermarkOverlay> {
  late Timer _timer;
  double _opacity = 0.05;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (mounted) {
        setState(() {
          _opacity = 0.03 + _random.nextDouble() * 0.04;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(12, (index) {
            final top = (index / 3).floor() * (constraints.maxHeight / 4) + 100;
            final left = (index % 3) * (constraints.maxWidth / 3) + 20;

            return Positioned(
              top: top,
              left: left,
              child: Transform.rotate(
                angle: -0.5,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(_opacity),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
