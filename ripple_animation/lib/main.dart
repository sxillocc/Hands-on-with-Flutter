import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   GlobalKey globalKey = RectGetter.createGlobalKey();
   Rect rect;
   final Duration animationDuration = Duration(milliseconds: 300);
   final Duration delay = Duration(milliseconds: 300);

  void _onTap(){
    setState(() => rect = RectGetter.getRectFromKey(globalKey));
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(()=>
        rect = rect.inflate(MediaQuery.of(context).size.longestSide)
      );
      Future.delayed(animationDuration+delay , _goToNextPage);
    });
  }

  void _goToNextPage(){
    Navigator.of(context)
             .push(FadeRouteBuilder(page: SecondPage()))
             .then((_)=>setState(()=>rect = null));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Ripple Animation"),
          ),
          body: Center(child: Text("Tap on Floating button"),),
          floatingActionButton: RectGetter(
            key: globalKey,
            child: FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              onPressed: _onTap,
            ),
          ),
        ),
        _ripple()
      ],
    );
  }

  Widget _ripple(){
    if(rect == null)
      return Container();
    else 
      return AnimatedPositioned(
          duration: animationDuration,
          left:rect.left,
          top: rect.top,
          right: MediaQuery.of(context).size.width - rect.right,
          bottom: MediaQuery.of(context).size.height - rect.bottom,
          child: Container(
            // width: 24,
            // height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle
            ),
          ),
        );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({this.page})
    :super(pageBuilder: (context,animation1,animation2) => page,
            transitionsBuilder:(context,animation1,animation2,child){
              return FadeTransition(opacity: animation1,child: child,);
            });
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(child: Text("This is new Page"),),
    );
  }
}

