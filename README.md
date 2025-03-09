# KoERec医療従事者向けチラシ（Webサイト版）

このプロジェクトは、KoERec（コエレク）AI音声入力アプリの医療従事者向けチラシをWebサイト形式で作成したものです。

## デプロイ方法

このWebサイトは静的なHTMLファイルで構成されているため、様々なホスティングサービスを使用してデプロイすることができます。以下に主なデプロイ方法を紹介します。

### 自動デプロイスクリプトを使用する方法（推奨）

このプロジェクトには、主要なホスティングサービスへのデプロイを自動化するスクリプトが含まれています。

#### GitHub Pagesへのデプロイ

```bash
# スクリプトを実行可能にする（初回のみ）
chmod +x deploy-to-github.sh

# スクリプトを実行
./deploy-to-github.sh
```

スクリプトを実行すると、GitHubのユーザー名とリポジトリ名の入力を求められます。入力後、自動的にGitHubリポジトリが作成され、ファイルがプッシュされます。その後、GitHub Pagesの設定方法が表示されます。

デプロイ後のURLは通常、以下の形式になります：
```
https://あなたのユーザー名.github.io/リポジトリ名/
```

例：https://username.github.io/koerec-medical-flyer/

#### Netlifyへのデプロイ

```bash
# スクリプトを実行可能にする（初回のみ）
chmod +x deploy-to-netlify.sh

# スクリプトを実行
./deploy-to-netlify.sh
```

スクリプトを実行すると、Netlify CLIがインストールされ、Netlifyアカウントへのログインが求められます。その後、サイト名を入力することができます（空白の場合はランダムな名前が生成されます）。

デプロイ後のURLは通常、以下の形式になります：
```
https://サイト名.netlify.app/
```

例：https://koerec-medical-flyer.netlify.app/

#### Firebase Hostingへのデプロイ

```bash
# スクリプトを実行可能にする（初回のみ）
chmod +x deploy-to-firebase.sh

# スクリプトを実行
./deploy-to-firebase.sh
```

スクリプトを実行すると、Firebase CLIがインストールされ、Googleアカウントへのログインが求められます。その後、Firebaseプロジェクト名を入力し、自動的にデプロイが行われます。

デプロイ後のURLは通常、以下の形式になります：
```
https://プロジェクト名.web.app/
```

例：https://koerec-medical-flyer.web.app/

### 手動でデプロイする方法

#### 1. GitHub Pagesを使用する方法

1. GitHubアカウントを持っていない場合は、[GitHub](https://github.com/)で作成します。
2. 新しいリポジトリを作成します（例：koere-medical-flyer）。
3. ローカルのプロジェクトフォルダをGitリポジトリとして初期化し、GitHubリポジトリにプッシュします：

```bash
cd koere-medical-flyer
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/あなたのユーザー名/koere-medical-flyer.git
git push -u origin main
```

4. GitHubリポジトリの「Settings」タブに移動し、左側のメニューから「Pages」を選択します。
5. 「Source」セクションで、ブランチを「main」に設定し、フォルダを「/(root)」に設定して「Save」をクリックします。
6. 数分後、サイトがデプロイされ、URLが表示されます（通常は https://あなたのユーザー名.github.io/koere-medical-flyer/ の形式）。

#### 2. Netlifyを使用する方法

1. [Netlify](https://www.netlify.com/)にアカウントを作成します（GitHubアカウントでログインすることもできます）。
2. ダッシュボードから「New site from Git」をクリックします。
3. GitHubを選択し、リポジトリへのアクセスを許可します。
4. koere-medical-flyerリポジトリを選択します。
5. ビルド設定は空のままで「Deploy site」をクリックします。
6. 数分後、サイトがデプロイされ、Netlifyのサブドメイン（例：random-name.netlify.app）でアクセスできるようになります。
7. カスタムドメインを設定することもできます。

#### 3. Vercelを使用する方法

1. [Vercel](https://vercel.com/)にアカウントを作成します（GitHubアカウントでログインすることもできます）。
2. ダッシュボードから「New Project」をクリックします。
3. GitHubリポジトリをインポートします。
4. koere-medical-flyerリポジトリを選択します。
5. プロジェクト設定はデフォルトのままで「Deploy」をクリックします。
6. 数分後、サイトがデプロイされ、Vercelのサブドメイン（例：koere-medical-flyer.vercel.app）でアクセスできるようになります。
7. カスタムドメインを設定することもできます。

#### 4. Firebase Hostingを使用する方法

1. Googleアカウントを使用して[Firebase](https://firebase.google.com/)にログインします。
2. 「コンソールに移動」をクリックし、新しいプロジェクトを作成します。
3. 左側のメニューから「Hosting」を選択し、「開始する」をクリックします。
4. Firebase CLIをインストールします：

```bash
npm install -g firebase-tools
```

5. Firebaseにログインし、プロジェクトを初期化します：

```bash
firebase login
cd koere-medical-flyer
firebase init
```

6. 「Hosting」を選択し、作成したFirebaseプロジェクトを選択します。
7. 公開ディレクトリとして「.」（カレントディレクトリ）を指定します。
8. 単一ページアプリケーションの設定は「No」を選択します。
9. index.htmlを上書きしないように「No」を選択します。
10. デプロイします：

```bash
firebase deploy
```

11. デプロイが完了すると、Firebaseのサブドメイン（例：koere-medical-flyer.web.app）でアクセスできるようになります。

## ローカルでの実行方法

ローカルでWebサイトを表示するには、以下の方法があります：

1. ファイルエクスプローラーでindex.htmlをダブルクリックする
2. ローカルサーバーを使用する（より本番環境に近い表示になります）：

```bash
# Node.jsがインストールされている場合
npx serve

# Pythonがインストールされている場合
python -m http.server
```

その後、ブラウザで`http://localhost:3000`または`http://localhost:8000`にアクセスします。