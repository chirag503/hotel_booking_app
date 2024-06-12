import 'package:flutter/material.dart';

///Common App Button
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.onPressed,
    Color? onHoverButtonColor,
    Color? focusColor,
    Color? borderColor,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderSide? borderSide,
    double? elevation,
    double? height,
    double? width,
    TextStyle? textStyle,
    double? borderRadius,
    Size? maximumSize,
    EdgeInsets? padding,
  })  : _focusColor = focusColor ?? Colors.black,
        _onHoverButtonColor = onHoverButtonColor,
        _borderSide = borderSide,
        _elevation = elevation ?? 0,
        _backgroundColor = backgroundColor ?? Colors.black,
        _foregroundColor = foregroundColor ?? Colors.black,
        _borderColor = borderColor ?? Colors.grey,
        _height = height ?? 52,
        _width = width,
        _borderRadius = borderRadius ?? 8,
        _padding = padding ?? EdgeInsets.zero;
  // _textStyle = textStyle;

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A background color of the button.
  final Color? _onHoverButtonColor;

  /// A border color of the button.
  /// Defaults to [Colors.white].
  final Color _borderColor;

  /// A border of the button.
  final BorderSide? _borderSide;

  /// Elevation of the button.
  final double _elevation;

  /// Color of the text, icons etc.
  /// Defaults to [AppColors.black].
  final Color _foregroundColor;

  /// The padding of the button.
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets _padding;

  /// Color of the background of the button
  /// Defaults to [AppColors.white].
  final Color _backgroundColor;

  final Color _focusColor;

  /// The width of the button
  final double? _width;

  /// The height of the button
  final double? _height;

  /// The borderRadius of the buttonZ
  /// Defaults to 4.
  final double _borderRadius;

  /// [TextStyle] of the button text.
  ///
  /// Defaults to [TextTheme.labelLarge].
  // final TextStyle? _textStyle;

  /// [Widget] displayed on the button.
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final state = MaterialStateProperty.res
    return SizedBox(
      height: _height,
      width: _width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: _onHoverButtonColor != null
              ? MaterialStateProperty.resolveWith<Color>(
                  (states) => _getColorOnFocus(
                      states: states,
                      focusColor: _onHoverButtonColor,
                      unFocusColor: theme.canvasColor),
                )
              : MaterialStateProperty.all(_backgroundColor),
          elevation: MaterialStateProperty.all(_elevation),
          foregroundColor: MaterialStateProperty.all(_foregroundColor),
          side: MaterialStateProperty.all(_borderSide),
          padding: MaterialStateProperty.all(_padding),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              side: BorderSide(
                color: _getColorOnFocus(
                  states: states,
                  unFocusColor: _borderColor,
                  // focusColor: AppColors.kPrimaryBlue,
                  focusColor: _focusColor,
                ),
              ),
            ),
          ),
        ),
        child: child,
      ),
    );
  }

  Color _getColorOnFocus(
      {required Set<MaterialState> states,
      required Color unFocusColor,
      required Color focusColor}) {
    if (states.contains(MaterialState.hovered)) {
      return focusColor;
    } else if (states.contains(MaterialState.pressed)) {
      return focusColor;
    }
    return unFocusColor;
  }
}
