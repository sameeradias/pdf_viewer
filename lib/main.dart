import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pdf1 =
      'https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-file.pdf';
  final pdf2 =
      'https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-download-10-mb.pdf';
  final pdf3 =
      'https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-with-images.pdf';

  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromURL(pdf1);
    } else if (value == 2) {
      document = await PDFDocument.fromURL(pdf2);
    } else {
      document = await PDFDocument.fromURL(pdf3);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('ABC'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                TextButton(onPressed: () {changePDF(1);}, child: Text('B1')),
                TextButton(onPressed: () {changePDF(2);}, child: Text('B2')),
                TextButton(onPressed: () {changePDF(3);}, child: Text('B3')),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Container(height: 300, width: 300, child:  _isLoading
                ? const Center(child: CircularProgressIndicator())
                : PDFViewer(
              document: document,
              lazyLoad: false,
              zoomSteps: 1,
              numberPickerConfirmWidget: const Text(
                "Confirm",
              ),
              //uncomment below line to preload all pages
              // lazyLoad: false,
              // uncomment below line to scroll vertically
              // scrollDirection: Axis.vertical,

              //uncomment below code to replace bottom navigation with your own
              /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
            ),)
          ],
        ),);
  }
}
