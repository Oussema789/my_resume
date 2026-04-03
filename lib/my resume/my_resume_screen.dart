import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;

void main() {
  runApp(const PortfolioWebsite());
}

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _scrollToTop();
    }
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context!).pop();
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _downloadCV() async {
    // Using url_launcher to open the PDF in a new tab (works reliably on Vercel)
    const cvUrl = '/assets/Oussema_KHELIFI_Resume.pdf';
    final Uri uri = Uri.parse(cvUrl);

    // For web, launch the URL - this will open the PDF in browser's PDF viewer
    // and user can save it from there
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to the original AnchorElement method
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
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5BFF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(),
        body: Stack(
          children: [
            // Animated gradient background
            AnimatedContainer(
              duration: const Duration(seconds: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    const Color(0xFFF8FAFF),
                    const Color(0xFFF0F4FF),
                    const Color(0xFFE8EDF9),
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
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
            child: const Icon(Icons.arrow_upward),
            tooltip: 'Back to top',
            backgroundColor: const Color(0xFF2E5BFF),
            foregroundColor: Colors.white,
            elevation: 4,
          ),
        ),
      ),
    );
  }

  // Drawer remains same
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF2E5BFF), const Color(0xFF1E3A8A)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Oussema KHELIFI',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Industrial Systems Engineer',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem('Home', _heroKey, Icons.home),
            _buildDrawerItem('Services', _servicesKey, Icons.work),
            _buildDrawerItem('Education', _educationKey, Icons.school),
            _buildDrawerItem(
              'Experience',
              _experienceKey,
              Icons.business_center,
            ),
            _buildDrawerItem('Projects', _projectsKey, Icons.code),
            _buildDrawerItem('Skills', _skillsKey, Icons.build),
            _buildDrawerItem('Contact', _contactKey, Icons.contact_mail),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, GlobalKey key, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2E5BFF)),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () => _scrollToSection(key),
    );
  }

  // Responsive NavBar using ScreenTypeLayout
  Widget _buildResponsiveNavBar() {
    return ScreenTypeLayout(
      mobile: _buildMobileNavBar(),
      desktop: _buildDesktopNavBar(),
    );
  }

  Widget _buildMobileNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Oussema K.',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E5BFF),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF2E5BFF)),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem('Home', _heroKey),
          const SizedBox(width: 32),
          _buildNavItem('Services', _servicesKey),
          const SizedBox(width: 32),
          _buildNavItem('Education', _educationKey),
          const SizedBox(width: 32),
          _buildNavItem('Experience', _experienceKey),
          const SizedBox(width: 32),
          _buildNavItem('Projects', _projectsKey),
          const SizedBox(width: 32),
          _buildNavItem('Skills', _skillsKey),
          const SizedBox(width: 32),
          _buildNavItem('Contact', _contactKey),
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
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E2A3E),
          ),
        ),
      ),
    );
  }

  // Hero section using ResponsiveBuilder
  Widget _buildHeroSection() {
    return Container(
      key: _heroKey,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          bool isWide = sizingInfo.deviceScreenType == DeviceScreenType.desktop;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildProfileImage(context)),
                    const SizedBox(width: 48),
                    Expanded(child: _buildHeroText()),
                  ],
                )
              : Column(
                  children: [
                    _buildProfileImage(context),
                    const SizedBox(height: 40),
                    _buildHeroText(),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.22,
        backgroundImage: AssetImage('assets/profile.png'),
      ),
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF1E2A3E), const Color(0xFF2C3E50)],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E2A3E).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Oussema KHELIFI',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
          'Making industrial systems\nsmarter, one solution at a time.',
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: const Color(0xFF1A2A3A),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Industrial Systems Engineer | Quality & Automation Specialist',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildButton(
              onPressed: _downloadCV,
              text: 'Download CV',
              icon: Icons.download,
              isOutlined: false,
            ),
            _buildButton(
              onPressed: () => _scrollToSection(_contactKey),
              text: 'Contact Me',
              icon: Icons.email,
              isOutlined: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    required bool isOutlined,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: isOutlined
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF2E5BFF), Color(0xFF1E3A8A)],
                  ),
            color: isOutlined ? Colors.transparent : null,
            borderRadius: BorderRadius.circular(60),
            border: isOutlined
                ? Border.all(color: const Color(0xFF2E5BFF), width: 2)
                : null,
            boxShadow: isOutlined
                ? null
                : [
                    BoxShadow(
                      color: const Color(0xFF2E5BFF).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isOutlined ? const Color(0xFF2E5BFF) : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: isOutlined ? const Color(0xFF2E5BFF) : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Services Section with responsive grid
  Widget _buildServicesSection() {
    return AnimatedSection(
      key: _servicesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Text(
              'What I Do',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Transforming industrial challenges into streamlined solutions',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                int crossAxisCount = 1;
                if (sizingInfo.deviceScreenType == DeviceScreenType.tablet) {
                  crossAxisCount = 2;
                } else if (sizingInfo.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  crossAxisCount = 3;
                }
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  children: [
                    _buildServiceCard(
                      icon: Icons.search,
                      title: 'Research & Strategy',
                      description:
                          'Data-driven analysis, process optimization, and strategic planning for operational excellence.',
                    ),
                    _buildServiceCard(
                      icon: Icons.code,
                      title: 'Development Solutions',
                      description:
                          'Custom Flutter apps, automation tools, and digital transformation to modernize workflows.',
                    ),
                    _buildServiceCard(
                      icon: Icons.engineering,
                      title: 'Quality & Excellence',
                      description:
                          'Lean Six Sigma, PPAP, FMEA, and operational excellence frameworks for continuous improvement.',
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

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Container(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E5BFF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 48, color: const Color(0xFF2E5BFF)),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Education Section (unchanged, but uses Card and responsive padding)
  Widget _buildEducationSection() {
    return AnimatedSection(
      key: _educationKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Education',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Academic background and specialized training',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
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
                ),
                const SizedBox(height: 24),
                _buildEducationItem(
                  degree:
                      'Preparatory Cycle for Engineering Studies - Mathematics and Physics',
                  institution:
                      'Faculty of Sciences of Tunis, University of Tunis El Manar',
                  period: '2018 – 2020',
                  description:
                      'Intensive two-year program in mathematics, physics, and fundamental engineering sciences.',
                ),
                const SizedBox(height: 24),
                _buildEducationItem(
                  degree: 'Baccalaureate in Experimental Sciences',
                  institution: 'Khaled Ibn El Walid High School',
                  period: '2018',
                  description: 'High school diploma in experimental sciences.',
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
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    degree,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  period,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              institution,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF2E5BFF),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.poppins(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Experience Section (unchanged, but responsive via parent padding)
  Widget _buildExperienceSection() {
    return AnimatedSection(
      key: _experienceKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          children: [
            Text(
              'Professional Experience',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'A track record of delivering impactful results',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
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
                  tags: const [
                    'Sage X3',
                    'Power BI',
                    'Excel',
                    'Financial Analysis',
                    'Inventory Management',
                  ],
                ),
                const SizedBox(height: 32),
                _buildExperienceItem(
                  title: 'Project Quality Engineer',
                  company: 'MISTA Tunisia',
                  period: 'Mar 2024 – Jan 2025',
                  description:
                      '• Analyzed customer quality manuals to ensure full compliance, prepared PPAP files, and organized customer audits to secure PSW/ISIR signatures.\n'
                      '• Led QRQC/QRAP routines to identify root causes, deploy corrective actions, and monitor effectiveness, while implementing FMEA and Control Plans to secure process robustness.\n'
                      '• Developed and updated production documentation (work instructions, control sheets, packaging instructions) and trained operators on quality standards.\n'
                      '• Analyzed and handled customer complaints using the 8D method; developed a VBA solution for automatic duplicate QR code detection (scanner + visual alerts) following a Valeo complaint.\n'
                      '• Prepared and passed a VDA 6.3 process audit for a BMW project with a 90% score, enabling ISR signature and series production start-up.',
                  tags: const [
                    'PPAP',
                    'FMEA',
                    'VDA 6.3',
                    '8D',
                    'VBA',
                    'QRQC',
                    'IATF 16949',
                  ],
                ),
                const SizedBox(height: 32),
                _buildExperienceItem(
                  title: 'Flutter Developer (Internship)',
                  company: 'Zodiac Nautic',
                  period: 'Jul 2023 – Nov 2023',
                  description:
                      '• Developed an AI-based maintenance application with Flutter (frontend) and Flask (backend) to optimize efficiency of maintenance personnel.\n'
                      '• Designed an automation feature to generate Excel files related to preventive maintenance, reducing manual effort.\n'
                      '• Implemented two distinct interfaces: administrators (monitoring, updating) and operators (paperless checks, real-time assistance).',
                  tags: const [
                    'Flutter',
                    'Flask',
                    'AI',
                    'Excel Automation',
                    'LLM',
                  ],
                ),
                const SizedBox(height: 32),
                _buildExperienceItem(
                  title: 'Flutter Developer (Internship)',
                  company: 'Smart Solutions Consulting',
                  period: 'Jul 2022 – Aug 2022',
                  description:
                      '• Built a corporate showcase website using Flutter Web presenting the company’s Lean Management and Six Sigma training activities.\n'
                      '• Integrated interactive modules highlighting Lean Six Sigma courses.\n'
                      '• Designed a responsive, intuitive interface and deployed it online via Vercel.',
                  tags: const ['Flutter', 'Responsive Design', 'Vercel'],
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
  }) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      period,
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  company,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF2E5BFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade700,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey.shade100,
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Projects Section with responsive grid
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
        technologies: 'Flutter, OpenRouter API, Lean Manufacturing',
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
          'Enabled image capture for visual evidence and automated generation of professional PDF reports for clients and quality teams.',
        ],
        technologies: 'Flutter, Quality Tools, PDF Automation',
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
          'Automated supplier claim generation with a structured form capturing category (Damage, Quantity, Quality), supplier data, and severity level.',
          'Integrated image capture to add photographic evidence directly into the claim report.',
          'Automated PDF report generation summarizing claim details, discrepancy descriptions, and corrective action requests.',
        ],
        technologies: 'Flutter, PDF Generator, Quality Management',
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
          'Implemented cloud synchronization to save inventory data in Excel format with automatic quantity adjustment based on weight discrepancies.',
          'Developed local database to calculate KPIs (warehouse occupancy, estimated stock cost) and automated Excel reporting with transaction history and summary statistics.',
        ],
        technologies: 'Flutter, Excel Automation, Data Analysis',
      ),
    ];

    return AnimatedSection(
      key: _projectsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Text(
              'Personal Projects',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Innovative tools I’ve built to solve real-world problems',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                int crossAxisCount = 1;
                if (sizingInfo.deviceScreenType == DeviceScreenType.tablet) {
                  crossAxisCount = 2;
                } else if (sizingInfo.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  crossAxisCount = 3;
                }
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  children: projects.map((project) {
                    return _buildProjectImageCard(project);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImageCard(Project project) {
    String summary = project.tasks.isNotEmpty ? project.tasks.first : '';
    if (summary.length > 100) summary = summary.substring(0, 100) + '...';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(project: project),
            ),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  color: Colors.grey.shade100,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: Image.asset(
                    project.mainImagePath,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          project.period,
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        project.technologies,
                        style: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      summary,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Skills Section using ScreenTypeLayout
  Widget _buildSkillsSectionCompact() {
    final Map<String, List<String>> skillCategories = {
      'Programming Languages': ['Dart', 'Python', 'Java'],
      'Software & ERP': [
        'LOGIDAS',
        'CATIA',
        'Sage X3',
        'Power BI',
        'Microsoft Excel',
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
      'Soft Skills': [
        'Effective Communication',
        'Problem Solving',
        'Active Listening',
        'Creativity',
        'Adaptability',
      ],
    };

    return AnimatedSection(
      key: _skillsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Text(
              'Skills & Expertise',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Technical competencies and industrial knowledge',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ScreenTypeLayout(
                  mobile: Column(
                    children: [
                      _buildSkillCategoryCompact(
                        skillCategories['Programming Languages']!,
                        'Programming Languages',
                      ),
                      const SizedBox(height: 24),
                      _buildSkillCategoryCompact(
                        skillCategories['Software & ERP']!,
                        'Software & ERP',
                      ),
                      const SizedBox(height: 24),
                      _buildSkillCategoryCompact(
                        skillCategories['Soft Skills']!,
                        'Soft Skills',
                      ),
                    ],
                  ),
                  desktop: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSkillCategoryCompact(
                          skillCategories['Programming Languages']!,
                          'Programming Languages',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildSkillCategoryCompact(
                          skillCategories['Software & ERP']!,
                          'Software & ERP',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildSkillCategoryCompact(
                          skillCategories['Soft Skills']!,
                          'Soft Skills',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _buildSkillCategoryCompact(
                  skillCategories['Industrial Knowledge']!,
                  'Industrial Knowledge',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCategoryCompact(List<String> skills, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E2A3E),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2E5BFF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                skill,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF2E5BFF),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Languages Section
  Widget _buildLanguagesSection() {
    return AnimatedSection(
      key: _languagesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Languages',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 48),
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                double cardWidth =
                    sizingInfo.deviceScreenType == DeviceScreenType.mobile
                    ? 200
                    : 250;
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildLanguageCard('Arabic', 'Native', cardWidth),
                    _buildLanguageCard(
                      'English',
                      'Professional working proficiency',
                      cardWidth,
                    ),
                    _buildLanguageCard(
                      'French',
                      'Professional working proficiency',
                      cardWidth,
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

  Widget _buildLanguageCard(String language, String level, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E5BFF), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E5BFF).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            language,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            level,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Power BI Section (carousel already responsive)
  Widget _buildPowerBISection() {
    return AnimatedSection(
      key: _powerbiKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Text(
              'Power BI Dashboards',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Data visualizations and business intelligence projects',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            CarouselSlider(
              items: _powerbiImages.map((imagePath) {
                return Builder(
                  builder: (context) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) =>
                    setState(() => _currentPowerBIIndex = index),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _powerbiImages.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPowerBIIndex == entry.key
                        ? const Color(0xFF2E5BFF)
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkshopsSection() {
    return AnimatedSection(
      key: _workshopsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Workshops & Training',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Knowledge sharing sessions I have conducted',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            CarouselSlider(
              items: _workshopImages.map((imagePath) {
                return Builder(
                  builder: (context) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) =>
                    setState(() => _currentWorkshopIndex = index),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _workshopImages.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentWorkshopIndex == entry.key
                        ? const Color(0xFF2E5BFF)
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatesSection() {
    return AnimatedSection(
      key: _certificatesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Certifications & Awards',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2A3E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Professional recognitions and continuous learning milestones',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            CarouselSlider(
              items: _certificateImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 50),
                                ),
                              ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _certificateImages.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == entry.key
                        ? const Color(0xFF2E5BFF)
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      key: _contactKey,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      color: const Color(0xFF1E2A3E),
      child: Column(
        children: [
          Text(
            'Let’s connect',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Have a project in mind? Let’s bring it to life.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.email,
                label: 'oussemakhlifi999@gmail.com',
                onTap: () => _launchUrl('mailto:oussemakhlifi999@gmail.com'),
              ),
              _buildSocialButton(
                icon: Icons.link,
                label: 'LinkedIn',
                onTap: () =>
                    _launchUrl('https://www.linkedin.com/in/oussamakhlifi/'),
              ),
              _buildSocialButton(
                icon: Icons.code,
                label: 'GitHub',
                onTap: () => _launchUrl('https://github.com/Oussema789'),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Divider(color: Colors.grey.shade800, thickness: 1),
          const SizedBox(height: 24),
          Text(
            '© 2026 Oussema KHELIFI. All rights reserved.',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
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

// Project Model and Detail Page (unchanged)
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
      appBar: AppBar(
        title: Text(widget.project.name),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E2A3E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  CarouselSlider(
                    items: widget.project.additionalImagePaths.map((path) {
                      return Builder(
                        builder: (context) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.grey.shade100,
                          child: Image.asset(
                            path,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    carouselController: _carouselController,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.project.additionalImagePaths
                        .asMap()
                        .entries
                        .map((entry) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == entry.key
                                  ? const Color(0xFF2E5BFF)
                                  : Colors.grey.shade400,
                            ),
                          );
                        })
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.name,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E2A3E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.project.period,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E5BFF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.project.technologies,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF2E5BFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Key Features & Tasks',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2A3E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...widget.project.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E5BFF),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              task,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.grey.shade700,
                              ),
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

// AnimatedSection remains unchanged
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
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
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
        if (!_hasAnimated && info.visibleFraction > 0.1) {
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
