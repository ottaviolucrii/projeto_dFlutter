import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Projeto semana 2 - FLutter/Dart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _shouldFlash = false;
  bool _canContinueAfterWarning = false;
  IconData _buttonIcon = Icons.add;

void _incrementCounter() {
    setState(() {
      if (_counter < 20) {
        _counter++;
      }
        else if(!_canContinueAfterWarning){
          _showWarningDialog();
        }
       else if (_counter < 70){
        _counter += 5;
        _shouldFlash = true;
        _buttonIcon = Icons.warning;
        
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            _shouldFlash = false;
          });
        });
      } else if (_counter == 70) {
        _showFinalWarning();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _canContinueAfterWarning = false;
      _buttonIcon = Icons.add;
    });
  }
  void _showWarningDialog(){
    showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Cuidado!'),
        content: const Text('Você chegou aos 20 cliques! O que deseja fazer?'),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();//fecha o dialogo
              _resetCounter();
            },
            child: const Text('Parar'),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();//fecha o dialogo
              _showConfirmationDialog();
            },
            child: const Text('Continuar'),
          )
        ],
      );
    },//builder
    );//showDialog
  }

  void _showConfirmationDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('Tem certeza? Continue por sua conta e risco!'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                _canContinueAfterWarning = true;
              },
              child: const Text('Continuar'),
        ),
          ],
        );
      },
    );
  }

  void _showFinalWarning(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Eu avisei 😨'),
          content: const Text('Você chegou ao número proíbido de 70 cliques, NÂO ABRA SEU GUARDA-ROUPA!'),
          actions: <Widget> [ 
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                _resetCounter();
              },
              child: const Text('Tome cuidado à partir de agora!'),
            ),
          ],
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: _shouldFlash ? Colors.red : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Não queira descobrir o que acontece se apertar 20 vezes!\nEm hipótese alguma chegue nos 70 cliques!',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Cuidado!',
        child: Icon(_buttonIcon),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
