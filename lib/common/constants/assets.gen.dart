/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsPicturesGen {
  const $AssetsPicturesGen();

  /// File path: assets/pictures/harrypotterB1.jpg
  AssetGenImage get harrypotterB1 => const AssetGenImage('assets/pictures/harrypotterB1.jpg');

  /// File path: assets/pictures/harrypotterB2.jpg
  AssetGenImage get harrypotterB2 => const AssetGenImage('assets/pictures/harrypotterB2.jpg');

  /// File path: assets/pictures/harrypotterB3.jpg
  AssetGenImage get harrypotterB3 => const AssetGenImage('assets/pictures/harrypotterB3.jpg');

  /// File path: assets/pictures/harrypotterB4.jpg
  AssetGenImage get harrypotterB4 => const AssetGenImage('assets/pictures/harrypotterB4.jpg');

  /// File path: assets/pictures/harrypotterB5.jpg
  AssetGenImage get harrypotterB5 => const AssetGenImage('assets/pictures/harrypotterB5.jpg');
}

class Assets {
  Assets._();

  static const $AssetsPicturesGen pictures = $AssetsPicturesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
