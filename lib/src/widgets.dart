import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:double_tap_player_view/src/border_clipper/oval_left_border_clipper.dart';
import 'package:double_tap_player_view/src/border_clipper/oval_right_border_clipper.dart';
import 'package:double_tap_player_view/src/model/double_tap_model.dart';
import 'package:double_tap_player_view/src/double_tap_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/lr.dart';

typedef TapCountWidgetBuilder = Widget Function(Lr lr, int tapCount);

typedef TextBuilder = String Function(Lr lr, int tapCount);

final _kPrvViewModel = StateNotifierProvider.autoDispose
    .family<DoubleTapViewModel, ViewModelConfig>(
        (ref, conf) => DoubleTapViewModel(conf));

final _pDoubleTapEvent = Provider.autoDispose.family<String, ViewModelConfig>(
    (ref, ltr) => ref.watch(_kPrvViewModel(ltr).state).doubleTapEventKey);

class DoubleTapPlayerView extends StatelessWidget {
  DoubleTapPlayerView({
    Key key,
    double ignoreCenterWidth = 128,
    this.iconRight = const Icon(
      Icons.fast_forward,
      color: Colors.white,
      size: 40,
    ),
    this.iconLeft = const Icon(
      Icons.fast_rewind,
      color: Colors.white,
      size: 40,
    ),
    this.curveBank = 40,
    this.ovalColor = Colors.white30,
    this.rippleColor = Colors.white30,
    this.rippleExpansionTime = const Duration(milliseconds: 400),
    this.expansionHoldingTime = const Duration(milliseconds: 200),
    this.fadeTime = const Duration(milliseconds: 100),
    this.customWidgetBuilder,
    this.textBuilder,
    this.textStyle = const TextStyle(color: Colors.white),
    this.child,
    this.onDoubleTap,
  })  : vmConfL = ViewModelConfig(
          lr: Lr.LEFT,
          ignoreRangeFromCenter: ignoreCenterWidth / 2,
        ),
        vmConfR = ViewModelConfig(
          lr: Lr.RIGHT,
          ignoreRangeFromCenter: ignoreCenterWidth / 2,
        ),
        assert(0 <= curveBank),
        super(key: key) {
    if (customWidgetBuilder != null)
      assert(
          iconRight == null &&
              iconLeft == null &&
              textBuilder == null &&
              textStyle == null,
          'if customWidgetBuilder is not null, iconRight, iconLeft, textBuilder and textStyle must be null.');
  }

  final ViewModelConfig vmConfL;
  final ViewModelConfig vmConfR;
  final TapCountWidgetBuilder customWidgetBuilder;
  final Icon iconRight;
  final Icon iconLeft;
  final TextBuilder textBuilder;
  final TextStyle textStyle;
  final Widget child;
  final Duration rippleExpansionTime;
  final Duration expansionHoldingTime;
  final Duration fadeTime;
  final double curveBank;
  final Color ovalColor;
  final Color rippleColor;
  final GestureTapCallback onDoubleTap;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          Row(
            children: [
              _DoubleTapAnimated(
                vmConf: vmConfL,
                builder: customWidgetBuilder,
                rippleExpansionTime: rippleExpansionTime,
                fadeTime: fadeTime,
                expansionHoldingTime: expansionHoldingTime,
                curveBank: curveBank,
                rippleColor: rippleColor,
                ovalColor: ovalColor,
                textBuilder: textBuilder,
                textStyle: textStyle,
                iconLeft: iconLeft,
                iconRight: iconRight,
              ),
              _DoubleTapAnimated(
                vmConf: vmConfR,
                builder: customWidgetBuilder,
                rippleExpansionTime: rippleExpansionTime,
                fadeTime: fadeTime,
                expansionHoldingTime: expansionHoldingTime,
                curveBank: curveBank,
                rippleColor: rippleColor,
                ovalColor: ovalColor,
                textBuilder: textBuilder,
                textStyle: textStyle,
                iconLeft: iconLeft,
                iconRight: iconRight,
              )
            ],
          ),
          LayoutBuilder(
            builder: (context, constrains) => SizedBox.expand(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTapDown: (details) =>
                    _onDoubleTapDown(context, constrains, details),
                onDoubleTap: () => _onDoubleTap(context, constrains),
              ),
            ),
          ),
        ],
      );

  void _onDoubleTapDown(BuildContext context, BoxConstraints constraints,
      TapDownDetails details) {
    final centerX = constraints.maxWidth / 2;
    final vmConf = details.localPosition.dx < centerX ? vmConfL : vmConfR;
    final dx = vmConf == vmConfL
        ? details.localPosition.dx
        : details.localPosition.dx - centerX;
    final dy = details.localPosition.dy;
    context.read(_kPrvViewModel(vmConf)).noteTapPosition(dx, dy);
  }

  void _onDoubleTap(BuildContext context, BoxConstraints constraints) {
    final lastTapTimeL =
        context.read(_kPrvViewModel(vmConfL).state).lastTapTime;
    final lastTapTimeR =
        context.read(_kPrvViewModel(vmConfR).state).lastTapTime;
    final vmConf = lastTapTimeL < lastTapTimeR ? vmConfR : vmConfL;

    context.read(_kPrvViewModel(vmConf)).notifyTap(constraints.maxWidth);
    if (onDoubleTap != null)
      onDoubleTap();
  }
}

class _DoubleTapAnimated extends StatefulHookWidget {
  const _DoubleTapAnimated({
    @required this.vmConf,
    @required this.builder,
    @required this.rippleExpansionTime,
    @required this.expansionHoldingTime,
    @required this.fadeTime,
    @required this.curveBank,
    @required this.ovalColor,
    @required this.rippleColor,
    @required this.iconRight,
    @required this.iconLeft,
    @required this.textBuilder,
    @required this.textStyle,
    Key key,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder builder;
  final Duration rippleExpansionTime;
  final Duration expansionHoldingTime;
  final Duration fadeTime;
  final Icon iconRight;
  final Icon iconLeft;
  final TextBuilder textBuilder;
  final TextStyle textStyle;
  final double curveBank;
  final Color ovalColor;
  final Color rippleColor;

  @override
  _DoubleTapAnimatedState createState() => _DoubleTapAnimatedState();
}

class _DoubleTapAnimatedState extends State<_DoubleTapAnimated>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _fadeController;
  Animation<double> _animation;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.rippleExpansionTime,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: widget.fadeTime,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: ProviderListener(
          onChange: _onChange,
          provider: _pDoubleTapEvent(widget.vmConf),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ClipPath(
              clipper: widget.vmConf.lr == Lr.LEFT
                  ? OvalRightBorderClipper(curveHeight: widget.curveBank)
                  : OvalLeftBorderClipper(curveHeight: widget.curveBank),
              child: Stack(
                children: [
                  CircularRevealAnimation(
                    animation: _animation,
                    centerOffset: useProvider(_kPrvViewModel(widget.vmConf)
                        .state
                        .select((it) => it.lastTap))?.toOffset(),
                    child: SizedBox.expand(
                      child: ColoredBox(
                        color: widget.rippleColor,
                      ),
                    ),
                  ),
                  _IconWithShade(
                    vmConf: widget.vmConf,
                    builder: widget.builder,
                    ovalColor: widget.ovalColor,
                    textBuilder: widget.textBuilder,
                    iconRight: widget.iconRight,
                    iconLeft: widget.iconLeft,
                    textStyle: widget.textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _onChange(BuildContext context, String value) async {
    if (value == null)
      return;

    if (_animationController.status == AnimationStatus.completed)
      _animationController.reset();
    if (_fadeController.status == AnimationStatus.reverse)
      _fadeController.reset();

    try {
      _fadeController.value = 1;
      await _animationController.forward().orCancel;
      await Future.delayed(widget.expansionHoldingTime);
      _animationController.reset();
      await _fadeController.reverse().orCancel;
      _fadeController.reset();
      // ignore: empty_catches
    } on TickerCanceled {}
    context.read(_kPrvViewModel(widget.vmConf)).notifyHideWidget(value);
  }
}

class _IconWithShade extends HookWidget {
  const _IconWithShade({
    Key key,
    @required this.ovalColor,
    @required this.vmConf,
    @required this.builder,
    @required this.iconRight,
    @required this.iconLeft,
    @required this.textBuilder,
    @required this.textStyle,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder builder;
  final Icon iconRight;
  final Icon iconLeft;
  final TextBuilder textBuilder;
  final TextStyle textStyle;
  final Color ovalColor;

  @override
  Widget build(BuildContext context) => Container(
        height: double.infinity,
        width: double.infinity,
        color: ovalColor,
        child: builder == null
            ? _DefaultChild(
                vmConf: vmConf,
                textStyle: textStyle,
                iconLeft: iconLeft,
                iconRight: iconRight,
                textBuilder: textBuilder,
              )
            : _CustomChild(
                vmConf: vmConf,
                builder: builder,
              ),
      );
}

class _CustomChild extends HookWidget {
  const _CustomChild({
    Key key,
    @required this.vmConf,
    @required this.builder,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final continuesTapTime = useProvider(
        _kPrvViewModel(vmConf).state.select((it) => it.continuesTapTime));
    return builder(vmConf.lr, continuesTapTime);
  }
}

class _DefaultChild extends StatelessWidget {
  const _DefaultChild({
    Key key,
    @required this.vmConf,
    @required this.iconRight,
    @required this.iconLeft,
    @required this.textBuilder,
    @required this.textStyle,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final Icon iconRight;
  final Icon iconLeft;
  final TextBuilder textBuilder;
  final TextStyle textStyle;

  static const double _TEXT_H = 24;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: _TEXT_H),
          if (vmConf.lr == Lr.LEFT) iconLeft else iconRight,
          _DefaultChildText(
            vmConf: vmConf,
            textStyle: textStyle,
            textBuilder: textBuilder,
          ),
        ],
      );
}

class _DefaultChildText extends HookWidget {
  const _DefaultChildText({
    Key key,
    @required this.textBuilder,
    @required this.textStyle,
    @required this.vmConf,
  }) : super(key: key);

  final TextBuilder textBuilder;
  final TextStyle textStyle;
  final ViewModelConfig vmConf;

  @override
  Widget build(BuildContext context) {
    final tapCount = useProvider(
        _kPrvViewModel(vmConf).state.select((it) => it.continuesTapTime));
    final text = textBuilder == null
        ? '${tapCount * 10} sec'
        : textBuilder(vmConf.lr, tapCount);
    return Text(
      text,
      style: textStyle,
    );
  }
}
