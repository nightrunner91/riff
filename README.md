# <p align="center">Riff</p>

<p align="center">
  <strong>A focused JavaScript playground with an editor and an embedded console.</strong>
</p>

<p align="center">
  <img src="assets/preview.png" alt="Riff preview">
</p>

<p align="center">
  <strong><img src="https://flagcdn.com/w20/us.png" width="20"> English</strong> | <a href="README.ru.md"><img src="https://flagcdn.com/w20/ru.png" width="20"> Russian</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.1.0-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/Runtime-Browser-6da55f?style=for-the-badge" alt="Runtime">
  <img src="https://img.shields.io/badge/Hosting-GitHub_Pages-6da55f?style=for-the-badge&logo=github" alt="Hosting">
</p>

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Quick Start](#quick-start)
- [Usage](#usage)
- [Configuration](#configuration)
- [How It Works](#how-it-works)
- [Deployment](#deployment)
- [Development](#development)
- [License](#license)

## Project Overview

Riff is a small browser-based JavaScript playground. The page has exactly two working areas: a code editor on top and an output console below. Write a snippet, press `Run` or `Ctrl+Enter`, and read the result without opening DevTools.

Riff is designed for one short feedback loop: change a line, run the code, and see what the browser actually does. Every run starts in a fresh sandbox, so timers and pending tasks from the previous run do not leak into the next result.

The live version is available at [nightrunner91.github.io/riff](https://nightrunner91.github.io/riff/).

## Features

- **Editor and console in one page** — the UI includes a code editor above and a dedicated log panel below.
- **No DevTools required** — `console.log()`, `console.warn()`, `console.error()` and runtime errors appear in the built-in console.
- **Fresh event loop on every run** — a new sandbox removes intervals, timers and pending tasks from the previous attempt.
- **Browser JavaScript semantics** — microtasks, timers, `queueMicrotask`, top-level `await` and basic DOM APIs run in a browser realm.
- **Readable output** — multiple arguments, objects, arrays, `Map`, `Set`, dates, functions and errors are formatted as text.
- **Useful error locations** — stack frames are rewritten to `your-code:line:column`.
- **Keyboard-friendly editing** — run, comment, indent, outdent and auto-indent without leaving the editor.
- **Persistent local buffer** — the current code and editor/console split are saved in `localStorage`.
- **Static and dependency-free** — the app is a single HTML page with no build step, backend or account.

## Tech Stack

| Area | Technology |
|---|---|
| UI | HTML, CSS and vanilla JavaScript |
| Code execution | Sandboxed `iframe` with `srcdoc` |
| Communication | `postMessage` |
| Persistence | Browser `localStorage` |
| Hosting | GitHub Pages |
| License | MIT |

## Project Structure

```text
riff/
├── index.html                  # Complete application
├── assets/
│   ├── icon.svg                # Desktop launcher icon
│   └── preview.png             # README preview
├── .github/workflows/
│   └── pages.yml               # GitHub Pages deployment
├── run.sh                      # Optional local app-window launcher
├── riff.desktop                # Optional Linux desktop entry
├── README.md                   # English documentation
├── README.ru.md                # Russian documentation
└── LICENSE                     # MIT license
```

## Getting Started

### Prerequisites

- A modern browser with JavaScript enabled.
- No Node.js, package manager or build tools are required.

### Installation

No installation is needed for the hosted version. Open the [live Riff page](https://nightrunner91.github.io/riff/) in a browser.

To work with the source locally:

```bash
git clone https://github.com/nightrunner91/riff.git
cd riff
```

### Quick Start

Open `index.html` directly or serve the repository with any static HTTP server:

```bash
xdg-open index.html
```

Linux users can also use the optional standalone-window launcher:

```bash
chmod +x run.sh
./run.sh
```

The launcher is a convenience for local use only. The primary version of Riff is the web page.

## Usage

1. Open the [live app](https://nightrunner91.github.io/riff/).
2. Paste or write JavaScript in the editor.
3. Press `Run` or `Ctrl+Enter` (`Cmd+Enter` on macOS).
4. Read the output in the console below the editor.

The console is cleared before every run. Change the code and run it again to replace the previous result.

### Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl`/`Cmd` + `Enter` | Run the buffer |
| `Ctrl`/`Cmd` + `/` | Toggle `//` on the current line or selection |
| `Tab` | Indent by two spaces |
| `Shift` + `Tab` | Outdent |
| `Enter` | Auto-indent and open blocks between matching brackets |
| Drag the bar between panes | Resize the editor and console |

## Configuration

Riff has no configuration file or account system. It stores two values in the browser's `localStorage` for the current site origin:

| Key | Contents |
|---|---|
| `riff.code` | Last editor buffer |
| `riff.split` | Editor height in pixels |

The saved buffer belongs to the browser profile and is not shared between users or devices. Clearing site data resets it.

## How It Works

1. `run()` clears the console and creates a new run token.
2. The app writes a new `srcdoc` document into a `sandbox="allow-scripts"` iframe.
3. Replacing the iframe document destroys the previous document and its timers.
4. The runner patches `console.*` and sends formatted records to the parent page with `postMessage`.
5. User code runs inside an async wrapper, which enables top-level `await`.
6. Errors are formatted inside the sandbox and their stack frames are mapped back to editor lines.

The sandbox cannot access the parent page, the clipboard or the user's filesystem. The app itself is static; code is executed in the visitor's browser, not on a server.

## Deployment

The repository is deployed to GitHub Pages by [`.github/workflows/pages.yml`](.github/workflows/pages.yml) on every push to `main`.

To deploy your own fork:

1. Enable **Settings → Pages → Source → GitHub Actions**.
2. Push changes to `main`.
3. GitHub Actions publishes the contents of the repository as a static site.

No server, environment variables or build command is required.

## Development

Edit `index.html` and reload the page. There is no build step.

Before committing, manually check:

1. Run the event-loop example and compare the output order.
2. Start `setInterval`, run `console.log('fresh')`, and confirm that only `fresh` remains.
3. Throw inside `setTimeout` and check that the reported line matches the editor.
4. Reload the page and confirm that the buffer is restored.

## License

This project is licensed under the [MIT License](LICENSE).

---

<p align="center">
  Built with ❤ by <a href="https://t.me/nightrunner91">nightrunner91</a>
</p>
