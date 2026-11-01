const fs = require('fs');
const path = require('path');
const vm = require('vm');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');

// Extract all script tags
const scriptRegex = /<script\b[^>]*>([\s\S]*?)<\/script>/gi;
let match;
let scriptIndex = 0;
let errors = 0;

while ((match = scriptRegex.exec(html)) !== null) {
  const code = match[1];
  if (!code.trim()) continue;
  scriptIndex++;
  try {
    // Check syntax with Script constructor
    new vm.Script(code);
    console.log(`Script block #${scriptIndex}: SYNTAX VALID`);
  } catch (err) {
    console.error(`Script block #${scriptIndex}: SYNTAX ERROR:`, err.message);
    errors++;
  }
}

if (errors === 0) {
  console.log(`All ${scriptIndex} script blocks passed syntax check!`);
} else {
  console.error(`Found ${errors} syntax errors!`);
  process.exit(1);
}
