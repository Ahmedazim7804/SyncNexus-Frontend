<<<<<<< HEAD
import 'package:flutter/material.dart';

Widget overlayChildBuilder(BuildContext ctx) {
  final baseColor = Theme.of(ctx).colorScheme.primary;

  return Container(
    height: MediaQuery.of(ctx).size.height,
    width: MediaQuery.of(ctx).size.width,
    color: Colors.black38,
    child: Center(
        child: CircularProgressIndicator(
      color: baseColor,
    )),
  );
}
||||||| e76931d
=======
import 'package:flutter/material.dart';

Widget overlayChildBuilder(BuildContext ctx) {
  final baseColor = Theme.of(ctx).colorScheme.onSurface;

  return Container(
    height: MediaQuery.of(ctx).size.height,
    width: MediaQuery.of(ctx).size.width,
    color: Theme.of(ctx).colorScheme.primary.withAlpha(150),
    child: Center(
        child: CircularProgressIndicator(
      color: baseColor,
    )),
  );
}
>>>>>>> 86ceac9
