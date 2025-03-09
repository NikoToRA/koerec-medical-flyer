#!/bin/bash

# KoERec医療従事者向けチラシWebサイトをNetlifyにデプロイするスクリプト

# 色の定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}KoERec医療従事者向けチラシWebサイトをNetlifyにデプロイします${NC}"
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

# Netlify CLIがインストールされているか確認し、なければインストール
if ! command -v netlify &> /dev/null; then
    echo -e "${BLUE}Netlify CLIをインストールしています...${NC}"
    npm install -g netlify-cli
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Netlify CLIのインストールに失敗しました。${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Netlify CLIがインストールされました。${NC}"
else
    echo -e "${GREEN}Netlify CLIは既にインストールされています。${NC}"
fi

# サイト名の入力（オプション）
read -p "Netlifyのサイト名を入力してください（空白の場合はランダムな名前が生成されます）: " site_name
site_name_option=""
if [ ! -z "$site_name" ]; then
    site_name_option="--name $site_name"
fi

# Netlifyにログイン
echo -e "${BLUE}Netlifyにログインします...${NC}"
netlify login

if [ $? -ne 0 ]; then
    echo -e "${RED}Netlifyへのログインに失敗しました。${NC}"
    exit 1
fi

# サイトの初期化（既存のサイトがある場合はリンク）
echo -e "${BLUE}Netlifyサイトを初期化しています...${NC}"
netlify init

# デプロイの確認
read -p "Netlifyにデプロイを開始しますか？ (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo -e "${RED}デプロイを中止しました。${NC}"
    exit 1
fi

# Netlifyにデプロイ
echo -e "${BLUE}Netlifyにデプロイしています...${NC}"
netlify deploy --prod $site_name_option

if [ $? -eq 0 ]; then
    echo -e "${GREEN}サイトが正常にNetlifyにデプロイされました！${NC}"
    echo -e "${BLUE}デプロイされたサイトのURLは上記の「Website Draft URL」または「Live URL」で確認できます。${NC}"
    echo -e "${BLUE}Netlifyダッシュボードでさらに設定を行うことができます：${NC}"
    echo "https://app.netlify.com/"
else
    echo -e "${RED}Netlifyへのデプロイ中にエラーが発生しました。${NC}"
fi

echo -e "${BLUE}デプロイプロセスが完了しました。${NC}"