import { defineConfig, devices } from '@playwright/test';

const baseURL = process.env.PLAYWRIGHT_BASE_URL || 'http://localhost:3000';
const bypassSecret = process.env.PLAYWRIGHT_BYPASS_SECRET;

const extraHTTPHeaders: Record<string, string> = {};
if (bypassSecret) {
  extraHTTPHeaders['x-vercel-protection-bypass'] = bypassSecret;
}

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  timeout: 30_000,
  reporter: [['html', { open: 'never' }]],
  use: {
    baseURL,
    extraHTTPHeaders,
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
