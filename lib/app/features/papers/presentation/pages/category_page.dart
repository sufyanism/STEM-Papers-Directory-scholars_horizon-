import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scholars_horizon/app/core/theme/theme_provider.dart';
import 'package:scholars_horizon/app/features/papers/presentation/pages/papers_page.dart';

class BiologyCategoryPage extends ConsumerWidget {
  const BiologyCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    /// ✅ UI Categories
    final categories = [
      {
        "title": "Molecular Biology",
        "code": "bio.MB",
        "arxiv": "q-bio.BM",
        "icon": Icons.biotech,
        "color": Colors.green
      },
      {
        "title": "Genetics",
        "code": "bio.GN",
        "arxiv": "q-bio.GN",
        "icon": Icons.science,
        "color": Colors.purple
      },
      {
        "title": "Cell Biology",
        "code": "bio.CB",
        "arxiv": "q-bio.CB",
        "icon": Icons.grid_view,
        "color": Colors.blue
      },
      {
        "title": "Microbiology",
        "code": "bio.MC",
        "arxiv": "q-bio.MN",
        "icon": Icons.bubble_chart,
        "color": Colors.teal
      },
      {
        "title": "Neuroscience",
        "code": "bio.NS",
        "arxiv": "q-bio.NC",
        "icon": Icons.psychology,
        "color": Colors.indigo
      },
      {
        "title": "Ecology",
        "code": "bio.EC",
        "arxiv": "q-bio.EC",
        "icon": Icons.public,
        "color": Colors.lightGreen
      },
      {
        "title": "Biotechnology",
        "code": "bio.BT",
        "arxiv": "q-bio.QM",
        "icon": Icons.precision_manufacturing,
        "color": Colors.orange
      },
      {
        "title": "Immunology",
        "code": "bio.IM",
        "arxiv": "q-bio.IM",
        "icon": Icons.health_and_safety,
        "color": Colors.red
      },
      {
        "title": "Bioinformatics",
        "code": "bio.BI",
        "arxiv": "q-bio.QM",
        "icon": Icons.computer,
        "color": Colors.cyan
      },
      {
        "title": "Zoology",
        "code": "bio.ZO",
        "arxiv": "q-bio.PE",
        "icon": Icons.pets,
        "color": Colors.brown
      },
      {
        "title": "Botany",
        "code": "bio.BO",
        "arxiv": "q-bio.PE",
        "icon": Icons.local_florist,
        "color": Colors.green
      },
      {
        "title": "Evolution",
        "code": "bio.EV",
        "arxiv": "q-bio.PE",
        "icon": Icons.timeline,
        "color": Colors.deepPurple
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          "Browse Biology",
          style: theme.textTheme.titleLarge?.copyWith(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
          ),
        ),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(width * 0.04),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(height: height * 0.015),
        itemBuilder: (context, index) {
          final item = categories[index];
          return _categoryTile(
            context,
            width: width,
            height: height,
            title: item["title"] as String,
            code: item["code"] as String,
            arxivCode: item["arxiv"] as String,
            icon: item["icon"] as IconData,
            color: item["color"] as Color,
            theme: theme,
            isDark: isDark,
          );
        },
      ),
    );
  }

  /// ================= CATEGORY TILE =================
  Widget _categoryTile(
      BuildContext context, {
        required double width,
        required double height,
        required String title,
        required String code,
        required String arxivCode,
        required IconData icon,
        required Color color,
        required ThemeData theme,
        required bool isDark,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(width * 0.04),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PapersPage(
              title: title,
              category: arxivCode,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// ICON
            Container(
              padding: EdgeInsets.all(width * 0.025),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              child: Icon(
                icon,
                color: color,
                size: width * 0.055,
              ),
            ),

            SizedBox(width: width * 0.04),

            /// TEXT
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "$title ",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.04,
                  ),
                  children: [
                    TextSpan(
                      text: "($code)",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
              size: width * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}