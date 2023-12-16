# ハッカソン 献立ちゃん

## メンバー

- Hiro
- Nekoyashiki
- Yutaro

# APP詳細

## 概要

- 入力された食材をもとに、作成できる料理レシピを提案してくれるAPP

## 構築環境

- フロントエンド
  - Flutter
- Data保管
  - DynamoDB
- API
  - APIGateway
- API(処理)
  - Lambda
- IaaS
  - aws cdk

### 使用言語

- Dart
  - Flutter
- Typescript
  - aws cdk , Lambda

## APP詳細

### 入力する食材について
- 食材の項目名を入力する


### 開発中の制限
- ローカル開発アプリとし、一般公開はしない
  -  サーバー構築費用などの兼ね合いにより優先度低

### 今後の拡張性


### モックサーバーについて

prism-cliのインストール
```
npm install -g @stoplight/prism-cli
```

モックサーバーを起動する
```
prism mock ./document/api/kondateTyanApi.yaml
```