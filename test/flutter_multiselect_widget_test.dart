import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_multiselect_widget/flutter_multiselect_widget.dart';

void main() {
  // test('Checks for the type of arguments', () {
  //   var description = 'Select Something';
  //   List<String> items = [
  //     'First thing',
  //     'Second Thing',
  //     'Third Thing',
  //     'Fourth Thing',
  //     'Fifth Thing'
  //   ];
  //   expect(description.runtimeType, String);
  // });

  testWidgets("If there are no items, then show empty container",
      (WidgetTester tester) async {
    // Empty urls
    List<String> items = [];
    await tester.pumpWidget(MultiSelect(
      items: items,
      description: 'Multiselect',
    ));

    var container = find.byType(Container);

    expect(container, findsOneWidget);

    var column = find.byType(Column);

    expect(column, findsNothing);
  });
}
