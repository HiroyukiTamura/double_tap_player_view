import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:double_tap_player_view/src/border_clipper/oval_left_border_clipper.dart';
import 'package:double_tap_player_view/src/border_clipper/oval_right_border_clipper.dart';
import 'package:double_tap_player_view/src/model/conf_pair.dart';
import 'package:double_tap_player_view/src/model/double_tap_model.dart';
import 'package:double_tap_player_view/src/ui/horizontal_drag_detector.dart';
import 'package:double_tap_player_view/src/viewmodel/double_tap_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../double_tap_player_view.dart';

final kPrvDoubleTapVm = StateNotifierProvider.autoDispose
    .family<DoubleTapViewModel, DoubleTapState, ViewModelConfig>(
        (ref, conf) => DoubleTapViewModel(conf));

final _pDoubleTapEvent = Provider.autoDispose.family<String, ViewModelConfig>(
    (ref, ltr) => ref.watch(kPrvDoubleTapVm(ltr)).doubleTapEventKey);

final kPrvDoubleTapVis = Provider.autoDispose.family<bool, ConfPair>(
    (ref, confPair) =>
        ref.watch(kPrvDoubleTapVm(confPair.vmConfL)).continuesTapTime != 0 ||
        ref.watch(kPrvDoubleTapVm(confPair.vmConfR)).continuesTapTime != 0);

class DoubleTapWidget extends HookConsumerWidget {
  const DoubleTapWidget({
    Key? key,
    required this.config,
    required this.enabledDrag,
  }) : super(key: key);

  final DoubleTapConfig config;
  final bool enabledDrag;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Visibility(
        visible: ref.watch(kPrvDragVm.select((it) => !it.isDragging)),
        child: Stack(
          children: [
            _BackDrop(config: config),
            Row(
              children: [
                _DoubleTapAnimated(
                  vmConf: config.vmConfL,
                  builder: config.customWidgetBuilder,
                  rippleExpansionTime: config.rippleExpansionTime,
                  fadeTime: config.fadeTime,
                  expansionHoldingTime: config.expansionHoldingTime,
                  curveBank: config.curveBank,
                  rippleColor: config.rippleColor,
                  ovalColor: config.ovalColor,
                  labelBuilder: config.labelBuilder,
                  labelStyle: config.labelStyle,
                  icon: config.iconLeft,
                ),
                _DoubleTapAnimated(
                  vmConf: config.vmConfR,
                  builder: config.customWidgetBuilder,
                  rippleExpansionTime: config.rippleExpansionTime,
                  fadeTime: config.fadeTime,
                  expansionHoldingTime: config.expansionHoldingTime,
                  curveBank: config.curveBank,
                  rippleColor: config.rippleColor,
                  ovalColor: config.ovalColor,
                  labelBuilder: config.labelBuilder,
                  labelStyle: config.labelStyle,
                  icon: config.iconRight,
                )
              ],
            )
          ],
        ),
      );
}

class _BackDrop extends HookConsumerWidget {
  const _BackDrop({
    required this.config,
  });

  final DoubleTapConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AnimatedOpacity(
        duration: config.backDropAnimDuration,
        opacity: ref.watch(kPrvDoubleTapVis(config.confPair)) ? 1 : 0,
        child: SizedBox.expand(
          child: ColoredBox(
            color: config.backDrop,
          ),
        ),
      );
}

class _DoubleTapAnimated extends StatefulHookConsumerWidget {
  const _DoubleTapAnimated({
    required this.vmConf,
    required this.builder,
    required this.rippleExpansionTime,
    required this.expansionHoldingTime,
    required this.fadeTime,
    required this.curveBank,
    required this.ovalColor,
    required this.rippleColor,
    required this.icon,
    required this.labelBuilder,
    required this.labelStyle,
    Key? key,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder? builder;
  final Duration rippleExpansionTime;
  final Duration expansionHoldingTime;
  final Duration fadeTime;
  final Widget icon;
  final TextBuilder? labelBuilder;
  final TextStyle labelStyle;
  final double curveBank;
  final Color ovalColor;
  final Color rippleColor;

  @override
  _DoubleTapAnimatedState createState() => _DoubleTapAnimatedState();
}

class _DoubleTapAnimatedState extends ConsumerState<_DoubleTapAnimated>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;

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
    _animationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(_pDoubleTapEvent(widget.vmConf), (previous, next) => _onChange(context, next));
    return Expanded(
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
                  centerOffset: ref.watch(kPrvDoubleTapVm(widget.vmConf)
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
                  textBuilder: widget.labelBuilder,
                  icon: widget.icon,
                  textStyle: widget.labelStyle,
                ),
              ],
            ),
          ),
        ),
      );
  }

  Future<void> _onChange(BuildContext context, String value) async {
    if (value == DoubleTapState.INITIAL_KEY) return;

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
    ref.read(kPrvDoubleTapVm(widget.vmConf).notifier)
        .notifyHideWidget(value);
  }
}

class _IconWithShade extends HookWidget {
  const _IconWithShade({
    Key? key,
    required this.ovalColor,
    required this.vmConf,
    required this.builder,
    required this.icon,
    required this.textBuilder,
    required this.textStyle,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder? builder;
  final Widget icon;
  final TextBuilder? textBuilder;
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
                icon: icon,
                textBuilder: textBuilder,
              )
            : _CustomChild(
                vmConf: vmConf,
                builder: builder!, //todo fix
              ),
      );
}

class _CustomChild extends HookConsumerWidget {
  const _CustomChild({
    Key? key,
    required this.vmConf,
    required this.builder,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final TapCountWidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continuesTapTime = ref.watch(kPrvDoubleTapVm(vmConf).select((it) => it.continuesTapTime));
    return builder(vmConf.lr, continuesTapTime);
  }
}

class _DefaultChild extends StatelessWidget {
  const _DefaultChild({
    Key? key,
    required this.vmConf,
    required this.icon,
    required this.textBuilder,
    required this.textStyle,
  }) : super(key: key);

  final ViewModelConfig vmConf;
  final Widget icon;
  final TextBuilder? textBuilder;
  final TextStyle textStyle;

  static const double _TEXT_H = 24;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: _TEXT_H),
          icon,
          _DefaultChildText(
            vmConf: vmConf,
            textStyle: textStyle,
            textBuilder: textBuilder,
          ),
        ],
      );
}

class _DefaultChildText extends HookConsumerWidget {
  const _DefaultChildText({
    Key? key,
    required this.textBuilder,
    required this.textStyle,
    required this.vmConf,
  }) : super(key: key);

  final TextBuilder? textBuilder;
  final TextStyle textStyle;
  final ViewModelConfig vmConf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tapCount = ref.watch(
        kPrvDoubleTapVm(vmConf).select((it) => it.continuesTapTime));
    final text =
        textBuilder?.call(vmConf.lr, tapCount) ?? '${tapCount * 10} sec';
    return Text(
      text,
      style: textStyle,
    );
  }
}
