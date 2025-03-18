import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = ResponsiveSize(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(screenSize),
            Expanded(child: _buildBody(screenSize)),
            _buildFooter(screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ResponsiveSize size) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: size.horizontalPadding,
        right:
            size.isMobile
                ? size.horizontalPadding
                : size.isTablet
                ? 60.0
                : 56.0,
      ),
      height: size.isTablet ? 90.0 : 80.0,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
      child: size.isMobile ? _buildMobileHeader() : _buildDesktopHeader(size),
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/infinity.svg', fit: BoxFit.contain, width: 60.0, height: 40.0),
        Text('INVESTORS PROGRAM', style: TextStyle(fontSize: 14.0, color: Colors.white)),
      ],
    );
  }

  Widget _buildDesktopHeader(ResponsiveSize size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/infinity.svg',
          fit: BoxFit.contain,
          width: size.isTablet ? 65.0 : 75.0,
          height: size.isTablet ? 65.0 : 75.0,
        ),
        Text('INVESTORS PROGRAM', style: TextStyle(fontSize: size.isTablet ? 15.0 : 16.0, color: Colors.white)),
      ],
    );
  }

  Widget _buildBody(ResponsiveSize size) {
    final contentWidget = _buildContent(size);

    if (size.isTablet) {
      return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(left: size.horizontalPadding, top: 30.0),
        child: contentWidget,
      );
    } else {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: size.horizontalPadding),
        child:
            size.isMobile
                ? SingleChildScrollView(child: contentWidget)
                : Align(alignment: Alignment.centerLeft, child: contentWidget),
      );
    }
  }

  Widget _buildContent(ResponsiveSize size) {
    final TextContent textContent = TextContent();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.getSpacing(mobile: 40.0, tablet: 20.0, desktop: 0)),
        Transform.translate(
          offset: Offset(size.getSpacing(mobile: -16.0, tablet: -18.0, desktop: -20.0), 0),
          child: SvgPicture.asset(
            'assets/decimal.svg',
            width: size.getSpacing(mobile: 60.0, tablet: 68.0, desktop: 75.0),
            height: size.getSpacing(mobile: 60.0, tablet: 68.0, desktop: 75.0),
          ),
        ),
        SizedBox(height: 18.0),
        _buildRichText(size),
        SizedBox(height: 32.0),
        _buildTextSection(size, textContent),
        SizedBox(height: size.getSpacing(mobile: 20.0, tablet: 25.0, desktop: 32.0)),
        SvgPicture.asset('assets/signature.svg', colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        SizedBox(height: size.getSpacing(mobile: 20.0, tablet: 10.0, desktop: 0)),
      ],
    );
  }

  Widget _buildRichText(ResponsiveSize size) {
    return RichText(
      text: TextSpan(
        text: 'is ',
        style: TextStyle(fontSize: size.getSpacing(mobile: 24.0, tablet: 26.0, desktop: 28.0), color: Colors.white),
        children: const <TextSpan>[
          TextSpan(text: 'for '),
          TextSpan(text: 'D', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF54ACF7))),
          TextSpan(text: 'e', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEA5BAF))),
          TextSpan(text: 'c', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF7DB49))),
          TextSpan(text: 'i', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6EC644))),
          TextSpan(text: 'm', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF54ACF7))),
          TextSpan(text: 'a', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEA5BAF))),
          TextSpan(text: 'l', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6EC644))),
        ],
      ),
    );
  }

  Widget _buildTextSection(ResponsiveSize size, TextContent textContent) {
    return SizedBox(
      width: size.getSpacing(mobile: 250.0, tablet: 400.0, desktop: 500.0),
      child:
          size.isMobile
              ? _buildExpandableText(textContent)
              : Text(
                textContent.fullText,
                style: TextStyle(fontSize: size.isTablet ? 15.0 : 16.0, color: Colors.white),
              ),
    );
  }

  Widget _buildExpandableText(TextContent textContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textContent.initialText, style: const TextStyle(fontSize: 14.0, color: Colors.white)),
        AnimatedCrossFade(
          firstChild: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = true;
              });
            },
            child: const Row(
              children: [
                Text(' Read more', style: TextStyle(fontSize: 14.0, color: Colors.blue, fontWeight: FontWeight.bold)),
                Icon(Icons.keyboard_arrow_down, color: Colors.blue, size: 16),
              ],
            ),
          ),
          secondChild: Text(textContent.expandedText, style: const TextStyle(fontSize: 14.0, color: Colors.white)),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildFooter(ResponsiveSize size) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.horizontalPadding,
        bottom: 20.0,
        top: size.getSpacing(mobile: 20.0, tablet: 10.0, desktop: 0),
      ),
      child: Text(
        'Infinity 2025 Ⓒ',
        style: TextStyle(fontSize: size.getSpacing(mobile: 14.0, tablet: 15.0, desktop: 16.0), color: Colors.white),
      ),
    );
  }
}

// Classes utilitaires

class ResponsiveSize {
  final BuildContext context;
  final double width;

  ResponsiveSize(this.context) : width = MediaQuery.of(context).size.width;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 900;
  bool get isDesktop => width >= 900;

  double get horizontalPadding =>
      isMobile
          ? 48.0
          : isTablet
          ? 80.0
          : 135.0;

  double getSpacing({required double mobile, required double tablet, required double desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}

class TextContent {
  final String initialText =
      'As Morgane wondered, there is plenty of work to do in this information classification quest.';

  final String expandedText =
      'We had to find a way to classify informations that is relatable and easy to use. '
      'So we came up with an innovative solution, rewarding for both the actors on the internet and us. '
      'The parallax of this thing is that we can use it to make a better world, a world where information '
      'is not only accessible but also easy to understand, wrapped-up in multiple categories. '
      'And that quest is what we intend to aim for: the re-organization of the internet '
      'and the completion of the offer that already are in use today.';

  String get fullText => '$initialText $expandedText';
}
