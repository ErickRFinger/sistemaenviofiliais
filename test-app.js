import puppeteer from 'puppeteer';

(async () => {
    try {
        const browser = await puppeteer.launch({ headless: 'new' });
        const page = await browser.newPage();

        await page.setViewport({ width: 375, height: 812 });

        page.on('console', msg => console.log('PAGE LOG:', msg.text()));
        page.on('pageerror', error => console.log('PAGE ERROR:', error.message));

        console.log('Navigating to http://localhost:5174/novo-envio...');
        await page.goto('http://localhost:5174/novo-envio', { waitUntil: 'networkidle0' });

        console.log('Page loaded. Capturing screenshot...');
        await page.screenshot({ path: 'screenshot_novo_mobile.png' });

        await browser.close();
        console.log('Done.');
    } catch (e) {
        console.error('Script failed:', e);
    }
})();
