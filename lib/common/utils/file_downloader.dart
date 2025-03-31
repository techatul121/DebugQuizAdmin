import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xliso;

class FileDownloader {
  FileDownloader._();

  static Future<void> save({
    required GlobalKey<SfDataGridState> sfDataGridKey,
    String? fileName,
  }) async {
    final xliso.Workbook workbook = xliso.Workbook();
    final xliso.Worksheet worksheet = workbook.worksheets[0];
    sfDataGridKey.currentState!.exportToExcelWorksheet(worksheet);
    final List<int> bytes = workbook.saveAsStream();

    await FileSaver.instance.saveFile(
      name: fileName == null ? '${DateTime.timestamp()}.xls' : '$fileName.xls',
      bytes: Uint8List.fromList(bytes),
    );
  }
}
