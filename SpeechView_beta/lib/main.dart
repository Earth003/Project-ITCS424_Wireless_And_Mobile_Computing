import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget { //was stateless
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Named Route Demo',
      //TODO 1:  Update Route Table HERE
	    initialRoute:'/',
	    routes: {
		    // When navigating to the "/" route ,
 		    // build the First Screen widget.
 		    '/':(context) => const FirstScreen(),

 		    // When navigating to the ”/second” route,
 		    // build the Second Screen widget.
 		    '/second' : (context) => const SecondScreen(),
	    },
    );
  }
}

class FirstScreen extends StatefulWidget {

  final String data;
  const FirstScreen({Key? key, @required this.data=""}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech View'),
      ),

	    //Image.asset('images/userInterface.JPG'),
	
      body: Center( //was Center

          // child: ElevatedButton(
          //   onPressed: () {
          //     // Navigate to the second screen when tapped.
          //     // TODO 2: Update Navigator with Push Named route here
	        //     // Navi gate to the second screen using a named route.
	        //     Navigator.pushNamed(context, '/second');
          //   },
          //   child: const Text('Launch screen'), 
          // ),
          
          child: Column(              
            children: <Widget>[  

              Text(
                widget.data,
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),

              Image.asset('images/microphone.png'), 

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen when tapped.
                  // TODO 2: Update Navigator with Push Named route here
	                // Navi gate to the second screen using a named route.
	                Navigator.pushNamed(context, '/second');
                  // Navigator.of(context).push(
			            //   MaterialPageRoute(
				          //     builder: (context) =>
					        //       const SecondScreen(data: '\n     This project is about utilizing android API to' 
                  //       'recognize voice input and convert it into text string and then display it on the user screen.\n' 
                  //       '\n     Additionally, it can make note files easily which can be use with speech to text at the same time.\n'
                  //       ),// '\n\nNote: this text is parsed from firstscreen(), refer to line 69.\n'
			            //   ),
                  // );
                },
                child: const Text('Start now'), 
            ), 

            ],  
            
          ),
        


      ),
    );
  }
}

class SecondScreen extends StatefulWidget {

  final String data;

  const SecondScreen({Key? key, @required this.data="",}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  
  @override
  //SPEECH TO TEXT HERE************************************************
    SpeechToText _speechToText = SpeechToText();
    bool _speechEnabled = false;
    String _lastWords = '';
    
    @override
  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      debugPrint(result.recognizedWords);
    });
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
  //SPEECH TO TEXT HERE************************************************
  @override
  Widget build(BuildContext context) {
    String words = _lastWords;
    
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Information about our application'),
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: false,
          padding: EdgeInsets.all(32),
          child: Column(       
            mainAxisSize: MainAxisSize.max,       
            children: <Widget>[ 

            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),

            // // Text(
            // //     'Recognized words:',
            // //     style: TextStyle(fontSize: 20, color: Colors.green),
            // // ),
              Container(
                height: 200,
                width: 200,
                padding: EdgeInsets.all(16), 
                  child: Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? '$_lastWords' 
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : _speechEnabled
                            ? 'Tap the microphone to start listening...'
                            : 'Speech not available',
                  ),
              ),
            

              // const Text(
              //   // words.toString(),
              //   'Second Page',
              //   // widget.data,
              //   style: TextStyle(fontSize: 20, color: Colors.green),
              // ),
              
              // Image.asset('images/microphone.png', height:500, width:500,), 
              
              ElevatedButton(
                onPressed: () {
                  //sending back transcribed voice input **NOT implemented yet, its a place holder.
                  // Navigator.of(context).push(
			            //   MaterialPageRoute(
				          //     builder: (context) =>
                      
					        //     const FirstScreen(data: '\n     This project is about utilizing android API'),

			            //   ),
                  // );

                  // Navigate back to first screen when tapped.
                  // TODO 3: Update code to return to FirstScreen Pop()
                  // Navigate back to the firstscreen by popping the current route
                  // off the stack.     
                  
                  Navigator.pop(context,'\n     This project is about utilizing android API');
                },
                child: const Text('Go back!'),
              ),


            ],
          ),


        ), //single child scroll view

      ),     
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),

    );
  }
}
