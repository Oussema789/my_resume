import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;
import 'dart:math' as math;

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN TOKENS
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  static const navy = Color(0xFF0A0F1E);
  static const navyMid = Color(0xFF111827);
  static const accent = Color(0xFF3B6EF8);
  static const accentLight = Color(0xFF6B93FF);
  static const accentGlow = Color(0x333B6EF8);
  static const surface = Color(0xFFF7F8FC);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const text = Color(0xFF0A0F1E);
  static const textSub = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const gold = Color(0xFFE8C84A);
  static const teal = Color(0xFF10B981);
}

class AppTextStyles {
  static TextStyle display(double size) => GoogleFonts.dmSerifDisplay(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.1,
  );

  static TextStyle heading(double size) => GoogleFonts.bricolageGrotesque(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.2,
  );

  static TextStyle body(double size) =>
      GoogleFonts.inter(fontSize: size, color: AppColors.textSub, height: 1.6);

  static TextStyle label(double size) => GoogleFonts.inter(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    letterSpacing: 0.3,
  );

  static TextStyle mono(double size) => GoogleFonts.jetBrainsMono(
    fontSize: size,
    color: AppColors.accent,
    letterSpacing: -0.5,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// APP ROOT
// ─────────────────────────────────────────────────────────────────────────────
class PortfolioWebsite extends StatefulWidget {
  const PortfolioWebsite({super.key});

  @override
  State<PortfolioWebsite> createState() => _PortfolioWebsiteState();
}

class _PortfolioWebsiteState extends State<PortfolioWebsite>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _languagesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _certificatesKey = GlobalKey();
  final GlobalKey _powerbiKey = GlobalKey();
  final GlobalKey _workshopsKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _powerbiImages = [
    'assets/dashboard/dashboard_1.jpg',
    'assets/dashboard/dashboard_2.jpg',
    'assets/dashboard/dashboard_3.jpg',
    'assets/dashboard/dashboard_4.jpg',
  ];
  final List<String> _workshopImages = [
    'assets/workshop/workshop1.jpg',
    'assets/workshop/workshop2.jpg',
    'assets/workshop/workshop3.jpg',
  ];
  final List<String> _certificateImages = [
    'assets/certificates/cert1.jpg',
    'assets/certificates/cert2.jpg',
    'assets/certificates/cert3.jpg',
    'assets/certificates/cert4.jpg',
    'assets/certificates/cert5.jpg',
    'assets/certificates/cert6.jpg',
    'assets/certificates/cert7.jpg',
  ];

  int _currentCarouselIndex = 0;
  int _currentPowerBIIndex = 0;
  int _currentWorkshopIndex = 0;

  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 200 &&
        !_fabController.isForwardOrCompleted) {
      _fabController.forward();
    } else if (_scrollController.offset <= 200 &&
        _fabController.isForwardOrCompleted) {
      _fabController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _scrollToTop();
    }
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(ctx!).pop();
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _downloadCV() async {
    const cvUrl = '/assets/Oussema_KHELIFI_Resume.pdf';
    final Uri uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final anchor = html.AnchorElement(href: cvUrl)
        ..setAttribute('download', 'Oussema_KHELIFI_Resume.pdf')
        ..click();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oussema Khelifi | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(),
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(child: _buildResponsiveNavBar()),
                  SliverToBoxAdapter(child: _buildHeroSection()),
                  SliverToBoxAdapter(child: _buildServicesSection()),
                  SliverToBoxAdapter(child: _buildEducationSection()),
                  SliverToBoxAdapter(child: _buildExperienceSection()),
                  SliverToBoxAdapter(child: _buildProjectsSection()),
                  SliverToBoxAdapter(child: _buildSkillsSectionCompact()),
                  SliverToBoxAdapter(child: _buildLanguagesSection()),
                  SliverToBoxAdapter(child: _buildPowerBISection()),
                  SliverToBoxAdapter(child: _buildWorkshopsSection()),
                  SliverToBoxAdapter(child: _buildCertificatesSection()),
                  SliverToBoxAdapter(child: _buildFooter()),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ScaleTransition(
          scale: _fabController,
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            tooltip: 'Back to top',
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            elevation: 6,
            child: const Icon(Icons.arrow_upward_rounded, size: 20),
          ),
        ),
      ),
    );
  }

  // ─── DRAWER ────────────────────────────────────────────────────────────────
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.navy,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accent, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Oussema KHELIFI',
                  style: AppTextStyles.label(18).copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Industrial Systems Engineer',
                  style: AppTextStyles.body(12).copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
          ...[
            ('Home', _heroKey, Icons.home_rounded),
            ('Services', _servicesKey, Icons.work_rounded),
            ('Education', _educationKey, Icons.school_rounded),
            ('Experience', _experienceKey, Icons.business_center_rounded),
            ('Projects', _projectsKey, Icons.code_rounded),
            ('Skills', _skillsKey, Icons.build_rounded),
            ('Contact', _contactKey, Icons.contact_mail_rounded),
          ].map((item) => _buildDrawerItem(item.$1, item.$2, item.$3)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, GlobalKey key, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentLight, size: 20),
      title: Text(
        title,
        style: AppTextStyles.body(14).copyWith(color: Colors.white70),
      ),
      onTap: () => _scrollToSection(key),
    );
  }

  // ─── NAVBAR ────────────────────────────────────────────────────────────────
  Widget _buildResponsiveNavBar() {
    return ScreenTypeLayout(
      mobile: _buildMobileNavBar(),
      desktop: _buildDesktopNavBar(),
    );
  }

  Widget _buildMobileNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      color: AppColors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'OK',
                  style: AppTextStyles.mono(
                    20,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: '.',
                  style: AppTextStyles.mono(20).copyWith(color: AppColors.gold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.navy,
              size: 24,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
      color: AppColors.surface,
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'OK',
                  style: AppTextStyles.mono(
                    18,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: '.',
                  style: AppTextStyles.mono(18).copyWith(color: AppColors.gold),
                ),
              ],
            ),
          ),
          const Spacer(),
          ...[
            ('Home', _heroKey),
            ('Services', _servicesKey),
            ('Education', _educationKey),
            ('Experience', _experienceKey),
            ('Projects', _projectsKey),
            ('Skills', _skillsKey),
            ('Contact', _contactKey),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 36),
              child: _buildNavItem(item.$1, item.$2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, GlobalKey key) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection(key),
        child: Text(
          title,
          style: AppTextStyles.label(14).copyWith(color: AppColors.textSub),
        ),
      ),
    );
  }

  // ─── HERO ──────────────────────────────────────────────────────────────────
  Widget _buildHeroSection() {
    return Container(
      key: _heroKey,
      color: AppColors.surface,
      child: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          final isDesktop =
              sizingInfo.deviceScreenType == DeviceScreenType.desktop;
          return isDesktop ? _buildDesktopHero() : _buildMobileHero();
        },
      ),
    );
  }

  Widget _buildDesktopHero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(64, 80, 64, 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: _buildHeroText()),
          const SizedBox(width: 80),
          Expanded(flex: 4, child: _buildHeroImageDesktop()),
        ],
      ),
    );
  }

  Widget _buildMobileHero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
      child: Column(
        children: [
          _buildHeroImageMobile(),
          const SizedBox(height: 48),
          _buildHeroText(),
        ],
      ),
    );
  }

  Widget _buildHeroImageDesktop() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (context, v, child) =>
          Transform.scale(scale: 0.7 + 0.3 * v, child: child),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative rings
          Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withOpacity(0.12),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          // Glow
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.accentGlow, Colors.transparent],
              ),
            ),
          ),
          // Photo
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.25),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
          ),
          // Floating badge
          Positioned(
            bottom: 60,
            right: 30,
            child: _buildFloatingBadge(
              'Quality\nEngineer',
              Icons.verified_rounded,
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: _buildFloatingBadge('Flutter\nDev', Icons.code_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImageMobile() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, v, child) =>
          Transform.scale(scale: 0.7 + 0.3 * v, child: child),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.accent, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.2),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: const CircleAvatar(
          radius: 90,
          backgroundImage: AssetImage('assets/profile.png'),
        ),
      ),
    );
  }

  Widget _buildFloatingBadge(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.accent),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.label(
              11,
            ).copyWith(color: AppColors.navy, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, v, child) => Opacity(opacity: v, child: child),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentGlow,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.teal,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for new opportunities',
                  style: AppTextStyles.label(
                    12,
                  ).copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Oussema\nKHELIFI',
            style: AppTextStyles.display(
              64,
            ).copyWith(color: AppColors.navy, letterSpacing: -1.5),
          ),
          const SizedBox(height: 20),
          Text(
            'Industrial Systems Engineer crafting\nsmarter factories & digital solutions.',
            style: AppTextStyles.body(
              18,
            ).copyWith(color: AppColors.textSub, height: 1.6),
          ),
          const SizedBox(height: 16),
          // Specialties inline
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSpecialtyChip('Quality Engineering'),
              _buildSpecialtyChip('Flutter Dev'),
              _buildSpecialtyChip('Lean Six Sigma'),
              _buildSpecialtyChip('Power BI'),
            ],
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildPrimaryButton(
                'Download CV',
                Icons.download_rounded,
                _downloadCV,
              ),
              _buildSecondaryButton(
                'Contact Me',
                Icons.arrow_forward_rounded,
                () => _scrollToSection(_contactKey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        label,
        style: AppTextStyles.label(11).copyWith(color: AppColors.textSub),
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                text,
                style: AppTextStyles.label(15).copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: AppTextStyles.label(15).copyWith(color: AppColors.text),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: AppColors.accent, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SECTION HEADER ────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String eyebrow, String title, String subtitle) {
    return Column(
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: AppTextStyles.mono(12).copyWith(letterSpacing: 2),
        ),
        const SizedBox(height: 12),
        Text(title, style: AppTextStyles.display(40)),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: AppTextStyles.body(16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ─── SERVICES ──────────────────────────────────────────────────────────────
  Widget _buildServicesSection() {
    return AnimatedSection(
      key: _servicesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(
              'what i do',
              'Services',
              'Transforming industrial challenges into streamlined solutions',
            ),
            const SizedBox(height: 64),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                int cols =
                    sizingInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 3
                    : sizingInfo.deviceScreenType == DeviceScreenType.tablet
                    ? 2
                    : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cols,
                  childAspectRatio: cols == 1 ? 1.4 : 0.95,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildServiceCard(
                      icon: Icons.search_rounded,
                      title: 'Research & Strategy',
                      description:
                          'Data-driven analysis, process optimization, and strategic planning for operational excellence.',
                      index: 0,
                    ),
                    _buildServiceCard(
                      icon: Icons.code_rounded,
                      title: 'Development Solutions',
                      description:
                          'Custom Flutter apps, automation tools, and digital transformation to modernize workflows.',
                      index: 1,
                    ),
                    _buildServiceCard(
                      icon: Icons.engineering_rounded,
                      title: 'Quality & Excellence',
                      description:
                          'Lean Six Sigma, PPAP, FMEA, and operational excellence frameworks for continuous improvement.',
                      index: 2,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static const List<Color> _serviceAccents = [
    AppColors.accent,
    AppColors.teal,
    AppColors.gold,
  ];

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required int index,
  }) {
    final accent = _serviceAccents[index % _serviceAccents.length];
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: accent),
          ),
          const SizedBox(height: 24),
          Text(title, style: AppTextStyles.heading(20)),
          const SizedBox(height: 12),
          Text(description, style: AppTextStyles.body(14)),
        ],
      ),
    );
  }

  // ─── EDUCATION ─────────────────────────────────────────────────────────────
  Widget _buildEducationSection() {
    return AnimatedSection(
      key: _educationKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader(
              'background',
              'Education',
              'Academic background and specialized training',
            ),
            const SizedBox(height: 64),
            Column(
              children: [
                _buildEducationItem(
                  degree:
                      'National Diploma of Engineer in Advanced Technologies',
                  institution:
                      'National School of Advanced Sciences and Technologies of Borj Cedria, University of Carthage',
                  period: '2020 – 2023',
                  description:
                      'Specialized in Industrial Systems & Competitivity',
                  isFirst: true,
                ),
                _buildEducationItem(
                  degree:
                      'Preparatory Cycle for Engineering Studies — Mathematics & Physics',
                  institution:
                      'Faculty of Sciences of Tunis, University of Tunis El Manar',
                  period: '2018 – 2020',
                  description:
                      'Intensive two-year program in mathematics, physics, and fundamental engineering sciences.',
                ),
                _buildEducationItem(
                  degree: 'Baccalaureate in Experimental Sciences',
                  institution: 'Khaled Ibn El Walid High School',
                  period: '2018',
                  description: 'High school diploma in experimental sciences.',
                  isLast: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String institution,
    required String period,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFirst ? AppColors.accent : AppColors.divider,
                  border: Border.all(
                    color: isFirst ? AppColors.accent : AppColors.textMuted,
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: AppColors.divider,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(degree, style: AppTextStyles.heading(18)),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentGlow,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          period,
                          style: AppTextStyles.label(
                            12,
                          ).copyWith(color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    institution,
                    style: AppTextStyles.body(
                      14,
                    ).copyWith(color: AppColors.accent),
                  ),
                  const SizedBox(height: 8),
                  Text(description, style: AppTextStyles.body(14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── EXPERIENCE ────────────────────────────────────────────────────────────
  Widget _buildExperienceSection() {
    return AnimatedSection(
      key: _experienceKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(
              'track record',
              'Professional Experience',
              'A history of delivering impactful results',
            ),
            const SizedBox(height: 64),
            Column(
              children: [
                _buildExperienceItem(
                  title: 'Management Controller',
                  company: 'Adwya - KILANI Group',
                  period: 'Jan 2025 – Aug 2025',
                  description:
                      '• Prepared monthly reports monitoring raw materials near expiry and inactive stocks, evaluating and deciding on retention or destruction.\n'
                      '• Developed and implemented an action plan to liquidate inactive stocks in collaboration with Methods and Logistics, integrating RM&P materials into the MPS.\n'
                      '• Monitored OPEX budgets across departments, identified and justified variances, and validated supplier invoices via Sage X3 to protect product margins.\n'
                      '• Ensured validation of forwarding agent files, conducted physical inventories, adjusted stocks with appropriate justifications, and analyzed stock discrepancies.',
                  tags: [
                    'Sage X3',
                    'Power BI',
                    'Excel',
                    'Financial Analysis',
                    'Inventory Management',
                  ],
                ),
                _buildExperienceItem(
                  title: 'Project Quality Engineer',
                  company: 'MISTA Tunisia',
                  period: 'Mar 2024 – Jan 2025',
                  description:
                      '• Analyzed customer quality manuals to ensure full compliance, prepared PPAP files, and organized customer audits to secure PSW/ISIR signatures.\n'
                      '• Led QRQC/QRAP routines to identify root causes, deploy corrective actions, and monitor effectiveness, while implementing FMEA and Control Plans.\n'
                      '• Developed a VBA solution for automatic duplicate QR code detection (scanner + visual alerts) following a Valeo complaint.\n'
                      '• Prepared and passed a VDA 6.3 process audit for a BMW project with a 90% score, enabling ISR signature and series production start-up.',
                  tags: [
                    'PPAP',
                    'FMEA',
                    'VDA 6.3',
                    '8D',
                    'VBA',
                    'QRQC',
                    'IATF 16949',
                  ],
                ),
                _buildExperienceItem(
                  title: 'Flutter Developer',
                  company: 'Zodiac Nautic',
                  period: 'Jul 2023 – Nov 2023',
                  description:
                      '• Developed an AI-based maintenance application with Flutter (frontend) and Flask (backend) to optimize efficiency of maintenance personnel.\n'
                      '• Designed an automation feature to generate Excel files related to preventive maintenance, reducing manual effort.\n'
                      '• Implemented two distinct interfaces: administrators (monitoring, updating) and operators (paperless checks, real-time assistance).',
                  tags: ['Flutter', 'Flask', 'AI', 'Excel Automation', 'LLM'],
                ),
                _buildExperienceItem(
                  title: 'Flutter Developer',
                  company: 'Smart Solutions Consulting',
                  period: 'Jul 2022 – Aug 2022',
                  description:
                      '• Built a corporate showcase website using Flutter Web presenting the company\'s Lean Management and Six Sigma training activities.\n'
                      '• Designed a responsive, intuitive interface and deployed it online via Vercel.',
                  tags: ['Flutter', 'Responsive Design', 'Vercel'],
                  isLast: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceItem({
    required String title,
    required String company,
    required String period,
    required String description,
    required List<String> tags,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: AppColors.divider,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: AppTextStyles.heading(20)),
                              const SizedBox(height: 4),
                              Text(
                                company,
                                style: AppTextStyles.label(
                                  14,
                                ).copyWith(color: AppColors.accent),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGlow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            period,
                            style: AppTextStyles.label(
                              11,
                            ).copyWith(color: AppColors.accent),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(description, style: AppTextStyles.body(14)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: Text(
                                tag,
                                style: AppTextStyles.label(
                                  11,
                                ).copyWith(color: AppColors.textSub),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── PROJECTS ──────────────────────────────────────────────────────────────
  Widget _buildProjectsSection() {
    final List<Project> projects = [
      Project(
        id: 'vsm_generator',
        name: 'Intelligent VSM Generator',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/vsm_generator/vsm1.jpg',
        additionalImagePaths: [
          'assets/apps/vsm_generator/vsm1.jpg',
          'assets/apps/vsm_generator/vsm2.jpg',
          'assets/apps/vsm_generator/vsm3.jpg',
        ],
        tasks: const [
          'Automated Value Stream Mapping creation and analysis with AI-generated improvement recommendations via OpenRouter API.',
          'Integrated Lean calculations: Takt Time, Lead Time, Value-Added/Non-Value-Added ratio, plus advanced indicators (Mura, Muri, Muda, Flow Efficiency).',
          'Implemented automatic PDF export of analyses for streamlined reporting.',
        ],
        technologies: 'Flutter · OpenRouter API · Lean Manufacturing',
      ),
      Project(
        id: 'mom',
        name: '8D Problem-Solving App',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/mom/mom1.jpg',
        additionalImagePaths: [
          'assets/apps/mom/mom1.jpg',
          'assets/apps/mom/mom2.jpg',
          'assets/apps/mom/mom3.jpg',
          'assets/apps/mom/mom4.jpg',
          'assets/apps/mom/mom5.png',
        ],
        tasks: const [
          'Digitalized the 8D methodology with a guided interface to document all eight disciplines, team roles, and meeting information.',
          'Integrated root cause analysis tools: 5 Why, Ishikawa diagram, FMEA, and Fault Tree Analysis.',
          'Enabled image capture for visual evidence and automated generation of professional PDF reports.',
        ],
        technologies: 'Flutter · Quality Tools · PDF Automation',
      ),
      Project(
        id: 'supplierclaim',
        name: 'Supplier Claims Manager',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/supplierclaim/claim1.jpg',
        additionalImagePaths: [
          'assets/apps/supplierclaim/claim1.jpg',
          'assets/apps/supplierclaim/claim2.jpg',
          'assets/apps/supplierclaim/claim3.jpg',
          'assets/apps/supplierclaim/claim4.jpg',
          'assets/apps/supplierclaim/claim5.jpg',
        ],
        tasks: const [
          'Automated supplier claim generation with a structured form capturing category, supplier data, and severity level.',
          'Integrated image capture to add photographic evidence directly into the claim report.',
          'Automated PDF report generation summarizing claim details, discrepancy descriptions, and corrective action requests.',
        ],
        technologies: 'Flutter · PDF Generator · Quality Management',
      ),
      Project(
        id: 'smartInventory',
        name: 'Intelligent Inventory App',
        period: 'Feb 2026',
        mainImagePath: 'assets/apps/smartInventory/smart1.jpg',
        additionalImagePaths: [
          'assets/apps/smartInventory/smart1.jpg',
          'assets/apps/smartInventory/smart2.jpg',
          'assets/apps/smartInventory/smart3.jpg',
          'assets/apps/smartInventory/smart4.jpg',
        ],
        tasks: const [
          'Digitized warehouse management with barcode scanning to capture product labels and automatically structure data.',
          'Implemented cloud synchronization to save inventory data in Excel format with automatic quantity adjustment.',
          'Developed local database to calculate KPIs (warehouse occupancy, estimated stock cost) and automated Excel reporting.',
        ],
        technologies: 'Flutter · Excel Automation · Data Analysis',
      ),
    ];

    return AnimatedSection(
      key: _projectsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader(
              'portfolio',
              'Personal Projects',
              'Innovative tools built to solve real-world problems',
            ),
            const SizedBox(height: 64),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                int cols =
                    sizingInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 2
                    : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cols,
                  childAspectRatio: cols == 2 ? 1.1 : 1.4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: projects.map((p) => _buildProjectCard(p)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Project project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProjectDetailPage(project: project),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        project.mainImagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.accentGlow,
                          child: const Icon(
                            Icons.broken_image,
                            size: 40,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      // Overlay arrow
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            size: 16,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Info
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: AppTextStyles.heading(16),
                          ),
                        ),
                        Text(
                          project.period,
                          style: AppTextStyles.body(
                            11,
                          ).copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(project.technologies, style: AppTextStyles.mono(11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SKILLS ────────────────────────────────────────────────────────────────
  Widget _buildSkillsSectionCompact() {
    final Map<String, List<String>> skillCategories = {
      'Programming': ['Dart', 'Python', 'Java'],
      'Software & ERP': [
        'LOGIDAS',
        'CATIA',
        'Sage X3',
        'Power BI',
        'Microsoft Excel',
      ],
      'Soft Skills': [
        'Effective Communication',
        'Problem Solving',
        'Active Listening',
        'Creativity',
        'Adaptability',
      ],
      'Industrial Knowledge': [
        'Quality Management',
        'Operations Management',
        'Risk Management',
        'Lean Six Sigma',
        'Supply Chain Management',
        'QHSE',
        'ISO 9001',
        'IATF 16949',
        'VDA 6.3',
        'PPAP',
        'FMEA',
        '8D',
        'QRQC',
        'Control Plans',
        'MSA',
        'SPC',
        'GD&T',
        'Process/Product Audits',
      ],
    };

    return AnimatedSection(
      key: _skillsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(
              'expertise',
              'Skills & Knowledge',
              'Technical competencies and industrial knowledge',
            ),
            const SizedBox(height: 64),
            // Top 3 categories
            ScreenTypeLayout(
              mobile: Column(
                children: [
                  _buildSkillBlock(
                    'Programming',
                    skillCategories['Programming']!,
                  ),
                  const SizedBox(height: 20),
                  _buildSkillBlock(
                    'Software & ERP',
                    skillCategories['Software & ERP']!,
                  ),
                  const SizedBox(height: 20),
                  _buildSkillBlock(
                    'Soft Skills',
                    skillCategories['Soft Skills']!,
                  ),
                ],
              ),
              desktop: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildSkillBlock(
                      'Programming',
                      skillCategories['Programming']!,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildSkillBlock(
                      'Software & ERP',
                      skillCategories['Software & ERP']!,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildSkillBlock(
                      'Soft Skills',
                      skillCategories['Soft Skills']!,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSkillBlock(
              'Industrial Knowledge',
              skillCategories['Industrial Knowledge']!,
              accentColor: AppColors.navy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillBlock(
    String title,
    List<String> skills, {
    Color accentColor = AppColors.accent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.label(14).copyWith(color: accentColor),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills
                .map(
                  (skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Text(
                      skill,
                      style: AppTextStyles.body(
                        13,
                      ).copyWith(color: AppColors.text),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // ─── LANGUAGES ─────────────────────────────────────────────────────────────
  Widget _buildLanguagesSection() {
    return AnimatedSection(
      key: _languagesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader('communication', 'Languages', ''),
            const SizedBox(height: 48),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                final isMobile =
                    sizingInfo.deviceScreenType == DeviceScreenType.mobile;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildLanguageCard('Arabic', 'Native', '🇹🇳', isMobile),
                    _buildLanguageCard(
                      'English',
                      'Professional',
                      '🇬🇧',
                      isMobile,
                    ),
                    _buildLanguageCard(
                      'French',
                      'Professional',
                      '🇫🇷',
                      isMobile,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    String language,
    String level,
    String flag,
    bool isMobile,
  ) {
    return Container(
      width: isMobile ? 180 : 220,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(flag, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          Text(language, style: AppTextStyles.heading(18)),
          const SizedBox(height: 6),
          Text(
            level,
            style: AppTextStyles.body(13).copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }

  // ─── POWER BI ──────────────────────────────────────────────────────────────
  Widget _buildPowerBISection() {
    return AnimatedSection(
      key: _powerbiKey,
      child: _buildCarouselSection(
        eyebrow: 'data visualization',
        title: 'Power BI Dashboards',
        subtitle: 'Business intelligence projects',
        images: _powerbiImages,
        currentIndex: _currentPowerBIIndex,
        onPageChanged: (i) => setState(() => _currentPowerBIIndex = i),
        bgColor: Colors.white,
      ),
    );
  }

  Widget _buildWorkshopsSection() {
    return AnimatedSection(
      key: _workshopsKey,
      child: _buildCarouselSection(
        eyebrow: 'knowledge sharing',
        title: 'Workshops & Training',
        subtitle: 'Knowledge sharing sessions I have conducted',
        images: _workshopImages,
        currentIndex: _currentWorkshopIndex,
        onPageChanged: (i) => setState(() => _currentWorkshopIndex = i),
        bgColor: AppColors.surface,
      ),
    );
  }

  Widget _buildCertificatesSection() {
    return AnimatedSection(
      key: _certificatesKey,
      child: _buildCarouselSection(
        eyebrow: 'achievements',
        title: 'Certifications & Awards',
        subtitle:
            'Professional recognitions and continuous learning milestones',
        images: _certificateImages,
        currentIndex: _currentCarouselIndex,
        onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
        bgColor: Colors.white,
        carouselHeight: 420,
      ),
    );
  }

  Widget _buildCarouselSection({
    required String eyebrow,
    required String title,
    required String subtitle,
    required List<String> images,
    required int currentIndex,
    required ValueChanged<int> onPageChanged,
    required Color bgColor,
    double carouselHeight = 360,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
      color: bgColor,
      child: Column(
        children: [
          _buildSectionHeader(eyebrow, title, subtitle),
          const SizedBox(height: 56),
          CarouselSlider(
            items: images.map((imagePath) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.accentGlow,
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: carouselHeight,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 0.85,
              onPageChanged: (index, _) => onPageChanged(index),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              final active = currentIndex == entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: active ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: active ? AppColors.accent : AppColors.divider,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── FOOTER ────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Container(
      key: _contactKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: AppColors.navy,
      child: Column(
        children: [
          Text(
            "Let's connect",
            style: AppTextStyles.display(48).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            'Have a project in mind? Let\'s bring it to life.',
            style: AppTextStyles.body(16).copyWith(color: Colors.white54),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildContactPill(
                Icons.email_rounded,
                'oussemakhlifi999@gmail.com',
                () => _launchUrl('mailto:oussemakhlifi999@gmail.com'),
              ),
              _buildContactPill(
                Icons.link_rounded,
                'LinkedIn',
                () => _launchUrl('https://www.linkedin.com/in/oussamakhlifi/'),
              ),
              _buildContactPill(
                Icons.code_rounded,
                'GitHub',
                () => _launchUrl('https://github.com/Oussema789'),
              ),
            ],
          ),
          const SizedBox(height: 64),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 24),
          Text(
            '© 2026 Oussema KHELIFI. All rights reserved.',
            style: AppTextStyles.body(12).copyWith(color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildContactPill(IconData icon, String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.accentLight),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.label(14).copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT MODEL
// ─────────────────────────────────────────────────────────────────────────────
class Project {
  final String id;
  final String name;
  final String period;
  final String mainImagePath;
  final List<String> additionalImagePaths;
  final List<String> tasks;
  final String technologies;

  Project({
    required this.id,
    required this.name,
    required this.period,
    required this.mainImagePath,
    required this.additionalImagePaths,
    required this.tasks,
    required this.technologies,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT DETAIL PAGE
// ─────────────────────────────────────────────────────────────────────────────
class ProjectDetailPage extends StatefulWidget {
  final Project project;
  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  int _currentImageIndex = 0;
  late CarouselSliderController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.navy,
        elevation: 0,
        title: Text(widget.project.name, style: AppTextStyles.heading(18)),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    items: widget.project.additionalImagePaths.map((path) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            path,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.accentGlow,
                              child: const Icon(
                                Icons.broken_image,
                                size: 80,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 420,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      onPageChanged: (index, _) =>
                          setState(() => _currentImageIndex = index),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.project.additionalImagePaths
                        .asMap()
                        .entries
                        .map((entry) {
                          final active = _currentImageIndex == entry.key;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: active ? 20 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: active
                                  ? AppColors.accent
                                  : AppColors.divider,
                            ),
                          );
                        })
                        .toList(),
                  ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.name,
                          style: AppTextStyles.display(32),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentGlow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.project.period,
                          style: AppTextStyles.label(
                            13,
                          ).copyWith(color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.project.technologies,
                    style: AppTextStyles.mono(14),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Key Features & Tasks',
                    style: AppTextStyles.heading(20),
                  ),
                  const SizedBox(height: 20),
                  ...widget.project.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 8, right: 14),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              task,
                              style: AppTextStyles.body(
                                15,
                              ).copyWith(color: AppColors.textSub),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED SECTION
// ─────────────────────────────────────────────────────────────────────────────
class AnimatedSection extends StatefulWidget {
  final Widget child;
  const AnimatedSection({super.key, required this.child});

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.toString()),
      onVisibilityChanged: (info) {
        if (!_hasAnimated && info.visibleFraction > 0.05) {
          _hasAnimated = true;
          _controller.forward();
        }
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
