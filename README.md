# Curae — cross-platform telehealth demo

**Curae** (from *cura* — care/cure) is a polished, patient-facing telehealth /
doctor-appointment app built with **Flutter** from a single codebase targeting
**iOS, Android, Web, macOS, Windows, and Linux**. It ships with a runnable
**mock REST API** (json-server) and consumes it through a proper Dio + retrofit +
repository layer — there is **no hardcoded data in the UI**.

> ⚠️ **Demo — not medical advice.** Curae is a demonstration built on **synthetic
> data**. It is not a medical device. Health articles/tips are generic and
> illustrative only. A disclaimer is shown in **Settings** and **About**.

---

## Highlights

- **Material 3 (Material You)** throughout — `ColorScheme.fromSeed` on the brand
  seed `#006C51`, full light/dark themes, and platform **dynamic color** via
  `dynamic_color` (falls back to the seed scheme where unavailable).
- **Adaptive & responsive** — `NavigationBar` on phones, `NavigationRail` on
  tablets, an **extended rail** on desktop/web, and **master–detail** panes for
  the doctor and appointment lists on wide screens.
- **Real images only** — doctor/patient portraits from
  [`randomuser.me`](https://randomuser.me) and medical/wellness imagery from
  **Unsplash**, curated into `db.json` with verified URLs. No
  picsum/placeholder anywhere. Loaded via `cached_network_image`.
- **Full end-to-end flows** — find a doctor → detail + availability calendar →
  pick a slot → choose in-person/video + patient (self or family) + reason →
  confirm → appears in **My Appointments** → reschedule / cancel. Auth-gated
  with **resume-after-login**.
- **Loading / empty / error** states everywhere (shimmer skeletons), plus a Dio
  interceptor that simulates **300–800 ms latency and occasional transient
  errors** so those states are genuinely exercised.

## Tech stack

| Concern | Package |
|---|---|
| State management | `flutter_riverpod` (3.x) |
| Routing | `go_router` (shell route, deep links, auth redirect) |
| Networking | `dio` + `retrofit` |
| Models | `freezed` + `json_serializable` |
| Images | `cached_network_image` |
| UI helpers | `table_calendar`, `carousel_slider`, `shimmer`, `flutter_rating_bar`, `fl_chart` |
| Storage | `flutter_secure_storage` (token), `shared_preferences` (theme/locale) |
| i18n / formatting | `intl`, `flutter_localizations` |
| App icon | `flutter_launcher_icons` |

> Note on state: providers are written by hand (idiomatic `Notifier` /
> `AsyncNotifier` / `FutureProvider`) rather than `riverpod_generator`, to keep
> the codegen surface small and robust. All other codegen (`freezed`,
> `json_serializable`, `retrofit`) is used as specified.

## Project structure

```
lib/
  core/        # env config, theme + design tokens, dio client + interceptors,
               # router, storage, utils, providers (DI)
  data/        # freezed models, retrofit api client, query mapping, repositories
  features/
    auth/  onboarding/  splash/
    home/  doctors/  booking/  appointments/
    records/  articles/  family/  account/  notifications/
  shared/      # curae_image, state widgets, doctor/slot/appointment cards,
               # adaptive app shell
  app.dart  main.dart
mock-api/      # json-server: db.json, routes.json, server.js, generators
assets/icon/   # icon master + adaptive foreground + SVG source + generator
```

---

## 1. Prerequisites

- Flutter **3.44+** (Dart 3.12+) — `flutter doctor`
- Node.js **18+** (for the mock API)
- Python **3.x** with **Pillow** (only if you want to re-generate the icon/seed data)

On **Windows**, enable **Developer Mode** (`start ms-settings:developers`) so
Flutter can create the plugin symlinks needed for desktop/plugin builds.

## 2. Install

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/json/retrofit
```

## 3. Generate the app icon

The brand mark is a rounded-square, healing-green (`#006C51`) field with a white
rounded medical cross whose right arm tapers into a **pulse / ECG tick**.

- Master: `assets/icon/icon.png` (1024×1024, opaque — iOS-safe)
- Adaptive foreground: `assets/icon/foreground.png` over `#006C51`
- Vector source: `assets/icon/icon.svg`

To (re)create the PNGs from the source, then emit all platform icons:

```bash
python assets/icon/generate_icons.py     # optional — regenerates icon.png + foreground.png
dart run flutter_launcher_icons          # writes Android/iOS/web/Windows/macOS icons
```

The `flutter_launcher_icons` config lives in `pubspec.yaml`.

## 4. Run the mock API

```bash
cd mock-api
npm install
npm start            # http://localhost:3000  (auth + fresh availability + resources)
# or:  npm run db    # plain json-server (no /auth endpoints, static slots)
# or:  npm run seed  # re-generate db.json (real image URLs) via Python
```

`npm start` runs `server.js`, which wraps json-server to add the `/auth/*`
endpoints and regenerate doctor availability with **fresh future dates** on every
request, so the calendar never goes stale. CORS is enabled by default.

Seed data: 1 user + 3 family members, 8 specialties, **30 doctors** (real
portraits), reviews, availability, **8 articles** (real Unsplash imagery), health
records (vitals/labs/prescriptions), sample appointments, and 6 notifications.

### Endpoints

```
POST /auth/login            -> { token, user }
POST /auth/register         -> { token, user }
GET  /auth/me               -> { user }
GET  /specialties
GET  /doctors               ?specialtyId=&q=&rating_gte=&gender=&_sort=&_order=&_page=&_limit=
GET  /doctors/:id
GET  /doctors/:id/reviews
GET  /doctors/:id/slots     ?date=
GET/POST /appointments      ·  GET/PATCH /appointments/:id
GET  /records               -> { vitals, labs, prescriptions }
GET/POST /family-members    ·  PATCH/DELETE /family-members/:id
GET  /articles  ·  GET /articles/:id
GET  /notifications  ·  PATCH /notifications/:id
```

**Demo login:** `alex@curae.app` / `password` (any email works; the demo
returns the seeded user). You can also browse doctors and articles **as a
guest** — booking, records, family and notifications require signing in.

## 5. Configure the API base URL

Defaults are chosen per platform so the bundled server is reachable out of the
box: `http://localhost:3000`, and `http://10.0.2.2:3000` on the Android emulator.
Override at build/run time:

```bash
flutter run --dart-define=CURAE_API_BASE_URL=http://192.168.1.50:3000
```

(A physical device must point at your machine's LAN IP, not `localhost`.)

## 6. Run on each platform

```bash
flutter run -d chrome      # Web
flutter run -d windows     # Windows  (needs Developer Mode)
flutter run -d macos       # macOS
flutter run -d linux       # Linux
flutter run -d <android>   # Android emulator/device
flutter run -d <ios>       # iOS simulator/device (macOS host)
```

Start the mock API first (step 4). The same codebase runs on all six targets
with no code changes.

## 7. Tests & analysis

```bash
flutter analyze            # zero warnings
flutter test               # slot/booking logic, filter→query mapping, mocked-Dio repo
```

---

## Imagery & licensing

- Portraits: `https://randomuser.me/api/portraits/{men|women}/{n}.jpg` (no key).
- Medical/wellness photos: **Unsplash** (`images.unsplash.com`), curated into
  `db.json`. All URLs were verified to return HTTP 200 before seeding.

## Branding

App name **Curae**; seed color `#006C51`; informational accent sky-blue. To
rename, change `pubspec.yaml` `name`, the app title in `app.dart`, the wordmark
in the splash/shell, the icon assets, and this README. (Alternates considered:
Docly, Medvia, Cura, Saluvia.)
