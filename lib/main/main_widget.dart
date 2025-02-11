import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

MainWidget get W => MainWidget._();

class MainWidget {
  factory MainWidget() => MainWidget._();
  MainWidget._();

  Widget text({
    Function()? onTap,
    required String text,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget input({
    TextEditingController? controller,
    Color? cursorColor = Colors.black,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    int? maxLength,
    int? maxLines,
    bool obscureText = false,
    int? minLines,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    String? hintText,
    isDense = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputBorder? focusedBorder,
    InputBorder? enabledBorder,
    InputBorder? errorBorder,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    Color? hintColor,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      cursorColor: cursorColor,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: focusedBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder ??= focusedBorder,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: fillColor != null,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: hintColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        isDense: isDense,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      minLines: maxLines,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      buildCounter: (
        BuildContext _, {
        int? currentLength,
        int? maxLength,
        bool? isFocused,
      }) {
        return null;
      },
    );
  }

  Widget button({
    double? height,
    double? width,
    Function()? onPressed,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Color? shadowColor,
    BorderSide? side,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Widget? child,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
          padding: padding ??= EdgeInsets.all(12),
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          side: side,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: child,
      ),
    );
  }

  Widget gap({
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget pinput({
    TextEditingController? controller,
    List<TextInputFormatter> inputFormatters = const [],
    TextInputType keyboardType = TextInputType.number,
    int length = 6,
    bool obscureText = false,
    void Function(String)? onChanged,
    void Function(String)? onCompleted,
    void Function(String)? onSubmitted,
    double? height,
    double? width,
    Color? color,
    Color? borderColor,
    Color? focusedBorderColor,
  }) {
    return Pinput(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      length: length,
      obscureText: obscureText,
      onChanged: onChanged,
      onCompleted: onCompleted,
      onSubmitted: onSubmitted,
      defaultPinTheme: PinTheme(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor ??= Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      focusedPinTheme: PinTheme(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ??= Colors.white,
          border: Border.all(color: focusedBorderColor ??= borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
