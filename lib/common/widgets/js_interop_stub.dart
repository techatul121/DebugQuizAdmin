import 'dart:js_interop';
import 'dart:typed_data';

@JS()
@staticInterop
class Blob {
  external factory Blob(JSArray data, BlobOptions options);
}

@JS()
@staticInterop
@anonymous
class BlobOptions {
  external factory BlobOptions({String type});
}

@JS('URL.createObjectURL')
external String createObjectURL(Blob blob);

/// ✅ Correct function to create a Blob URL
String createBlobUrl(Uint8List bytes) {
  final data = [bytes.toJS].toJS; // Convert Uint8List to JS Array

  final blob = Blob(data, BlobOptions(type: 'video/mp4'));
  return createObjectURL(blob);
}
