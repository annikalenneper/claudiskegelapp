// filepath: c:\Users\alenn\projects\ClaudisApp\claudiskegelapp\scripts\generateFirebaseConfig.js
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const templatePath = path.resolve(__dirname, '../firebase.template.json');
const outputPath = path.resolve(__dirname, '../firebase.json');

const template = fs.readFileSync(templatePath, 'utf8');

const config = template
  .replace(/\${FIREBASE_APP_ID_ANDROID}/g, process.env.FIREBASE_APP_ID_ANDROID)
  .replace(/\${FIREBASE_APP_ID_IOS}/g, process.env.FIREBASE_APP_ID_IOS)
  .replace(/\${FIREBASE_APP_ID_MACOS}/g, process.env.FIREBASE_APP_ID_MACOS)
  .replace(/\${FIREBASE_APP_ID_WEB}/g, process.env.FIREBASE_APP_ID_WEB)
  .replace(/\${FIREBASE_APP_ID_WINDOWS}/g, process.env.FIREBASE_APP_ID_WINDOWS);

fs.writeFileSync(outputPath, config);

console.log('firebase.json has been generated successfully.');