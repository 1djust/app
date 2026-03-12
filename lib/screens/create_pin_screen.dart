import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import '../widgets/custom_keypad.dart';
import 'verification_status_screen.dart';
import '../theme/app_colors.dart';

class CreatePinScreen extends StatefulWidget {
  final bool isLoginPin;
  final String? loginPin;

  const CreatePinScreen({super.key, required this.isLoginPin, this.loginPin});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';
  bool _enableFingerprint = false;
  bool _obscurePin = true;

  int get _pinLength => widget.isLoginPin ? 4 : 6;

  void _onKeyPressed(String value) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == _pinLength) {
        _onSubmit();
      }
    }
  }

  void _onDeletePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _onSubmit() {
    if (widget.isLoginPin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreatePinScreen(isLoginPin: false, loginPin: _pin),
        ),
      );
    } else {
      if (_pin == widget.loginPin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction PIN must be different from Login PIN'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _pin = '';
        });
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationStatusScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textMain),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                ProgressBar(
                  currentStep: widget.isLoginPin ? 4 : 5,
                  totalSteps: 5,
                ),
                const SizedBox(height: 32),
                Text(
                  widget.isLoginPin
                      ? 'Create Login PIN'
                      : 'Create Transaction PIN',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.isLoginPin
                        ? 'This PIN is used to unlock your app'
                        : 'This PIN is required to approve transactions and sensitive action. Make it different from your login PIN.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // PIN Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(_pinLength, (index) {
                      final isFilled = index < _pin.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: widget.isLoginPin ? 20 : 40,
                        height: widget.isLoginPin ? 20 : 55,
                        decoration: widget.isLoginPin
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFilled
                                    ? Colors.amber
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 2,
                                ),
                              )
                            : BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isFilled
                                      ? Colors.amber
                                      : AppColors.borderLight,
                                  width: 1.5,
                                ),
                              ),
                        child: !widget.isLoginPin && isFilled
                            ? Center(
                                child: _obscurePin
                                    ? Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : Text(
                                        _pin[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textMain,
                                        ),
                                      ),
                              )
                            : null,
                      );
                    }),
                    if (!widget.isLoginPin) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          _obscurePin
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textMain,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePin = !_obscurePin;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Fingerprint
          if (widget.isLoginPin)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                border: Border.all(color: AppColors.borderLight),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.borderLight, width: 0.5),
                    ),
                    child: Image.asset(
                      'assets/images/finger.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.fingerprint,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enable Fingerprint',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textMain,
                          ),
                        ),
                        Text(
                          'Faster, secure login',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _enableFingerprint,
                    onChanged: (value) {
                      setState(() {
                        _enableFingerprint = value;
                      });
                    },
                    thumbColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.amber;
                      }
                      return null;
                    }),
                    activeTrackColor: Colors.amber.withOpacity(0.3),
                  ),
                ],
              ),
            ),

          // Keypad
          CustomKeypad(
            onKeyPressed: _onKeyPressed,
            onDeletePressed: _onDeletePressed,
          ),
        ],
      ),
    );
  }
}
