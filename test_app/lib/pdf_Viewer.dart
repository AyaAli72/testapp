import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  PdfControllerPinch? _pdfController;
  bool _isLoading = true;
  int _totalPages = 0;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final document = await PdfDocument.openAsset('assets/pdf/pdf1.pdf');

      _pdfController = PdfControllerPinch(
        document: PdfDocument.openAsset('assets/pdf/pdf1.pdf'),
      );

      _totalPages = document.pagesCount;

      _pdfController!.addListener(() {
        final page = _pdfController!.page;
        if (page != null) {
          final newPage = page.floor() + 1;
          if (newPage != _currentPage) {
            setState(() {
              _currentPage = newPage;
            });
          }
        }
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading PDF: $e');
    }
  }

  Future<void> navigateToPage(int pageNumber) async {
    if (_pdfController == null) return;

    if (pageNumber < 1 || pageNumber > _totalPages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Page number must be between 1 and $_totalPages'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _pdfController!.jumpToPage(pageNumber - 1);

    setState(() {
      _currentPage = pageNumber;
    });
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        PdfViewPinch(controller: _pdfController!),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$_currentPage / $_totalPages',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
