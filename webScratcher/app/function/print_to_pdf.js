const puppeteer = require("puppeteer");
const { PDFDocument, rgb } = require("pdf-lib");
const fs = require("fs");

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();

  // Block iframes by intercepting requests
  await page.setRequestInterception(true);
  page.on("request", (request) => {
    const resourceType = request.resourceType();
    if (resourceType === "document" && request.frame() !== page.mainFrame()) {
      request.abort(); // Block iframe requests
    } else {
      request.continue();
    }
  });

  // Disable popups by overriding the default behavior
  await page.evaluateOnNewDocument(() => {
    window.open = function () {
      console.log("Popup blocked:", arguments);
      return null;
    };
  });

  await page.goto("https://www.bain.com/insights/bab-next-chapter/"); // Replace with your target URL

  // Hide any iframes that might still be on the page
  await page.evaluate(() => {
    const style = document.createElement("style");
    style.innerHTML = "iframe { display: none !important; }";
    document.head.appendChild(style);
  });

  // // Wait for the content to load
  // await new Promise((resolve) => setTimeout(resolve, 5000)); // Adjust timeout as needed

  // Save the page as a PDF
  await page.pdf({ path: "page.pdf", format: "A4" });

  await browser.close();
  
})();
