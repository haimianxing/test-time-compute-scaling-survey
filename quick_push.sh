#!/bin/bash

# ⚡ Quick GitHub Push - UT-TTS Survey 2026
# Just edit YOUR_USERNAME and run!

# ========================================
# STEP 1: Edit your GitHub username
# ========================================
YOUR_USERNAME="YOUR_USERNAME"  # ⬅️ REPLACE THIS!

# ========================================
# STEP 2: Repository name
# ========================================
REPO_NAME="survey-2026"

# ========================================
# STEP 3: Run this script!
# ========================================

echo "🚀 Pushing to GitHub..."
echo "Username: $YOUR_USERNAME"
echo "Repository: $REPO_NAME"
echo ""

# Check if username is set
if [ "$YOUR_USERNAME" == "YOUR_USERNAME" ]; then
    echo "⚠️  Please edit this script first!"
    echo "   Change YOUR_USERNAME to your actual GitHub username"
    echo "   Then run again."
    exit 1
fi

# Show current status
echo "📊 Current git status:"
git status --short
echo ""

# Confirm push
read -p "Ready to push? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "❌ Push cancelled"
    exit 0
fi

# Add remote
echo "📡 Adding remote..."
git remote add origin https://github.com/${YOUR_USERNAME}/${REPO_NAME}.git 2>/dev/null || \
    git remote set-url origin https://github.com/${YOUR_USERNAME}/${REPO_NAME}.git

# Show remote
echo "Remote: $(git remote get-url origin)"
echo ""

# Push
echo "⬆️  Pushing to GitHub..."
git branch -M main 2>/dev/null || git branch -M master
git push -u origin main 2>/dev/null || git push -u origin master

echo ""
echo "✅ Done! Your repository is live at:"
echo "   https://github.com/${YOUR_USERNAME}/${REPO_NAME}"
echo ""
echo "📝 Don't forget to:"
echo "   1. Create the repository on GitHub first if needed"
echo "   2. Add topics: llm, test-time-compute, systematic-review"
echo "   3. Enable Issues and Discussions"
echo ""
