import 'package:finance_manager/entity/currency.dart';

class DefaultCurrencyData {
  static List<Currency> listOfCurrencies = const [
    Currency(
      currencyName: "Tenge",
      currencySign: "₸",
    ),
    Currency(
      currencyName: "Ruble",
      currencySign: "₽",
    ),
    Currency(
      currencyName: "Dollar",
      currencySign: "\$",
    ),
    Currency(
      currencyName: "Yuan",
      currencySign: "¥",
    ),
    Currency(
      currencyName: "Euro",
      currencySign: "€",
    ),
    Currency(
      currencyName: "Yen",
      currencySign: "¥",
    ),
    Currency(
      currencyName: "Lira",
      currencySign: "₺",
    ),
    Currency(
      currencyName: "Pound",
      currencySign: "£",
    ),
  ];
}
