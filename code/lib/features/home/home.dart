import 'package:calculator/logic/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String? _pressedButton;
  late AnimationController _scaleController;
  late AnimationController _rippleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scaleController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _animateButton(String value) {
    setState(() {
      _pressedButton = value;
    });

    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    _rippleController.forward().then((_) {
      _rippleController.reset();
      if (mounted) {
        setState(() {
          _pressedButton = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'C',
      'DEL',
      '%',
      '/',
      '7',
      '8',
      '9',
      '*',
      '4',
      '5',
      '6',
      '-',
      '1',
      '2',
      '3',
      '+',
      '0',
      '.',
      '=',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: KeyboardListener(
          focusNode: FocusNode()..requestFocus(),
          autofocus: true,
          onKeyEvent: (KeyEvent event) {
            if (event is KeyDownEvent) {
              _handleKeyPress(context, event);
            }
          },
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Calculator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Display area
              Container(
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFF2d2d2d),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF404040), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    // Auto-scroll to bottom when expression changes
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.jumpTo(
                          _scrollController.position.maxScrollExtent,
                        );
                      }
                    });
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: (constraints.maxHeight / 2) - 8,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Text(
                                  state.expression.isEmpty
                                      ? '0'
                                      : state.expression,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                  textAlign: TextAlign.end,
                                  softWrap: true, // Enable text wrapping
                                  overflow: TextOverflow
                                      .visible, // Allow overflow for scrolling
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: (constraints.maxHeight / 2) - 8,
                              child: Text(
                                state.result,
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Button grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                      final value = buttons[index];
                      final isZero = value == '0';

                      return GridTile(
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            _scaleAnimation,
                            _rippleAnimation,
                          ]),
                          builder: (context, child) {
                            final isPressed = _pressedButton == value;
                            final scale = isPressed
                                ? _scaleAnimation.value
                                : 1.0;

                            return Transform.scale(
                              scale: scale,
                              child: GestureDetector(
                                onTapDown: (_) {
                                  HapticFeedback.lightImpact();
                                  _animateButton(value);
                                },
                                onTap: () {
                                  _handleButtonPress(value);
                                },
                                child: Stack(
                                  children: [
                                    // Main button
                                    Container(
                                      decoration: BoxDecoration(
                                        color: _getButtonColor(value),
                                        borderRadius: BorderRadius.circular(
                                          isZero ? 32 : 24,
                                        ),
                                        border: _getBorder(value),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _getShadowColor(value),
                                            blurRadius: isPressed ? 8 : 12,
                                            offset: Offset(
                                              0,
                                              isPressed ? 2 : 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: _getFontSize(value),
                                            fontWeight: FontWeight.w600,
                                            color: _getTextColor(value),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Ripple effect
                                    if (isPressed)
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            isZero ? 32 : 24,
                                          ),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    isZero ? 32 : 24,
                                                  ),
                                              gradient: RadialGradient(
                                                center: Alignment.center,
                                                radius:
                                                    _rippleAnimation.value *
                                                    1.5,
                                                colors: [
                                                  Colors.white.withValues(
                                                    alpha:
                                                        0.3 *
                                                        (1 -
                                                            _rippleAnimation
                                                                .value),
                                                  ),
                                                  Colors.white.withValues(
                                                    alpha:
                                                        0.1 *
                                                        (1 -
                                                            _rippleAnimation
                                                                .value),
                                                  ),
                                                  Colors.transparent,
                                                ],
                                                stops: const [0.0, 0.7, 1.0],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    // Glow effect for special buttons
                                    if (isPressed &&
                                        ['=', 'C', '%'].contains(value))
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              isZero ? 32 : 24,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: _getButtonColor(
                                                  value,
                                                ).withValues(alpha: 0.6),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(String value) {
    if (value == 'C') {
      context.read<CalculatorBloc>().add(Clear());
    } else if (value == 'DEL') {
      context.read<CalculatorBloc>().add(Delete());
    } else if (value == '=') {
      context.read<CalculatorBloc>().add(Calculate());
    } else {
      context.read<CalculatorBloc>().add(AddInput(value));
    }
  }

  void _handleKeyPress(BuildContext context, KeyEvent event) {
    final key = event.logicalKey;
    String? buttonValue;

    // Number keys (regular and numpad)
    if (key == LogicalKeyboardKey.digit0 || key == LogicalKeyboardKey.numpad0) {
      buttonValue = '0';
    } else if (key == LogicalKeyboardKey.digit1 ||
        key == LogicalKeyboardKey.numpad1) {
      buttonValue = '1';
    } else if (key == LogicalKeyboardKey.digit2 ||
        key == LogicalKeyboardKey.numpad2) {
      buttonValue = '2';
    } else if (key == LogicalKeyboardKey.digit3 ||
        key == LogicalKeyboardKey.numpad3) {
      buttonValue = '3';
    } else if (key == LogicalKeyboardKey.digit4 ||
        key == LogicalKeyboardKey.numpad4) {
      buttonValue = '4';
    } else if (key == LogicalKeyboardKey.digit5 ||
        key == LogicalKeyboardKey.numpad5) {
      buttonValue = '5';
    } else if (key == LogicalKeyboardKey.digit6 ||
        key == LogicalKeyboardKey.numpad6) {
      buttonValue = '6';
    } else if (key == LogicalKeyboardKey.digit7 ||
        key == LogicalKeyboardKey.numpad7) {
      buttonValue = '7';
    } else if (key == LogicalKeyboardKey.digit8 ||
        key == LogicalKeyboardKey.numpad8) {
      buttonValue = '8';
    } else if (key == LogicalKeyboardKey.digit9 ||
        key == LogicalKeyboardKey.numpad9) {
      buttonValue = '9';
    } else if (key == LogicalKeyboardKey.period ||
        key == LogicalKeyboardKey.numpadDecimal) {
      buttonValue = '.';
    } else if (key == LogicalKeyboardKey.add ||
        key == LogicalKeyboardKey.numpadAdd) {
      buttonValue = '+';
    } else if (key == LogicalKeyboardKey.minus ||
        key == LogicalKeyboardKey.numpadSubtract) {
      buttonValue = '-';
    } else if (key == LogicalKeyboardKey.asterisk ||
        key == LogicalKeyboardKey.numpadMultiply) {
      buttonValue = '*';
    } else if (key == LogicalKeyboardKey.slash ||
        key == LogicalKeyboardKey.numpadDivide) {
      buttonValue = '/';
    } else if (key == LogicalKeyboardKey.percent) {
      buttonValue = '%';
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      buttonValue = '=';
    } else if (key == LogicalKeyboardKey.backspace) {
      buttonValue = 'DEL';
    } else if (key == LogicalKeyboardKey.escape) {
      buttonValue = 'C';
    }

    if (buttonValue != null) {
      _animateButton(buttonValue);
      _handleButtonPress(buttonValue);
    }
  }

  Color _getButtonColor(String value) {
    if (value == 'C') {
      return const Color(0xFFE74C3C);
    } else if (value == 'DEL') {
      return const Color(0xFF95A5A6);
    } else if (['/', '*', '-', '+'].contains(value)) {
      return const Color(0xFF6C5CE7);
    } else if (value == '=') {
      return const Color(0xFF00B894);
    } else if (value == '%') {
      return const Color(0xFFE17055);
    } else {
      return const Color(0xFF3d3d3d);
    }
  }

  Color _getTextColor(String value) {
    if (['C', 'DEL', '/', '*', '-', '+', '=', '%'].contains(value)) {
      return Colors.white;
    } else {
      return const Color(0xFFE8E8E8);
    }
  }

  Color _getShadowColor(String value) {
    if (value == 'C') {
      return const Color(0xFFE74C3C).withValues(alpha: 0.3);
    } else if (['/', '*', '-', '+'].contains(value)) {
      return const Color(0xFF6C5CE7).withValues(alpha: 0.3);
    } else if (value == '=') {
      return const Color(0xFF00B894).withValues(alpha: 0.3);
    } else if (value == '%') {
      return const Color(0xFFE17055).withValues(alpha: 0.3);
    } else {
      return Colors.black.withValues(alpha: 0.2);
    }
  }

  Border? _getBorder(String value) {
    if (['C', 'DEL', '/', '*', '-', '+', '=', '%'].contains(value)) {
      return null;
    }
    return Border.all(color: const Color(0xFF505050), width: 1);
  }

  double _getFontSize(String value) {
    if (value == 'DEL') {
      return 16;
    }
    return 24;
  }
}
