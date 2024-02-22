import 'package:project_urbanizacion/model/gc0040.dart';
import 'package:project_urbanizacion/utils/save_file_web.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:flutter/services.dart';

class CreateFileWeb {
  static onStarPdf(Gc0040 objeto, String name) async {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('FORMATO_POSESION_2024_.pdf'));

    //Asignacion de valores en el formulario
    final PdfForm form = document.form;

    final PdfTextBoxField propietario =
        document.form.fields[0] as PdfTextBoxField;
    propietario.text = name;
    propietario.font = PdfStandardFont(PdfFontFamily.helvetica, 11);

    final PdfTextBoxField cedula = document.form.fields[1] as PdfTextBoxField;
    cedula.text = objeto.secNic.trim();
    cedula.font = PdfStandardFont(PdfFontFamily.helvetica, 11);

    final PdfTextBoxField norte = document.form.fields[2] as PdfTextBoxField;
    norte.text = "${objeto.mtnLot}";
    norte.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    final PdfTextBoxField sur = document.form.fields[3] as PdfTextBoxField;
    sur.text = "${objeto.mtsLot}";
    sur.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    final PdfTextBoxField este = document.form.fields[4] as PdfTextBoxField;
    este.text = "${objeto.mteLot}";
    este.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    final PdfTextBoxField oeste = document.form.fields[5] as PdfTextBoxField;
    oeste.text = "${objeto.mtoLot}";
    oeste.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    final PdfTextBoxField dia = document.form.fields[6] as PdfTextBoxField;
    dia.text = "${DateTime.now().day}";
    dia.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    final PdfTextBoxField mes = document.form.fields[7] as PdfTextBoxField;
    mes.text = "${DateTime.now().month}";
    dia.textAlignment = PdfTextAlignment.center;

    final PdfTextBoxField total = document.form.fields[8] as PdfTextBoxField;
    total.text =
        "${objeto.mtnLot + objeto.mtsLot + objeto.mteLot + objeto.mtoLot}";
    total.font = PdfStandardFont(PdfFontFamily.helvetica, 10);

    form.setDefaultAppearance(false);
    form.flattenAllFields();
    final List<int> bytes = await document.save();
    document.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'certidicado.pdf');
  }

  static Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
