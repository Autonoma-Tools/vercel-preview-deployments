import { test, expect } from '@playwright/test';

test.describe('preview deployment canary', () => {
  test('preview deployment is reachable', async ({ page }) => {
    const response = await page.goto('/');
    expect(response, 'navigation should return a response').not.toBeNull();
    expect(response!.status(), 'HTTP status should be < 400').toBeLessThan(400);
    await expect(page).not.toHaveTitle('');
  });

  test('main content renders', async ({ page }) => {
    await page.goto('/');
    const bodyText = await page.textContent('body');
    expect(bodyText, 'document.body should have text content').not.toBeNull();
    expect((bodyText ?? '').trim().length, 'body text should be non-trivial').toBeGreaterThan(0);
  });
});
