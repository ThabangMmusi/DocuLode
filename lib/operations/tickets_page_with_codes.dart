import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

const PdfColor red = PdfColor.fromInt(0xFF000000);
const PdfColor white = PdfColor.fromInt(0xFFFFffff);
const PdfColor lightGreen = PdfColor.fromInt(0xFFFFBDBD);
const sep = 120.0;
Future<Uint8List> generateMembershipFormFilled(List<String> data,
    String docName, String tType, Uint8List ticketPath) async {
  final doc = Document(title: docName, author: 'Rich Visual Art Pty Ltd');
  const PdfPageFormat format = PdfPageFormat.a4;
  // String bgTicket(String type) {
  //   String value = '';
  //   if (type == 'VIP') {
  //     value = 'assets/tickets_bg_vip.png';
  //   } else if (type == 'General') {
  //     value = 'assets/tickets_bg_dnw_gen.png';
  //   } else {
  //     value = 'assets/tickets_bg_dnw_eb.png';
  //   }

  //   return value;
  // }

  // final bg = pw.MemoryImage(
  //   (await rootBundle.load(bgTicket(tType))).buffer.asUint8List(),
  // );

  // final pageTheme = await _myPageTheme(format);
  final bg = pw.MemoryImage(ticketPath);
  doc.addPage(
    pw.MultiPage(
      maxPages: 50,
      pageTheme: pw.PageTheme(
        pageFormat: format.copyWith(
            marginBottom: 0, marginLeft: 0, marginRight: 0, marginTop: 0),
      ),
      build: (pw.Context context) => [
        pw.GridView(
            padding: const pw.EdgeInsets.all(16),
            crossAxisCount: 2,
            childAspectRatio: 0.478,
            children: data
                .map((e) => pw.Container(
                      decoration: pw.BoxDecoration(
                        image: DecorationImage(image: bg, fit: BoxFit.contain),
                      ),
                      child: pw.Row(children: [
                        //?ticket no on top of barcode
                        pw.Transform.rotateBox(
                          angle: 1.571,
                          child: pw.Container(
                              margin: const pw.EdgeInsets.only(
                                  bottom: 20, left: 28, top: 8),
                              padding: const pw.EdgeInsets.fromLTRB(4, 4, 4, 3),
                              child: pw.Column(children: [
                                pw.Text(
                                  "Ticket No.",
                                  style: const pw.TextStyle(fontSize: 7),
                                ),
                                pw.Text(
                                  e,
                                  style: const pw.TextStyle(fontSize: 16),
                                ),
                              ])),
                        ),
                        pw.Spacer(),
                        //?? qr code
                        pw.Column(children: [
                          pw.Spacer(),
                          pw.BarcodeWidget(
                            color: red,
                            margin: const pw.EdgeInsets.only(
                                left: 5, bottom: 5, top: 20),
                            // decoration: const pw.BoxDecoration(
                            //   color: white,
                            // ),
                            padding: const pw.EdgeInsets.fromLTRB(4, 8, 10, 7),
                            data: e,
                            width: 60,
                            height: 60,
                            barcode: pw.Barcode.qrCode(),
                            // drawText: false,
                          ),
                        ])
                        //?ticket no on top of barcode
                        //? front ui shuffle
                        // pw.Spacer(),
                        // pw.Container(
                        //     margin: const pw.EdgeInsets.only(bottom: 20),
                        //     padding:
                        //         const pw.EdgeInsets.fromLTRB(4, 4, 4, 3),
                        //     color: white,
                        //     child: pw.Text("TICKET #" + e,
                        //         style: const pw.TextStyle(fontSize: 6)))
                        //?back ui shuffle
                        //   pw.Container(
                        //       margin: const pw.EdgeInsets.only(left: 20),
                        //       padding: const pw.EdgeInsets.fromLTRB(
                        //           10, 40, 10, 36),
                        //       decoration: pw.BoxDecoration(
                        //         color: white,
                        //         border: pw.Border.all(width: 2),
                        //       ),
                        //       child: pw.Text("TICKET #" + e,
                        //           style: const pw.TextStyle(fontSize: 16))),
                        //   pw.Spacer(),
                        //   pw.Container(
                        //       margin: const pw.EdgeInsets.only(right: 20),
                        //       padding: const pw.EdgeInsets.fromLTRB(
                        //           10, 40, 10, 36),
                        //       decoration: pw.BoxDecoration(
                        //         color: white,
                        //         border: pw.Border.all(width: 2),
                        //       ),
                        //       child: pw.Text("TICKET #" + e,
                        //           style: const pw.TextStyle(fontSize: 16)))
                      ]),
                    ))
                .toList()),
      ],
    ),
  );
  doc.addPage(
    pw.MultiPage(
      maxPages: 50,
      pageTheme: pw.PageTheme(
        pageFormat: format.copyWith(
            marginBottom: 0, marginLeft: 0, marginRight: 0, marginTop: 0),
      ),
      build: (pw.Context context) => [
        pw.GridView(
            padding: const pw.EdgeInsets.all(16),
            crossAxisCount: 4,
            childAspectRatio: 0.478,
            children: data
                .map((e) => pw.Container(
                    decoration: pw.BoxDecoration(
                      color: white,
                      border: pw.Border.all(width: 2),
                    ),
                    child: pw.Center(
                        child: pw.Text("Ticket #" + e,
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)))))
                .toList()),
      ],
    ),
  );
  return doc.save();
}
