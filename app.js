const fs = require('fs');
const CDP = require('chrome-remote-interface');

const port = 9222;

async function pdf(content) {
  let client;

  try {
    client = await CDP({ port });

    const { Network, Page } = client;

    await Promise.all([Network.enable(), Page.enable()]);

    const c64 = Buffer.from(content, 'utf8').toString('base64');

    await Page.navigate({ url: `data:text/html;base64,${c64}` });

    await Page.loadEventFired();

    const pdfData = await Page.printToPDF({
      landscape:           true,
      displayHeaderFooter: false,
      printBackground:     true,
      scale:               1,
      paperHeight:         4,
      paperWidth:          3,
      marginTop:           0,
      marginLeft:          0,
      marginRight:         0,
      marginBottom:        0,
      pageRanges:          '', // all pages
      preferCSSPageSize:   true
    });

    return Buffer.from(pdfData.data, 'base64');
  }
  catch (err) {
    console.log('PDF err', err);

    return null;
  }
  finally {
    if (client) {
      await client.close();
    }
  }
}

(async function run() {
  console.log('start');

  const src = fs.readFileSync(`${__dirname}/fixture/in.html`, 'utf8');

  console.log(`loaded source HTML [${src.length} bytes]`);

  const pdfContent = await pdf(src);

  console.log(`writing resulting PDF [${pdfContent.length} bytes]`);

  fs.writeFileSync(`${__dirname}/fixture/out.pdf`, pdfContent, null);
})();
