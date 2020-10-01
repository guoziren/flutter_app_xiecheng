import 'package:flutter/material.dart';

enum SearchBarType {
  home, //首页的搜索框
  normal, // 标准的，也就是搜索页用的
  homeLight
}

class SearchBar extends StatefulWidget {
  final String city;
  final String hint;
  final String defaultText;
  final SearchBarType searchBarType;
  final bool enabled;
  final bool hideLeft;
  final bool autofocus;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakButtonClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
      this.city,
      this.hint,
      this.defaultText,
      this.searchBarType = SearchBarType.normal,
      this.enabled = true,
      this.hideLeft,
      this.autofocus = false,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakButtonClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  // 搜索页搜索bar布局
  get _genNormalSearch => Container(
        child: Row(
          children: <Widget>[
            _wrapTap(
                //左边箭头
                Container(
                  padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                  child: widget?.hideLeft ?? false
                      ? null
                      : Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 26,
                        ),
                ),
                widget.leftButtonClick),
            Expanded(
              flex: 1,
              child: _inputBox,
            ),
            _wrapTap(
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    '搜索',
                    style: TextStyle(color: Colors.blue, fontSize: 17),
                  ),
                ),
                widget.rightButtonClick),
          ],
        ),
      );

  get _genHomeSearch => Container(
        child: Row(
          children: <Widget>[
            _wrapTap(
                Container(
                    padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.city,
                          style: TextStyle(color: _homeFontColor, fontSize: 14),
                        ),
                        Icon(
                          Icons.expand_more,
                          color: _homeFontColor,
                          size: 22,
                        )
                      ],
                    )),
                widget.leftButtonClick),
            Expanded(
              flex: 1,
              child: _inputBox,
            ),
            _wrapTap(
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(
                      Icons.comment,
                      color: _homeFontColor,
                      size: 26,
                    )),
                widget.rightButtonClick),
          ],
        ),
      );

  //输入框
  Widget get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      //搜索页就是灰色，主页就是白色
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 40,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 22,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(
              child: widget.searchBarType == SearchBarType.normal
                  //搜索页是编辑框
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: widget.autofocus,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 6),
                        border: InputBorder.none,
                        hintText: widget.hint ?? '',
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    )
                  //主页是搜索框是不可点击的，点击后跳转
                  : _wrapTap(
                      Container(
                        child: Text(
                          widget.defaultText,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick)),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakButtonClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  @override
  void initState() {
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch
        : _genHomeSearch;
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  //输入框内容改变
  void _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
