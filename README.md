# Localized Minecraft Images

日本語ロケールが設定されたMinecraftサーバー用Dockerイメージです。

## 概要

このリポジトリは、[itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server) をベースに、日本語ロケール（`ja_JP.UTF-8`）を追加したDockerイメージを提供します。

## 利用可能なイメージ

### Minecraft Server
- `MusclePr/minecraft-server:latest` - itzg/minecraft-server:latest + 日本語ロケール
- `MusclePr/minecraft-server:java17` - itzg/minecraft-server:java17 + 日本語ロケール

### MC Proxy
- `MusclePr/mc-proxy:latest` - itzg/mc-proxy:latest + 日本語ロケール

### MC Backup
- `MusclePr/mc-backup:latest` - itzg/mc-backup:latest + 日本語ロケール

## 使用方法

### 基本的な使用例

#### Minecraft Server
- 使用例については、[itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server) の examples に使用例が多くありますので、それを参照してください。
- イメージの名前のを `ghcr.io/musclepr/minecraft-server` に入れ替えるだけでOKです。

#### MC Proxy (Bungeecord/Velocity)
- 使用例については、[itzg/docker-mc-proxy](https://github.com/itzg/docker-mc-proxy) の README に使用例がありますので、それを参照してください。

#### MC Backup
- 使用例については、[itzg/docker-mc-backup](https://github.com/itzg/docker-mc-backup) の README に使用例がありますので、それを参照してください。

## 日本語サポートの詳細

これらのイメージには以下の日本語ロケール設定が追加されています：

- **ロケール**: `ja_JP.UTF-8`
- **環境変数**:
  - `LANG=ja_JP.UTF-8`
  - `LANGUAGE=ja_JP:ja`
  - `LC_ALL=ja_JP.UTF-8`

### 対応する機能
- 日本語プレイヤー名の適切な表示
- 日本語チャットメッセージの正常処理
- 日本語プラグインメッセージのサポート
- ログファイルでの日本語文字化け防止

## ローカルビルド

このプロジェクトをローカルでビルドする場合：

### 自動ビルドスクリプト
```bash
# 全てのイメージをビルド
./build.sh

# 実行可能にする必要がある場合
chmod +x build.sh
```

### 手動ビルド
```bash
# Minecraft Server (latest)
docker build -t MusclePr/minecraft-server:latest \
  --build-arg BASE_IMAGE=itzg/minecraft-server:latest .

# Minecraft Server (Java 17)
docker build -t MusclePr/minecraft-server:java17 \
  --build-arg BASE_IMAGE=itzg/minecraft-server:java17 .

# MC Proxy
docker build -t MusclePr/mc-proxy:latest \
  --build-arg BASE_IMAGE=itzg/mc-proxy:latest .

# MC Backup
docker build -t MusclePr/mc-backup:latest \
  --build-arg BASE_IMAGE=itzg/mc-backup:latest .
```

## 技術的詳細

### Dockerfileの仕組み
本プロジェクトのDockerfileは、ベースイメージがAlpineベースかUbuntuベースかを自動検出し、適切なロケールパッケージをインストールします：

- **Alpine系**: `musl-locales` と `musl-locales-lang` パッケージ
- **Ubuntu/Debian系**: `locales` パッケージと `locale-gen` コマンド

### 対応ベースイメージ
- Alpine Linux ベース（mc-backupなど）
- Ubuntu/Debian ベース（minecraft-server、mc-proxyなど）

## プロジェクト情報

### ベースイメージ
- [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) - 元のMinecraftサーバーイメージ
- [itzg/mc-proxy](https://hub.docker.com/r/itzg/mc-proxy) - Bungeecord/Velocityプロキシ
- [itzg/mc-backup](https://hub.docker.com/r/itzg/mc-backup) - バックアップツール

### 追加された機能
- **日本語ロケールサポート**: `ja_JP.UTF-8` の完全サポート
- **クロスプラットフォーム対応**: Alpine/Ubuntu両方のベースイメージに対応
- **自動検出**: ベースイメージのOSを自動検出してパッケージ管理

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
├── Dockerfile          # ユニバーサルDockerfile（Alpine/Ubuntu対応）
├── build.sh             # 自動ビルドスクリプト
├── .dockerignore        # Docker除外ファイル
└── README.md           # このファイル
```

### ファイル説明
- **Dockerfile**: ベースイメージの種類を自動検出し、適切なロケールパッケージをインストール
- **build.sh**: 4つのイメージを一括でビルドする自動化スクリプト
- **.dockerignore**: ビルド時に不要なファイルを除外

## 関連リンク

- [itzg/docker-minecraft-server GitHub](https://github.com/itzg/docker-minecraft-server)
- [itzg/mc-proxy GitHub](https://github.com/itzg/mc-proxy)
- [itzg/mc-backup GitHub](https://github.com/itzg/mc-backup)
- [Docker Hub - itzg](https://hub.docker.com/u/itzg)

## ライセンス

このプロジェクトは元のitzgプロジェクトと同じライセンスに従います。
