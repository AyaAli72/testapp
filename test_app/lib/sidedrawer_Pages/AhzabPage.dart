import 'package:flutter/material.dart';

class AhzabPage extends StatefulWidget {
  const AhzabPage({super.key});

  @override
  State<AhzabPage> createState() => _AhzabPageState();
}

class _AhzabPageState extends State<AhzabPage> {
  // Quran Hizb data (60 Hizb)
  final List<Map<String, dynamic>> _quranAhzab = List.generate(60, (index) {
    final hizbNumber = index + 1;
    return {
      'id': hizbNumber,
      'name': 'الحزب ${_arabicNumber(hizbNumber)}',
      'juz': _getJuzForHizb(hizbNumber),
      'pages': _getPagesForHizb(hizbNumber),
      'description': _getHizbDescription(hizbNumber),
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

  // Helper function to get Juz for Hizb
  static int _getJuzForHizb(int hizbNumber) {
    // Each Juz has 2 Hizb
    return ((hizbNumber + 1) ~/ 2).ceil();
  }

  // Helper function to get pages for Hizb
  static String _getPagesForHizb(int hizbNumber) {
    // Each Hizb is approximately 10 pages in the standard Quran
    final startPage = ((hizbNumber - 1) * 10) + 1;
    final endPage = startPage + 9;
    return '$startPage - $endPage';
  }

  // Helper function to get Hizb description
  static String _getHizbDescription(int hizbNumber) {
    final juz = _getJuzForHizb(hizbNumber);
    final isFirstHizb = hizbNumber % 2 == 1;
    final position = isFirstHizb ? 'النصف الأول' : 'النصف الثاني';
    return 'الجزء $juz - $position';
  }

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredAhzab = [];

  @override
  void initState() {
    super.initState();
    _filteredAhzab = List.from(_quranAhzab);
  }

  void _filterAhzab(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAhzab = List.from(_quranAhzab);
      } else {
        _filteredAhzab = _quranAhzab
            .where((hizb) =>
                hizb['name'].contains(query) ||
                hizb['id'].toString().contains(query) ||
                hizb['description'].contains(query))
            .toList();
      }
    });
  }

  void _navigateToHizbDetails(Map<String, dynamic> hizb) {
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
              hizb['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 54, 53, 57),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildDetailRow('رقم الحزب:', '${hizb['id']}'),
              _buildDetailRow('الجزء:', '${hizb['juz']}'),
              _buildDetailRow('الصفحات:', hizb['pages']),
              _buildDetailRow('الوصف:', hizb['description']),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 166, 165, 169),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to reading page
                        _showReadingOptions(hizb);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 72, 70, 76),
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
                          'الحزب ${hizb['id']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 42, 41, 45),
                          ),
                        ),
                        Text(
                          'من ٦٠',
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 39, 38, 41),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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

  void _showReadingOptions(Map<String, dynamic> hizb) {
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
              'خيارات القراءة - ${hizb['name']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildReadingOption(
              icon: Icons.picture_as_pdf,
              title: 'قراءة PDF',
              subtitle: 'فتح نسخة PDF من المصحف',
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
            color: const Color.fromARGB(255, 150, 148, 154),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color.fromARGB(255, 66, 64, 69)),
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
            "أحزاب القرآن الكريم",
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
                    AhzabSearchDelegate(_quranAhzab, _navigateToHizbDetails),
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
              onChanged: _filterAhzab,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                hintText: 'ابحث عن حزب...',
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _filterAhzab('');
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
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 73, 71, 77), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              cursorColor: Color.fromARGB(255, 94, 92, 98),
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
                  'عدد الأحزاب: ${_filteredAhzab.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  'الحزب',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Ahzab List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredAhzab.length,
              itemBuilder: (context, index) {
                final hizb = _filteredAhzab[index];
                final hizbNumber = hizb['id'];
                final juz = hizb['juz'];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 173, 169, 177),
                            Color.fromARGB(255, 105, 102, 111),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 144, 139, 152),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$hizbNumber',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 119, 116, 124),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      hizb['name'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الجزء $juz',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            hizb['pages'],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 172, 170, 176),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        hizbNumber % 2 == 0 ? 'الثاني' : 'الأول',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 129, 127, 133),
                        ),
                      ),
                    ),
                    onTap: () => _navigateToHizbDetails(hizb),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Search Delegate for Ahzab
class AhzabSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> ahzab;
  final Function(Map<String, dynamic>) onHizbSelected;

  AhzabSearchDelegate(this.ahzab, this.onHizbSelected);

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
    final results = ahzab
        .where((hizb) =>
            hizb['name'].contains(query) ||
            hizb['id'].toString().contains(query) ||
            hizb['description'].contains(query))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final hizb = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 143, 140, 147),
              child: Text(
                '${hizb['id']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 150, 148, 154),
                ),
              ),
            ),
            title: Text(
              hizb['name'],
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              hizb['description'],
              textAlign: TextAlign.right,
            ),
            trailing: const Icon(Icons.arrow_back_ios, size: 16),
            onTap: () {
              onHizbSelected(hizb);
              close(context, hizb['name']);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? ahzab.take(10).toList()
        : ahzab
            .where((hizb) =>
                hizb['name'].contains(query) ||
                hizb['id'].toString().contains(query) ||
                hizb['description'].contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final hizb = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 128, 126, 133),
            child: Text(
              '${hizb['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 148, 145, 152),
              ),
            ),
          ),
          title: Text(
            hizb['name'],
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            hizb['description'],
            textAlign: TextAlign.right,
          ),
          onTap: () {
            onHizbSelected(hizb);
            close(context, hizb['name']);
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
