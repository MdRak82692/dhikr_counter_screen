import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/dhikr_provider.dart';
import '../widgets/glowing_counter.dart';

class DhikrCounterScreen extends ConsumerWidget {
  const DhikrCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dhikrProvider);
    final notifier = ref.read(dhikrProvider.notifier);
    final fmt = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF111111), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 0.5,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dhikr',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'JOINED',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: AppColors.primaryGold,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                      onPressed: notifier.reset,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Global Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF0C0C0C),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.indicatorGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'GLOBAL LIVE COUNT',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                fmt.format(state.totalRecitationsToday),
                style: GoogleFonts.outfit(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'TOTAL RECITATIONS TODAY',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              const Spacer(),
              // Center Circle
              GlowingCounter(
                count: state.currentCount,
                arabic: state.arabicText,
                transliteration: state.transliteration,
                translation: state.translation,
                onTap: state.isVoiceMode
                    ? () {}
                    : notifier
                          .increment, // Disable tap increment if in Voice Mode? No, keep it anyway
              ),
              const Spacer(),
              // Actions
              GestureDetector(
                onTap:
                    notifier.increment, // Make "TAP TO RECITE" functional too
                child: Column(
                  children: [
                    Text(
                      state.isVoiceMode ? 'LISTENING...' : 'TAP TO RECITE',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        letterSpacing: 3.0,
                        color: state.isVoiceMode
                            ? AppColors.indicatorGreen
                            : Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (state.isVoiceMode)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 20,
                          height: 2,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: AppColors.indicatorGreen,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await notifier.toggleVoiceMode();
                  // Re-fetching state because it might have changed inside the await
                  final updatedState = ref.read(dhikrProvider);

                  // Check if the widget is still in the tree before using context
                  if (!context.mounted) return;

                  if (updatedState.isVoiceMode) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Voice Mode Activated: Say "SUBHANALLAH" to count',
                        ),
                        backgroundColor: AppColors.primaryGold,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E0D0B),
                  foregroundColor: AppColors.primaryGold,
                  side: BorderSide(
                    color: AppColors.primaryGold.withValues(alpha: 0.4),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      state.isVoiceMode ? Icons.touch_app : Icons.mic,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      state.isVoiceMode ? 'CHANGE TO TAP' : 'CHANGE TO VOICE',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SESSION GOAL',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.4),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${state.currentCount} / ${state.sessionGoal}',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${state.completionPercentage.toInt()}% COMPLETE',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
