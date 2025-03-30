# 🚀 Flutter Web Deployment für GitHub Pages (in /docs/app) – Windows PowerShell

Write-Host "🔨 Baue Flutter Web App..."
flutter build web

# Sicherstellen, dass die Datei existiert
$indexPath = "build\web\index.html"
if (Test-Path $indexPath) {
    Write-Host "🛠️  Passe <base href> in index.html an..."
    
    (Get-Content $indexPath) -replace '<base href="/[^"]*">', '<base href="/app/">' | Set-Content $indexPath
} else {
    Write-Host "❌ Fehler: index.html nicht gefunden unter $indexPath"
    exit 1
}

# Zielordner leeren
$targetPath = "docs\app"
Write-Host "🧹 Lösche alten Web-Build im $targetPath..."
Remove-Item -Recurse -Force $targetPath -ErrorAction SilentlyContinue

Write-Host "📂 Kopiere neuen Web-Build nach $targetPath..."
New-Item -ItemType Directory -Force -Path $targetPath
Copy-Item -Path "build\web\*" -Destination $targetPath -Recurse

Write-Host "✅ Deployment abgeschlossen."
Write-Host "📦 Jetzt kannst du committen und pushen:"
Write-Host "   git add docs/app"
Write-Host "   git commit -m 'Deploy Web App to /app'"
Write-Host "   git push"
