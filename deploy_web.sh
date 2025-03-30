#!/bin/bash

# 🚀 Automatische Flutter Web Deployment für GitHub Pages (/docs/app)

set -e

echo "🔨 Baue Flutter Web App..."
flutter build web

echo "🛠️  Passe <base href> in index.html an..."
sed -i.bak 's|<base href="/[^"]*">|<base href="/app/">|' build/web/index.html

echo "🧹 Lösche alten Web-Build im docs/app..."
rm -rf docs/app

echo "📂 Kopiere neuen Web-Build nach docs/app..."
mkdir -p docs/app
cp -r build/web/* docs/app/

echo "✅ Deployment abgeschlossen."
echo "📦 Jetzt kannst du committen und pushen:"
echo "   git add docs/app"
echo "   git commit -m \"Deploy Web App to /app\""
echo "   git push"
