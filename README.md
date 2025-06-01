# Localized Minecraft Images

日本語ロケールが設定されたMinecraftサーバー用Dockerイメージです。

## 概要

このリポジトリは、[itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server) をベースに、日本語ロケール（`ja_JP.UTF-8`）を追加したDockerイメージを提供します。

## 利用可能なイメージ

### Minecraft Server
- `ghcr.io/musclepr/minecraft-server:latest` - itzg/minecraft-server:latest + 日本語ロケール
- `ghcr.io/musclepr/minecraft-server:java17` - itzg/minecraft-server:java17 + 日本語ロケール

### MC Proxy
- `ghcr.io/musclepr/mc-proxy:latest` - itzg/mc-proxy:latest + 日本語ロケール

## 自動ビルド

このリポジトリでは、柔軟性を重視したGitHub Actionsワークフローが設定されています：

### 拡張性のある設計
- `BASE_IMAGE` パラメータで任意のベースイメージを指定可能
- 現在は `itzg/minecraft-server` と `itzg/mc-proxy` をサポート
- 将来的に他のベンダーのイメージも簡単に追加可能

### Matrix戦略での設定
```yaml
matrix:
  include:
    - base_image: itzg/minecraft-server
      project: minecraft-server
      tag: latest
    - base_image: itzg/minecraft-server
      project: minecraft-server  
      tag: java17
    - base_image: itzg/mc-proxy
      project: mc-proxy
      tag: latest
```

### 1. `build.yml` - メインワークフロー
- **トリガー**:
  - メインブランチへのプッシュ
  - 毎時間の上流イメージ更新チェック
  - 手動実行（強制ビルドオプション付き）
- **機能**: 上流イメージに変更がある場合のみ自動ビルド

### 2. `manual.yml` - 手動ビルド
- **機能**: 特定のプロジェクトやタグを選択してビルド
- **オプション**:
  - プロジェクト選択: `all`, `minecraft-server`, `mc-proxy`
  - タグ選択: `all`, `latest`, `java17`

## 拡張例

新しいベースイメージを追加する場合は、matrixに追加するだけで対応できます：

```yaml
# 例：他のベンダーのイメージを追加
- base_image: other-vendor/minecraft-server
  project: minecraft-server-alt
  tag: latest
```

## ベースイメージ

- [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server)
- [itzg/mc-proxy](https://hub.docker.com/r/itzg/mc-proxy)

## 追加された機能

- 日本語ロケール（`ja_JP.UTF-8`）のインストールと設定
- 環境変数の設定:
  - `LANG=ja_JP.UTF-8`
  - `LANGUAGE=ja_JP:ja`
  - `LC_ALL=ja_JP.UTF-8`

## ライセンス

このプロジェクトは元のitzgプロジェクトと同じライセンスに従います。
