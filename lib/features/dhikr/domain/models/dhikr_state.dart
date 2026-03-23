class DhikrState {
  final int currentCount;
  final int sessionGoal;
  final int totalRecitationsToday;
  final String arabicText;
  final String transliteration;
  final String translation;
  final bool isVoiceMode; // New state field

  DhikrState({
    required this.currentCount,
    required this.sessionGoal,
    required this.totalRecitationsToday,
    required this.arabicText,
    required this.transliteration,
    required this.translation,
    this.isVoiceMode = false,
  });

  double get completionPercentage {
    if (sessionGoal == 0) return 0;
    final percentage = (currentCount / sessionGoal) * 100;
    return percentage > 100 ? 100 : percentage;
  }

  DhikrState copyWith({
    int? currentCount,
    int? sessionGoal,
    int? totalRecitationsToday,
    String? arabicText,
    String? transliteration,
    String? translation,
    bool? isVoiceMode,
  }) {
    return DhikrState(
      currentCount: currentCount ?? this.currentCount,
      sessionGoal: sessionGoal ?? this.sessionGoal,
      totalRecitationsToday:
          totalRecitationsToday ?? this.totalRecitationsToday,
      arabicText: arabicText ?? this.arabicText,
      transliteration: transliteration ?? this.transliteration,
      translation: translation ?? this.translation,
      isVoiceMode: isVoiceMode ?? this.isVoiceMode,
    );
  }
}
