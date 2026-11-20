const fs = require('fs');
const path = require('path');

const targetDocs = [
  'docs/ARCHITECTURE.md',
  'docs/BUILD.md',
  'docs/GITHUB.md',
  'docs/INSTALL.md',
  'docs/MODULES.md',
  'docs/NATIVE_DLL_ARCHITECTURE.md',
  'docs/SECURITY.md'
];

targetDocs.forEach(filePath => {
  if (fs.existsSync(filePath)) {
    let text = fs.readFileSync(filePath, 'utf8');
    // Replace v1.4.8 to v1.4.9
    text = text.replace(/v1\.4\.8/g, 'v1.4.9');
    text = text.replace(/1\.4\.8/g, '1.4.9');
    fs.writeFileSync(filePath, text, 'utf8');
    console.log(`Updated ${filePath}`);
  }
});
