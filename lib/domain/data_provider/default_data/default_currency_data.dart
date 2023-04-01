import 'package:finance_manager/domain/entity/currency.dart';

class DefaultCurrencyData {
  static List<Currency> listOfCurrencies = const [
    Currency(
      currencyName: "Tenge",
      currencyCode: "KZT",
      currencySign: "₸",
    ),
    Currency(
      currencyName: "Ruble",
      currencyCode: "RUB",
      currencySign: "₽",
    ),
    Currency(
      currencyName: "Dollar",
      currencyCode: "USD",
      currencySign: "\$",
    ),
    Currency(
      currencyName: "Yuan",
      currencyCode: "CNY",
      currencySign: "¥",
    ),
    Currency(
      currencyName: "Euro",
      currencyCode: "EUR",
      currencySign: "€",
    ),
    Currency(
      currencyName: "Yen",
      currencyCode: "JPY",
      currencySign: "¥",
    ),
    Currency(
      currencyName: "Lira",
      currencyCode: "TRY",
      currencySign: "₺",
    ),
    Currency(
      currencyName: "Pound",
      currencyCode: "GBP",
      currencySign: "£",
    ),
  ];
}
