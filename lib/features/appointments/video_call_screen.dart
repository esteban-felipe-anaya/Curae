import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import '../../data/models/appointment.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import 'appointment_providers.dart';

class VideoCallScreen extends ConsumerStatefulWidget {
  const VideoCallScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  late final Timer _timer;
  int _seconds = 0;
  bool _micOn = true;
  bool _cameraOn = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _elapsed {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final apptAsync = ref.watch(appointmentByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: Colors.black,
      body: AsyncView<Appointment>(
        value: apptAsync,
        data: (appt) => _CallBody(
          appt: appt,
          elapsed: _elapsed,
          micOn: _micOn,
          cameraOn: _cameraOn,
          onToggleMic: () => setState(() => _micOn = !_micOn),
          onToggleCamera: () => setState(() => _cameraOn = !_cameraOn),
          onEndCall: () => context.pop(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}

class _CallBody extends StatelessWidget {
  const _CallBody({
    required this.appt,
    required this.elapsed,
    required this.micOn,
    required this.cameraOn,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onEndCall,
  });

  final Appointment appt;
  final String elapsed;
  final bool micOn;
  final bool cameraOn;
  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onEndCall;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // ── Remote video (doctor photo fill) ────────────────────────────
        Positioned.fill(
          child: appt.doctorPhoto.isNotEmpty
              ? CuraeImage(
                  url: appt.doctorPhoto,
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                )
              : Container(color: const Color(0xFF1A2A38)),
        ),

        // ── Dark scrim for readability ───────────────────────────────────
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xDD000000),
                ],
                stops: [0.0, 0.25, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // ── Top bar: doctor name + timer ─────────────────────────────────
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.space20,
                vertical: AppTokens.space16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appt.doctorName.isEmpty ? 'Doctor' : appt.doctorName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.v4,
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gaps.h8,
                            Text(
                              'Connected $elapsed',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
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
          ),
        ),

        // ── Self-preview (bottom-right) ──────────────────────────────────
        Positioned(
          right: AppTokens.space20,
          bottom: 140,
          child: Container(
            width: 100,
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: AppTokens.brLg,
              border: Border.all(color: Colors.white24, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: AppTokens.brLg,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  if (!cameraOn)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: Icon(Icons.videocam_off,
                            color: Colors.white54, size: 28),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // ── Bottom control bar ────────────────────────────────────────────
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppTokens.space24,
                right: AppTokens.space24,
                bottom: AppTokens.space32,
                top: AppTokens.space16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ControlButton(
                    icon: micOn ? Icons.mic_outlined : Icons.mic_off_outlined,
                    label: micOn ? 'Mute' : 'Unmute',
                    onTap: onToggleMic,
                    active: !micOn,
                  ),
                  Gaps.h16,
                  _ControlButton(
                    icon: cameraOn
                        ? Icons.videocam_outlined
                        : Icons.videocam_off_outlined,
                    label: cameraOn ? 'Camera' : 'No cam',
                    onTap: onToggleCamera,
                    active: !cameraOn,
                  ),
                  Gaps.h16,
                  _ControlButton(
                    icon: Icons.flip_camera_ios_outlined,
                    label: 'Flip',
                    onTap: () {},
                  ),
                  const SizedBox(width: AppTokens.space24),
                  // End call
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onEndCall,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD32F2F),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'End call',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: active
                  ? Colors.white.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: active
                  ? Border.all(color: Colors.white38, width: 1.5)
                  : null,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
      ],
    );
  }
}

