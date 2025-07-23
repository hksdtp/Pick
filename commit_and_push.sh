#!/bin/bash

# 🚀 Auto Commit and Push Script for Pickleball App
# Run this script in your project directory

echo "🏓 Pickleball App - Auto Commit & Push"
echo "======================================"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "📁 Initializing git repository..."
    git init
    git remote add origin https://github.com/hksdtp/Pick.git
    echo "✅ Git repository initialized"
fi

# Check git status
echo "📋 Checking git status..."
git status

# Add all changes
echo "➕ Adding all changes..."
git add .

# Commit with detailed message
echo "💾 Committing changes..."
git commit -m "feat: mobile-optimized transaction history with collapsible UI

✨ Features:
- Add collapsible transaction history with summary stats
- Mobile-first design with expand/collapse functionality  
- Touch-friendly interactions with smooth animations

🎨 Design System:
- Sync CSS variables with consistent color palette
- Improve typography with font smoothing
- Standardize border radius and shadow system

🐛 Bug Fixes:
- Remove duplicate penalty section title
- Clean up redundant UI elements

📱 Mobile UX:
- Save screen space with collapsible lists
- Always-visible transaction summary
- Smooth expand/collapse animations
- 44px minimum touch targets

🏓 Perfect for mobile pickleball club management!"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "🎉 Successfully pushed to GitHub!"
echo "🔗 Repository: https://github.com/hksdtp/Pick"
echo "✅ All changes are now live!"
