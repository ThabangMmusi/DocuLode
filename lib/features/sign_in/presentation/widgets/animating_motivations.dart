import 'package:flutter/material.dart';
import 'package:doculode/app/config/index.dart';

import 'dart:async';

class AnimatingMotivations extends StatefulWidget {
  const AnimatingMotivations({super.key});

  @override
  State<AnimatingMotivations> createState() => _AnimatingMotivationsState();
}

class _AnimatingMotivationsState extends State<AnimatingMotivations> {
  AnimationPhase _currentPhase = AnimationPhase.typingTodos;
  Timer? _animationTimer;
  Timer? _typingTimer;

  // --- Content Data ---
  final List<String> _initialTodoTexts = [
    "Review Chapter 3 notes",
    "Start history essay outline",
    "Practice 5 math problems",
    "Plan weekly study schedule",
  ];
  List<TodoItem> _todos = [];

  final List<MotivationalQuote> _quotes = [
    MotivationalQuote(
        quote:
            "The beautiful thing about learning is that no one can take it away from you.",
        author: "B.B. King"),
    MotivationalQuote(
        quote:
            "Education is the most powerful weapon which you can use to change the world.",
        author: "Nelson Mandela"),
    MotivationalQuote(
        quote: "The only way to do great work is to love what you do.",
        author: "Steve Jobs"),
    MotivationalQuote(
        quote:
            "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        author: "Winston Churchill"),
    MotivationalQuote(
        quote: "Believe you can and you're halfway there.",
        author: "Theodore Roosevelt"),
  ];

  int _currentTodoIndex = 0;
  int _currentQuoteIndex = 0;

  String _displayedText = ""; // For typing effect
  int _charIndex = 0;

  // Animation Durations
  final Duration _typingCharDelay = const Duration(milliseconds: 60);
  final Duration _interItemDelay =
      const Duration(milliseconds: 800); // Delay between typing/checking items
  final Duration _interPhaseDelay =
      const Duration(seconds: 3); // Delay between phases
  final Duration _quoteDisplayTime =
      const Duration(seconds: 5); // How long a full quote stays

  @override
  void initState() {
    super.initState();
    _resetAndStartAnimation();
  }

  void _resetAndStartAnimation() {
    _currentPhase = AnimationPhase.typingTodos;
    _todos = _initialTodoTexts.map((text) => TodoItem(text: text)).toList();
    _currentTodoIndex = 0;
    _currentQuoteIndex = 0;
    _startTypingNextTodo();
  }

  void _startTypingNextTodo() {
    if (!mounted) return;
    if (_currentTodoIndex < _todos.length) {
      _charIndex = 0;
      _displayedText = "";
      setState(() {}); // To clear previous item's full text if any

      _typingTimer?.cancel();
      _typingTimer = Timer.periodic(_typingCharDelay, (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_charIndex < _todos[_currentTodoIndex].text.length) {
          setState(() {
            _displayedText += _todos[_currentTodoIndex].text[_charIndex];
            _charIndex++;
          });
        } else {
          timer.cancel();
          _currentTodoIndex++;
          _animationTimer = Timer(_interItemDelay, _startTypingNextTodo);
        }
      });
    } else {
      // All todos typed, move to checking phase
      _animationTimer = Timer(_interPhaseDelay, () {
        if (!mounted) return;
        setState(() {
          _currentPhase = AnimationPhase.checkingTodos;
          _currentTodoIndex = 0; // Reset for checking
        });
        _startCheckingNextTodo();
      });
    }
  }

  void _startCheckingNextTodo() {
    if (!mounted) return;
    if (_currentTodoIndex < _todos.length) {
      _animationTimer = Timer(_interItemDelay, () {
        if (!mounted) return;
        setState(() {
          _todos[_currentTodoIndex].isDone = true;
        });
        _currentTodoIndex++;
        _startCheckingNextTodo(); // Check next item
      });
    } else {
      // All todos checked, move to quote phase
      _animationTimer = Timer(_interPhaseDelay, () {
        if (!mounted) return;
        setState(() {
          _currentPhase = AnimationPhase.showingQuote;
          // currentTodoIndex already at end, so don't need to reset for quote index
        });
        _showNextQuote();
      });
    }
  }

  void _showNextQuote() {
    if (!mounted) return;
    _charIndex = 0;
    final currentQuote = _quotes[_currentQuoteIndex];
    _displayedText = ""; // Clear for typing quote
    setState(() {});

    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(_typingCharDelay, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      String fullText = "\"${currentQuote.quote}\" - ${currentQuote.author}";
      if (_charIndex < fullText.length) {
        setState(() {
          _displayedText += fullText[_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
        _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
        _animationTimer = Timer(_quoteDisplayTime, () {
          if (_currentQuoteIndex == 0) {
            // Cycled through all quotes
            _resetAndStartAnimation(); // Loop back to todos
          } else {
            _showNextQuote(); // Show next quote
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _typingTimer?.cancel();
    super.dispose();
  }

  Widget _buildTodoView(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    for (int i = 0; i < _todos.length; i++) {
      children.add(
        Container(
          margin: EdgeInsets.only(bottom: Insets.sm),
          decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: Corners.medBorder),
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              AnimatedSwitcher(
                // Animate checkbox appearance/change
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Checkbox(
                  key: ValueKey(
                      _todos[i].isDone), // Key to force rebuild on change
                  value: _todos[i].isDone,
                  onChanged: null, // Non-interactive
                  activeColor: theme.primaryColor.withOpacity(0.7),
                  checkColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  // Show currently typing text, or full text for others
                  (_currentPhase == AnimationPhase.typingTodos &&
                          i == _currentTodoIndex)
                      ? _displayedText
                      : _todos[i].text,
                  style: TextStyle(
                    fontSize: 15,
                    color: _todos[i].isDone
                        ? Colors.grey.shade500
                        : Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black87,
                    decoration:
                        _todos[i].isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Have A Todo List✅",
            style: theme.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onPrimary)),
        VSpace.lg,
        VSpace.lg,
        VSpace.lg,
        VSpace.lg,
        Transform.rotate(
          angle: _currentPhase == AnimationPhase.typingTodos ? 0.05 : -0.05,
          child: Container(
            padding: EdgeInsets.all(Insets.med),
            decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: Corners.medBorder),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentPhase == AnimationPhase.typingTodos
                      ? "Your Study Goals..."
                      : "Progress Update!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 15),
                ...children,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteView() {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Words of Wisdom🧠",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onPrimary)),
        VSpace.lg,
        VSpace.lg,
        Stack(
          children: [
            Transform.rotate(
              angle: _currentTodoIndex.isEven ? -0.05 : 0.05,
              child: Container(
                height: double.infinity,
                constraints:
                    const BoxConstraints(maxWidth: 250, maxHeight: 300),
                padding: EdgeInsets.all(Insets.med),
                decoration: BoxDecoration(
                    color: theme.colorScheme.inversePrimary,
                    borderRadius: Corners.medBorder),
              ),
            ),
            Transform.rotate(
              angle: _currentTodoIndex.isEven ? 0.05 : -0.05,
              child: Container(
                height: double.infinity,
                constraints:
                    const BoxConstraints(maxWidth: 250, maxHeight: 300),
                padding: EdgeInsets.all(Insets.med),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: Corners.medBorder),
                child: Center(
                  child: Text(
                    _displayedText, // Shows the typing quote and author
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      // color: Theme.of(context).colorScheme.onPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_currentPhase) {
      case AnimationPhase.typingTodos:
      case AnimationPhase.checkingTodos:
        content = _buildTodoView(context);
        break;
      case AnimationPhase.showingQuote:
        content = _buildQuoteView();
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(
                    0.0,
                    child.key == ValueKey(_currentPhase)
                        ? 0.05
                        : -0.05), // Adjust for smoother transition
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ));
      },
      child: Container(
        // Ensure the AnimatedSwitcher has a consistent key for its child
        key: ValueKey(_currentPhase),
        padding: const EdgeInsets.all(20.0),
        child: content,
      ),
    );
  }
}

class TodoItem {
  String text;
  bool isDone;

  TodoItem({required this.text, this.isDone = false});
}

class MotivationalQuote {
  final String quote;
  final String author;

  MotivationalQuote({required this.quote, required this.author});
}

enum AnimationPhase { typingTodos, checkingTodos, showingQuote }
