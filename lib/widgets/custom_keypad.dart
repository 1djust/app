import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onDeletePressed;
  final bool biometricEnabled;
  final VoidCallback? onBiometricPressed;

  const CustomKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onDeletePressed,
    this.biometricEnabled = false,
    this.onBiometricPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.midnightBase : AppColors.surfaceLight,
      padding: const EdgeInsets.only(bottom: 24, top: 16, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey(context, '1', ''),
              _buildKey(context, '2', 'ABC'),
              _buildKey(context, '3', 'DEF'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey(context, '4', 'GHI'),
              _buildKey(context, '5', 'JKL'),
              _buildKey(context, '6', 'MNO'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey(context, '7', 'PQRS'),
              _buildKey(context, '8', 'TUV'),
              _buildKey(context, '9', 'WXYZ'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: SizedBox()),
              _buildKey(context, '0', ''),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.backspace_outlined),
                      onPressed: onDeletePressed,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(BuildContext context, String value, String letters) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Material(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.midnightSurface
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 0,
          child: InkWell(
            onTap: () => onKeyPressed(value),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    width: 0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                    ),
                  ),
                  if (letters.isNotEmpty)
                    Text(
                      letters,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
