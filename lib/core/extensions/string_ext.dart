extension FormatString on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get capsAfterSpace {
    return split(" ").map((e) => e.capitalize).join(" ");
  }

  String get formatName {
    return capitalize.capsAfterSpace;
  }
}
