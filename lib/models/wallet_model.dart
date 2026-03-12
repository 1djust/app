class Wallet {
  final String currency;
  final double balance;
  final String accountNumber;
  final String accountName;
  final String bankName;
  final bool isActive;
  final bool isVisible; // For eye toggle state

  Wallet({
    required this.currency,
    required this.balance,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.isActive,
    this.isVisible = false,
  });

  // CopyWith for state updates (like toggling visibility)
  Wallet copyWith({
    String? currency,
    double? balance,
    String? accountNumber,
    String? accountName,
    String? bankName,
    bool? isActive,
    bool? isVisible,
  }) {
    return Wallet(
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      bankName: bankName ?? this.bankName,
      isActive: isActive ?? this.isActive,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
