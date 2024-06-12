const inputPath = "page.pdf"; // Change this to your input PDF file path
const outputPath = "page.pdf"; // Change this to your desired output PDF file path

const { PDFDocument, rgb } = require("pdf-lib");
const fs = require("fs");

async function trimPdfWhitespace(inputPath, outputPath) {
  // Load the PDF
  const existingPdfBytes = fs.readFileSync(inputPath);
  const pdfDoc = await PDFDocument.load(existingPdfBytes);

  // Remove empty pages
  const pages = pdfDoc.getPages();
  const nonEmptyPages = pages.filter((page) => {
    const contentStream = page.node.AcroForm;
    return contentStream && contentStream.array && contentStream.array.length > 0;
  });

  if (nonEmptyPages.length === 0) {
    console.error("All pages are empty or the document is empty.");
    return;
  }

  // Create a new PDF document to hold the processed pages
  const newPdfDoc = await PDFDocument.create();

  for (let page of nonEmptyPages) {
    const copiedPage = await newPdfDoc.copyPages(pdfDoc, [pdfDoc.getPageIndex(page)]);
    const [newPage] = copiedPage;
    newPdfDoc.addPage(newPage);
  }

  // Function to trim excessive whitespace in a page
  const trimPageWhitespace = async (page) => {
    const contentStream = page.node.AcroForm;
    const content = contentStream && contentStream.array ? contentStream.array : [];

    if (content.length === 0) return;

    const contentItems = [];
    for (let obj of content) {
      const objData = await obj.dict.get("Contents");
      if (objData) {
        contentItems.push(...objData);
      }
    }

    // Check for large vertical gaps and adjust
    let lastY = null;
    const threshold = 50; // Adjust the threshold as needed
    for (let item of contentItems) {
      const yPos = item.dict.get("TM")[5];
      if (lastY !== null && lastY - yPos > threshold) {
        const delta = lastY - yPos - threshold;
        item.dict.get("TM")[5] += delta;
      }
      lastY = yPos;
    }
  };

  // Apply trimming to each page
  const newPages = newPdfDoc.getPages();
  for (let page of newPages) {
    await trimPageWhitespace(page);
  }

  // Serialize the PDF and save it
  const pdfBytes = await newPdfDoc.save();
  fs.writeFileSync(outputPath, pdfBytes);
}

trimPdfWhitespace(inputPath, outputPath)
  .then(() => {
    console.log("PDF whitespace trimmed successfully.");
  })
  .catch((err) => {
    console.error("Error trimming PDF:", err);
  });
