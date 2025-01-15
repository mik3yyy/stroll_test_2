import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stroll_test/core/extensions/context_extensions.dart';
import 'package:stroll_test/core/extensions/list_extensions.dart';
import 'package:stroll_test/core/extensions/widget_extensions.dart';
import 'package:stroll_test/core/gen/assets.gen.dart';
import 'package:stroll_test/core/widgets/custom_text_button.dart';

import 'package:stroll_test/features/home/presentation/widgets/ring_widget.dart';

import 'package:badges/badges.dart' as badges;

enum AudioState { recording, stoppedRecording, pause, play, none }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? recordedFilePath;
  final RecorderController recorderController = RecorderController();
  final PlayerController playerController = PlayerController();
  AudioState audioState = AudioState.none;
  late StreamSubscription<Duration> _durationSubscription;

  String playerIcon = Assets.application.assets.images.startRecording.path;
  @override
  void initState() {
    super.initState();

    recorderController.checkPermission();
    playerController.onCompletion.listen((_) {
      playerIcon = Assets.application.assets.images.startRecording.path;
      handleAudioState(AudioState.pause);
      playerController.stopPlayer();
      playerController.preparePlayer(path: recordedFilePath!);
      setState(() {});
      // Handle the completion
    });
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    _durationSubscription.cancel();

    super.dispose();
  }

  void handleAudioState(AudioState state) {
    audioState = state;
    switch (state) {
      case AudioState.recording:
        playerIcon = Assets.application.assets.images.stopRecording.path;

        // Add logic for starting or handling recording
        break;

      case AudioState.stoppedRecording:
        playerIcon = Assets.application.assets.images.playRecording.path;
        // Add logic for stopping recording
        break;

      case AudioState.pause:
        playerIcon = Assets.application.assets.images.playRecording.path;
        // Add logic for pausing audio
        break;

      case AudioState.play:
        playerIcon = Assets.application.assets.images.pauseRecording.path;
        // Add logic for playing audio
        break;

      case AudioState.none:
        playerIcon = Assets.application.assets.images.startRecording.path;
        // Handle case when there is no audio action
        break;
    }
    setState(() {});
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              child: Stack(
            children: [
              Positioned.fill(
                child: Assets.application.assets.images.backgroundVideo
                    .image(fit: BoxFit.cover),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 150,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        context.colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.8],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      // Progress bar
                      Container(
                        width: context.screenWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            LinearProgressIndicator(
                              value: 1, // Example progress value
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              borderRadius: BorderRadius.circular(4),
                            ).withExpanded(),
                            const Gap(10),
                            LinearProgressIndicator(
                              value: 0, // Example progress value
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              borderRadius: BorderRadius.circular(4),
                            ).withExpanded(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 30,
                        width: context.screenWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            // Title
                            Text("Angelina, 28",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )),
                            // Menu icon
                            const Icon(Icons.more_horiz, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    height: 180,
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [context.colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.1, 1]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        badges.Badge(
                          position: badges.BadgePosition.bottomStart(
                              bottom: -14, start: -17),
                          showBadge: true,
                          ignorePointer: false,
                          onTap: () {},
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.instagram,
                            badgeColor: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(0),
                            elevation: 0,
                          ),
                          badgeAnimation: const badges.BadgeAnimation.slide(
                              animationDuration: Duration.zero),
                          badgeContent: Container(
                              // width: 80,
                              height: 17,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: context.colors.greyDecorDark,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Stroll Question",
                                // maxLines: 1,
                                style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: context.colors.white),
                              ).toCenter()),
                          child: SizedBox(
                            child: CircleAvatar(
                              backgroundColor: context.colors.greyDecorDark,
                              radius: 30,
                              child:
                                  Assets.application.assets.images.image.image(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "What is your favorite time\nof the day?",
                              maxLines: 2,
                              minFontSize: 24,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "“Mine is definitely the peace in the morning.”",
                          style: context.textTheme.bodySmall?.copyWith(
                              color: context.secondaryColor,
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                        ),
                        const Gap(10)
                      ],
                    )),
              )
            ],
          )).withExpanded(flex: 2),
          Container(
            color: context.colors.black,
            width: context.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (audioState == AudioState.none ||
                    audioState == AudioState.recording) ...[
                  StreamBuilder<Duration>(
                    stream: recorderController.onCurrentDuration,
                    initialData: Duration.zero,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      final formattedDuration = formatDuration(duration);
                      return AnimatedOpacity(
                        opacity: audioState == AudioState.none ? 0.5 : 1,
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          formattedDuration,
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: audioState == AudioState.recording
                                  ? context.secondaryColor
                                  : context.colors.white),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<int>(
                        stream: playerController.onCurrentDurationChanged,
                        initialData: 0,
                        builder: (context, snapshot) {
                          final currentDuration = snapshot.data ?? 0;
                          final formattedDuration = formatDuration(
                              Duration(milliseconds: currentDuration));
                          return Text(
                            formattedDuration,
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.colors.white),
                          );
                        },
                      ),
                      FutureBuilder<int>(
                        future: playerController.getDuration(),
                        builder: (context, snapshot) {
                          final maxDuration = snapshot.data ?? 0;
                          final formattedDuration = formatDuration(
                              Duration(milliseconds: maxDuration));
                          return Text(
                            " / $formattedDuration",
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.colors.white),
                          );
                        },
                      ),
                    ],
                  )
                ],
                if (audioState == AudioState.none ||
                    audioState == AudioState.recording) ...[
                  AudioWaveforms(
                    recorderController: recorderController,
                    size: Size(context.screenWidth * .85, 50),
                    waveStyle: const WaveStyle(
                      waveThickness: 2.0,
                      spacing: 4.0,
                      waveColor: Color(0xFF36393E),

                      extendWaveform: true,
                      // waveColor: Colors.blue,
                      showMiddleLine: false,
                    ),
                  ).withPadding(const EdgeInsets.symmetric(horizontal: 10))
                ] else ...[
                  AudioFileWaveforms(
                    playerController: playerController,
                    size: Size(context.screenWidth * .85, 50),
                    playerWaveStyle: PlayerWaveStyle(
                      waveThickness: 2.0,
                      spacing: 4.0,
                      showSeekLine: false,
                      liveWaveColor: context.secondaryColor,
                    ),
                    waveformType: WaveformType.fitWidth,
                  ).withPadding(const EdgeInsets.symmetric(horizontal: 20))
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextButton(
                      state: audioState,
                      label: "Delete",
                      onPressed: () {
                        handleAudioState(AudioState.none);
                        recordedFilePath = null;
                        playerController.stopPlayer();
                        recorderController.stop();
                      },
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Recording
                        if (!recorderController.isRecording &&
                            (recordedFilePath == null) &&
                            !playerController.playerState.isPlaying) {
                          handleAudioState(AudioState.recording);

                          recorderController.record();
                        } else if (recorderController.isRecording) {
                          // Stop Recording
                          handleAudioState(AudioState.stoppedRecording);

                          recordedFilePath = await recorderController.stop();
                          if (recordedFilePath != null) {
                            playerController.preparePlayer(
                                path: recordedFilePath!);
                          }
                        } else if (!recorderController.isRecording &&
                            recordedFilePath != null &&
                            !playerController.playerState.isPlaying) {
                          // Start Player
                          handleAudioState(AudioState.play);

                          playerController.startPlayer();
                        } else if (playerController.playerState.isPlaying) {
                          // Pause Player
                          handleAudioState(AudioState.pause);

                          playerController.pausePlayer();
                        } else if (playerController.playerState.isPaused) {
                          // Resume Player
                          handleAudioState(AudioState.play);

                          await playerController.startPlayer();
                        }
                      },
                      child: RingWidget(
                        color: context.colors.white,
                        radius: 60,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            // Define the animation for the transition
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: SvgPicture.asset(
                            key: ValueKey(playerIcon),
                            playerIcon,
                          ),
                        ),
                      ),
                    ),
                    CustomTextButton(
                      state: audioState,
                      label: "Submit",
                      onPressed: () {},
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ],
                ),
                CustomTextButton(
                  state: audioState,
                  label: "Unmatch",
                  onPressed: () {},
                  textStyle: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.red,
                  ),
                ),
                const Gap(10),
              ].addSpacer(const Gap(10)),
            ),
          )
        ],
      ),
    );
  }
}
