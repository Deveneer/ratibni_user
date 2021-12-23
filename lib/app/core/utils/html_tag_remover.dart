import 'package:html/parser.dart';

class HtmlTagRemover {
  static String removeHtmlTags(content) {
    var document = parse(content);
    final String parsedString =
        parse(document.body.text).documentElement.text;
    return parsedString;
  }
}
