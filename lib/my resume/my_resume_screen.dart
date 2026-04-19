import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;

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

  // ── Navbar
  String get navHome => isFr ? 'Accueil' : 'Home';
  String get navServices => isFr ? 'Services' : 'Services';
  String get navEducation => isFr ? 'Formation' : 'Education';
  String get navExperience => isFr ? 'Expérience' : 'Experience';
  String get navProjects => isFr ? 'Projets' : 'Projects';
  String get navSkills => isFr ? 'Compétences' : 'Skills';
  String get navContact => isFr ? 'Contact' : 'Contact';

  // ── Hero / About
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

  // ── About Me
  String get aboutEyebrow => isFr ? 'à propos' : 'about me';
  String get aboutTitle => isFr ? 'À Propos' : 'About Me';
  String get aboutSub => isFr
      ? 'Passionné par l\'intersection entre la qualité industrielle et le digital.'
      : 'Passionate about the intersection of industrial quality and digital innovation.';
  String get aboutBio1 => isFr
      ? 'Ingénieur en Systèmes Industriels diplômé de l\'ENSTAB (Université de Carthage), je combines une solide expertise en management de la qualité — IATF 16949, PPAP, FMEA, Lean Six Sigma — avec des compétences avancées en développement d\'applications Flutter et en analyse de données Power BI.'
      : 'Industrial Systems Engineer graduated from ENSTAB (University of Carthage), I combine solid quality management expertise — IATF 16949, PPAP, FMEA, Lean Six Sigma — with advanced Flutter app development and Power BI data analytics skills.';
  String get aboutBio2 => isFr
      ? 'Mon parcours m\'a amené à travailler dans des environnements industriels exigeants (MISTA, Adwya-KILANI Group) où j\'ai eu l\'opportunité de piloter des projets qualité critiques, de développer des outils digitaux sur mesure, et d\'animer des formations pour des équipes terrain.'
      : 'My career has taken me through demanding industrial environments (MISTA, Adwya-KILANI Group) where I\'ve led critical quality projects, developed custom digital tools, and delivered hands-on training sessions for production teams.';
  String get aboutBio3 => isFr
      ? 'Au-delà de mon poste actuel, je développe activement des applications Flutter orientées industrie — VSM Generator, 8D Problem Solver, Supplier Claims Manager — convaincus que la digitalisation des métiers industriels est un levier de performance incontournable.'
      : 'Beyond my day job, I actively build industry-focused Flutter apps — VSM Generator, 8D Problem Solver, Supplier Claims Manager — firmly believing that digitalizing industrial workflows is a key performance driver.';
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

  // ── Services
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

  // ── Education
  String get eduEyebrow => isFr ? 'parcours' : 'background';
  String get eduTitle => isFr ? 'Formation' : 'Education';
  String get eduSub => isFr
      ? 'Parcours académique et formations spécialisées'
      : 'Academic background and specialized training';
  String get edu1Degree => isFr
      ? 'Diplôme National d\'Ingénieur en Technologies Avancées'
      : 'National Diploma of Engineer in Advanced Technologies';
  String get edu1Inst => isFr
      ? 'École Nationale des Sciences et Technologies Avancées de Borj Cedria, Université de Carthage'
      : 'National School of Advanced Sciences and Technologies of Borj Cedria, University of Carthage';
  String get edu1Desc => isFr
      ? 'Spécialité : Systèmes Industriels & Compétitivité'
      : 'Specialized in Industrial Systems & Competitivity';
  String get edu2Degree => isFr
      ? 'Cycle Préparatoire aux Études d\'Ingénieur — Mathématiques & Physique'
      : 'Preparatory Cycle for Engineering Studies — Mathematics & Physics';
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

  // ── Experience
  String get expEyebrow => isFr ? 'parcours pro' : 'track record';
  String get expTitle =>
      isFr ? 'Expérience Professionnelle' : 'Professional Experience';
  String get expSub => isFr
      ? 'Un historique de résultats à fort impact'
      : 'A history of delivering impactful results';
  String get expFeaturesTitle =>
      isFr ? 'Réalisations clés' : 'Key Achievements';

  // ── Projects
  String get projEyebrow => isFr ? 'portfolio' : 'portfolio';
  String get projTitle => isFr ? 'Projets Personnels' : 'Personal Projects';
  String get projSub => isFr
      ? 'Outils innovants construits pour résoudre des problèmes réels'
      : 'Innovative tools built to solve real-world problems';

  // ── Skills
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

  // ── Languages
  String get langEyebrow => isFr ? 'communication' : 'communication';
  String get langTitle => isFr ? 'Langues' : 'Languages';
  String get langNative => isFr ? 'Natif' : 'Native';
  String get langProf => isFr ? 'Niveau professionnel' : 'Professional';

  // ── Power BI
  String get pbiEyebrow =>
      isFr ? 'visualisation données' : 'data visualization';
  String get pbiTitle =>
      isFr ? 'Tableaux de Bord Power BI' : 'Power BI Dashboards';
  String get pbiSub => isFr
      ? 'Projets de Business Intelligence'
      : 'Business intelligence projects';

  // ── Workshops
  String get wsEyebrow =>
      isFr ? 'partage de connaissance' : 'knowledge sharing';
  String get wsTitle => isFr ? 'Ateliers & Formations' : 'Workshops & Training';
  String get wsSub => isFr
      ? 'Sessions de formation que j\'ai animées'
      : 'Knowledge sharing sessions I have conducted';

  // ── Certifications
  String get certEyebrow => isFr ? 'réalisations' : 'achievements';
  String get certTitle =>
      isFr ? 'Certifications & Distinctions' : 'Certifications & Awards';
  String get certSub => isFr
      ? 'Reconnaissances professionnelles et étapes de formation continue'
      : 'Professional recognitions and continuous learning milestones';

  // ── Footer
  String get footerTitle => isFr ? 'Parlons-en' : "Let's connect";
  String get footerSub => isFr
      ? 'Un projet en tête ? Concrétisons-le ensemble.'
      : 'Have a project in mind? Let\'s bring it to life.';
  String get footerRights => isFr
      ? '© 2026 Oussema KHELIFI. Tous droits réservés.'
      : '© 2026 Oussema KHELIFI. All rights reserved.';

  // ── Project detail
  String get projDetailFeatures =>
      isFr ? 'Fonctionnalités & Tâches' : 'Key Features & Tasks';
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
    // Extract file ID from your Google Drive link
    const String fileId = '1pjUQ2NctS2iTjaa6risUrGyBJmh8rl6K';
    // Direct download URL (forces download instead of preview)
    final String downloadUrl =
        'https://drive.google.com/uc?export=download&id=$fileId';

    if (kIsWeb) {
      // Web: Use AnchorElement to trigger download
      final anchor = html.AnchorElement(href: downloadUrl)
        ..setAttribute('download', 'Oussema_KHELIFI_Resume.pdf')
        ..click();
    } else {
      // Mobile / Desktop: Use url_launcher to open in browser
      final Uri uri = Uri.parse(downloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $downloadUrl');
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
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
                  SliverToBoxAdapter(child: _buildAboutSection()),
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

  // ─── LANGUAGE TOGGLE ───────────────────────────────────────────────────────
  Widget _buildLangToggle() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _toggleLanguage,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.navy.withOpacity(0.06),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [_langPill('EN', !_isFr), _langPill('FR', _isFr)],
          ),
        ),
      ),
    );
  }

  Widget _langPill(String code, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.navy : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        code,
        style: AppTextStyles.label(12).copyWith(
          color: active ? Colors.white : AppColors.textSub,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
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
                const SizedBox(height: 12),
                _buildLangToggle(),
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
              leading: Icon(item.$3, color: AppColors.accentLight, size: 20),
              title: Text(
                item.$1,
                style: AppTextStyles.body(14).copyWith(color: Colors.white70),
              ),
              onTap: () => _scrollToSection(item.$2),
            ),
          ),
        ],
      ),
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
          _buildMonogram(),
          Row(
            children: [
              _buildLangToggle(),
              const SizedBox(width: 8),
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
          _buildMonogram(),
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
              padding: const EdgeInsets.only(left: 32),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _scrollToSection(item.$2),
                  child: Text(
                    item.$1,
                    style: AppTextStyles.label(
                      14,
                    ).copyWith(color: AppColors.textSub),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 36),
          _buildLangToggle(),
        ],
      ),
    );
  }

  Widget _buildMonogram() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'OK',
            style: AppTextStyles.mono(18).copyWith(fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: '.',
            style: AppTextStyles.mono(18).copyWith(color: AppColors.gold),
          ),
        ],
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
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppTextStyles.body(16),
            textAlign: TextAlign.center,
          ),
        ],
      ],
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

  Widget _buildDesktopHero() => Container(
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

  Widget _buildMobileHero() => Container(
    padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
    child: Column(
      children: [
        _buildHeroImageMobile(),
        const SizedBox(height: 48),
        _buildHeroText(),
      ],
    ),
  );

  Widget _buildHeroImageDesktop() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (_, v, child) =>
          Transform.scale(scale: 0.7 + 0.3 * v, child: child),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(380, 0.12),
          _ring(320, 0.2),
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
          Positioned(
            bottom: 60,
            right: 30,
            child: _floatingBadge('Quality\nEngineer', Icons.verified_rounded),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: _floatingBadge('Flutter\nDev', Icons.code_rounded),
          ),
        ],
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

  Widget _buildHeroImageMobile() => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeOutBack,
    builder: (_, v, child) =>
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

  Widget _floatingBadge(String label, IconData icon) => Container(
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

  Widget _buildHeroText() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (_, v, child) => Opacity(opacity: v, child: child),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Available tag
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
                  s.heroAvailable,
                  style: AppTextStyles.label(
                    12,
                  ).copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            s.heroTitle,
            style: AppTextStyles.display(
              64,
            ).copyWith(color: AppColors.navy, letterSpacing: -1.5),
          ),
          const SizedBox(height: 20),
          Text(
            s.heroSubtitle,
            style: AppTextStyles.body(18).copyWith(height: 1.6),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(s.heroChip1),
              _chip(s.heroChip2),
              _chip(s.heroChip3),
              _chip(s.heroChip4),
            ],
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _primaryBtn(s.heroCvBtn, Icons.download_rounded, _downloadCV),
              _secondaryBtn(
                s.heroContactBtn,
                Icons.arrow_forward_rounded,
                () => _scrollToSection(_contactKey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) => Container(
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

  Widget _primaryBtn(String text, IconData icon, VoidCallback onPressed) =>
      MouseRegion(
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

  Widget _secondaryBtn(String text, IconData icon, VoidCallback onPressed) =>
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: AppTextStyles.label(
                    15,
                  ).copyWith(color: AppColors.text),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: AppColors.accent, size: 18),
              ],
            ),
          ),
        ),
      );

  // ─── ABOUT ME ──────────────────────────────────────────────────────────────
  Widget _buildAboutSection() {
    return AnimatedSection(
      key: _aboutKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(s.aboutEyebrow, s.aboutTitle, s.aboutSub),
            const SizedBox(height: 64),

            // ── Bio + Stats row
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                final isDesktop =
                    sizingInfo.deviceScreenType == DeviceScreenType.desktop;
                final bioBlock = _buildAboutBio();
                final statsBlock = _buildAboutStats();
                return isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: bioBlock),
                          const SizedBox(width: 48),
                          Expanded(flex: 5, child: statsBlock),
                        ],
                      )
                    : Column(
                        children: [
                          bioBlock,
                          const SizedBox(height: 40),
                          statsBlock,
                        ],
                      );
              },
            ),

            const SizedBox(height: 56),

            // ── Values row
            _buildAboutValues(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.aboutBio1,
          style: AppTextStyles.body(15).copyWith(color: AppColors.textSub),
        ),
        const SizedBox(height: 20),
        Text(
          s.aboutBio2,
          style: AppTextStyles.body(15).copyWith(color: AppColors.textSub),
        ),
        const SizedBox(height: 20),
        Text(
          s.aboutBio3,
          style: AppTextStyles.body(15).copyWith(color: AppColors.textSub),
        ),
        const SizedBox(height: 32),
        // Signature-style highlight quote
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.accentGlow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accent.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _isFr
                      ? '"La qualité n\'est pas un acte, c\'est une habitude."'
                      : '"Quality is not an act, it is a habit."',
                  style: AppTextStyles.body(14).copyWith(
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

  Widget _buildAboutStats() {
    final stats = [
      ('2+', s.aboutStatYears),
      ('10+', s.aboutStatProjects),
      ('7+', s.aboutStatCerts),
      ('90%', s.aboutStatAudit),
    ];
    return Column(
      children: [
        // Profile card
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withOpacity(0.25),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Oussema KHELIFI',
                style: AppTextStyles.label(16).copyWith(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                _isFr
                    ? 'Ingénieur Systèmes Industriels'
                    : 'Industrial Systems Engineer',
                style: AppTextStyles.body(12).copyWith(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '📍 Tunis, Tunisia',
                style: AppTextStyles.body(12).copyWith(color: Colors.white38),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Stats grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: stats
              .map(
                (stat) => Container(
                  padding: const EdgeInsets.all(16),
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
                          28,
                        ).copyWith(color: AppColors.accent, height: 1.0),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat.$2,
                        style: AppTextStyles.body(11).copyWith(height: 1.3),
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

  Widget _buildAboutValues() {
    final values = [
      (Icons.rule_rounded, s.aboutVal1, s.aboutVal1Sub, AppColors.accent),
      (Icons.lightbulb_rounded, s.aboutVal2, s.aboutVal2Sub, AppColors.teal),
      (Icons.school_rounded, s.aboutVal3, s.aboutVal3Sub, AppColors.gold),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.aboutValuesTitle, style: AppTextStyles.heading(22)),
        const SizedBox(height: 24),
        ResponsiveBuilder(
          builder: (context, sizingInfo) {
            final isDesktop =
                sizingInfo.deviceScreenType == DeviceScreenType.desktop;
            if (isDesktop) {
              return Row(
                children: values
                    .map(
                      (v) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: _valueCard(v.$1, v.$2, v.$3, v.$4),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Column(
              children: values
                  .map(
                    (v) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _valueCard(v.$1, v.$2, v.$3, v.$4),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _valueCard(IconData icon, String title, String sub, Color accent) =>
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 22, color: accent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.label(14)),
                  const SizedBox(height: 4),
                  Text(sub, style: AppTextStyles.body(12)),
                ],
              ),
            ),
          ],
        ),
      );

  // ─── SERVICES ──────────────────────────────────────────────────────────────
  Widget _buildServicesSection() {
    return AnimatedSection(
      key: _servicesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader(s.svcEyebrow, s.svcTitle, s.svcSub),
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
                  childAspectRatio: cols == 1 ? 1.8 : 0.95,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _serviceCard(
                      Icons.search_rounded,
                      s.svc1Title,
                      s.svc1Desc,
                      0,
                    ),
                    _serviceCard(
                      Icons.code_rounded,
                      s.svc2Title,
                      s.svc2Desc,
                      1,
                    ),
                    _serviceCard(
                      Icons.engineering_rounded,
                      s.svc3Title,
                      s.svc3Desc,
                      2,
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

  static const List<Color> _svcAccents = [
    AppColors.accent,
    AppColors.teal,
    AppColors.gold,
  ];

  Widget _serviceCard(IconData icon, String title, String desc, int idx) {
    final ac = _svcAccents[idx % _svcAccents.length];
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: ac.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: ac),
          ),
          const SizedBox(height: 24),
          Text(title, style: AppTextStyles.heading(20)),
          const SizedBox(height: 12),
          Text(desc, style: AppTextStyles.body(14)),
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
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(s.eduEyebrow, s.eduTitle, s.eduSub),
            const SizedBox(height: 64),
            _eduItem(
              s.edu1Degree,
              s.edu1Inst,
              '2020 – 2023',
              s.edu1Desc,
              true,
              false,
            ),
            _eduItem(
              s.edu2Degree,
              s.edu2Inst,
              '2018 – 2020',
              s.edu2Desc,
              false,
              false,
            ),
            _eduItem(s.edu3Degree, s.edu3Inst, '2018', s.edu3Desc, false, true),
          ],
        ),
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
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    inst,
                    style: AppTextStyles.body(
                      14,
                    ).copyWith(color: AppColors.accent),
                  ),
                  const SizedBox(height: 8),
                  Text(desc, style: AppTextStyles.body(14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── EXPERIENCE — FULL VISUAL TIMELINE ─────────────────────────────────────
  Widget _buildExperienceSection() {
    final items = [
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
                'Élaboration et mise en œuvre d\'un plan d\'action de liquidation des stocks inactifs en collaboration avec les méthodes et la logistique.',
                'Suivi des budgets OPEX, identification et justification des écarts, validation des factures fournisseurs via Sage X3.',
                'Réalisation des inventaires physiques et analyse des écarts de stocks avec justifications appropriées.',
              ]
            : [
                'Prepared monthly reports monitoring raw materials near expiry and inactive stocks, evaluating retention or destruction decisions.',
                'Developed and implemented an action plan to liquidate inactive stocks in collaboration with Methods and Logistics.',
                'Monitored OPEX budgets, identified variances, and validated supplier invoices via Sage X3 to protect product margins.',
                'Conducted physical inventories, adjusted stocks with appropriate justifications, and analyzed stock discrepancies.',
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
                'Analyse des manuels qualité clients, constitution des dossiers PPAP et organisation des audits clients pour obtenir les signatures PSW/ISIR.',
                'Animation des routines QRQC/QRAP, déploiement des actions correctives et mise en œuvre des AMDEC et Plans de Contrôle.',
                'Développement d\'une solution VBA de détection automatique des QR codes en double suite à une réclamation Valeo.',
                'Préparation et réussite d\'un audit processus VDA 6.3 pour un projet BMW avec un score de 90%, permettant le démarrage série.',
              ]
            : [
                'Analyzed customer quality manuals, prepared PPAP files, and organized customer audits to secure PSW/ISIR signatures.',
                'Led QRQC/QRAP routines to identify root causes, deploy corrective actions, and implement FMEA and Control Plans.',
                'Developed a VBA solution for automatic duplicate QR code detection (scanner + visual alerts) following a Valeo complaint.',
                'Prepared and passed a VDA 6.3 process audit for a BMW project with a 90% score, enabling series production start-up.',
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
                'Développement d\'une application de maintenance basée sur l\'IA avec Flutter (frontend) et Flask (backend).',
                'Conception d\'une fonctionnalité d\'automatisation pour générer des fichiers Excel liés à la maintenance préventive.',
                'Mise en place de deux interfaces distinctes : administrateurs (monitoring) et opérateurs (vérifications dématérialisées).',
              ]
            : [
                'Developed an AI-based maintenance application with Flutter (frontend) and Flask (backend) to optimize maintenance personnel efficiency.',
                'Designed an automation feature to generate Excel files related to preventive maintenance, reducing manual effort.',
                'Implemented two distinct interfaces: administrators (monitoring, updating) and operators (paperless checks, real-time assistance).',
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
                'Développement d\'un site vitrine Flutter Web présentant les activités de formation Lean Management et Six Sigma.',
                'Intégration de modules interactifs mettant en avant les cours Lean Six Sigma.',
                'Conception d\'une interface responsive et déploiement en ligne via Vercel.',
              ]
            : [
                'Built a corporate showcase website using Flutter Web presenting Lean Management and Six Sigma training activities.',
                'Integrated interactive modules highlighting Lean Six Sigma courses.',
                'Designed a responsive, intuitive interface and deployed it online via Vercel.',
              ],
        tags: ['Flutter', 'Responsive Design', 'Vercel'],
      ),
    ];

    return AnimatedSection(
      key: _experienceKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader(s.expEyebrow, s.expTitle, s.expSub),
            const SizedBox(height: 64),

            // Full timeline
            ...List.generate(items.length, (i) {
              final item = items[i];
              final isLast = i == items.length - 1;
              return _buildTimelineEntry(item, isLast);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEntry(_ExpData item, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left: timeline spine
          SizedBox(
            width: 60,
            child: Column(
              children: [
                // Icon node
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: item.accentColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item.accentColor.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 20),
                ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            item.accentColor.withOpacity(0.6),
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

          const SizedBox(width: 20),

          // ── Right: card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    // Card header
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                      decoration: BoxDecoration(
                        color: item.accentColor.withOpacity(0.05),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        border: Border(
                          bottom: BorderSide(color: AppColors.divider),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: AppTextStyles.heading(18),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.business_rounded,
                                      size: 14,
                                      color: item.accentColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.company,
                                      style: AppTextStyles.label(
                                        13,
                                      ).copyWith(color: item.accentColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: item.accentColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item.period,
                                  style: AppTextStyles.label(
                                    11,
                                  ).copyWith(color: item.accentColor),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.divider),
                                ),
                                child: Text(
                                  item.type,
                                  style: AppTextStyles.body(
                                    11,
                                  ).copyWith(color: AppColors.textMuted),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bullets
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...item.bullets.map(
                            (b) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(
                                      top: 7,
                                      right: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item.accentColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: AppTextStyles.body(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: item.tags
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.divider,
                                      ),
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
    final projects = [
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
                'Création automatisée de Value Stream Maps avec recommandations d\'amélioration générées par IA via OpenRouter API.',
                'Calculs Lean intégrés : Takt Time, Lead Time, ratio VA/NVA, indicateurs avancés (Mura, Muri, Muda, Flow Efficiency).',
                'Export PDF automatique des analyses pour le reporting.',
              ]
            : [
                'Automated Value Stream Mapping creation and analysis with AI-generated improvement recommendations via OpenRouter API.',
                'Integrated Lean calculations: Takt Time, Lead Time, Value-Added/Non-Value-Added ratio, plus advanced indicators.',
                'Implemented automatic PDF export of analyses for streamlined reporting.',
              ],
        technologies: 'Flutter · OpenRouter API · Lean Manufacturing',
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
                'Digitalisation de la méthodologie 8D avec une interface guidée pour documenter les 8 disciplines, rôles et informations de réunion.',
                'Intégration d\'outils d\'analyse des causes racines : 5 Pourquoi, diagramme Ishikawa, AMDEC et arbre des défaillances.',
                'Capture d\'images pour les preuves visuelles et génération automatique de rapports PDF professionnels.',
              ]
            : [
                'Digitalized the 8D methodology with a guided interface to document all eight disciplines, team roles, and meeting information.',
                'Integrated root cause analysis tools: 5 Why, Ishikawa diagram, FMEA, and Fault Tree Analysis.',
                'Enabled image capture for visual evidence and automated generation of professional PDF reports.',
              ],
        technologies: 'Flutter · Quality Tools · PDF Automation',
      ),
      Project(
        id: 'supplierclaim',
        name: _isFr
            ? 'Gestionnaire de Réclamations Fournisseur'
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
                'Génération automatisée des réclamations fournisseurs avec formulaire structuré (catégorie, données fournisseur, niveau de gravité).',
                'Intégration de la capture d\'images pour ajouter des preuves photographiques directement dans le rapport.',
                'Génération automatique de rapports PDF résumant les détails de la réclamation et les demandes d\'actions correctives.',
              ]
            : [
                'Automated supplier claim generation with a structured form capturing category, supplier data, and severity level.',
                'Integrated image capture to add photographic evidence directly into the claim report.',
                'Automated PDF report generation summarizing claim details and corrective action requests.',
              ],
        technologies: 'Flutter · PDF Generator · Quality Management',
      ),
      Project(
        id: 'smartInventory',
        name: _isFr
            ? 'Application Inventaire Intelligent'
            : 'Intelligent Inventory App',
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
                'Numérisation de la gestion d\'entrepôt avec scan de codes-barres pour capturer les étiquettes produits et structurer automatiquement les données.',
                'Synchronisation cloud pour sauvegarder les données d\'inventaire en format Excel avec ajustement automatique des quantités.',
                'Base de données locale pour calculer les KPIs (taux d\'occupation, coût estimé du stock) et reporting Excel automatisé.',
              ]
            : [
                'Digitized warehouse management with barcode scanning to capture product labels and automatically structure data.',
                'Implemented cloud synchronization to save inventory data in Excel format with automatic quantity adjustment.',
                'Developed local database to calculate KPIs and automated Excel reporting with transaction history.',
              ],
        technologies: 'Flutter · Excel Automation · Data Analysis',
      ),
    ];

    return AnimatedSection(
      key: _projectsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(s.projEyebrow, s.projTitle, s.projSub),
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
                  children: projects.map((p) => _projectCard(p)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectCard(Project project) {
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

    return AnimatedSection(
      key: _skillsKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: AppColors.surface,
        child: Column(
          children: [
            _buildSectionHeader(s.skillEyebrow, s.skillTitle, s.skillSub),
            const SizedBox(height: 64),
            ScreenTypeLayout(
              mobile: Column(
                children: [
                  _skillBlock(s.skillCat1, cats[s.skillCat1]!),
                  const SizedBox(height: 16),
                  _skillBlock(s.skillCat2, cats[s.skillCat2]!),
                  const SizedBox(height: 16),
                  _skillBlock(s.skillCat3, cats[s.skillCat3]!),
                ],
              ),
              desktop: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _skillBlock(s.skillCat1, cats[s.skillCat1]!)),
                  const SizedBox(width: 16),
                  Expanded(child: _skillBlock(s.skillCat2, cats[s.skillCat2]!)),
                  const SizedBox(width: 16),
                  Expanded(child: _skillBlock(s.skillCat3, cats[s.skillCat3]!)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _skillBlock(
              s.skillCat4,
              cats[s.skillCat4]!,
              accentColor: AppColors.navy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _skillBlock(
    String title,
    List<String> skills, {
    Color accentColor = AppColors.accent,
  }) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: Colors.white,
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
                    color: AppColors.surface,
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

  // ─── LANGUAGES ─────────────────────────────────────────────────────────────
  Widget _buildLanguagesSection() {
    return AnimatedSection(
      key: _languagesKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
        color: Colors.white,
        child: Column(
          children: [
            _buildSectionHeader(s.langEyebrow, s.langTitle, ''),
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
                    _langCard('Arabic', s.langNative, '🇹🇳', isMobile),
                    _langCard('English', s.langProf, '🇬🇧', isMobile),
                    _langCard('French', s.langProf, '🇫🇷', isMobile),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _langCard(String lang, String level, String flag, bool isMobile) =>
      Container(
        width: isMobile ? 180 : 220,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surface,
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
            Text(lang, style: AppTextStyles.heading(18)),
            const SizedBox(height: 6),
            Text(
              level,
              style: AppTextStyles.body(13).copyWith(color: AppColors.accent),
            ),
          ],
        ),
      );

  // ─── CAROUSELS ─────────────────────────────────────────────────────────────
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
      carouselHeight: 420,
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
            items: images
                .map(
                  (path) => Container(
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
                        path,
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
                  ),
                )
                .toList(),
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
            s.footerTitle,
            style: AppTextStyles.display(48).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            s.footerSub,
            style: AppTextStyles.body(16).copyWith(color: Colors.white54),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _contactPill(
                Icons.email_rounded,
                'oussemakhlifi999@gmail.com',
                () => _launchUrl('mailto:oussemakhlifi999@gmail.com'),
              ),
              _contactPill(
                Icons.link_rounded,
                'LinkedIn',
                () => _launchUrl('https://www.linkedin.com/in/oussamakhlifi/'),
              ),
              _contactPill(
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
            s.footerRights,
            style: AppTextStyles.body(12).copyWith(color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _contactPill(IconData icon, String label, VoidCallback onTap) =>
      MouseRegion(
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
                  style: AppTextStyles.label(
                    14,
                  ).copyWith(color: Colors.white70),
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
  int _currentImageIndex = 0;
  late CarouselSliderController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
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
        title: Text(widget.project.name, style: AppTextStyles.heading(18)),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    items: widget.project.additionalImagePaths
                        .map(
                          (path) => Container(
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
                          ),
                        )
                        .toList(),
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
                  Text(s.projDetailFeatures, style: AppTextStyles.heading(20)),
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
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
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
        if (!_done && info.visibleFraction > 0.05) {
          _done = true;
          _controller.forward();
        }
      },
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}
