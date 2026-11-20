const fs = require('fs');
const path = require('path');

const files = [
  'README.md',
  'docs/README.md',
  'docs/AI_HANDOVER.md',
  'docs/BLOG_POST.md',
  'docs/ROADMAP.md',
  'docs/ARCHITECTURE.md',
  'docs/BUILD.md',
  'docs/GITHUB.md',
  'docs/INSTALL.md',
  'docs/MODULES.md',
  'docs/NATIVE_DLL_ARCHITECTURE.md',
  'docs/SECURITY.md'
];

for (const f of files) {
  const fullPath = path.resolve(f);
  if (fs.existsSync(fullPath)) {
    const lines = fs.readFileSync(fullPath, 'utf8').split(/\r?\n/).slice(0, 25);
    console.log(`=== ${f} ===`);
    lines.forEach((l, i) => {
      if (/v1\.[0-9]+\.[0-9]+|version/i.test(l)) {
        console.log(`  L${i+1}: ${l}`);
      }
    });
  }
}
