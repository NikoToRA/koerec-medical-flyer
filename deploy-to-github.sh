#!/bin/bash

# KoERec医療従事者向けチラシWebサイトをGitHub Pagesにデプロイするスクリプト

# 色の定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}KoERec医療従事者向けチラシWebサイトをGitHub Pagesにデプロイします${NC}"
echo "-----------------------------------------------------"

# Gitがインストールされているか確認
if ! command -v git &> /dev/null; then
    echo -e "${RED}Gitがインストールされていません。以下のURLからGitをインストールしてください：${NC}"
    echo "https://git-scm.com/downloads"
    exit 1
fi

# GitHubユーザー名の入力
read -p "GitHubのユーザー名を入力してください: " github_username
if [ -z "$github_username" ]; then
    echo -e "${RED}ユーザー名が入力されていません。${NC}"
    exit 1
fi

# リポジトリ名の入力（デフォルト：koerec-medical-flyer）
read -p "リポジトリ名を入力してください [koerec-medical-flyer]: " repo_name
repo_name=${repo_name:-koerec-medical-flyer}

# リポジトリURLの作成
repo_url="https://github.com/$github_username/$repo_name.git"

echo -e "${BLUE}以下の情報でデプロイを開始します：${NC}"
echo "GitHubユーザー名: $github_username"
echo "リポジトリ名: $repo_name"
echo "リポジトリURL: $repo_url"
echo "-----------------------------------------------------"

# 確認
read -p "続行しますか？ (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo -e "${RED}デプロイを中止しました。${NC}"
    exit 1
fi

# カレントディレクトリがkoerec-medical-flyerであることを確認
if [ "$(basename "$(pwd)")" != "koerec-medical-flyer" ]; then
    echo -e "${RED}このスクリプトはkoerec-medical-flyerディレクトリ内で実行してください。${NC}"
    exit 1
fi

# Gitリポジトリの初期化
echo -e "${BLUE}Gitリポジトリを初期化しています...${NC}"
git init

# すべてのファイルをステージング
echo -e "${BLUE}ファイルをステージングしています...${NC}"
git add .

# コミット
echo -e "${BLUE}変更をコミットしています...${NC}"
git commit -m "Initial commit: KoERec医療従事者向けチラシWebサイト"

# リモートリポジトリの追加
echo -e "${BLUE}リモートリポジトリを追加しています...${NC}"
git remote add origin "$repo_url"

# mainブランチにプッシュ
echo -e "${BLUE}GitHubにプッシュしています...${NC}"
git push -u origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}ファイルが正常にGitHubにプッシュされました！${NC}"
    echo -e "${BLUE}GitHub Pagesを有効にするには、以下の手順に従ってください：${NC}"
    echo "1. ブラウザで $repo_url にアクセスします"
    echo "2. 「Settings」タブをクリックします"
    echo "3. 左側のメニューから「Pages」を選択します"
    echo "4. 「Source」セクションで、ブランチを「main」に設定し、フォルダを「/(root)」に設定して「Save」をクリックします"
    echo "5. 数分後、サイトがデプロイされ、以下のURLでアクセスできるようになります："
    echo -e "${GREEN}https://$github_username.github.io/$repo_name/${NC}"
else
    echo -e "${RED}GitHubへのプッシュ中にエラーが発生しました。${NC}"
    echo "リポジトリが既に存在するか、アクセス権限がない可能性があります。"
    echo "GitHubで新しいリポジトリを作成し、正しいアクセス権限があることを確認してください。"
fi

echo -e "${BLUE}デプロイプロセスが完了しました。${NC}"