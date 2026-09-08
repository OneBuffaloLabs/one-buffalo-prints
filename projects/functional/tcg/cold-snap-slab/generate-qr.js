import fs from 'node:fs';
import qr from 'qrcode';

// CLI argument parsing: node generate-qr.js [url] OR node generate-qr.js --custom [url]
const args = process.argv.slice(2);
let customInput = null;

for (let i = 0; i < args.length; i++) {
    if (args[i] === '--custom' && args[i + 1]) {
        customInput = args[i + 1];
        break;
    } else if (!args[i].startsWith('-') && !customInput) {
        customInput = args[i];
    }
}

const baseUrl = "https://coldfrontforge.com/cold-snap-slab/";
const targets = {
    probably_a_10: baseUrl + "probably-a-10",
    near_mint: baseUrl + "near-mint",
    gem_mint_10: baseUrl + "gem-mint-10",
    lightly_played: baseUrl + "lightly-played",
    moderately_played: baseUrl + "moderately-played",
    heavily_played: baseUrl + "heavily-played",
    damaged: baseUrl + "damaged",
    cooked: baseUrl + "cooked",
    custom: customInput || (baseUrl + "custom")
};

let output = `// =========================================================================\n`;
output += `// Auto-generated QR Matrix Data\n`;
output += `// File: qr-matrices.scad\n`;
output += `// =========================================================================\n\n`;

for (const [key, url] of Object.entries(targets)) {
    const qrData = qr.create(url, { errorCorrectionLevel: 'L' });
    const size = qrData.modules.size;
    const raw = qrData.modules.data;

    output += `qr_${key} = [\n`;
    for (let r = 0; r < size; r++) {
        const row = [];
        for (let c = 0; c < size; c++) {
            row.push(raw[r * size + c] ? 1 : 0);
        }
        output += `    [${row.join(",")}]${r < size - 1 ? "," : ""}\n`;
    }
    output += `];\n\n`;
}

output += `function get_qr_matrix(key) =\n`;
output += `    key == "probably_a_10"     ? qr_probably_a_10 :\n`;
output += `    key == "near_mint"         ? qr_near_mint :\n`;
output += `    key == "gem_mint_10"       ? qr_gem_mint_10 :\n`;
output += `    key == "lightly_played"    ? qr_lightly_played :\n`;
output += `    key == "moderately_played" ? qr_moderately_played :\n`;
output += `    key == "heavily_played"    ? qr_heavily_played :\n`;
output += `    key == "damaged"           ? qr_damaged :\n`;
output += `    key == "cooked"            ? qr_cooked :\n`;
output += `                               qr_custom;\n`;

fs.writeFileSync('qr-matrices.scad', output);
console.log(`Generated qr-matrices.scad (custom URL: "${targets.custom}")`);