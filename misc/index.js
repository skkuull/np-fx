// Skull#5065

const fs = require('fs');

const content = fs.readFileSync(`${__dirname}/fx.txt`);
const lines = content.toString().split('\n');

let currentDict = '';

const data = [];

lines.forEach((line) => {
    if (!line.trim()) {
        return;
    }
    if (line.startsWith('[')) {
        const word = line.trim().split('[')[1].split(']')[0];
        currentDict = word;
        return
    }
    data.push({
        dict: currentDict,
        fx: line.trim(),
    });
});

fs.writeFileSync(`${__dirname}/output.json`, JSON.stringify(data, null, 2));

// Skull#5065
