import puppeteer from 'puppeteer';

(async () => {
    try {
        const browser = await puppeteer.launch({ headless: 'new' });
        const page = await browser.newPage();

        page.on('console', msg => console.log('PAGE LOG:', msg.text()));
        page.on('pageerror', error => console.log('PAGE ERROR:', error.message));
        page.on('requestfailed', request =>
            console.log('REQUEST FAILED:', request.url(), request.failure()?.errorText)
        );

        console.log('Navigating to http://localhost:5174...');
        await page.goto('http://localhost:5174', { waitUntil: 'networkidle0' });

        console.log('Page loaded. Capturing screenshot...');
        await page.screenshot({ path: 'screenshot.png' });

        await browser.close();
        console.log('Done.');
    } catch (e) {
        console.error('Script failed:', e);
    }
})();
