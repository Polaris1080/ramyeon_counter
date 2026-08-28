part of '../home_page.dart';

enum RamyeonListOrder(final String label) {
  normal('名前'),
  rating('評価'),
  price('価格'),
  count('個数'),
  limit('期限');

  MapEntry<RamyeonListOrder, String> get menuItem => .new(this, label);
}
