import 'package:flutter/material.dart';

class ArbaPage extends StatefulWidget {
  const ArbaPage({super.key});

  @override
  State<ArbaPage> createState() => _ArbaPageState();
}

class _ArbaPageState extends State<ArbaPage> {
  // Quran Quarters (Rub') data - 240 quarters total
  final List<Map<String, dynamic>> _quranArba = List.generate(240, (index) {
    final quarterNumber = index + 1;
    return {
      'id': quarterNumber,
      'name': 'الربع ${_arabicNumber(quarterNumber)}',
      'hizb': _getHizbForQuarter(quarterNumber),
      'juz': _getJuzForQuarter(quarterNumber),
      'position': _getQuarterPosition(quarterNumber),
      'description': _getQuarterDescription(quarterNumber),
      'pages': _getPagesForQuarter(quarterNumber),
    };
  });

  // Helper function to get Arabic number
  static String _arabicNumber(int number) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((digit) => arabicNumbers[int.parse(digit)])
        .join('');
  }

  // Helper function to get Hizb for quarter (each Hizb has 4 quarters)
  static int _getHizbForQuarter(int quarterNumber) {
    return ((quarterNumber + 3) ~/ 4).ceil();
  }

  // Helper function to get Juz for quarter
  static int _getJuzForQuarter(int quarterNumber) {
    // Each Juz has 8 quarters (2 Hizb × 4 quarters)
    return ((quarterNumber + 7) ~/ 8).ceil();
  }

  // Helper function to get quarter position within Hizb
  static String _getQuarterPosition(int quarterNumber) {
    final positionInHizb = ((quarterNumber - 1) % 4) + 1;
    final positions = ['الأول', 'الثاني', 'الثالث', 'الرابع'];
    return positions[positionInHizb - 1];
  }

  // Helper function to get quarter description
  static String _getQuarterDescription(int quarterNumber) {
    final juz = _getJuzForQuarter(quarterNumber);
    final hizb = _getHizbForQuarter(quarterNumber);
    final position = _getQuarterPosition(quarterNumber);
    return 'الجزء $juz - الحزب $hizb - $position';
  }

  // Helper function to get pages for quarter (approximately 2.5 pages each)
  static String _getPagesForQuarter(int quarterNumber) {
    final startPage = ((quarterNumber - 1) * 2.5).ceil() + 1;
    final endPage = startPage + 2;
    return '$startPage - ${endPage < 604 ? endPage : 604}';
  }

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredArba = [];

  @override
  void initState() {
    super.initState();
    _filteredArba = List.from(_quranArba);
  }

  void _filterArba(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredArba = List.from(_quranArba);
      } else {
        _filteredArba = _quranArba
            .where((quarter) =>
                quarter['name'].contains(query) ||
                quarter['id'].toString().contains(query) ||
                quarter['description'].contains(query))
            .toList();
      }
    });
  }

  void _navigateToQuarterDetails(Map<String, dynamic> quarter) {
    // Show details dialog
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: Text(
              quarter['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDetailRow('رقم الربع:', '${quarter['id']}'),
                _buildDetailRow('الجزء:', '${quarter['juz']}'),
                _buildDetailRow('الحزب:', '${quarter['hizb']}'),
                _buildDetailRow('الموقع:', quarter['position']),
                _buildDetailRow('الصفحات:', quarter['pages']),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showReadingOptions(quarter);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.menu_book, color: Colors.white),
                        label: const Text(
                          'قراءة',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الربع ${quarter['id']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          Text(
                            'من ٢٤٠',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.indigo.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        ),
      ),
    );
  }

  void _showReadingOptions(Map<String, dynamic> quarter) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'قراءة ${quarter['name']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildReadingOption(
              icon: Icons.picture_as_pdf,
              title: 'قراءة PDF',
              subtitle: 'فتح نسخة PDF للمصحف',
              onTap: () {
                Navigator.pop(context);
                // Open PDF
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
              ),
              child: const Text('إلغاء'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.indigo),
        ),
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          textAlign: TextAlign.right,
        ),
        trailing: const Icon(Icons.arrow_back_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(
            "أرباع القرآن الكريم",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    ArbaSearchDelegate(_quranArba, _navigateToQuarterDetails),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterArba,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                hintText: 'ابحث عن ربع...',
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _filterArba('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.indigo, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              cursorColor: Colors.indigo,
              enableSuggestions: true,
              autocorrect: true,
            ),
          ),

          // Counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عدد الأرباع: ${_filteredArba.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  'الربع',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Arba List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredArba.length,
              itemBuilder: (context, index) {
                final quarter = _filteredArba[index];
                final quarterNumber = quarter['id'];
                final juz = quarter['juz'];
                final hizb = quarter['hizb'];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo.shade100,
                            Colors.indigo.shade200,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$quarterNumber',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      quarter['name'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الجزء $juz - الحزب $hizb',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            quarter['pages'],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        quarter['position'],
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                    onTap: () => _navigateToQuarterDetails(quarter),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Info
    );
  }
}

// Custom Search Delegate for Arba
class ArbaSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> arba;
  final Function(Map<String, dynamic>) onQuarterSelected;

  ArbaSearchDelegate(this.arba, this.onQuarterSelected);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = arba
        .where((quarter) =>
            quarter['name'].contains(query) ||
            quarter['id'].toString().contains(query) ||
            quarter['description'].contains(query))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final quarter = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                '${quarter['id']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            title: Text(
              quarter['name'],
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              quarter['description'],
              textAlign: TextAlign.right,
            ),
            trailing: const Icon(Icons.arrow_back_ios, size: 16),
            onTap: () {
              onQuarterSelected(quarter);
              close(context, quarter['name']);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? arba.take(10).toList()
        : arba
            .where((quarter) =>
                quarter['name'].contains(query) ||
                quarter['id'].toString().contains(query) ||
                quarter['description'].contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final quarter = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigo.shade100,
            child: Text(
              '${quarter['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          title: Text(
            quarter['name'],
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            quarter['description'],
            textAlign: TextAlign.right,
          ),
          onTap: () {
            onQuarterSelected(quarter);
            close(context, quarter['name']);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
