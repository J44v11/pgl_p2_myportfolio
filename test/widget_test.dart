import 'package:flutter_test/flutter_test.dart';

import 'package:pgl_p2_myportfolio/main.dart';

void main() {
  testWidgets(
    'Muestra la pantalla de bienvenida y navega al portfolio',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyPortfolioApp());
      await tester.pumpAndSettle();

      // Comprobar la pantalla de bienvenida
      expect(find.text('Senderos de\nCanarias'), findsOneWidget);
      expect(
        find.text('¡Descubre la naturaleza\nde nuestras islas!'),
        findsOneWidget,
      );
      expect(find.text('Empezar'), findsOneWidget);

      // Pulsar el botón para ir al portfolio
      await tester.tap(find.text('Empezar'));
      await tester.pumpAndSettle();

      // Comprobar que se muestra el portfolio
      expect(find.text('Este es mi portfolio'), findsOneWidget);
    },
  );

  testWidgets(
    'El Drawer muestra las opciones de navegación',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyPortfolioApp());
      await tester.pumpAndSettle();

      // Abrir el Drawer mediante el botón del AppBar
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Comprobar las opciones del Drawer
      expect(find.text('Inicio'), findsOneWidget);
      expect(find.text('Mi Portfolio'), findsOneWidget);
    },
  );
}