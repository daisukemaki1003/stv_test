import 'package:flutter_riverpod/flutter_riverpod.dart';

final targetYear = StateProvider<int>((ref) => DateTime.now().year);
final targetMonth = StateProvider<int>((ref) => DateTime.now().month);
