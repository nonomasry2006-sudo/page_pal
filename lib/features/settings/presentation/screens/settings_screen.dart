import 'package:flutter/material.dart';

import '../../../../core/storage/prefs_service.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _dailyReminder = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final push = await PrefsService.getPushNotifications();
    final daily = await PrefsService.getDailyReminder();
    if (!mounted) return;
    setState(() {
      _pushNotifications = push;
      _dailyReminder = daily;
      _isLoading = false;
    });
  }

  Future<void> _togglePush(bool value) async {
    setState(() => _pushNotifications = value);
    await PrefsService.setPushNotifications(value);
  }

  Future<void> _toggleDaily(bool value) async {
    setState(() => _dailyReminder = value);
    await PrefsService.setDailyReminder(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Settings')),
      body: GradientBackground(
        showFireflies: false,
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    GlassCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          SwitchListTile(
                            value: _pushNotifications,
                            onChanged: _togglePush,
                            secondary:
                                const Icon(Icons.notifications_outlined),
                            title: const Text('Push Notifications'),
                          ),
                          const Divider(height: 1),
                          SwitchListTile(
                            value: _dailyReminder,
                            onChanged: _toggleDaily,
                            secondary: const Icon(Icons.alarm_outlined),
                            title: const Text('Daily Reading Reminder'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Other',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    GlassCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.cleaning_services_outlined,
                            ),
                            title: const Text('Clear Cache'),
                            onTap: () {},
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('About PagePal'),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'PagePal v1.0.0',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}