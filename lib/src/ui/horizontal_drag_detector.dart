import 'package:double_tap_player_view/src/model/swipe_model.dart';
import 'package:double_tap_player_view/src/viewmodel/swipe_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../double_tap_player_view.dart';

final kPrvDragVm =
    StateNotifierProvider<SwipeViewModel>((ref) => SwipeViewModel());

final _kPrvIsDragging =
    Provider.autoDispose<bool>((ref) => ref.watch(kPrvDragVm.state).isDragging);

class _ConfPair {
  final ViewModelConfig vmConfR;
  final ViewModelConfig vmConfL;

  _ConfPair(this.vmConfR, this.vmConfL);
}

final _kPrvDoubleTapVis = Provider.autoDispose.family<bool, _ConfPair>((ref,
        confPair) =>
    ref.watch(kPrvViewModel(confPair.vmConfL).state).continuesTapTime != 0 ||
    ref.watch(kPrvViewModel(confPair.vmConfR).state).continuesTapTime != 0);

class DragOverlayWrapper extends HookWidget {
  DragOverlayWrapper({
    Key key,
    @required this.overlayBuilder,
    @required this.backDrop,
    @required ViewModelConfig vmConfR,
    @required ViewModelConfig vmConfL,
  })  : _confPair = _ConfPair(vmConfL, vmConfR),
        super(key: key);

  final _ConfPair _confPair;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: !useProvider(_kPrvDoubleTapVis(_confPair)),
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
    super.dispose();
    _ac.dispose();
  }

  @override
  Widget build(BuildContext context) => ProviderListener(
        onChange: _onChange,
        provider: _kPrvIsDragging,
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: widget.backDrop,
            child: DragOverlayContentWrapper(
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

class DragOverlayContentWrapper extends HookWidget {
  const DragOverlayContentWrapper({@required this.overlayBuilder});

  final SwipeOverlayBuilder overlayBuilder;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: useProvider(kPrvDragVm.state.select((it) => it.isDragging)),
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
