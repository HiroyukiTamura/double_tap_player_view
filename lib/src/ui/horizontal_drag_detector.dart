import 'package:double_tap_player_view/src/model/double_tap_model.dart';
import 'package:double_tap_player_view/src/viewmodel/swipe_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../double_tap_player_view.dart';
import 'double_tap_animated.dart';

final kPrvDragVm =
    StateNotifierProvider<SwipeViewModel>((ref) => SwipeViewModel());

final kPrvIsDragging =
    Provider.autoDispose<bool>((ref) => ref.watch(kPrvDragVm.state).isDragging);

class _ConfPair {
  final ViewModelConfig vmConfR;
  final ViewModelConfig vmConfL;

  _ConfPair(this.vmConfR, this.vmConfL);
}

final _kPrvDoubleTapVis = Provider.autoDispose.family<bool, _ConfPair>((ref,
        confPair) =>
    ref.watch(kPrvDoubleTapVm(confPair.vmConfL).state).continuesTapTime != 0 ||
    ref.watch(kPrvDoubleTapVm(confPair.vmConfR).state).continuesTapTime != 0);

class DragOverlayWrapper extends HookWidget {
  DragOverlayWrapper({
    Key key,
    @required this.overlayBuilder,
    @required this.backDrop,
    @required this.enableDoubleTap,
    @required ViewModelConfig vmConfR,
    @required ViewModelConfig vmConfL,
  })  : _confPair = _ConfPair(vmConfL, vmConfR),
        super(key: key);

  final _ConfPair _confPair;
  final enableDoubleTap;

  @override
  Widget build(BuildContext context) => Visibility(
        visible:
            enableDoubleTap ? !useProvider(_kPrvDoubleTapVis(_confPair)) : true,
        child: DragOverlay(
          overlayBuilder: overlayBuilder,
          backDrop: backDrop,
        ),
      );

  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;
}

class DragOverlay extends StatefulWidget {
  const DragOverlay({
    Key key,
    @required this.overlayBuilder,
    @required this.backDrop,
  }) : super(key: key);

  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;

  @override
  DragOverlayState createState() => DragOverlayState();
}

class DragOverlayState extends State<DragOverlay>
    with SingleTickerProviderStateMixin {
  static const _DURATION_R = Duration(milliseconds: 200);
  AnimationController _ac;
  Animation<double> _animation;

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
  Widget build(BuildContext context) => ProviderListener(
        onChange: _onChange,
        provider: kPrvIsDragging,
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: widget.backDrop,
            child: _DragOverlayContentWrapper(
              overlayBuilder: widget.overlayBuilder,
            ),
          ),
        ),
      );

  void _onChange(BuildContext context, bool isDragging) {
    if (isDragging) {
      if (_ac.status == AnimationStatus.completed ||
          _ac.status == AnimationStatus.reverse) _ac.reset();
      _ac.forward();
    } else
      _ac.reverse();
  }
}

class _DragOverlayContentWrapper extends HookWidget {
  const _DragOverlayContentWrapper({@required this.overlayBuilder});

  final SwipeOverlayBuilder overlayBuilder;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: useProvider(kPrvIsDragging),
        child: _OverlayWidget(
          overlayBuilder: overlayBuilder,
        ),
      );
}

class _OverlayWidget extends HookWidget {
  const _OverlayWidget({
    Key key,
    @required this.overlayBuilder,
  }) : super(key: key);

  final SwipeOverlayBuilder overlayBuilder;

  @override
  Widget build(BuildContext context) {
    final data = useProvider(kPrvDragVm.state.select((it) => it.data));
    return overlayBuilder(data);
  }
}
