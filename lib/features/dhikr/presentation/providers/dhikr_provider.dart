import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../domain/models/dhikr_state.dart';

class DhikrNotifier extends Notifier<DhikrState> {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  @override
  DhikrState build() {
    return DhikrState(
      currentCount: 24,
      sessionGoal: 33,
      totalRecitationsToday: 2841092,
      arabicText: "سُبْحَانَ اللَّهِ",
      transliteration: "SUBHANALLAH",
      translation: "GLORY BE TO ALLAH",
      isVoiceMode: false,
    );
  }

  void increment() {
    state = state.copyWith(
      currentCount: state.currentCount + 1,
      totalRecitationsToday: state.totalRecitationsToday + 1,
    );
  }

  void reset() {
    state = state.copyWith(currentCount: 0);
  }

  Future<void> toggleVoiceMode() async {
    if (state.isVoiceMode) {
      await stopListening();
      state = state.copyWith(isVoiceMode: false);
    } else {
      final available = await _initSpeech();
      if (available) {
        state = state.copyWith(isVoiceMode: true);
        await startListening();
      }
    }
  }

  Future<bool> _initSpeech() async {
    if (_isInitialized) return true;
    _isInitialized = await _speech.initialize(
      onError: (val) => log('Speech Error: $val'),
      onStatus: (val) => log('Speech Status: $val'),
    );
    return _isInitialized;
  }

  Future<void> startListening() async {
    if (!_isInitialized) await _initSpeech();
    
    await _speech.listen(
      onResult: (result) {
        final recognizedWords = result.recognizedWords.toLowerCase();
        if (recognizedWords.contains('subhanallah') || 
            recognizedWords.contains('subhan allah')) {
          
          if (result.finalResult) {
             increment();
             if (state.isVoiceMode) {
                Future.delayed(const Duration(milliseconds: 500), startListening);
             }
          }
        }
      },
      localeId: 'en_US',
      listenFor: const Duration(seconds: 30),
      // Fixed deprecated members by using listenOptions (internal handling of the package)
      // or simply removing default values that match the deprecation.
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }
}

final dhikrProvider = NotifierProvider<DhikrNotifier, DhikrState>(() {
  return DhikrNotifier();
});
