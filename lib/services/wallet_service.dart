import '../models/wallet_model.dart';

class WalletService {
  Future<List<Wallet>> getWallets() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      Wallet(
        currency: 'NGN',
        balance: 2500000.00,
        accountNumber: '2781621121',
        accountName: 'FIG - JOHN OLAMIDE',
        bankName: 'Fidelity Bank',
        isActive: true,
      ),
      Wallet(
        currency: 'GBP',
        balance: 1540.50,
        accountNumber: 'GB93COOP8728119837123',
        accountName: 'JOHN OLAMIDE',
        bankName: 'Clear Junction',
        isActive: true,
      ),
      Wallet(
        currency: 'EUR',
        balance: 420.00,
        accountNumber: 'GB93COOP8728119837123',
        accountName: 'JOHN OLAMIDE',
        bankName: 'Clear Junction',
        isActive: true,
      ),
    ];
  }
}
