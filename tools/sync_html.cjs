const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const baseDir = path.join(__dirname, '..');
const sourceFile = path.join(baseDir, 'index.html');
const sourceContent = fs.readFileSync(sourceFile);
const sourceHash = crypto.createHash('sha256').update(sourceContent).digest('hex');

const targetFiles = [
  '교실용_실물화상기.html',
  '아비캠뷰어_(AhBiCamViewer).html',
  '(AhBiYout)_공용_실물화상기_보기.html'
];

console.log(`Source [index.html]: ${sourceContent.length} bytes, SHA-256: ${sourceHash}`);

targetFiles.forEach(f => {
  const p = path.join(baseDir, f);
  fs.writeFileSync(p, sourceContent);
  const hash = crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
  console.log(`Synced [${f}]: ${hash === sourceHash ? 'MATCH' : 'MISMATCH'} (${hash})`);
});
