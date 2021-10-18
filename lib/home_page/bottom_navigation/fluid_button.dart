import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_demo/components/imgProcessing.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/screenApdar.dart';

typedef void FluidNavBarButtonPressedCallback();

class FluidNavBarButton extends StatefulWidget {
  static const nominalExtent = const Size(64, 64);
  final bool _selected;
  final Map _titles;
  final FluidNavBarButtonPressedCallback _onPressed;

  FluidNavBarButton(
      Map titles, bool selected, FluidNavBarButtonPressedCallback onPressed)
      : _titles = titles,
        _selected = selected,
        _onPressed = onPressed;

  @override
  State createState() {
    return _FluidNavBarButtonState(_selected, _onPressed);
  }
}

class _FluidNavBarButtonState extends State<FluidNavBarButton>
    with SingleTickerProviderStateMixin {
  static const double _activeOffset = 20;
  static const double _defaultOffset = 8;
  static const double _radius = 25;
  bool _selected;
  FluidNavBarButtonPressedCallback _onPressed;

  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _opacity;

  _FluidNavBarButtonState(
      bool selected, FluidNavBarButtonPressedCallback onPressed)
      : _selected = selected,
        _onPressed = onPressed;

  @override
  void initState() {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    _animation =
        Tween<double>(begin: 0.0, end: 1).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _startAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {

      const ne = FluidNavBarButton.nominalExtent;
    final offsetCurve = _selected ? Curves.easeInOut : Curves.easeIn;
    final progress = LinearPointCurve(0.28, 0.0).transform(_animation.value);

    final offset = Tween<double>(begin: _defaultOffset, end: _activeOffset)
        .transform(offsetCurve.transform(progress));

    dynamic iconSvg = ImgProcessing.svgPictureAsset(
        url: widget._titles['icon'],
        svgColor: ComponentStyle.AVERAGE_COLOR,
        width: ScreenApdar.setWidth(22.0));
    if (_selected) {
      iconSvg = ImgProcessing.svgPictureAsset(
          url: widget._titles['icon'],
          svgColor: ComponentStyle.AVERAGE_COLOR,
          width: ScreenApdar.setWidth(22.0));
    }
    return GestureDetector(
      onTap: _onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: ScreenApdar.setWidth(30.0),
        height: ScreenApdar.setWidth(30.0),
        decoration: ShapeDecoration(
          // color: _selected ? ComponentStyle.INDICATOR_COLOR : null,
          shape: CircleBorder(),
        ),
        // constraints: BoxConstraints.tight(ne),
        alignment: Alignment.center,
        // margin: EdgeInsets.all(ne.width / 2 - _radius),
        transform: Matrix4.translationValues(0, -offset, 0),
        child: Stack(alignment: Alignment.center, children: [
          Opacity(
            opacity: _opacity.value,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: ShapeDecoration(
                  color: ComponentStyle.INDICATOR_COLOR,
                  shape: CircleBorder(),
                )),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: iconSvg,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    setState(() {
      _selected = widget._selected;
    });
    _startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    if (_selected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

class LinearPointCurve extends Curve {
  final double pIn;
  final double pOut;

  LinearPointCurve(this.pIn, this.pOut);

  @override
  double transform(double x) {
    // Just a simple bit of linear interpolation math
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 - pIn);
    final upperOffset = 1.0 - upperScale;
    return x < pIn ? x * lowerScale : x * upperScale + upperOffset;
  }
}

/*

class FluidNavBarButton extends StatefulWidget {
  static const nominalExtent = const Size(64, 64);

  final Map _titles;
  final bool _selected;
  final FluidNavBarButtonPressedCallback _onPressed;

  FluidNavBarButton(
      Map titles, bool selected, FluidNavBarButtonPressedCallback onPressed)
      : _titles = titles,
        _selected = selected,
        _onPressed = onPressed;

  @override
  State createState() {
    return _FluidNavBarButtonState(_selected, _onPressed);
  }
}

class _FluidNavBarButtonState extends State<FluidNavBarButton>
    with SingleTickerProviderStateMixin {
  static const double _activeOffset = 16;
  static const double _defaultOffset = 0;
  static const double _radius = 25;

  bool _selected;
  FluidNavBarButtonPressedCallback _onPressed;

  AnimationController _animationController;
  Animation<double> _animation;

  _FluidNavBarButtonState(
      bool selected, FluidNavBarButtonPressedCallback onPressed)
      : _selected = selected,
        _onPressed = onPressed;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _startAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    const ne = FluidNavBarButton.nominalExtent;
    final offsetCurve = _selected ? ElasticOutCurve(0.38) : Curves.easeInQuint;
    // final scaleCurve = _selected ? CenteredElasticOutCurve(0.6) : CenteredElasticInCurve(0.6);

    final progress = LinearPointCurve(0.28, 0.0).transform(_animation.value);

    final offset = Tween<double>(begin: _defaultOffset, end: _activeOffset)
        .transform(offsetCurve.transform(progress));
    final scaleCurveScale = 0.50;
    // final scaleY = 0.5 + scaleCurve.transform(progress) * scaleCurveScale + (0.5 - scaleCurveScale / 2);

    // Create a parameterizable flat button with a fluid fill icon
    return GestureDetector(
      // We wan't to know when this button was tapped, don't bother letting out children know as well
      onTap: _onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
          // Alignment container to the circle
          constraints: BoxConstraints.tight(ne),
          alignment: Alignment.center,
          child: Container(
            // This container just draws a circle with a certain radius and offset
            margin: EdgeInsets.all(ne.width / 2 - _radius),
            constraints: BoxConstraints.tight(Size.square(_radius * 2)),
            transform: Matrix4.translationValues(0, -offset, 0),
            // Create a fluid fill icon that get's filled in with a slight delay to the buttons animation
            child: Container(
              width: ScreenApdar.setWidth(30.0),
              height: ScreenApdar.setWidth(30.0),
              decoration: ShapeDecoration(
                // color: _selected ? ComponentStyle.INDICATOR_COLOR : null,
                shape: CircleBorder(),
              ),
              // constraints: BoxConstraints.tight(ne),
              alignment: Alignment.center,
              // margin: EdgeInsets.all(ne.width / 2 - _radius),
              transform: Matrix4.translationValues(0, -offset, 0),
              child: Stack(alignment: Alignment.center, children: [
                Opacity(
                  opacity: 1,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: ShapeDecoration(
                        color: ComponentStyle.INDICATOR_COLOR,
                        shape: CircleBorder(),
                      )),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    // child: ,
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    setState(() {
      _selected = widget._selected;
    });
    _startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    if (_selected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
*/
