# Vercel Preview Deployments: 3 Testing Layers Most Teams Only Half-Build

Companion code for the Autonoma blog post 'Vercel Preview Deployments: 3 Testing Layers Most Teams Only Half-Build'.

> Companion code for the Autonoma blog post: **[Vercel Preview Deployments: 3 Testing Layers Most Teams Only Half-Build](https://getautonoma.com/blog/vercel-preview-deployments)**

## Requirements

Node.js 20+, a Vercel-connected repository, Playwright (`@playwright/test`), and optionally Vercel Deployment Protection enabled with a bypass secret for automation.

## Quickstart

```bash
git clone https://github.com/Autonoma-Tools/vercel-preview-deployments.git
cd vercel-preview-deployments
1. Copy `.github/workflows/preview-e2e.yml` into your repo under the same path.
2. Copy `playwright.config.ts` and `tests/smoke.spec.ts` into your project root.
3. Add `PLAYWRIGHT_BYPASS_SECRET` as a GitHub repository secret — match your Vercel project's Deployment Protection bypass secret.
4. Push a commit and open a PR. The workflow fires on Vercel's `deployment_status` event and runs Playwright against the preview URL automatically.

To run locally against a live preview:

```bash
npm install
npx playwright install --with-deps chromium
PLAYWRIGHT_BASE_URL=https://your-preview.vercel.app \
  PLAYWRIGHT_BYPASS_SECRET=xxx \
  npx playwright test
```
```

## Project structure

```
.
├── .github/
│   └── workflows/
│       └── preview-e2e.yml
├── examples/
│   └── protection-bypass.sh
├── tests/
│   └── smoke.spec.ts
├── playwright.config.ts
├── package.json
├── README.md
├── LICENSE
└── .gitignore
```

- `tests/` — Playwright specs. `smoke.spec.ts` is the canary suite that runs against every preview.
- `examples/` — runnable examples. `protection-bypass.sh` verifies your Vercel bypass secret is wired up correctly.
- `.github/workflows/` — the CI entry point. `preview-e2e.yml` runs Playwright against the preview URL emitted by Vercel's `deployment_status` event.

## About

This repository is maintained by [Autonoma](https://getautonoma.com) as reference material for the linked blog post. Autonoma builds autonomous AI agents that plan, execute, and maintain end-to-end tests directly from your codebase.

If something here is wrong, out of date, or unclear, please [open an issue](https://github.com/Autonoma-Tools/vercel-preview-deployments/issues/new).

## License

Released under the [MIT License](./LICENSE) © 2026 Autonoma Labs.
