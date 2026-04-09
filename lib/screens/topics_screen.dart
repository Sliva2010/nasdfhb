import 'package:flutter/material.dart';
import '../utils/theme.dart';

class Topic {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int lessonsCount;

  const Topic({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.lessonsCount,
  });
}

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Topic> _topics = const [
    Topic(
      title: 'Математика',
      description: 'Алгебра, геометрия, анализ',
      icon: Icons.calculate_rounded,
      color: Color(0xFFE94560),
      lessonsCount: 24,
    ),
    Topic(
      title: 'Физика',
      description: 'Механика, оптика, электричество',
      icon: Icons.bolt_rounded,
      color: Color(0xFFFFB800),
      lessonsCount: 18,
    ),
    Topic(
      title: 'Химия',
      description: 'Органическая и неорганическая',
      icon: Icons.science_rounded,
      color: Color(0xFF4ADE80),
      lessonsCount: 20,
    ),
    Topic(
      title: 'Биология',
      description: 'Ботаника, зоология, анатомия',
      icon: Icons.park_rounded,
      color: Color(0xFF60A5FA),
      lessonsCount: 16,
    ),
    Topic(
      title: 'История',
      description: 'Мировая и отечественная',
      icon: Icons.menu_book_rounded,
      color: Color(0xFFC084FC),
      lessonsCount: 22,
    ),
    Topic(
      title: 'Программирование',
      description: 'Python, JavaScript, алгоритмы',
      icon: Icons.code_rounded,
      color: Color(0xFFF472B6),
      lessonsCount: 30,
    ),
    Topic(
      title: 'Английский язык',
      description: 'Грамматика, лексика, разговор',
      icon: Icons.translate_rounded,
      color: Color(0xFFFB923C),
      lessonsCount: 28,
    ),
    Topic(
      title: 'Литература',
      description: 'Классика и современность',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF34D399),
      lessonsCount: 15,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text('Темы обучения'),
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE94560).withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.lightbulb_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Выберите тему',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Начните изучение прямо сейчас',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final topic = _topics[index];
                    return _TopicCard(
                      topic: topic,
                      animationController: _animationController,
                      index: index,
                    );
                  },
                  childCount: _topics.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatefulWidget {
  final Topic topic;
  final AnimationController animationController;
  final int index;

  const _TopicCard({
    required this.topic,
    required this.animationController,
    required this.index,
  });

  @override
  State<_TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<_TopicCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          widget.index * 0.08,
          (widget.index * 0.08) + 0.5,
          curve: Curves.elasticOut,
        ),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          widget.index * 0.08,
          (widget.index * 0.08) + 0.4,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isHovered = true),
          onTapUp: (_) => setState(() => _isHovered = false),
          onTapCancel: () => setState(() => _isHovered = false),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Тема "${widget.topic.title}" скоро будет доступна!'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF1A1A2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF2A2A3E)),
                ),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? widget.topic.color
                    : const Color(0xFF2A2A3E),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.topic.color.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.topic.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.topic.icon,
                    color: widget.topic.color,
                    size: 26,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.topic.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.topic.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline_rounded,
                      size: 16,
                      color: widget.topic.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.topic.lessonsCount} уроков',
                      style: TextStyle(
                        fontSize: 11,
                        color: widget.topic.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
