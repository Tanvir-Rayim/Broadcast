import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

// Root App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Broadcast App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor:
                  Colors.deepPurple,
            ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Home Page with Navigation Drawer
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Broadcast Receiver',
    'Image Scale',
    'Video',
    'Audio',
  ];

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return const BroadcastReceiverScreen();
      case 1:
        return const ImageScaleScreen();
      case 2:
        return const VideoScreen();
      case 3:
        return const AudioScreen();
      default:
        return const BroadcastReceiverScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons
                    .broadcast_on_personal,
              ),
              title: const Text(
                'Broadcast Receiver',
              ),
              selected:
                  _selectedIndex == 0,
              onTap: () {
                setState(
                  () => _selectedIndex =
                      0,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.image,
              ),
              title: const Text(
                'Image Scale',
              ),
              selected:
                  _selectedIndex == 1,
              onTap: () {
                setState(
                  () => _selectedIndex =
                      1,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.video_library,
              ),
              title: const Text(
                'Video',
              ),
              selected:
                  _selectedIndex == 2,
              onTap: () {
                setState(
                  () => _selectedIndex =
                      2,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.audiotrack,
              ),
              title: const Text(
                'Audio',
              ),
              selected:
                  _selectedIndex == 3,
              onTap: () {
                setState(
                  () => _selectedIndex =
                      3,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }
}

// A. BROADCAST RECEIVER

/// First Screen – Spinner to choose broadcast type + Next button
class BroadcastReceiverScreen
    extends StatefulWidget {
  const BroadcastReceiverScreen({
    super.key,
  });

  @override
  State<BroadcastReceiverScreen>
  createState() =>
      _BroadcastReceiverScreenState();
}

class _BroadcastReceiverScreenState
    extends
        State<BroadcastReceiverScreen> {
  String _selectedOption =
      'Custom broadcast receiver';

  final List<String> _options = [
    'Custom broadcast receiver',
    'System battery notification receiver',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          24.0,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Text(
              'Select Broadcast Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedOption,
              items: _options
                  .map(
                    (option) =>
                        DropdownMenuItem<
                          String
                        >(
                          value: option,
                          child: Text(
                            option,
                          ),
                        ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOption =
                      value!;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_selectedOption ==
                    _options[0]) {
                  // Custom broadcast – go to input screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CustomBroadcastInputScreen(),
                    ),
                  );
                } else {
                  // Battery notification – go to battery screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const BatteryReceiverScreen(),
                    ),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Second Screen (Option 1) – Text input for custom broadcast message
class CustomBroadcastInputScreen
    extends StatefulWidget {
  const CustomBroadcastInputScreen({
    super.key,
  });

  @override
  State<CustomBroadcastInputScreen>
  createState() =>
      _CustomBroadcastInputScreenState();
}

class _CustomBroadcastInputScreenState
    extends
        State<
          CustomBroadcastInputScreen
        > {
  final TextEditingController
  _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Broadcast Input',
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            24.0,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              const Text(
                'Enter your broadcast message:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border:
                      OutlineInputBorder(),
                  hintText:
                      'Type your message here',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  final message =
                      _controller.text
                          .trim();
                  if (message.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a message',
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CustomBroadcastReceiverScreen(
                            message:
                                message,
                          ),
                    ),
                  );
                },
                child: const Text(
                  'Send Broadcast',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Third Screen (Option 1) – Custom Broadcast Receiver
class CustomBroadcastReceiverScreen
    extends StatefulWidget {
  final String message;
  const CustomBroadcastReceiverScreen({
    super.key,
    required this.message,
  });

  @override
  State<CustomBroadcastReceiverScreen>
  createState() =>
      _CustomBroadcastReceiverScreenState();
}

class _CustomBroadcastReceiverScreenState
    extends
        State<
          CustomBroadcastReceiverScreen
        > {
  String _receivedMessage = '';
  bool _received = false;

  @override
  void initState() {
    super.initState();
    // Simulate receiving a custom broadcast after a short delay
    _simulateBroadcast();
  }

  Future<void>
  _simulateBroadcast() async {
    // Simulate broadcast delay
    await Future.delayed(
      const Duration(seconds: 1),
    );
    if (mounted) {
      setState(() {
        _receivedMessage =
            widget.message;
        _received = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Broadcast Receiver',
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            24.0,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              Icon(
                _received
                    ? Icons.check_circle
                    : Icons
                          .hourglass_top,
                size: 64,
                color: _received
                    ? Colors.green
                    : Colors.orange,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                _received
                    ? 'Broadcast Received!'
                    : 'Waiting for broadcast...',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (_received)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                          16.0,
                        ),
                    child: Column(
                      children: [
                        const Text(
                          'Received Message:',
                          style: TextStyle(
                            fontSize:
                                16,
                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _receivedMessage,
                          style:
                              const TextStyle(
                                fontSize:
                                    18,
                              ),
                          textAlign:
                              TextAlign
                                  .center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Second Screen (Option 2) – System Battery Notification Receiver
class BatteryReceiverScreen
    extends StatefulWidget {
  const BatteryReceiverScreen({
    super.key,
  });

  @override
  State<BatteryReceiverScreen>
  createState() =>
      _BatteryReceiverScreenState();
}

class _BatteryReceiverScreenState
    extends
        State<BatteryReceiverScreen> {
  final Battery _battery = Battery();
  int _batteryLevel = -1;
  BatteryState _batteryState =
      BatteryState.unknown;
  late StreamSubscription<BatteryState>
  _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
    _batteryStateSubscription = _battery
        .onBatteryStateChanged
        .listen((BatteryState state) {
          setState(() {
            _batteryState = state;
          });
          _getBatteryLevel();
        });
  }

  Future<void>
  _getBatteryLevel() async {
    final level =
        await _battery.batteryLevel;
    if (mounted) {
      setState(() {
        _batteryLevel = level;
      });
    }
  }

  @override
  void dispose() {
    _batteryStateSubscription.cancel();
    super.dispose();
  }

  IconData _getBatteryIcon() {
    if (_batteryLevel < 0)
      return Icons.battery_unknown;
    if (_batteryState ==
        BatteryState.charging)
      return Icons
          .battery_charging_full;
    if (_batteryLevel <= 20)
      return Icons.battery_1_bar;
    if (_batteryLevel <= 40)
      return Icons.battery_3_bar;
    if (_batteryLevel <= 60)
      return Icons.battery_4_bar;
    if (_batteryLevel <= 80)
      return Icons.battery_5_bar;
    return Icons.battery_full;
  }

  Color _getBatteryColor() {
    if (_batteryLevel < 0)
      return Colors.grey;
    if (_batteryLevel <= 20)
      return Colors.red;
    if (_batteryLevel <= 50)
      return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Battery Receiver',
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            24.0,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              Icon(
                _getBatteryIcon(),
                size: 80,
                color:
                    _getBatteryColor(),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                _batteryLevel >= 0
                    ? 'Battery Level: $_batteryLevel%'
                    : 'Reading battery...',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Status: ${_batteryState.name.toUpperCase()}',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      Colors.grey[700],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton.icon(
                onPressed:
                    _getBatteryLevel,
                icon: const Icon(
                  Icons.refresh,
                ),
                label: const Text(
                  'Refresh',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// B. IMAGE SCALE – Load from internet + pinch-to-zoom
class ImageScaleScreen
    extends StatelessWidget {
  const ImageScaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        panEnabled: true,
        minScale: 0.5,
        maxScale: 4.0,
        child: Image.network(
          'https://picsum.photos/800/600',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null)
              return child;
            return Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress
                            .expectedTotalBytes !=
                        null
                    ? loadingProgress
                              .cumulativeBytesLoaded /
                          loadingProgress
                              .expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder:
              (
                context,
                error,
                stackTrace,
              ) {
                return const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 64,
                        color:
                            Colors.red,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Failed to load image.\nCheck internet connection.',
                      ),
                    ],
                  ),
                );
              },
        ),
      ),
    );
  }
}

// C. VIDEO – Play a video within the app
class VideoScreen
    extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() =>
      _VideoScreenState();
}

class _VideoScreenState
    extends State<VideoScreen> {
  late VideoPlayerController
  _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize()
              .then((_) {
                if (mounted) {
                  setState(() {
                    _isInitialized =
                        true;
                  });
                }
              })
              .catchError((error) {
                if (mounted) {
                  setState(() {
                    _hasError = true;
                  });
                }
              });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = d.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Failed to load video.\nCheck internet connection.',
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller
              .value
              .aspectRatio,
          child: VideoPlayer(
            _controller,
          ),
        ),
        const SizedBox(height: 16),
        // Progress bar
        ValueListenableBuilder<
          VideoPlayerValue
        >(
          valueListenable: _controller,
          builder: (context, value, child) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
              child: Column(
                children: [
                  Slider(
                    value: value
                        .position
                        .inMilliseconds
                        .toDouble(),
                    max: value
                        .duration
                        .inMilliseconds
                        .toDouble(),
                    onChanged: (newValue) {
                      _controller.seekTo(
                        Duration(
                          milliseconds:
                              newValue
                                  .toInt(),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Text(
                        _formatDuration(
                          value
                              .position,
                        ),
                      ),
                      Text(
                        _formatDuration(
                          value
                              .duration,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        // Playback controls
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 36,
              icon: const Icon(
                Icons.replay_10,
              ),
              onPressed: () {
                final newPos =
                    _controller
                        .value
                        .position -
                    const Duration(
                      seconds: 10,
                    );
                _controller.seekTo(
                  newPos,
                );
              },
            ),
            const SizedBox(width: 16),
            ValueListenableBuilder<
              VideoPlayerValue
            >(
              valueListenable:
                  _controller,
              builder: (context, value, child) {
                return IconButton(
                  iconSize: 48,
                  icon: Icon(
                    value.isPlaying
                        ? Icons
                              .pause_circle
                        : Icons
                              .play_circle,
                  ),
                  onPressed: () {
                    if (value
                        .isPlaying) {
                      _controller
                          .pause();
                    } else {
                      _controller
                          .play();
                    }
                  },
                );
              },
            ),
            const SizedBox(width: 16),
            IconButton(
              iconSize: 36,
              icon: const Icon(
                Icons.forward_10,
              ),
              onPressed: () {
                final newPos =
                    _controller
                        .value
                        .position +
                    const Duration(
                      seconds: 10,
                    );
                _controller.seekTo(
                  newPos,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// D. AUDIO – Play audio within the app
class AudioScreen
    extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() =>
      _AudioScreenState();
}

class _AudioScreenState
    extends State<AudioScreen> {
  final AudioPlayer _audioPlayer =
      AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  static const String _audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged
        .listen((d) {
          if (mounted)
            setState(
              () => _duration = d,
            );
        });

    _audioPlayer.onPositionChanged
        .listen((p) {
          if (mounted)
            setState(
              () => _position = p,
            );
        });

    _audioPlayer.onPlayerStateChanged
        .listen((state) {
          if (mounted) {
            setState(() {
              _isPlaying =
                  state ==
                  PlayerState.playing;
            });
          }
        });

    _audioPlayer.onPlayerComplete
        .listen((_) {
          if (mounted) {
            setState(() {
              _isPlaying = false;
              _position = Duration.zero;
            });
          }
        });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        UrlSource(_audioUrl),
      );
    }
  }

  Future<void> _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _position = Duration.zero;
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = d.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          24.0,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.music_note,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
            const Text(
              'SoundHelix Song 1',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sample Audio Track',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // Progress slider
            Slider(
              value: _position
                  .inMilliseconds
                  .toDouble(),
              max:
                  _duration
                          .inMilliseconds >
                      0
                  ? _duration
                        .inMilliseconds
                        .toDouble()
                  : 1.0,
              onChanged: (value) {
                _audioPlayer.seek(
                  Duration(
                    milliseconds: value
                        .toInt(),
                  ),
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Text(
                    _formatDuration(
                      _position,
                    ),
                  ),
                  Text(
                    _formatDuration(
                      _duration,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Controls
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: [
                IconButton(
                  iconSize: 48,
                  icon: Icon(
                    _isPlaying
                        ? Icons
                              .pause_circle_filled
                        : Icons
                              .play_circle_filled,
                    color: Colors
                        .deepPurple,
                  ),
                  onPressed: _playPause,
                ),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(
                    Icons.stop_circle,
                    color: Colors.red,
                  ),
                  onPressed: _stop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
