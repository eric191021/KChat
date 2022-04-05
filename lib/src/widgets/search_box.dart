import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.searchIconColor,
    this.backgroundColor,
    this.searchIconHeight,
    this.searchIconWidth,
    this.margin,
    this.padding,
    this.enabled = true,
    this.autofocus = false,
    this.clearBtn,
    this.height,
    this.onSubmitted,
    this.onCleared,
    this.onChanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final Color? searchIconColor;
  final Color? backgroundColor;
  final double? searchIconWidth;
  final double? searchIconHeight;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool autofocus;
  final double? height;
  final Widget? clearBtn;
  final Function(String)? onSubmitted;
  final Function()? onCleared;
  final ValueChanged<String>? onChanged;

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool _showClearBtn = false;

  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {
        _showClearBtn = widget.controller!.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 34.h,
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Image.asset(
            ImageRes.ic_searchGrey,
            color: widget.searchIconColor,
            width: widget.searchIconWidth ?? 18.w,
            height: widget.searchIconHeight ?? 17.h,
            alignment: Alignment.centerLeft,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: widget.textStyle ?? PageStyle.ts_000000_16sp,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: widget.hintText ?? StrRes.search,
                hintStyle: widget.hintStyle ?? PageStyle.ts_666666_16sp,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              onSubmitted: widget.onSubmitted,
              onChanged: widget.onChanged,
            ),
          ),
          if (_showClearBtn && widget.clearBtn != null)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                widget.controller?.clear();
                widget.onCleared?.call();
              },
              child: widget.clearBtn,
              /* child: Container(
                child: Image.asset(
                  ImageRes.ic_clearInput,
                  color: Color(0xFF999999),
                  width: 15.w,
                  height: 15.w,
                ),
              ),*/
            ),
        ],
      ),
    );
  }
}

/*class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.imgColor,
    this.margin,
    this.padding,
    this.enabled = true,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final Color? imgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Image.asset(
            ImageRes.ic_searchGrey,
            color: imgColor,
            width: 18.w,
            height: 17.h,
            alignment: Alignment.centerLeft,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: textStyle ?? SearchBoxStyle.searchContent,
              enabled: enabled,
              decoration: InputDecoration(
                hintText: hintText ?? StrRes.search,
                hintStyle: hintStyle ?? SearchBoxStyle.searchHint,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller?.clear();
            },
            child: Image.asset(
              ImageRes.ic_clearInput,
              color: Color(0xFF999999),
              width: 15.w,
              height: 15.w,
            ),
          ),
        ],
      ),
    );
  }
}*/