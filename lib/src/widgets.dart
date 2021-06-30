import 'package:double_tap_player_view/src/model/double_tap_config.dart';
import 'package:double_tap_player_view/src/ui/double_tap_animated.dart';
import 'package:double_tap_player_view/src/model/swipe_config.dart';
import 'package:double_tap_player_view/src/ui/horizontal_drag_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/lr.dart';
import 'model/swipe_data.dart';

/// Signature of callback that have horizontal tap position
typedef OnDragStartCallback = void Function(double dx);

/// Signature of callback that have [SwipeData]
typedef OnDragCallback = void Function(SwipeData? data);

/// Signature of widget creation from tap count and L/R
typedef TapCountWidgetBuilder = Widget Function(Lr lr, int tapCount);

/// Signature of string creation from tap count and L/R
typedef TextBuilder = String Function(Lr lr, int tapCount);

/// Signature of widget creation from [SwipeData]
typedef SwipeOverlayBuilder = Widget Function(SwipeData data);

/// Signature of callback that have [lr]
typedef DoubleTapCallback = void Function(Lr lr);

/// widget to detect double tap and horizontal drag.
/// this widget is usual to handle fast forward/rewind behavior like a video player.
class DoubleTapPlayerView extends StatelessWidget {
  DoubleTapPlayerView({
    Key? key,
    this.doubleTapConfig,
    this.child,
    this.swipeConfig,
  })  : enabledDoubleTap = doubleTapConfig != null,
        enabledSwipe = swipeConfig != null;

  final DoubleTapConfig? doubleTapConfig;
  final SwipeConfig? swipeConfig;
  final Widget? child;

  final bool enabledDoubleTap;
  final bool enabledSwipe;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          LayoutBuilder(
            builder: (context, constrains) => SizedBox.expand(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTapDown: enabledDoubleTap
                    ? (details) => _onDoubleTapDown(
                        context, constrains, doubleTapConfig!, details)
                    : null,
                onDoubleTap: enabledDoubleTap
                    ? () => _onDoubleTap(context, constrains, doubleTapConfig!)
                    : null,
                onHorizontalDragStart: enabledSwipe
                    ? (details) => _onDragStart(context, details, swipeConfig!)
                    : null,
                onHorizontalDragUpdate: enabledSwipe
                    ? (details) => _onDragUpdate(context, details, swipeConfig!)
                    : null,
                onHorizontalDragCancel: enabledSwipe
                    ? () => _onDragCancel(context, swipeConfig!)
                    : null,
                onHorizontalDragEnd: enabledSwipe
                    ? (details) => _onDragEnd(context, details, swipeConfig!)
                    : null,
                child: Stack(
                  children: [
                    if (enabledDoubleTap)
                      DoubleTapWidget(
                        config: doubleTapConfig!,
                        enabledDrag: enabledSwipe,
                      ),
                    if (enabledSwipe)
                      DragOverlayWrapper(
                        backDrop: swipeConfig!.backDrop,
                        overlayBuilder: swipeConfig!.overlayBuilder,
                        confPair: doubleTapConfig?.confPair,
                      )
                  ],
                ),
              ),
            ),
          ),
        ].whereNonNull(),
      );

  static void _onDoubleTapDown(BuildContext context, BoxConstraints constraints,
      DoubleTapConfig doubleTapConfig, TapDownDetails details) {
    final centerX = constraints.maxWidth / 2;
    final vmConf = details.localPosition.dx < centerX
        ? doubleTapConfig.vmConfL
        : doubleTapConfig.vmConfR;
    final dx = vmConf == doubleTapConfig.vmConfL
        ? details.localPosition.dx
        : details.localPosition.dx - centerX;
    final dy = details.localPosition.dy;
    context.read(kPrvDoubleTapVm(vmConf)).noteTapPosition(dx, dy);
  }

  void _onDoubleTap(BuildContext context, BoxConstraints constraints,
      DoubleTapConfig doubleTapConfig) {
    final lastTapTimeL =
        context.read(kPrvDoubleTapVm(doubleTapConfig.vmConfL)).lastTapTime;
    final lastTapTimeR =
        context.read(kPrvDoubleTapVm(doubleTapConfig.vmConfR)).lastTapTime;
    final vmConf = lastTapTimeL < lastTapTimeR
        ? doubleTapConfig.vmConfR
        : doubleTapConfig.vmConfL;
    final lr = lastTapTimeL < lastTapTimeR ? Lr.RIGHT : Lr.LEFT;

    context
        .read(kPrvDoubleTapVm(vmConf).notifier)
        .notifyTap(constraints.maxWidth);
    doubleTapConfig.onDoubleTap?.call(lr);
  }

  static void _onDragStart(
      BuildContext context, DragStartDetails details, SwipeConfig conf) {
    final dx = details.globalPosition.dx;
    context.read(kPrvDragVm.notifier).setStart(dx);
    conf.onDragStart?.call(dx);
  }

  static void _onDragUpdate(
      BuildContext context, DragUpdateDetails details, SwipeConfig conf) {
    context.read(kPrvDragVm.notifier).update(details.globalPosition.dx);
    conf.onDragUpdate?.call(context.read(kPrvDragVm).data);
  }

  static void _onDragCancel(BuildContext context, SwipeConfig swipeConfig) {
    context.read(kPrvDragVm.notifier).clear();
    swipeConfig.onDragCancel?.call();
  }

  static void _onDragEnd(
      BuildContext context, DragEndDetails details, SwipeConfig swipeConfig) {
    final data = context.read(kPrvDragVm).data?.copyWith();
    context.read(kPrvDragVm.notifier).clear();
    swipeConfig.onDragEnd?.call(data);
  }
}

extension IterableX<E> on Iterable<E?> {
  List<E> whereNonNull() => where((it) => it != null).cast<E>().toList();
}
