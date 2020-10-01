


import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({Key key,@required this.isLoading, this.cover = false,@required this.child}) : super(key: key);

  get _loadingView => Center(child: CircularProgressIndicator(),);
  @override
  Widget build(BuildContext context) {
     if(!cover){
       return !isLoading ? child : _loadingView;
     }else{
       return Stack(
         children: <Widget>[
           child,
           isLoading ? _loadingView : null,
         ],
       );
     }
  }
}
