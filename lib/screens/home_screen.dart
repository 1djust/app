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
  // ignore: unused_field
  int _activeWalletIndex = 0;

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
                totalBalance: 15332113,
                currencies: const ['NGN', 'GBP', 'EUR'],
                onCurrencyChanged: (index) {
                  setState(() => _activeWalletIndex = index);
                },
              ),
              const SizedBox(height: 16),
              // Currency Cards
              const CurrencyCard(
                currencyCode: 'EUR',
                currencyName: 'Euro',
                balance: 2156.80,
                trendPercentage: -1.8,
                accentColor: AppColors.cardPurple,
              ),
              const CurrencyCard(
                currencyCode: 'GBP',
                currencyName: 'British Pound',
                balance: 4280.55,
                trendPercentage: 3.2,
                accentColor: AppColors.cardBlue,
              ),
              const CurrencyCard(
                currencyCode: 'NGN',
                currencyName: 'Nigerian Naira',
                balance: 2847350,
                trendPercentage: 12.5,
                accentColor: AppColors.cardGreen,
              ),
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
