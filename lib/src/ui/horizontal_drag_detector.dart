import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:double_tap_player_view/src/model/conf_pair.dart';
import 'package:double_tap_player_view/src/model/swipe_model.dart';
import 'package:double_tap_player_view/src/ui/double_tap_animated.dart';
import 'package:double_tap_player_view/src/viewmodel/swipe_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final kPrvDragVm = StateNotifierProvider<SwipeViewModel, SwipeModel>(
    (ref) => SwipeViewModel());

final AutoDisposeProvider<bool> kPrvIsDragging =
    Provider.autoDispose<bool>((ref) => ref.watch(kPrvDragVm).isDragging);

class DragOverlayWrapper extends HookConsumerWidget {
  const DragOverlayWrapper({
    required this.overlayBuilder,
    required this.backDrop,
    required this.confPair,
    Key? key,
  }) : super(key: key);

  final ConfPair? confPair;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Visibility(
        visible: confPair == null
            ? true
            : !ref.watch(kPrvDoubleTapVis(confPair!)), //todo fix
        child: DragOverlay(
          overlayBuilder: overlayBuilder,
          backDrop: backDrop,
        ),
      );

  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;
}

class DragOverlay extends StatefulHookConsumerWidget {
  const DragOverlay({
    required this.overlayBuilder,
    required this.backDrop,
    Key? key,
  }) : super(key: key);

  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;

  @override
  DragOverlayState createState() => DragOverlayState();
}

class DragOverlayState extends ConsumerState<DragOverlay>
    with SingleTickerProviderStateMixin {
  static const _DURATION_R = Duration(milliseconds: 200);
  late AnimationController _ac;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: Duration.zero,
      reverseDuration: _DURATION_R,
    );
    _animation = CurvedAnimation(
      parent: _ac,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(
        kPrvIsDragging, (previous, next) => _onChange(context, next));
    return FadeTransition(
      opacity: _animation,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: widget.backDrop,
        child: _DragOverlayContentWrapper(
          overlayBuilder: widget.overlayBuilder,
        ),
      ),
    );
  }

  void _onChange(BuildContext context, bool isDragging) {
    if (isDragging) {
      if (_ac.status == AnimationStatus.completed ||
          _ac.status == AnimationStatus.reverse) _ac.reset();
      _ac.forward();
    } else
      _ac.reverse();
  }
}

class _DragOverlayContentWrapper extends HookConsumerWidget {
  const _DragOverlayContentWrapper({required this.overlayBuilder});

  final SwipeOverlayBuilder overlayBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Visibility(
        visible: ref.watch(kPrvIsDragging),
        child: _OverlayWidget(
          overlayBuilder: overlayBuilder,
        ),
      );
}

class _OverlayWidget extends HookConsumerWidget {
  const _OverlayWidget({
    required this.overlayBuilder,
    Key? key,
  }) : super(key: key);

  final SwipeOverlayBuilder overlayBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(kPrvDragVm.select((it) => it.data!));
    return overlayBuilder(data); //todo fix
  }
}
