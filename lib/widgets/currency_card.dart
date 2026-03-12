import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class CurrencyCard extends StatefulWidget {
  final String currencyCode;
  final String currencyName;
  final double balance;
  final double trendPercentage;
  final Color accentColor;

  const CurrencyCard({
    super.key,
    required this.currencyCode,
    required this.currencyName,
    required this.balance,
    required this.trendPercentage,
    required this.accentColor,
  });

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  bool _isExpanded = false;

  String _formatBalance(double balance) {
    return balance.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  String _getCurrencySymbol(String code) {
    switch (code) {
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'NGN':
        return '₦';
      default:
        return '\$';
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.trendPercentage >= 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isExpanded
              ? AppColors.primaryGreen
              : (isDark
                  ? AppColors.borderDark
                  : widget.accentColor.withOpacity(0.3)),
          width: _isExpanded ? 2.0 : 1.5,
        ),
        boxShadow: isDark || !_isExpanded
            ? []
            : [
                BoxShadow(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/${widget.currencyCode.toLowerCase()}.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.public, color: widget.accentColor),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.currencyCode,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.textMainDark
                              : AppColors.textMain,
                        ),
                      ),
                      Text(
                        widget.currencyName,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_getCurrencySymbol(widget.currencyCode)}${_formatBalance(widget.balance)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textMainDark
                            : AppColors.textMain,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive ? Icons.trending_up : Icons.trending_down,
                          size: 14,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${isPositive ? '+' : ''}${widget.trendPercentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isPositive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                    color: isDark ? AppColors.textMutedDark : Colors.grey[400],
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 24),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 20),

              // Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Credit',
                      '₦996,572',
                      Icons.south_west,
                      Colors.green,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Debit',
                      '₦340,200',
                      Icons.north_east,
                      Colors.red,
                      isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Insight
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1FDF9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6F9F3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_outlined,
                        color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "You're spending 18% less on food this week. Keep it up!",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Account Details Section
              Row(
                children: [
                  Icon(Icons.credit_card_outlined,
                      size: 18, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(
                    'ACCOUNT DETAILS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color:
                      isDark ? AppColors.surfaceDark : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildDetailItem(
                      icon: Icons.person_outline,
                      label: 'Account Name',
                      value: 'Justus Okonkwo',
                      isDark: isDark,
                      onCopy: () =>
                          _copyToClipboard('Justus Okonkwo', 'Account Name'),
                    ),
                    _buildDetailDivider(),
                    _buildDetailItem(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Account Number',
                      value: '0123 4567 89',
                      isDark: isDark,
                      onCopy: () =>
                          _copyToClipboard('0123456789', 'Account Number'),
                    ),
                    _buildDetailDivider(),
                    _buildDetailItem(
                      icon: Icons.storefront_outlined,
                      label: 'Bank',
                      value: 'Figours MFB',
                      isDark: isDark,
                      onCopy: () =>
                          _copyToClipboard('Figours MFB', 'Bank Name'),
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    required VoidCallback onCopy,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textMainDark
                        : const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCopy,
            icon: Icon(Icons.copy, size: 20, color: Colors.grey[400]),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailDivider() {
    return Divider(
        height: 1, thickness: 1, color: Colors.grey[100], indent: 52);
  }
}
