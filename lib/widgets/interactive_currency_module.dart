import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class InteractiveCurrencyModule extends StatefulWidget {
  final String fromCurrency;
  final String toCurrency;
  final double conversionRate;
  final double amount;
  final ValueChanged<String> onAmountChanged;
  final VoidCallback onSwap;
  final VoidCallback onFromCurrencyTap;
  final VoidCallback onToCurrencyTap;
  final bool isConverting;
  final String bestTimeSuggestion;
  final double
      volatilityIndicator; // -1.0 to 1.0 (negative = trending down, positive = trending up)

  const InteractiveCurrencyModule({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.conversionRate,
    required this.amount,
    required this.onAmountChanged,
    required this.onSwap,
    required this.onFromCurrencyTap,
    required this.onToCurrencyTap,
    this.isConverting = false,
    this.bestTimeSuggestion = 'Good time to convert',
    this.volatilityIndicator = 0.5,
  });

  @override
  State<InteractiveCurrencyModule> createState() =>
      _InteractiveCurrencyModuleState();
}

class _InteractiveCurrencyModuleState extends State<InteractiveCurrencyModule> {
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.amount.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(InteractiveCurrencyModule oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount &&
        !_amountController.text.startsWith(widget.amount.toString()) &&
        !widget.amount.toString().startsWith(_amountController.text)) {
      _amountController.text = widget.amount.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  final _numberFormat = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String _formatNumber(double number) {
    return number
        .toStringAsFixed(2)
        .replaceAllMapped(_numberFormat, (Match m) => '${m[1]},');
  }

  String _formatRate(double rate) {
    if (rate < 0.01) return rate.toStringAsFixed(4);
    if (rate < 1) return rate.toStringAsFixed(3);
    return rate.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Currency Converter',
                style: TextStyle(
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.volatilityIndicator >= 0
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.show_chart,
                        size: 14,
                        color: widget.volatilityIndicator >= 0
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '1 ${widget.fromCurrency} = ${_formatRate(widget.conversionRate)} ${widget.toCurrency}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.volatilityIndicator >= 0
                                ? Colors.green
                                : Colors.orange,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  _buildCurrencyInputRow(
                    isSource: true,
                    currency: widget.fromCurrency,
                    onCurrencyTap: widget.onFromCurrencyTap,
                    child: TextField(
                      controller: _amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: widget.onAmountChanged,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: isDark
                            ? AppColors.textMainDark
                            : AppColors.textMain,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCurrencyInputRow(
                    isSource: false,
                    currency: widget.toCurrency,
                    onCurrencyTap: widget.onToCurrencyTap,
                    child: Text(
                      widget.isConverting
                          ? '...'
                          : _formatNumber(
                              widget.amount * widget.conversionRate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: isDark
                            ? AppColors.textMainDark
                            : AppColors.textMain,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 32, // positioned between the two rows on the right side
                child: GestureDetector(
                  onTap: widget.onSwap,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.electricAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowGreen.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.swap_vert,
                        color: AppColors.midnightBase, size: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // AI Suggestion Footer
          Row(
            children: [
              Icon(Icons.info_outline,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                  size: 14),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.bestTimeSuggestion,
                  style: TextStyle(
                    color:
                        isDark ? AppColors.textMutedDark : AppColors.textMuted,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              // Mini Sparkline / Trend visual placeholder
              SizedBox(
                width: 60,
                height: 20,
                // A very simple placeholder for a trend indicator
                child: CustomPaint(
                  painter: _MiniTrendPainter(
                    isPositive: widget.volatilityIndicator >= 0,
                    color: widget.volatilityIndicator >= 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCurrencyInputRow({
    required bool isSource,
    required String currency,
    required VoidCallback onCurrencyTap,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color:
            isDark ? AppColors.midnightSurfaceLighter : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : AppColors.borderLight),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onCurrencyTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.midnightSurface : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/${currency.toLowerCase()}.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.public, size: 20, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currency,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark
                            ? AppColors.textMainDark
                            : AppColors.textMain),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _MiniTrendPainter extends CustomPainter {
  final bool isPositive;
  final Color color;

  _MiniTrendPainter({required this.isPositive, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * (isPositive ? 0.8 : 0.2));

    // Draw a simple zig-zag curve
    path.lineTo(size.width * 0.25, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * (isPositive ? 0.9 : 0.1));
    path.lineTo(size.width * 0.75, size.height * 0.4);
    path.lineTo(size.width, size.height * (isPositive ? 0.2 : 0.8));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
