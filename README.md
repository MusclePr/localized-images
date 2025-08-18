# Localized Docker Images

日本語ロケールが設定された Docker イメージを作成します。<br>
通常、各言語毎のロケールはイメージが膨れるため割愛されます。<br>
これを、ベースイメージに、`apt-get install -y locales && locale-gen ja_JP.UTF-8` を加える事で対処します。

## 概要

このリポジトリは、個人的によく使うイメージに日本語ロケールを追加したものを提供します。<br>
GitHub Workflow を用いて、毎日アップストリームの更新チェックを行い、必要に応じてイメージをビルドします。

## 利用可能なイメージ

### Minecraft Server
- `ghcr.io/musclepr/minecraft-server:latest` - itzg/minecraft-server:latest + 日本語ロケール
- `ghcr.io/musclepr/minecraft-server:java17` - itzg/minecraft-server:java17 + 日本語ロケール

### MC Proxy
- `ghcr.io/musclepr/mc-proxy:latest` - itzg/mc-proxy:latest + 日本語ロケール

### MC Backup
- `ghcr.io/musclepr/mc-backup:latest` - itzg/mc-backup:latest + 日本語ロケール

## 使用方法

### 基本的な使用例

`compose.yml` の `image` 指定を変更し、タイムゾーンを指定します。
```yaml
services:
  mc:
    #images: itzg/docker-minecraft-server:latest
    images: ghcr.io/musclepr/minecraft-server:latest
    environment:
      TZ: "Asia/Tokyo"
```

## 日本語サポートの詳細

これらのイメージには以下の日本語ロケール設定が追加されています：

- **ロケール**: `ja_JP.UTF-8`
- **環境変数**:
  - `LANG=ja_JP.UTF-8`
  - `LANGUAGE=ja_JP:ja`
  - `LC_ALL=ja_JP.UTF-8`

## ローカルビルド

このプロジェクトをローカルでビルドする場合：

### 自動ビルドスクリプト
```bash
# 全てのイメージをビルド
./build.sh
```

### 手動ビルド
```bash
# Minecraft Server (latest)
docker build -t ghcr.io/musclepr/minecraft-server:latest \
  --build-arg IMAGE=itzg/minecraft-server:latest .

# Minecraft Server (Java 17)
docker build -t ghcr.io/musclepr/minecraft-server:java17 \
  --build-arg IMAGE=itzg/minecraft-server:java17 .

# MC Proxy
docker build -t ghcr.io/musclepr/mc-proxy:latest \
  --build-arg IMAGE=itzg/mc-proxy:latest .

# MC Backup
docker build -t ghcr.io/musclepr/mc-backup:latest \
  --build-arg IMAGE=itzg/mc-backup:latest .
```

## 技術的詳細

### 自動ビルド判定・gh-pages管理

#### ビルド判定の仕組み
GitHub Actions のワークフローでは、アップストリームイメージのダイジェストを `gh-pages` ブランチの `digests.json` で管理しています。<br>
各イメージごとに最新ダイジェストを記録し、差分がなければ自動的にビルドをスキップします。

ビルド後は `digests.json` を自動更新し、`gh-pages` ブランチへ push されます。<br>
これにより、不要なビルドを防ぎつつ、アップストリームの更新にのみ反応します。

#### 仕組みの概要
- `gh-pages` の `digests.json` に全イメージのダイジェストをキーごとに管理
- ワークフローの最初で `digests.json` を取得し、対象イメージのダイジェストを比較
- 差分があればビルド・push後に `digests.json` を更新し `gh-pages` に反映

#### 参考: digests.json の例
```json
{
  "itzg/minecraft-server:latest": "sha256:xxxx...",
  "itzg/mc-proxy:latest": "sha256:yyyy...",
  "itzg/mc-backup:latest": "sha256:zzzz..."
}
```

### Dockerfile の仕組み
本プロジェクトの Dockerfile は、ベースイメージが Alpine ベースか Ubuntu ベースかを自動検出し、適切なロケールパッケージをインストールします：

- **Alpine系**: `musl-locales` と `musl-locales-lang` パッケージ
- **Ubuntu/Debian系**: `locales` パッケージと `locale-gen` コマンド

### 対応ベースイメージ
- Alpine Linux ベース（mc-backup など）
- Ubuntu/Debian ベース（minecraft-server、mc-proxy など）

## プロジェクト情報

### ベースイメージ
- [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) - 元の Minecraft サーバーイメージ
- [itzg/mc-proxy](https://hub.docker.com/r/itzg/mc-proxy) - Bungeecord/Velocity プロキシ
- [itzg/mc-backup](https://hub.docker.com/r/itzg/mc-backup) - バックアップツール

### 追加された機能
- **日本語ロケールサポート**: `ja_JP.UTF-8` の完全サポート
- **クロスプラットフォーム対応**: Alpine/Ubuntu 両方のベースイメージに対応
- **自動検出**: ベースイメージの OS を自動検出してパッケージ管理

### 技術仕様
- **環境変数**:
  - `LANG=ja_JP.UTF-8`
  - `LANGUAGE=ja_JP:ja` 
  - `LC_ALL=ja_JP.UTF-8`
- **追加パッケージ**:
  - Alpine: `musl-locales`, `musl-locales-lang`
  - Ubuntu/Debian: `locales` + `locale-gen ja_JP.UTF-8`

## トラブルシューティング

### 日本語が表示されない場合
1. コンテナ内でロケール設定を確認：
```bash
docker exec -it <container_name> locale
```

2. 日本語ロケールが利用可能か確認：
```bash
docker exec -it <container_name> locale -a | grep ja_JP
```

### プラグインで日本語が文字化けする場合
プラグインの設定ファイルで文字エンコーディングを `UTF-8` に設定してください。

## プロジェクト構成

```
localized-images/
├── Dockerfile           # ユニバーサル Dockerfile（Alpine/Ubuntu対応）
├── build.sh             # 自動ビルドスクリプト
├── .dockerignore        # Docker 除外ファイル
├── .gitignore           # Git 除外ファイル
├── README.md            # このファイル
└── .github/
  └── workflows/
    └── build.yml   # GitHub Actions ワークフロー
```

### ファイル説明
- **Dockerfile**: ベースイメージの種類を自動検出し、適切なロケールパッケージをインストール
- **build.sh**: 4つのイメージを一括でビルドする自動化スクリプト
- **.dockerignore**: ビルド時に不要なファイルを除外
- **.gitignore**: Git管理対象外ファイルの指定
- **.github/workflows/build.yml**: 自動ビルド・更新ワークフロー

## 関連リンク

- [itzg/docker-minecraft-server GitHub](https://github.com/itzg/docker-minecraft-server)
- [itzg/mc-proxy GitHub](https://github.com/itzg/mc-proxy)
- [itzg/mc-backup GitHub](https://github.com/itzg/mc-backup)
- [Docker Hub - itzg](https://hub.docker.com/u/itzg)

## ライセンス

このプロジェクトは元の itzg プロジェクトと同じライセンスに従います。
