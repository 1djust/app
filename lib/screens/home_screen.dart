import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'settings_screen.dart';

import '../widgets/home_header.dart';
import '../widgets/wallet_section.dart';
import '../widgets/currency_card.dart';
import '../widgets/home_action_grid.dart';
import '../widgets/exchange_widget.dart';
import '../widgets/recent_activity_list.dart';

// Figours fintech app - Smart Modular Home screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _activeWalletIndex = 0;

  final List<Map<String, dynamic>> _wallets = [
    {
      'code': 'NGN',
      'name': 'Nigerian Naira',
      'symbol': '₦',
      'balance': 2847350.0,
      'trend': 12.5,
      'color': AppColors.cardGreen,
    },
    {
      'code': 'GBP',
      'name': 'British Pound',
      'symbol': '£',
      'balance': 4280.55,
      'trend': 3.2,
      'color': AppColors.cardBlue,
    },
    {
      'code': 'EUR',
      'name': 'Euro',
      'symbol': '€',
      'balance': 2156.80,
      'trend': -1.8,
      'color': AppColors.cardPurple,
    },
  ];

  void _onCurrencyTapped(int index) {
    setState(() {
      _activeWalletIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: 'Justus',
                onProfileTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
                onNotificationTap: () {},
              ),
              WalletSection(
                totalBalance: _wallets[_activeWalletIndex]['balance'],
                currencySymbol: _wallets[_activeWalletIndex]['symbol'],
                currencyLabel: _wallets[_activeWalletIndex]['name'],
                currencies: _wallets.map((w) => w['code'] as String).toList(),
                initialIndex: _activeWalletIndex,
                onCurrencyChanged: _onCurrencyTapped,
              ),
              const SizedBox(height: 16),
              // Currency Cards
              ...List.generate(_wallets.length, (index) {
                final wallet = _wallets[index];
                return CurrencyCard(
                  currencyCode: wallet['code'],
                  currencyName: wallet['name'],
                  balance: wallet['balance'],
                  trendPercentage: wallet['trend'],
                  accentColor: wallet['color'],
                  onTap: () => _onCurrencyTapped(index),
                );
              }),
              const HomeActionGrid(),
              const ExchangeWidget(),
              const RecentActivityList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: 'Activity'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              activeIcon: Icon(Icons.trending_up),
              label: 'Invest'),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined),
              activeIcon: Icon(Icons.credit_card),
              label: 'Cards'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}
