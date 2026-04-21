import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;

// ─────────────────────────────────────────────────────────────────────────────
// BREAKPOINTS  (used throughout for consistent responsive logic)
// ─────────────────────────────────────────────────────────────────────────────
// mobile  : < 600
// tablet  : 600 – 1023
// desktop : ≥ 1024

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN TOKENS
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  static const navy = Color(0xFF0A0F1E);
  static const accent = Color(0xFF3B6EF8);
  static const accentLight = Color(0xFF6B93FF);
  static const accentGlow = Color(0x333B6EF8);
  static const surface = Color(0xFFF7F8FC);
  static const text = Color(0xFF0A0F1E);
  static const textSub = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const gold = Color(0xFFE8C84A);
  static const teal = Color(0xFF10B981);
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE HELPERS
// ─────────────────────────────────────────────────────────────────────────────
class R {
  /// Horizontal page padding per breakpoint
  static double hPad(DeviceScreenType t) {
    switch (t) {
      case DeviceScreenType.desktop:
        return 64;
      case DeviceScreenType.tablet:
        return 40;
      default:
        return 20;
    }
  }

  /// Vertical section padding per breakpoint
  static double vPad(DeviceScreenType t) {
    switch (t) {
      case DeviceScreenType.desktop:
        return 96;
      case DeviceScreenType.tablet:
        return 72;
      default:
        return 56;
    }
  }

  /// Display font size
  static double displaySize(DeviceScreenType t) {
    switch (t) {
      case DeviceScreenType.desktop:
        return 56;
      case DeviceScreenType.tablet:
        return 44;
      default:
        return 34;
    }
  }

  /// Section title size
  static double titleSize(DeviceScreenType t) {
    switch (t) {
      case DeviceScreenType.desktop:
        return 40;
      case DeviceScreenType.tablet:
        return 34;
      default:
        return 28;
    }
  }

  /// Body text size
  static double bodySize(DeviceScreenType t) {
    switch (t) {
      case DeviceScreenType.desktop:
        return 16;
      case DeviceScreenType.tablet:
        return 15;
      default:
        return 14;
    }
  }

  static bool isDesktop(DeviceScreenType t) => t == DeviceScreenType.desktop;
  static bool isTablet(DeviceScreenType t) => t == DeviceScreenType.tablet;
  static bool isMobile(DeviceScreenType t) => t == DeviceScreenType.mobile;
  static bool isNarrow(DeviceScreenType t) => t != DeviceScreenType.desktop;
}

// ─────────────────────────────────────────────────────────────────────────────
// TEXT STYLES
// ─────────────────────────────────────────────────────────────────────────────
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
// LOCALISATION
// ─────────────────────────────────────────────────────────────────────────────
class AppStrings {
  final bool isFr;
  const AppStrings({required this.isFr});

  String get navHome => isFr ? 'Accueil' : 'Home';
  String get navServices => isFr ? 'Services' : 'Services';
  String get navEducation => isFr ? 'Formation' : 'Education';
  String get navExperience => isFr ? 'Expérience' : 'Experience';
  String get navProjects => isFr ? 'Projets' : 'Projects';
  String get navSkills => isFr ? 'Compétences' : 'Skills';
  String get navContact => isFr ? 'Contact' : 'Contact';

  String get heroAvailable => isFr
      ? 'Disponible pour de nouvelles opportunités'
      : 'Available for new opportunities';
  String get heroTitle => 'Oussema\nKHELIFI';
  String get heroSubtitle => isFr
      ? 'Ingénieur en Systèmes Industriels — solutions intelligentes pour usines et digital.'
      : 'Industrial Systems Engineer crafting smarter factories & digital solutions.';
  String get heroChip1 => isFr ? 'Ingénierie Qualité' : 'Quality Engineering';
  String get heroChip2 => isFr ? 'Développement Flutter' : 'Flutter Dev';
  String get heroChip3 => 'Lean Six Sigma';
  String get heroChip4 => 'Power BI';
  String get heroCvBtn => isFr ? 'Télécharger CV' : 'Download CV';
  String get heroContactBtn => isFr ? 'Me Contacter' : 'Contact Me';

  String get aboutEyebrow => isFr ? 'à propos' : 'about me';
  String get aboutTitle => isFr ? 'À Propos' : 'About Me';
  String get aboutSub => isFr
      ? 'Passionné par l\'intersection entre la qualité industrielle et le digital.'
      : 'Passionate about the intersection of industrial quality and digital innovation.';
  String get aboutBio1 => isFr
      ? 'Ingénieur en Systèmes Industriels diplômé de l\'ENSTAB (Université de Carthage), je combine une solide expertise en management de la qualité — IATF 16949, PPAP, FMEA, Lean Six Sigma — avec des compétences avancées en développement d\'applications Flutter et en analyse de données Power BI.'
      : 'Industrial Systems Engineer graduated from ENSTAB (University of Carthage), I combine solid quality management expertise — IATF 16949, PPAP, FMEA, Lean Six Sigma — with advanced Flutter app development and Power BI data analytics skills.';
  String get aboutBio2 => isFr
      ? 'Mon parcours m\'a amené à travailler dans des environnements industriels exigeants (MISTA, Adwya-KILANI Group) où j\'ai piloté des projets qualité critiques, développé des outils digitaux sur mesure et animé des formations pour des équipes terrain.'
      : 'My career has taken me through demanding industrial environments (MISTA, Adwya-KILANI Group) where I\'ve led critical quality projects, developed custom digital tools, and delivered hands-on training sessions for production teams.';
  String get aboutBio3 => isFr
      ? 'Au-delà de mon poste actuel, je développe activement des applications Flutter orientées industrie — VSM Generator, 8D Problem Solver, Supplier Claims Manager — convaincu que la digitalisation des métiers industriels est un levier de performance incontournable.'
      : 'Beyond my day job, I actively build industry-focused Flutter apps — VSM Generator, 8D Problem Solver, Supplier Claims Manager — firmly believing that digitalizing industrial workflows is a key performance driver.';
  String get aboutQuote => isFr
      ? '"La qualité n\'est pas un acte, c\'est une habitude."'
      : '"Quality is not an act, it is a habit."';
  String get aboutStatYears =>
      isFr ? 'Années d\'expérience' : 'Years of experience';
  String get aboutStatProjects =>
      isFr ? 'Projets livrés' : 'Projects delivered';
  String get aboutStatCerts => isFr ? 'Certifications' : 'Certifications';
  String get aboutStatAudit =>
      isFr ? 'Score audit VDA 6.3' : 'VDA 6.3 audit score';
  String get aboutValuesTitle => isFr ? 'Mes valeurs' : 'My values';
  String get aboutVal1 => isFr ? 'Rigueur & Méthode' : 'Rigor & Method';
  String get aboutVal1Sub => isFr
      ? 'Chaque problème mérite une analyse structurée.'
      : 'Every problem deserves a structured analysis.';
  String get aboutVal2 => isFr ? 'Innovation pratique' : 'Practical Innovation';
  String get aboutVal2Sub => isFr
      ? 'La technologie au service des gens, pas l\'inverse.'
      : 'Technology serving people, not the other way around.';
  String get aboutVal3 => isFr ? 'Partage du savoir' : 'Knowledge Sharing';
  String get aboutVal3Sub => isFr
      ? 'Former et transmettre pour élever le niveau collectif.'
      : 'Training and teaching to elevate collective performance.';

  String get svcEyebrow => isFr ? 'ce que je fais' : 'what i do';
  String get svcTitle => 'Services';
  String get svcSub => isFr
      ? 'Transformer les défis industriels en solutions efficaces'
      : 'Transforming industrial challenges into streamlined solutions';
  String get svc1Title =>
      isFr ? 'Recherche & Stratégie' : 'Research & Strategy';
  String get svc1Desc => isFr
      ? 'Analyse data-driven, optimisation des processus et planification stratégique pour l\'excellence opérationnelle.'
      : 'Data-driven analysis, process optimization, and strategic planning for operational excellence.';
  String get svc2Title =>
      isFr ? 'Solutions Digitales' : 'Development Solutions';
  String get svc2Desc => isFr
      ? 'Applications Flutter sur mesure, outils d\'automatisation et transformation numérique.'
      : 'Custom Flutter apps, automation tools, and digital transformation to modernize workflows.';
  String get svc3Title =>
      isFr ? 'Qualité & Excellence' : 'Quality & Excellence';
  String get svc3Desc => isFr
      ? 'Lean Six Sigma, PPAP, FMEA et cadres d\'excellence opérationnelle pour l\'amélioration continue.'
      : 'Lean Six Sigma, PPAP, FMEA, and operational excellence frameworks for continuous improvement.';

  String get eduEyebrow => isFr ? 'parcours' : 'background';
  String get eduTitle => isFr ? 'Formation' : 'Education';
  String get eduSub => isFr
      ? 'Parcours académique et formations spécialisées'
      : 'Academic background and specialized training';
  String get edu1Degree => isFr
      ? 'Diplôme National d\'Ingénieur en Technologies Avancées'
      : 'National Diploma of Engineer in Advanced Technologies';
  String get edu1Inst => isFr
      ? 'ENSTAB — École Nationale des Sciences et Technologies Avancées de Borj Cedria, Université de Carthage'
      : 'ENSTAB — National School of Advanced Sciences and Technologies of Borj Cedria, University of Carthage';
  String get edu1Desc => isFr
      ? 'Spécialité : Systèmes Industriels & Compétitivité'
      : 'Specialized in Industrial Systems & Competitivity';
  String get edu2Degree => isFr
      ? 'Cycle Préparatoire — Mathématiques & Physique'
      : 'Preparatory Cycle — Mathematics & Physics';
  String get edu2Inst => isFr
      ? 'Faculté des Sciences de Tunis, Université de Tunis El Manar'
      : 'Faculty of Sciences of Tunis, University of Tunis El Manar';
  String get edu2Desc => isFr
      ? 'Programme intensif de deux ans en mathématiques, physique et sciences de l\'ingénieur.'
      : 'Intensive two-year program in mathematics, physics, and fundamental engineering sciences.';
  String get edu3Degree => isFr
      ? 'Baccalauréat Sciences Expérimentales'
      : 'Baccalaureate in Experimental Sciences';
  String get edu3Inst =>
      isFr ? 'Lycée Khaled Ibn El Walid' : 'Khaled Ibn El Walid High School';
  String get edu3Desc => isFr
      ? 'Diplôme du baccalauréat en sciences expérimentales.'
      : 'High school diploma in experimental sciences.';

  String get expEyebrow => isFr ? 'parcours pro' : 'track record';
  String get expTitle =>
      isFr ? 'Expérience Professionnelle' : 'Professional Experience';
  String get expSub => isFr
      ? 'Un historique de résultats à fort impact'
      : 'A history of delivering impactful results';

  String get projEyebrow => isFr ? 'portfolio' : 'portfolio';
  String get projTitle => isFr ? 'Projets Personnels' : 'Personal Projects';
  String get projSub => isFr
      ? 'Outils innovants construits pour résoudre des problèmes réels'
      : 'Innovative tools built to solve real-world problems';
  String get projDetailFeatures =>
      isFr ? 'Fonctionnalités & Tâches' : 'Key Features & Tasks';

  String get skillEyebrow => isFr ? 'expertise' : 'expertise';
  String get skillTitle =>
      isFr ? 'Compétences & Savoir-Faire' : 'Skills & Knowledge';
  String get skillSub => isFr
      ? 'Compétences techniques et connaissances industrielles'
      : 'Technical competencies and industrial knowledge';
  String get skillCat1 => isFr ? 'Langages de programmation' : 'Programming';
  String get skillCat2 => isFr ? 'Logiciels & ERP' : 'Software & ERP';
  String get skillCat3 => isFr ? 'Compétences humaines' : 'Soft Skills';
  String get skillCat4 =>
      isFr ? 'Connaissances industrielles' : 'Industrial Knowledge';
  List<String> get softSkills => isFr
      ? [
          'Communication efficace',
          'Résolution de problèmes',
          'Écoute active',
          'Créativité',
          'Adaptabilité',
        ]
      : [
          'Effective Communication',
          'Problem Solving',
          'Active Listening',
          'Creativity',
          'Adaptability',
        ];

  String get langEyebrow => isFr ? 'communication' : 'communication';
  String get langTitle => isFr ? 'Langues' : 'Languages';
  String get langNative => isFr ? 'Natif' : 'Native';
  String get langProf => isFr ? 'Niveau professionnel' : 'Professional';

  String get pbiEyebrow =>
      isFr ? 'visualisation données' : 'data visualization';
  String get pbiTitle =>
      isFr ? 'Tableaux de Bord Power BI' : 'Power BI Dashboards';
  String get pbiSub => isFr
      ? 'Projets de Business Intelligence'
      : 'Business intelligence projects';

  String get wsEyebrow =>
      isFr ? 'partage de connaissance' : 'knowledge sharing';
  String get wsTitle => isFr ? 'Ateliers & Formations' : 'Workshops & Training';
  String get wsSub => isFr
      ? 'Sessions de formation que j\'ai animées'
      : 'Knowledge sharing sessions I have conducted';

  String get certEyebrow => isFr ? 'réalisations' : 'achievements';
  String get certTitle =>
      isFr ? 'Certifications & Distinctions' : 'Certifications & Awards';
  String get certSub => isFr
      ? 'Reconnaissances professionnelles et étapes de formation continue'
      : 'Professional recognitions and continuous learning milestones';

  String get footerTitle => isFr ? 'Parlons-en' : "Let's connect";
  String get footerSub => isFr
      ? 'Un projet en tête ? Concrétisons-le ensemble.'
      : 'Have a project in mind? Let\'s bring it to life.';
  String get footerRights => isFr
      ? '© 2026 Oussema KHELIFI. Tous droits réservés.'
      : '© 2026 Oussema KHELIFI. All rights reserved.';
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
  bool _isFr = false;
  AppStrings get s => AppStrings(isFr: _isFr);
  void _toggleLanguage() => setState(() => _isFr = !_isFr);

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
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
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false)
      Navigator.of(ctx!).pop();
  }

  void _scrollToTop() => _scrollController.animateTo(
    0,
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOutCubic,
  );

  void _downloadCV() async {
    // Choose CV based on language
    final String fileId = _isFr
        ? '1ub3l6HDQI1m5ca1NghRAr8h4hcpiKREp' // French CV
        : '1QShVh7E-qqArwZJIrdvAuC6alHu2yD6L'; // English CV

    final String fileName = _isFr
        ? 'Oussema_KHELIFI_CV_FR.pdf'
        : 'Oussema_KHELIFI_CV_EN.pdf';

    final String downloadUrl =
        'https://drive.google.com/uc?export=download&id=$fileId';

    if (kIsWeb) {
      final anchor = html.AnchorElement(href: downloadUrl)
        ..setAttribute('download', fileName)
        ..click();
    } else {
      final Uri uri = Uri.parse(downloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
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
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: _buildNavBar()),
              SliverToBoxAdapter(child: _buildHeroSection()),
              SliverToBoxAdapter(child: _buildAboutSection()),
              SliverToBoxAdapter(child: _buildServicesSection()),
              SliverToBoxAdapter(child: _buildEducationSection()),
              SliverToBoxAdapter(child: _buildExperienceSection()),
              SliverToBoxAdapter(child: _buildProjectsSection()),
              SliverToBoxAdapter(child: _buildSkillsSection()),
              SliverToBoxAdapter(child: _buildLanguagesSection()),
              SliverToBoxAdapter(child: _buildPowerBISection()),
              SliverToBoxAdapter(child: _buildWorkshopsSection()),
              SliverToBoxAdapter(child: _buildCertificatesSection()),
              SliverToBoxAdapter(child: _buildFooter()),
            ],
          ),
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

  // ─── LANG TOGGLE ──────────────────────────────────────────────────────────
  Widget _buildLangToggle({bool compact = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _toggleLanguage,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.navy.withOpacity(0.06),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _langPill('EN', !_isFr, compact),
              _langPill('FR', _isFr, compact),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langPill(String code, bool active, bool compact) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: active ? AppColors.navy : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        code,
        style: AppTextStyles.label(compact ? 10 : 12).copyWith(
          color: active ? Colors.white : AppColors.textSub,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  // ─── DRAWER ───────────────────────────────────────────────────────────────
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
                    radius: 28,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Oussema KHELIFI',
                  style: AppTextStyles.label(16).copyWith(color: Colors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  'Industrial Systems Engineer',
                  style: AppTextStyles.body(11).copyWith(color: Colors.white54),
                ),
                const SizedBox(height: 10),
                _buildLangToggle(compact: true),
              ],
            ),
          ),
          ...[
            (s.navHome, _heroKey, Icons.home_rounded),
            (s.navServices, _servicesKey, Icons.work_rounded),
            (s.navEducation, _educationKey, Icons.school_rounded),
            (s.navExperience, _experienceKey, Icons.business_center_rounded),
            (s.navProjects, _projectsKey, Icons.code_rounded),
            (s.navSkills, _skillsKey, Icons.build_rounded),
            (s.navContact, _contactKey, Icons.contact_mail_rounded),
          ].map(
            (item) => ListTile(
              dense: true,
              leading: Icon(item.$3, color: AppColors.accentLight, size: 18),
              title: Text(
                item.$1,
                style: AppTextStyles.body(13).copyWith(color: Colors.white70),
              ),
              onTap: () => _scrollToSection(item.$2),
            ),
          ),
        ],
      ),
    );
  }

  // ─── NAVBAR ───────────────────────────────────────────────────────────────
  Widget _buildNavBar() {
    return ResponsiveBuilder(
      builder: (context, si) {
        if (R.isDesktop(si.deviceScreenType)) return _buildDesktopNavBar();
        return _buildMobileNavBar();
      },
    );
  }

  Widget _buildMobileNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _monogram(16),
          Row(
            children: [
              _buildLangToggle(compact: true),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: AppColors.navy,
                  size: 22,
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      color: AppColors.surface,
      child: Row(
        children: [
          _monogram(18),
          const Spacer(),
          ...[
            (s.navHome, _heroKey),
            (s.navServices, _servicesKey),
            (s.navEducation, _educationKey),
            (s.navExperience, _experienceKey),
            (s.navProjects, _projectsKey),
            (s.navSkills, _skillsKey),
            (s.navContact, _contactKey),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 28),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _scrollToSection(item.$2),
                  child: Text(
                    item.$1,
                    style: AppTextStyles.label(
                      13,
                    ).copyWith(color: AppColors.textSub),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 32),
          _buildLangToggle(),
        ],
      ),
    );
  }

  Widget _monogram(double size) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'OK',
            style: AppTextStyles.mono(
              size,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: '.',
            style: AppTextStyles.mono(size).copyWith(color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ─── SECTION HEADER ───────────────────────────────────────────────────────
  Widget _buildSectionHeader(
    String eyebrow,
    String title,
    String subtitle,
    DeviceScreenType t,
  ) {
    return Column(
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: AppTextStyles.mono(11).copyWith(letterSpacing: 2),
        ),
        const SizedBox(height: 10),
        Text(title, style: AppTextStyles.display(R.titleSize(t))),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle,
              style: AppTextStyles.body(R.bodySize(t)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  // ─── HERO ─────────────────────────────────────────────────────────────────
  Widget _buildHeroSection() {
    return Container(
      key: _heroKey,
      color: AppColors.surface,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final hp = R.hPad(t);
          final vp = R.vPad(t);
          if (R.isDesktop(t)) {
            return Padding(
              padding: EdgeInsets.fromLTRB(hp, vp, hp, vp + 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: _heroText(t)),
                  SizedBox(width: R.isTablet(t) ? 40 : 64),
                  Expanded(flex: 4, child: _heroImage(t)),
                ],
              ),
            );
          }
          // Tablet & mobile: stacked
          return Padding(
            padding: EdgeInsets.fromLTRB(hp, vp, hp, vp),
            child: Column(
              children: [
                _heroImage(t),
                SizedBox(height: R.isTablet(t) ? 40 : 32),
                _heroText(t),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _heroImage(DeviceScreenType t) {
    final photoSize = R.isDesktop(t)
        ? 220.0
        : R.isTablet(t)
        ? 180.0
        : 140.0;
    final ring1 = photoSize + 80;
    final ring2 = photoSize + 40;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (_, v, child) =>
          Transform.scale(scale: 0.7 + 0.3 * v, child: child),
      child: SizedBox(
        width: ring1,
        height: ring1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _ring(ring1, 0.10),
            _ring(ring2, 0.18),
            Container(
              width: photoSize + 20,
              height: photoSize + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.accentGlow, Colors.transparent],
                ),
              ),
            ),
            Container(
              width: photoSize,
              height: photoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.25),
                    blurRadius: 36,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 999,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
            ),
            if (R.isDesktop(t)) ...[
              Positioned(
                bottom: 28,
                right: 0,
                child: _floatingBadge(
                  'Quality\nEngineer',
                  Icons.verified_rounded,
                ),
              ),
              Positioned(
                top: 28,
                left: 0,
                child: _floatingBadge('Flutter\nDev', Icons.code_rounded),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _ring(double size, double opacity) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: AppColors.accent.withOpacity(opacity),
        width: 1,
      ),
    ),
  );

  Widget _floatingBadge(String label, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.accent),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.label(
            10,
          ).copyWith(color: AppColors.navy, height: 1.3),
        ),
      ],
    ),
  );

  Widget _heroText(DeviceScreenType t) {
    final align = R.isNarrow(t)
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = R.isNarrow(t) ? TextAlign.center : TextAlign.start;
    final wrapAlign = R.isNarrow(t)
        ? WrapAlignment.center
        : WrapAlignment.start;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (_, v, child) => Opacity(opacity: v, child: child),
      child: Column(
        crossAxisAlignment: align,
        children: [
          // Available badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                const SizedBox(width: 7),
                Flexible(
                  child: Text(
                    s.heroAvailable,
                    style: AppTextStyles.label(
                      11,
                    ).copyWith(color: AppColors.accent),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: R.isDesktop(t) ? 24 : 18),
          Text(
            s.heroTitle,
            textAlign: textAlign,
            style: AppTextStyles.display(
              R.displaySize(t),
            ).copyWith(color: AppColors.navy, letterSpacing: -1.5),
          ),
          SizedBox(height: R.isDesktop(t) ? 16 : 12),
          Text(
            s.heroSubtitle,
            textAlign: textAlign,
            style: AppTextStyles.body(R.bodySize(t) + 1).copyWith(height: 1.6),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: wrapAlign,
            children: [
              _chip(s.heroChip1),
              _chip(s.heroChip2),
              _chip(s.heroChip3),
              _chip(s.heroChip4),
            ],
          ),
          SizedBox(height: R.isDesktop(t) ? 36 : 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: wrapAlign,
            children: [
              _primaryBtn(s.heroCvBtn, Icons.download_rounded, _downloadCV, t),
              _secondaryBtn(
                s.heroContactBtn,
                Icons.arrow_forward_rounded,
                () => _scrollToSection(_contactKey),
                t,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
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

  Widget _primaryBtn(
    String text,
    IconData icon,
    VoidCallback onPressed,
    DeviceScreenType t,
  ) {
    final fs = R.isDesktop(t) ? 14.0 : 13.0;
    final hpad = R.isDesktop(t) ? 24.0 : 18.0;
    final vpad = R.isDesktop(t) ? 14.0 : 12.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: hpad, vertical: vpad),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                text,
                style: AppTextStyles.label(fs).copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _secondaryBtn(
    String text,
    IconData icon,
    VoidCallback onPressed,
    DeviceScreenType t,
  ) {
    final fs = R.isDesktop(t) ? 14.0 : 13.0;
    final hpad = R.isDesktop(t) ? 24.0 : 18.0;
    final vpad = R.isDesktop(t) ? 14.0 : 12.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: hpad, vertical: vpad),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.divider, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: AppTextStyles.label(fs).copyWith(color: AppColors.text),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: AppColors.accent, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─── ABOUT ────────────────────────────────────────────────────────────────
  Widget _buildAboutSection() {
    return AnimatedSection(
      key: _aboutKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final hp = R.hPad(t);
          final vp = R.vPad(t);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
            color: Colors.white,
            child: Column(
              children: [
                _buildSectionHeader(
                  s.aboutEyebrow,
                  s.aboutTitle,
                  s.aboutSub,
                  t,
                ),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),

                // Bio + Stats
                if (R.isDesktop(t))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _aboutBio(t)),
                      const SizedBox(width: 48),
                      Expanded(flex: 5, child: _aboutStats(t)),
                    ],
                  )
                else
                  Column(
                    children: [
                      _aboutBio(t),
                      const SizedBox(height: 36),
                      _aboutStats(t),
                    ],
                  ),

                SizedBox(height: R.isDesktop(t) ? 48 : 36),
                _aboutValues(t),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _aboutBio(DeviceScreenType t) {
    final fs = R.bodySize(t);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.aboutBio1, style: AppTextStyles.body(fs)),
        const SizedBox(height: 16),
        Text(s.aboutBio2, style: AppTextStyles.body(fs)),
        const SizedBox(height: 16),
        Text(s.aboutBio3, style: AppTextStyles.body(fs)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.accentGlow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accent.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  s.aboutQuote,
                  style: AppTextStyles.body(fs - 1).copyWith(
                    color: AppColors.navy,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _aboutStats(DeviceScreenType t) {
    final stats = [
      ('2+', s.aboutStatYears),
      ('10+', s.aboutStatProjects),
      ('7+', s.aboutStatCerts),
      ('90%', s.aboutStatAudit),
    ];
    final cardSize = R.isDesktop(t) ? 90.0 : 72.0;
    return Column(
      children: [
        // Profile card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(R.isDesktop(t) ? 24 : 18),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withOpacity(0.22),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: cardSize,
                height: cardSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 999,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Oussema KHELIFI',
                style: AppTextStyles.label(14).copyWith(color: Colors.white),
              ),
              const SizedBox(height: 3),
              Text(
                _isFr
                    ? 'Ingénieur Systèmes Industriels'
                    : 'Industrial Systems Engineer',
                style: AppTextStyles.body(11).copyWith(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                '📍 Tunis, Tunisia',
                style: AppTextStyles.body(11).copyWith(color: Colors.white38),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Stats
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: R.isDesktop(t) ? 1.6 : 1.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: stats
              .map(
                (stat) => Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stat.$1,
                        style: AppTextStyles.display(
                          24,
                        ).copyWith(color: AppColors.accent, height: 1.0),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        stat.$2,
                        style: AppTextStyles.body(10).copyWith(height: 1.3),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _aboutValues(DeviceScreenType t) {
    final values = [
      (Icons.rule_rounded, s.aboutVal1, s.aboutVal1Sub, AppColors.accent),
      (Icons.lightbulb_rounded, s.aboutVal2, s.aboutVal2Sub, AppColors.teal),
      (Icons.school_rounded, s.aboutVal3, s.aboutVal3Sub, AppColors.gold),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.aboutValuesTitle,
          style: AppTextStyles.heading(R.isDesktop(t) ? 20 : 17),
        ),
        const SizedBox(height: 18),
        if (R.isDesktop(t))
          Row(
            children: values
                .map(
                  (v) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: _valueCard(v.$1, v.$2, v.$3, v.$4, t),
                    ),
                  ),
                )
                .toList(),
          )
        else
          Column(
            children: values
                .map(
                  (v) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _valueCard(v.$1, v.$2, v.$3, v.$4, t),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _valueCard(
    IconData icon,
    String title,
    String sub,
    Color accent,
    DeviceScreenType t,
  ) => Container(
    padding: EdgeInsets.all(R.isDesktop(t) ? 20 : 16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.divider),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.label(13)),
              const SizedBox(height: 3),
              Text(sub, style: AppTextStyles.body(11)),
            ],
          ),
        ),
      ],
    ),
  );

  // ─── SERVICES ─────────────────────────────────────────────────────────────
  Widget _buildServicesSection() {
    return AnimatedSection(
      key: _servicesKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final cols = R.isDesktop(t)
              ? 3
              : R.isTablet(t)
              ? 2
              : 1;
          final ratio = cols == 3
              ? 1.0
              : cols == 2
              ? 1.2
              : 2.0;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: AppColors.surface,
            child: Column(
              children: [
                _buildSectionHeader(s.svcEyebrow, s.svcTitle, s.svcSub, t),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cols,
                  childAspectRatio: ratio,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _serviceCard(
                      Icons.search_rounded,
                      s.svc1Title,
                      s.svc1Desc,
                      0,
                      t,
                    ),
                    _serviceCard(
                      Icons.code_rounded,
                      s.svc2Title,
                      s.svc2Desc,
                      1,
                      t,
                    ),
                    _serviceCard(
                      Icons.engineering_rounded,
                      s.svc3Title,
                      s.svc3Desc,
                      2,
                      t,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static const List<Color> _svcAccents = [
    AppColors.accent,
    AppColors.teal,
    AppColors.gold,
  ];

  Widget _serviceCard(
    IconData icon,
    String title,
    String desc,
    int idx,
    DeviceScreenType t,
  ) {
    final ac = _svcAccents[idx % _svcAccents.length];
    return Container(
      padding: EdgeInsets.all(R.isDesktop(t) ? 28 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ac.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: ac),
          ),
          const SizedBox(height: 18),
          Text(title, style: AppTextStyles.heading(R.isDesktop(t) ? 18 : 16)),
          const SizedBox(height: 10),
          Text(desc, style: AppTextStyles.body(R.bodySize(t))),
        ],
      ),
    );
  }

  // ─── EDUCATION ────────────────────────────────────────────────────────────
  Widget _buildEducationSection() {
    return AnimatedSection(
      key: _educationKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: Colors.white,
            child: Column(
              children: [
                _buildSectionHeader(s.eduEyebrow, s.eduTitle, s.eduSub, t),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),
                _eduItem(
                  s.edu1Degree,
                  s.edu1Inst,
                  '2020 – 2023',
                  s.edu1Desc,
                  true,
                  false,
                  t,
                ),
                _eduItem(
                  s.edu2Degree,
                  s.edu2Inst,
                  '2018 – 2020',
                  s.edu2Desc,
                  false,
                  false,
                  t,
                ),
                _eduItem(
                  s.edu3Degree,
                  s.edu3Inst,
                  '2018',
                  s.edu3Desc,
                  false,
                  true,
                  t,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _eduItem(
    String degree,
    String inst,
    String period,
    String desc,
    bool isFirst,
    bool isLast,
    DeviceScreenType t,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 11,
                height: 11,
                margin: const EdgeInsets.only(top: 5),
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
          const SizedBox(width: 18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // On mobile stack period below title
                  if (R.isMobile(t)) ...[
                    Text(
                      degree,
                      style: AppTextStyles.heading(R.isDesktop(t) ? 17 : 15),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentGlow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        period,
                        style: AppTextStyles.label(
                          11,
                        ).copyWith(color: AppColors.accent),
                      ),
                    ),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            degree,
                            style: AppTextStyles.heading(
                              R.isDesktop(t) ? 17 : 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGlow,
                            borderRadius: BorderRadius.circular(5),
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
                  const SizedBox(height: 5),
                  Text(
                    inst,
                    style: AppTextStyles.body(
                      R.bodySize(t) - 1,
                    ).copyWith(color: AppColors.accent),
                  ),
                  const SizedBox(height: 5),
                  Text(desc, style: AppTextStyles.body(R.bodySize(t) - 1)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── EXPERIENCE ───────────────────────────────────────────────────────────
  Widget _buildExperienceSection() {
    return AnimatedSection(
      key: _experienceKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final items = _expItems(t);
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: AppColors.surface,
            child: Column(
              children: [
                _buildSectionHeader(s.expEyebrow, s.expTitle, s.expSub, t),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),
                ...List.generate(
                  items.length,
                  (i) => _timelineEntry(items[i], i == items.length - 1, t),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<_ExpData> _expItems(DeviceScreenType t) => [
    _ExpData(
      title: _isFr ? 'Contrôleur de Gestion' : 'Management Controller',
      company: 'Adwya - KILANI Group',
      period: 'Jan 2025 – Aug 2025',
      type: _isFr ? 'CDI' : 'Full-time',
      icon: Icons.bar_chart_rounded,
      accentColor: const Color(0xFF3B6EF8),
      bullets: _isFr
          ? [
              'Suivi mensuel des matières premières proches de la péremption et des stocks inactifs, avec évaluation et décision de maintien ou destruction.',
              'Élaboration d\'un plan d\'action de liquidation des stocks inactifs en collaboration avec les Méthodes et la Logistique.',
              'Suivi des budgets OPEX, identification et justification des écarts, validation des factures fournisseurs via Sage X3.',
              'Réalisation des inventaires physiques et analyse des écarts de stocks.',
            ]
          : [
              'Prepared monthly reports monitoring raw materials near expiry and inactive stocks, evaluating retention or destruction decisions.',
              'Developed an action plan to liquidate inactive stocks in collaboration with Methods and Logistics.',
              'Monitored OPEX budgets, identified variances, and validated supplier invoices via Sage X3.',
              'Conducted physical inventories and analyzed stock discrepancies with justifications.',
            ],
      tags: [
        'Sage X3',
        'Power BI',
        'Excel',
        _isFr ? 'Analyse financière' : 'Financial Analysis',
      ],
    ),
    _ExpData(
      title: _isFr ? 'Ingénieur Qualité Projet' : 'Project Quality Engineer',
      company: 'MISTA Tunisia',
      period: 'Mar 2024 – Jan 2025',
      type: _isFr ? 'CDI' : 'Full-time',
      icon: Icons.verified_rounded,
      accentColor: AppColors.teal,
      bullets: _isFr
          ? [
              'Analyse des manuels qualité clients, constitution des dossiers PPAP et organisation des audits pour les signatures PSW/ISIR.',
              'Animation des routines QRQC/QRAP, déploiement des actions correctives et mise en œuvre des AMDEC.',
              'Solution VBA de détection automatique des QR codes en double suite à une réclamation Valeo.',
              'Audit VDA 6.3 pour BMW avec un score de 90%, permettant le démarrage série.',
            ]
          : [
              'Analyzed customer quality manuals, prepared PPAP files, and organized audits to secure PSW/ISIR signatures.',
              'Led QRQC/QRAP routines, deployed corrective actions, and implemented FMEA and Control Plans.',
              'Built a VBA solution for automatic duplicate QR code detection following a Valeo complaint.',
              'Passed a VDA 6.3 process audit for BMW with a 90% score, enabling series production start-up.',
            ],
      tags: ['PPAP', 'FMEA', 'VDA 6.3', '8D', 'VBA', 'QRQC', 'IATF 16949'],
    ),
    _ExpData(
      title: _isFr
          ? 'Développeur Flutter (Stage)'
          : 'Flutter Developer (Internship)',
      company: 'Zodiac Nautic',
      period: 'Jul 2023 – Nov 2023',
      type: _isFr ? 'Stage' : 'Internship',
      icon: Icons.phone_android_rounded,
      accentColor: AppColors.gold,
      bullets: _isFr
          ? [
              'Application de maintenance IA avec Flutter (frontend) et Flask (backend).',
              'Automatisation de la génération de fichiers Excel pour la maintenance préventive.',
              'Interfaces distinctes : administrateurs (monitoring) et opérateurs (vérifications dématérialisées).',
            ]
          : [
              'AI-based maintenance application with Flutter (frontend) and Flask (backend).',
              'Automated Excel file generation for preventive maintenance tasks.',
              'Separate interfaces: administrators (monitoring) and operators (paperless checks).',
            ],
      tags: ['Flutter', 'Flask', 'AI', 'Excel Automation', 'LLM'],
    ),
    _ExpData(
      title: _isFr
          ? 'Développeur Flutter (Stage)'
          : 'Flutter Developer (Internship)',
      company: 'Smart Solutions Consulting',
      period: 'Jul 2022 – Aug 2022',
      type: _isFr ? 'Stage' : 'Internship',
      icon: Icons.web_rounded,
      accentColor: const Color(0xFFE879B0),
      bullets: _isFr
          ? [
              'Site vitrine Flutter Web pour les activités de formation Lean Management et Six Sigma.',
              'Modules interactifs et interface responsive déployée via Vercel.',
            ]
          : [
              'Flutter Web showcase presenting Lean Management and Six Sigma training services.',
              'Interactive modules and responsive interface deployed via Vercel.',
            ],
      tags: ['Flutter', 'Responsive Design', 'Vercel'],
    ),
  ];

  Widget _timelineEntry(_ExpData item, bool isLast, DeviceScreenType t) {
    final nodeSize = R.isDesktop(t)
        ? 44.0
        : R.isTablet(t)
        ? 38.0
        : 32.0;
    final spineWidth = nodeSize + (R.isDesktop(t) ? 16.0 : 12.0);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spine
          SizedBox(
            width: spineWidth,
            child: Column(
              children: [
                Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    color: item.accentColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item.accentColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: nodeSize * 0.45,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            item.accentColor.withOpacity(0.5),
                            AppColors.divider,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : (R.isDesktop(t) ? 36 : 28),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(R.isDesktop(t) ? 20 : 16),
                      decoration: BoxDecoration(
                        color: item.accentColor.withOpacity(0.04),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        border: Border(
                          bottom: BorderSide(color: AppColors.divider),
                        ),
                      ),
                      child: R.isMobile(t)
                          // Mobile: stacked header
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: AppTextStyles.heading(14),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.business_rounded,
                                      size: 12,
                                      color: item.accentColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        item.company,
                                        style: AppTextStyles.label(
                                          12,
                                        ).copyWith(color: item.accentColor),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _periodBadge(item.period, item.accentColor),
                                    const SizedBox(width: 8),
                                    _typeBadge(item.type),
                                  ],
                                ),
                              ],
                            )
                          // Tablet / Desktop: side-by-side
                          : Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: AppTextStyles.heading(
                                          R.isDesktop(t) ? 17 : 15,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business_rounded,
                                            size: 13,
                                            color: item.accentColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              item.company,
                                              style: AppTextStyles.label(13)
                                                  .copyWith(
                                                    color: item.accentColor,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _periodBadge(item.period, item.accentColor),
                                    const SizedBox(height: 5),
                                    _typeBadge(item.type),
                                  ],
                                ),
                              ],
                            ),
                    ),

                    // Body
                    Padding(
                      padding: EdgeInsets.all(R.isDesktop(t) ? 20 : 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...item.bullets.map(
                            (b) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.only(
                                      top: 7,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item.accentColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: AppTextStyles.body(
                                        R.bodySize(t) - 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: item.tags
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: AppColors.divider,
                                      ),
                                    ),
                                    child: Text(
                                      tag,
                                      style: AppTextStyles.label(
                                        10,
                                      ).copyWith(color: AppColors.textSub),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
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

  Widget _periodBadge(String period, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(period, style: AppTextStyles.label(10).copyWith(color: color)),
  );

  Widget _typeBadge(String type) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: AppColors.divider),
    ),
    child: Text(
      type,
      style: AppTextStyles.body(10).copyWith(color: AppColors.textMuted),
    ),
  );

  // ─── PROJECTS ─────────────────────────────────────────────────────────────
  Widget _buildProjectsSection() {
    final List<Project> projects = [
      Project(
        id: 'vsm_generator',
        name: _isFr
            ? 'Générateur VSM Intelligent'
            : 'Intelligent VSM Generator',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/vsm_generator/vsm1.jpg',
        additionalImagePaths: [
          'assets/apps/vsm_generator/vsm1.jpg',
          'assets/apps/vsm_generator/vsm2.jpg',
          'assets/apps/vsm_generator/vsm3.jpg',
        ],
        tasks: _isFr
            ? [
                'Création automatisée de Value Stream Maps avec recommandations IA via OpenRouter API.',
                'Calculs Lean intégrés : Takt Time, Lead Time, ratio VA/NVA, indicateurs avancés.',
                'Export PDF automatique des analyses pour le reporting.',
              ]
            : [
                'Automated VSM creation with AI-generated improvement recommendations via OpenRouter API.',
                'Integrated Lean calculations: Takt Time, Lead Time, VA/NVA ratio, advanced indicators.',
                'Automatic PDF export for streamlined reporting.',
              ],
        technologies: 'Flutter · OpenRouter API · Lean',
      ),
      Project(
        id: 'mom',
        name: _isFr ? 'Application 8D' : '8D Problem-Solving App',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/mom/mom1.jpg',
        additionalImagePaths: [
          'assets/apps/mom/mom1.jpg',
          'assets/apps/mom/mom2.jpg',
          'assets/apps/mom/mom3.jpg',
          'assets/apps/mom/mom4.jpg',
          'assets/apps/mom/mom5.png',
        ],
        tasks: _isFr
            ? [
                'Interface guidée pour documenter les 8 disciplines, rôles et informations de réunion.',
                'Outils RCA : 5 Pourquoi, Ishikawa, AMDEC et Arbre des défaillances.',
                'Génération automatique de rapports PDF professionnels.',
              ]
            : [
                'Guided interface for all eight 8D disciplines, team roles, and meeting info.',
                'Root cause tools: 5 Why, Ishikawa, FMEA, Fault Tree Analysis.',
                'Automated professional PDF report generation.',
              ],
        technologies: 'Flutter · Quality Tools · PDF',
      ),
      Project(
        id: 'supplierclaim',
        name: _isFr
            ? 'Gestionnaire de Réclamations'
            : 'Supplier Claims Manager',
        period: 'Mar 2026',
        mainImagePath: 'assets/apps/supplierclaim/claim1.jpg',
        additionalImagePaths: [
          'assets/apps/supplierclaim/claim1.jpg',
          'assets/apps/supplierclaim/claim2.jpg',
          'assets/apps/supplierclaim/claim3.jpg',
          'assets/apps/supplierclaim/claim4.jpg',
          'assets/apps/supplierclaim/claim5.jpg',
        ],
        tasks: _isFr
            ? [
                'Formulaire structuré : catégorie, données fournisseur, niveau de gravité.',
                'Capture d\'images pour preuves photographiques.',
                'Rapports PDF automatisés avec description et actions correctives.',
              ]
            : [
                'Structured form: category, supplier data, severity level.',
                'Image capture for photographic evidence.',
                'Automated PDF reports with discrepancy and corrective actions.',
              ],
        technologies: 'Flutter · PDF · Quality',
      ),
      Project(
        id: 'smartInventory',
        name: _isFr ? 'Inventaire Intelligent' : 'Intelligent Inventory App',
        period: 'Feb 2026',
        mainImagePath: 'assets/apps/smartInventory/smart1.jpg',
        additionalImagePaths: [
          'assets/apps/smartInventory/smart1.jpg',
          'assets/apps/smartInventory/smart2.jpg',
          'assets/apps/smartInventory/smart3.jpg',
          'assets/apps/smartInventory/smart4.jpg',
        ],
        tasks: _isFr
            ? [
                'Scan de codes-barres pour structurer automatiquement les données produit.',
                'Synchronisation cloud en format Excel avec ajustement des quantités.',
                'KPIs (taux d\'occupation, coût estimé) et reporting Excel automatisé.',
              ]
            : [
                'Barcode scanning to automatically structure product data.',
                'Cloud sync in Excel format with automatic quantity adjustment.',
                'KPIs (occupancy, estimated cost) and automated Excel reporting.',
              ],
        technologies: 'Flutter · Excel · Data',
      ),
    ];

    return AnimatedSection(
      key: _projectsKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final cols = R.isDesktop(t) ? 2 : 1;
          final ratio = cols == 2 ? 1.15 : 1.5;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: Colors.white,
            child: Column(
              children: [
                _buildSectionHeader(s.projEyebrow, s.projTitle, s.projSub, t),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cols,
                  childAspectRatio: ratio,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: projects.map((p) => _projectCard(p, t)).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _projectCard(Project project, DeviceScreenType t) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProjectDetailPage(project: project, isFr: _isFr),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
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
                            size: 36,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            size: 14,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(R.isDesktop(t) ? 16 : 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: AppTextStyles.heading(
                              R.isDesktop(t) ? 15 : 14,
                            ),
                          ),
                        ),
                        Text(
                          project.period,
                          style: AppTextStyles.body(
                            10,
                          ).copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(project.technologies, style: AppTextStyles.mono(10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SKILLS ───────────────────────────────────────────────────────────────
  Widget _buildSkillsSection() {
    return AnimatedSection(
      key: _skillsKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final cats = {
            s.skillCat1: ['Dart', 'Python', 'Java'],
            s.skillCat2: [
              'LOGIDAS',
              'CATIA',
              'Sage X3',
              'Power BI',
              'Microsoft Excel',
            ],
            s.skillCat3: s.softSkills,
            s.skillCat4: [
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
              'Lean Six Sigma',
              'QHSE',
              _isFr ? 'Gestion de la qualité' : 'Quality Management',
              _isFr ? 'Gestion des opérations' : 'Operations Management',
              _isFr ? 'Gestion des risques' : 'Risk Management',
              _isFr ? 'Audits Processus/Produit' : 'Process/Product Audits',
            ],
          };
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: AppColors.surface,
            child: Column(
              children: [
                _buildSectionHeader(
                  s.skillEyebrow,
                  s.skillTitle,
                  s.skillSub,
                  t,
                ),
                SizedBox(height: R.isDesktop(t) ? 56 : 40),
                if (R.isDesktop(t))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _skillBlock(s.skillCat1, cats[s.skillCat1]!, t),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _skillBlock(s.skillCat2, cats[s.skillCat2]!, t),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _skillBlock(s.skillCat3, cats[s.skillCat3]!, t),
                      ),
                    ],
                  )
                else if (R.isTablet(t))
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _skillBlock(
                              s.skillCat1,
                              cats[s.skillCat1]!,
                              t,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _skillBlock(
                              s.skillCat2,
                              cats[s.skillCat2]!,
                              t,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _skillBlock(s.skillCat3, cats[s.skillCat3]!, t),
                    ],
                  )
                else
                  Column(
                    children: [
                      _skillBlock(s.skillCat1, cats[s.skillCat1]!, t),
                      const SizedBox(height: 12),
                      _skillBlock(s.skillCat2, cats[s.skillCat2]!, t),
                      const SizedBox(height: 12),
                      _skillBlock(s.skillCat3, cats[s.skillCat3]!, t),
                    ],
                  ),
                const SizedBox(height: 14),
                _skillBlock(
                  s.skillCat4,
                  cats[s.skillCat4]!,
                  t,
                  accentColor: AppColors.navy,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _skillBlock(
    String title,
    List<String> skills,
    DeviceScreenType t, {
    Color accentColor = AppColors.accent,
  }) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(R.isDesktop(t) ? 24 : 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.divider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.label(13).copyWith(color: accentColor),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Text(
                    skill,
                    style: AppTextStyles.body(
                      12,
                    ).copyWith(color: AppColors.text),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );

  // ─── LANGUAGES ────────────────────────────────────────────────────────────
  Widget _buildLanguagesSection() {
    return AnimatedSection(
      key: _languagesKey,
      child: ResponsiveBuilder(
        builder: (context, si) {
          final t = si.deviceScreenType;
          final cardW = R.isDesktop(t)
              ? 220.0
              : R.isTablet(t)
              ? 190.0
              : 150.0;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.hPad(t),
              vertical: R.vPad(t),
            ),
            color: Colors.white,
            child: Column(
              children: [
                _buildSectionHeader(s.langEyebrow, s.langTitle, '', t),
                SizedBox(height: R.isDesktop(t) ? 44 : 32),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    _langCard('Arabic', s.langNative, '🇹🇳', cardW, t),
                    _langCard('English', s.langProf, '🇬🇧', cardW, t),
                    _langCard('French', s.langProf, '🇫🇷', cardW, t),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _langCard(
    String lang,
    String level,
    String flag,
    double width,
    DeviceScreenType t,
  ) => Container(
    width: width,
    padding: EdgeInsets.all(R.isDesktop(t) ? 24 : 18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.divider),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(flag, style: TextStyle(fontSize: R.isDesktop(t) ? 32.0 : 26.0)),
        const SizedBox(height: 10),
        Text(lang, style: AppTextStyles.heading(R.isDesktop(t) ? 16 : 14)),
        const SizedBox(height: 4),
        Text(
          level,
          style: AppTextStyles.body(11).copyWith(color: AppColors.accent),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ─── CAROUSELS ────────────────────────────────────────────────────────────
  Widget _buildPowerBISection() => AnimatedSection(
    key: _powerbiKey,
    child: _carouselSection(
      s.pbiEyebrow,
      s.pbiTitle,
      s.pbiSub,
      _powerbiImages,
      _currentPowerBIIndex,
      (i) => setState(() => _currentPowerBIIndex = i),
      Colors.white,
    ),
  );

  Widget _buildWorkshopsSection() => AnimatedSection(
    key: _workshopsKey,
    child: _carouselSection(
      s.wsEyebrow,
      s.wsTitle,
      s.wsSub,
      _workshopImages,
      _currentWorkshopIndex,
      (i) => setState(() => _currentWorkshopIndex = i),
      AppColors.surface,
    ),
  );

  Widget _buildCertificatesSection() => AnimatedSection(
    key: _certificatesKey,
    child: _carouselSection(
      s.certEyebrow,
      s.certTitle,
      s.certSub,
      _certificateImages,
      _currentCarouselIndex,
      (i) => setState(() => _currentCarouselIndex = i),
      Colors.white,
      carouselHeight: 400,
    ),
  );

  Widget _carouselSection(
    String eyebrow,
    String title,
    String subtitle,
    List<String> images,
    int currentIndex,
    ValueChanged<int> onPageChanged,
    Color bgColor, {
    double carouselHeight = 320,
  }) {
    return ResponsiveBuilder(
      builder: (context, si) {
        final t = si.deviceScreenType;
        final h = R.isMobile(t)
            ? carouselHeight * 0.65
            : R.isTablet(t)
            ? carouselHeight * 0.85
            : carouselHeight;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: R.hPad(t),
            vertical: R.vPad(t),
          ),
          color: bgColor,
          child: Column(
            children: [
              _buildSectionHeader(eyebrow, title, subtitle, t),
              SizedBox(height: R.isDesktop(t) ? 48 : 32),
              CarouselSlider(
                items: images
                    .map(
                      (path) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            path,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.accentGlow,
                              child: const Icon(
                                Icons.broken_image,
                                size: 40,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                  viewportFraction: R.isMobile(t) ? 0.92 : 0.85,
                  onPageChanged: (index, _) => onPageChanged(index),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  final active = currentIndex == entry.key;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: active ? 22 : 7,
                    height: 7,
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
      },
    );
  }

  // ─── FOOTER ───────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return ResponsiveBuilder(
      builder: (context, si) {
        final t = si.deviceScreenType;
        return Container(
          key: _contactKey,
          padding: EdgeInsets.symmetric(
            horizontal: R.hPad(t),
            vertical: R.vPad(t),
          ),
          color: AppColors.navy,
          child: Column(
            children: [
              Text(
                s.footerTitle,
                style: AppTextStyles.display(
                  R.isDesktop(t)
                      ? 44
                      : R.isTablet(t)
                      ? 36
                      : 28,
                ).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                s.footerSub,
                style: AppTextStyles.body(
                  R.bodySize(t),
                ).copyWith(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: R.isDesktop(t) ? 44 : 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _contactPill(
                    Icons.email_rounded,
                    'oussemakhlifi999@gmail.com',
                    () => _launchUrl('mailto:oussemakhlifi999@gmail.com'),
                    t,
                  ),
                  _contactPill(
                    Icons.link_rounded,
                    'LinkedIn',
                    () => _launchUrl(
                      'https://www.linkedin.com/in/oussamakhlifi/',
                    ),
                    t,
                  ),
                  _contactPill(
                    Icons.code_rounded,
                    'GitHub',
                    () => _launchUrl('https://github.com/Oussema789'),
                    t,
                  ),
                ],
              ),
              SizedBox(height: R.isDesktop(t) ? 56 : 40),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 20),
              Text(
                s.footerRights,
                style: AppTextStyles.body(11).copyWith(color: Colors.white38),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _contactPill(
    IconData icon,
    String label,
    VoidCallback onTap,
    DeviceScreenType t,
  ) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: R.isDesktop(t) ? 20 : 14,
          vertical: R.isDesktop(t) ? 12 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.accentLight),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: AppTextStyles.label(
                  R.isDesktop(t) ? 13 : 11,
                ).copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
class _ExpData {
  final String title, company, period, type;
  final IconData icon;
  final Color accentColor;
  final List<String> bullets, tags;
  const _ExpData({
    required this.title,
    required this.company,
    required this.period,
    required this.type,
    required this.icon,
    required this.accentColor,
    required this.bullets,
    required this.tags,
  });
}

class Project {
  final String id, name, period, mainImagePath, technologies;
  final List<String> additionalImagePaths, tasks;
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
  final bool isFr;
  const ProjectDetailPage({
    super.key,
    required this.project,
    required this.isFr,
  });
  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  int _idx = 0;
  late CarouselSliderController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(isFr: widget.isFr);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.navy,
        elevation: 0,
        title: Text(widget.project.name, style: AppTextStyles.heading(16)),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _ctrl,
                    items: widget.project.additionalImagePaths
                        .map(
                          (path) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                path,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.accentGlow,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 60,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 360,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      onPageChanged: (i, _) => setState(() => _idx = i),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.project.additionalImagePaths
                        .asMap()
                        .entries
                        .map((e) {
                          final active = _idx == e.key;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: active ? 18 : 7,
                            height: 7,
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.name,
                          style: AppTextStyles.display(26),
                        ),
                      ),
                      const SizedBox(width: 12),
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
                          widget.project.period,
                          style: AppTextStyles.label(
                            12,
                          ).copyWith(color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.technologies,
                    style: AppTextStyles.mono(12),
                  ),
                  const SizedBox(height: 24),
                  Text(s.projDetailFeatures, style: AppTextStyles.heading(18)),
                  const SizedBox(height: 16),
                  ...widget.project.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 8, right: 12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              task,
                              style: AppTextStyles.body(
                                14,
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
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _done = false;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.toString()),
      onVisibilityChanged: (info) {
        if (!_done && info.visibleFraction > 0.05) {
          _done = true;
          _ctrl.forward();
        }
      },
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}
