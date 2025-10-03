以下のような手順を README に書くとわかりやすいです。`openapi-challecara` プロジェクトをセットアップして実行する方法を整理しました。

---

# openapi-challecara

## 概要

`openapi-challecara` は TypeSpec を使った OpenAPI 定義生成および Express サーバーでの表示を行うプロジェクトです。
TypeSpec (旧名称 Cadl) を用いて API を定義し、Swagger UI で確認できます。

## 必要環境

* Node.js 18 以上
* npm 8 以上

## インストール

```bash
# リポジトリをクローン
git clone <リポジトリURL>
cd openapi-challecara

# 依存関係をインストール
npm install
```

## 開発用

TypeSpec のコンパイルと OpenAPI 生成を自動で行いながらサーバーを起動する場合：

```bash
# TypeSpec を監視モードでコンパイル
npm run watch
```

サーバー単体を起動する場合：

```bash
npm run start
```

## ビルド

TypeSpec から OpenAPI 定義を生成するだけの場合：

```bash
npm run build
```

生成された OpenAPI 定義はプロジェクト内の `tsp-output/schema/openapi.yaml` に出力されます。

## 使用方法

1. `npm run build` または `npm run watch` で OpenAPI 定義を生成
2. `npm run start` で Express サーバーを起動
3. ブラウザで `http://localhost:3000` にアクセスすると Swagger UI が表示されます

