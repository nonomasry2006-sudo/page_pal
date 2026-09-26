# 📚 PagePal

### *Your reading companion*

<p align="center">
  <b>Track, discover, and organize your reading journey.</b><br/>
  Search millions of books, manage your shelves, write notes, and watch your reading progress grow.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.10+-blue?logo=flutter" />
  <img src="https://img.shields.io/badge/Dart-3.0+-blue?logo=dart" />
  <img src="https://img.shields.io/badge/State%20Management-Cubit-purple" />
  <img src="https://img.shields.io/badge/Storage-Hive-orange" />
  <img src="https://img.shields.io/badge/API-Open%20Library-green" />
</p>

---

## 📖 About

**PagePal** is a Flutter mobile application that helps readers **track**, **discover**, and **organize** their reading journey. Users can search real books from the **Open Library API**, save them to personal shelves, track reading progress, write notes, and enjoy a beautifully crafted **forest-themed UI** with glassmorphism, fireflies, and magical animations.

The app runs fully **offline** for personal data (books, notes, accounts) using **Hive** as a local NoSQL database, and connects to the internet only for searching books.

---

## ✨ Features

- 🔐 **Authentication** — Sign up, log in, edit profile, and log out (local, Hive-based)
- 👋 **Onboarding** — 3-page walkthrough with Lottie animations
- 🌲 **Forest Theme** — Dark forest palette, glassmorphism UI, animated fireflies
- 🔍 **Explore** — Search millions of books from the Open Library API
- 📖 **Book Details** — Cover, authors, description, subjects, and publication year
- 📚 **Library** — Organize books into 3 shelves: *Want to Read*, *Reading*, *Finished*
- ➕ **Add to Library** — One-tap shelf picker from any book
- 📊 **Progress Tracking** — Update reading progress with a magical progress sheet
- 📝 **Notes** — Write and manage notes per book
- 🏠 **Home Dashboard** — Stats, currently reading card, and recent notes
- ⚙️ **Settings** — Persistent notification toggles
- 🎨 **Responsive UI** — Smooth animations and micro-interactions

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **Framework** | Flutter 3.10+ / Dart 3.0+ |
| **State Management** | flutter_bloc (Cubit) |
| **Navigation** | go_router |
| **Local Storage** | Hive (NoSQL) + SharedPreferences |
| **Networking** | Dio |
| **External API** | [Open Library](https://openlibrary.org/developers/api) |
| **Animations** | Lottie, Custom Painter |
| **UI Style** | Glassmorphism + Forest theme |

---


## 📱 How to Use

### First-Time Setup

1. **Launch the app**
   You'll see a splash screen, then a short onboarding walkthrough.

2. **Create an account**
   Sign up with a name, email, and password. All data is stored locally on your device.

### Daily Use

1. **Explore books**
   Tap the Explore tab and search for any title, author, or subject.

2. **Add to library**
   Open a book and choose a shelf — Want to Read, Reading, or Finished.

3. **Track progress**
   On the Home screen, tap **Update Progress** to set the current page.

4. **Write notes**
   Open a book's details and add personal notes as you read.

5. **Manage profile**
   Visit the Profile tab to edit your info or log out.

---

## 🎨 Design Highlights

### Visual Style

- **Glassmorphism cards** — Frosted glass effect with blur and transparency.
- **Custom forest palette** — Moss greens, firefly golds, midnight blacks.

### Animations

- **Animated fireflies** — Floating particles that drift across the UI.
- **Magical progress ring** — Gradient stroke, pulsing halo, and fireflies inside.
- **Lottie animations** — Hand-picked animations for the onboarding walkthrough.
- **Glow buttons** — Gradient buttons with soft ambient shadows.

---

## 📚 API Credit

### Book Data Source

- **Provider:** [Open Library](https://openlibrary.org) — an open, editable library catalog by the Internet Archive.
- **Search endpoint:** `https://openlibrary.org/search.json`
- **Authentication:** No API key required.
- **Cover images:** `https://covers.openlibrary.org`

### Usage Notes

- Search requests are rate-limited to be polite.
- Book metadata is community-maintained and free to use.
- See the [Open Library API docs](https://openlibrary.org/developers/api) for details.

---

## 📄 License

This project was built as part of a **university course assignment**.

- **Free to use** for educational purposes.
- **Not intended** for commercial distribution.
- All third-party assets retain their original licenses.

---

## 🙏 Acknowledgments

### Data & Content

- **Open Library** — for providing free, open book data.

### Design & Animation

- **LottieFiles** — for the open-source Lottie animations used in onboarding.

### Community

- **Flutter community** — for the excellent open-source packages that made this project possible.
