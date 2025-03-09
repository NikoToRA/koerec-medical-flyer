#!/bin/bash

# KoERec医療従事者向けチラシWebサイトをFirebase Hostingにデプロイするスクリプト

# 色の定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}KoERec医療従事者向けチラシWebサイトをFirebase Hostingにデプロイします${NC}"
echo "-----------------------------------------------------"

# Node.jsがインストールされているか確認
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.jsがインストールされていません。以下のURLからNode.jsをインストールしてください：${NC}"
    echo "https://nodejs.org/"
    exit 1
fi

# npmがインストールされているか確認
if ! command -v npm &> /dev/null; then
    echo -e "${RED}npmがインストールされていません。Node.jsと一緒にインストールされるはずです。${NC}"
    exit 1
fi

# カレントディレクトリがkoerec-medical-flyerであることを確認
if [ "$(basename "$(pwd)")" != "koerec-medical-flyer" ]; then
    echo -e "${RED}このスクリプトはkoerec-medical-flyerディレクトリ内で実行してください。${NC}"
    exit 1
fi

# Firebase CLIがインストールされているか確認し、なければインストール
if ! command -v firebase &> /dev/null; then
    echo -e "${BLUE}Firebase CLIをインストールしています...${NC}"
    npm install -g firebase-tools
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Firebase CLIのインストールに失敗しました。${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Firebase CLIがインストールされました。${NC}"
else
    echo -e "${GREEN}Firebase CLIは既にインストールされています。${NC}"
fi

# Firebaseにログイン
echo -e "${BLUE}Firebaseにログインします...${NC}"
firebase login

if [ $? -ne 0 ]; then
    echo -e "${RED}Firebaseへのログインに失敗しました。${NC}"
    exit 1
fi

# プロジェクト名の入力
read -p "Firebaseプロジェクト名を入力してください（既存のプロジェクト名または新規作成する名前）: " project_name
if [ -z "$project_name" ]; then
    echo -e "${RED}プロジェクト名が入力されていません。${NC}"
    exit 1
fi

# Firebaseプロジェクトの選択または作成
echo -e "${BLUE}Firebaseプロジェクトを設定しています...${NC}"
firebase use "$project_name" || firebase projects:create "$project_name"

if [ $? -ne 0 ]; then
    echo -e "${RED}Firebaseプロジェクトの設定に失敗しました。${NC}"
    exit 1
fi

# firebase.jsonが存在するか確認し、なければ作成
if [ ! -f "firebase.json" ]; then
    echo -e "${BLUE}firebase.jsonを作成しています...${NC}"
    cat > firebase.json << EOF
{
  "hosting": {
    "public": ".",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**",
      "deploy-to-*.sh",
      "README.md"
    ]
  }
}
EOF
    echo -e "${GREEN}firebase.jsonが作成されました。${NC}"
else
    echo -e "${GREEN}firebase.jsonは既に存在します。${NC}"
fi

# .firebasercが存在するか確認し、なければ作成
if [ ! -f ".firebaserc" ]; then
    echo -e "${BLUE}.firebasercを作成しています...${NC}"
    cat > .firebaserc << EOF
{
  "projects": {
    "default": "$project_name"
  }
}
EOF
    echo -e "${GREEN}.firebasercが作成されました。${NC}"
else
    echo -e "${GREEN}.firebasercは既に存在します。${NC}"
fi

# デプロイの確認
read -p "Firebase Hostingにデプロイを開始しますか？ (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo -e "${RED}デプロイを中止しました。${NC}"
    exit 1
fi

# Firebase Hostingにデプロイ
echo -e "${BLUE}Firebase Hostingにデプロイしています...${NC}"
firebase deploy --only hosting

if [ $? -eq 0 ]; then
    echo -e "${GREEN}サイトが正常にFirebase Hostingにデプロイされました！${NC}"
    echo -e "${BLUE}デプロイされたサイトのURLは上記の「Hosting URL」で確認できます。${NC}"
    echo -e "${BLUE}Firebaseコンソールでさらに設定を行うことができます：${NC}"
    echo "https://console.firebase.google.com/project/$project_name/hosting/sites"
else
    echo -e "${RED}Firebase Hostingへのデプロイ中にエラーが発生しました。${NC}"
fi

echo -e "${BLUE}デプロイプロセスが完了しました。${NC}"