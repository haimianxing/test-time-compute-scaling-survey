#!/bin/bash

# GitHub Push Script for UT-TTS Survey 2026
# This script will help you push the repository to GitHub

set -e

echo "=========================================="
echo "  UT-TTS Survey 2026 - GitHub Push Script"
echo "=========================================="
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if remote is already configured
if git remote get-url origin &>/dev/null; then
    echo -e "${YELLOW}Remote 'origin' already exists:${NC}"
    git remote get-url origin
    echo ""
    read -p "Do you want to use this remote? (y/n): " use_existing
    if [ "$use_existing" != "y" ]; then
        git remote remove origin
    else
        echo -e "${GREEN}Using existing remote${NC}"
        echo ""
        read -p "Ready to push? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            echo -e "${GREEN}Pushing to GitHub...${NC}"
            git push -u origin master || git push -u origin main
            echo -e "${GREEN}✓ Push completed!${NC}"
            echo ""
            echo "Your repository is now live at:"
            git remote get-url origin
            exit 0
        else
            echo "Push cancelled."
            exit 0
        fi
    fi
fi

echo -e "${YELLOW}Please choose your GitHub setup method:${NC}"
echo ""
echo "1) HTTPS with Personal Access Token (Recommended)"
echo "2) HTTPS with GitHub CLI (if installed)"
echo "3) SSH (requires SSH key setup)"
echo "4) Manual setup (I'll do it myself)"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo -e "${YELLOW}=== HTTPS with Personal Access Token ===${NC}"
        echo ""
        echo "Step 1: Create a GitHub Personal Access Token"
        echo "  - Go to: https://github.com/settings/tokens"
        echo "  - Click 'Generate new token (classic)'"
        echo "  - Select scopes: repo (full control)"
        echo "  - Generate and copy the token"
        echo ""
        read -p "Step 2: Enter your GitHub username: " username
        read -p "Step 3: Enter your Personal Access Token: " token
        read -p "Step 4: Repository name [survey-2026]: " repo_name
        repo_name=${repo_name:-survey-2026}

        echo ""
        echo -e "${GREEN}Configuring remote...${NC}"
        git remote add origin https://${token}@github.com/${username}/${repo_name}.git

        echo ""
        echo -e "${GREEN}Creating repository on GitHub...${NC}"
        echo "Note: If repository doesn't exist on GitHub, create it first at:"
        echo "https://github.com/new"

        echo ""
        read -p "Press Enter to push to GitHub..."

        echo -e "${GREEN}Pushing to GitHub...${NC}"
        git branch -M main
        git push -u origin main

        echo ""
        echo -e "${GREEN}✓ Push completed successfully!${NC}"
        echo ""
        echo "Your repository is now live at:"
        echo "https://github.com/${username}/${repo_name}"
        ;;

    2)
        echo ""
        echo -e "${YELLOW}=== GitHub CLI ===${NC}"
        if command -v gh &> /dev/null; then
            read -p "Enter repository name [survey-2026]: " repo_name
            repo_name=${repo_name:-survey-2026}
            read -p "Enter description [Systematic Review of TTS]: " description
            description=${description:-Systematic Review of TTS}

            echo -e "${GREEN}Creating repository with GitHub CLI...${NC}"
            gh repo create ${repo_name} --public --description "${description}" --source=. --remote=origin --push

            echo ""
            echo -e "${GREEN}✓ Repository created and pushed!${NC}"
        else
            echo -e "${RED}GitHub CLI is not installed.${NC}"
            echo "Install it from: https://cli.github.com/"
            echo "Or choose option 1 (HTTPS with Token)"
            exit 1
        fi
        ;;

    3)
        echo ""
        echo -e "${YELLOW}=== SSH Setup ===${NC}"
        echo "Checking for SSH keys..."
        if [ -f ~/.ssh/id_rsa.pub ] || [ -f ~/.ssh/id_ed25519.pub ]; then
            echo -e "${GREEN}SSH key found!${NC}"
        else
            echo -e "${RED}No SSH key found. Generating one...${NC}"
            ssh-keygen -t ed25519 -C "your_email@example.com"
            echo ""
            echo "Add this SSH key to GitHub:"
            echo "1. Copy the public key:"
            cat ~/.ssh/id_ed25519.pub
            echo ""
            echo "2. Go to: https://github.com/settings/ssh/new"
            echo "3. Paste the key and save"
            echo ""
            read -p "Press Enter after adding the key to GitHub..."
        fi

        read -p "Enter your GitHub username: " username
        read -p "Enter repository name [survey-2026]: " repo_name
        repo_name=${repo_name:-survey-2026}

        echo -e "${GREEN}Configuring SSH remote...${NC}"
        git remote add origin git@github.com:${username}/${repo_name}.git

        echo ""
        read -p "Press Enter to push to GitHub..."

        echo -e "${GREEN}Pushing via SSH...${NC}"
        git branch -M main
        git push -u origin main

        echo ""
        echo -e "${GREEN}✓ Push completed successfully!${NC}"
        echo ""
        echo "Your repository is now live at:"
        echo "https://github.com/${username}/${repo_name}"
        ;;

    4)
        echo ""
        echo -e "${YELLOW}=== Manual Setup ===${NC}"
        echo "Please follow these steps:"
        echo ""
        echo "1. Create a new repository on GitHub:"
        echo "   https://github.com/new"
        echo ""
        echo "2. Configure the remote:"
        echo "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
        echo ""
        echo "3. Push to GitHub:"
        echo "   git branch -M main"
        echo "   git push -u origin main"
        echo ""
        echo "Or use SSH:"
        echo "   git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git"
        echo "   git push -u origin main"
        ;;

    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}=========================================="
echo "  Next Steps:"
echo "==========================================${NC}"
echo "1. Verify your repository at the GitHub URL"
echo "2. Add topics: llm, test-time-compute, systematic-review"
echo "3. Enable GitHub Actions (if needed)"
echo "4. Add a nice README badge"
echo "5. Share with the community!"
echo ""
