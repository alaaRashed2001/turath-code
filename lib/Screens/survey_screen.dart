import 'dart:convert';
import 'package:echocode/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final Map<String, String> answers = {};
  final TextEditingController suggestionController = TextEditingController();
  bool submitted = false;

  List<String> get options => [
    AppLocalizations.of(context)!.excellent,
    AppLocalizations.of(context)!.good,
    AppLocalizations.of(context)!.acceptable,
    AppLocalizations.of(context)!.weak,
  ];

  List<String> get questions => [
    AppLocalizations.of(context)!.question1,
    AppLocalizations.of(context)!.question2,
    AppLocalizations.of(context)!.question3,
    AppLocalizations.of(context)!.question4,
    AppLocalizations.of(context)!.question5,
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedSurvey();
  }

  Future<void> _loadSavedSurvey() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('survey_data');

    if (savedData != null) {
      final Map<String, dynamic> data = jsonDecode(savedData);
      setState(() {
        submitted = true;
        for (final entry in data.entries) {
          if (entry.key == 'suggestion') {
            suggestionController.text = entry.value;
          } else {
            answers[entry.key] = entry.value;
          }
        }
      });
    }
  }

  Future<void> _submitSurvey() async {
    if (answers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.snackbarIncomplete)),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final dataToSave = Map<String, String>.from(answers);
    dataToSave['suggestion'] = suggestionController.text;
    await prefs.setString('survey_data', jsonEncode(dataToSave));

    setState(() {
      submitted = true;
    });
  }

  Future<void> _resetSurvey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('survey_data');
    setState(() {
      answers.clear();
      suggestionController.clear();
      submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.surveyTitle),
        actions: [
          if (!submitted)
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: AppLocalizations.of(context)!.prevSurvey,
              onPressed: _loadSavedSurvey,
            )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                Assets.youtubeVideo2,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: submitted
                  ? _buildThankYouMessage(isDark)
                  : _buildSurveyForm(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyForm(bool isDark) {
    return ListView(
      key: const ValueKey("form"),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          AppLocalizations.of(context)!.surveyIntro,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.amber : const Color(0xff6B8BCA),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ...questions.map(_buildQuestionBlock),
        const SizedBox(height: 16),
        _buildSuggestionBox(isDark),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _submitSurvey,
          icon: const Icon(Icons.send),
          label: Text(AppLocalizations.of(context)!.sendEvaluation),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.amber : const Color(0xffFAA72A),
            foregroundColor: isDark ? Colors.black : Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionBlock(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('📌 $question', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Wrap(
            spacing: 8,
            children: options.map((option) {
              return ChoiceChip(
                label: Text(option,
                  style: TextStyle(color: Colors.orange.shade800),
                ),
                selectedColor: const Color(0xff6B8BCA),
                labelStyle: TextStyle(
                  color: answers[question] == option ? Colors.white : Colors.black,
                ),
                selected: answers[question] == option,
                onSelected: (_) {
                  setState(() {
                    answers[question] = option;
                  });
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSuggestionBox(bool isDark) {
    return TextField(
      controller: suggestionController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.suggestionLabel,
        filled: true,
        fillColor: isDark ? Colors.grey[800] : Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildThankYouMessage(bool isDark) {
    return Center(
      key: const ValueKey("thankyou"),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: isDark ? Colors.grey[850] : Colors.white.withOpacity(0.95),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.celebration, color: Colors.green, size: 80),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.thankYou,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                ...answers.entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('✅ ${e.key}\n🔹 ${e.value}', textAlign: TextAlign.center),
                )),
                const SizedBox(height: 12),
                if (suggestionController.text.isNotEmpty)
                  Text(
                    AppLocalizations.of(context)!.yourSuggestion(suggestionController.text),

                    textAlign: TextAlign.center,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _resetSurvey,
                  icon: const Icon(Icons.restart_alt),
                  label: Text(AppLocalizations.of(context)!.resubmit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6B8BCA),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
