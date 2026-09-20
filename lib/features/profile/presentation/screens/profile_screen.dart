import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glow_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/cubit/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('My Profile')),
      body: GradientBackground(
        showFireflies: false,
        child: SafeArea(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is! AuthAuthenticated) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = state.user;
              final hasPhone = user.phone != null && user.phone!.isNotEmpty;
              final hasBio = user.bio != null && user.bio!.isNotEmpty;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // ── Profile card
                    GlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.3),
                            child: const Icon(Icons.person, size: 48),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          // Phone
                          if (hasPhone) ...[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  user.phone!,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],

                          // Bio
                          if (hasBio) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white
                                      .withValues(alpha: 0.08),
                                ),
                              ),
                              child: Text(
                                user.bio!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      height: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Menu card
                    GlassCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit_outlined),
                            title: const Text('Edit Profile'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push(RouteNames.editProfile),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.settings_outlined),
                            title: const Text('Settings'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push(RouteNames.settings),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Log out
                    GlowButton(
                      label: 'Log Out',
                      icon: Icons.logout_rounded,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7F1D1D), Color(0xFFEF4444)],
                      ),
                      onPressed: () async {
                        await context.read<AuthCubit>().signOut();
                        if (context.mounted) {
                          context.go(RouteNames.login);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}