# ChromeSidebarToggleRaycast

https://github.com/user-attachments/assets/7e155801-40e3-4101-a532-8856a9ad3aa0

[Raycast](https://www.raycast.com/) のスクリプトコマンドで、Chrome のタブサイドバーをキー一つで切り替えます。

Chrome の「タブを展開」/「タブを折りたたむ」ボタンにはキーボードショートカットがありません。このスクリプトは macOS のアクセシビリティ API を使ってボタンをプログラム的に検出・クリックします。座標ハックは不要で、どの画面・解像度でも動作します。

## 必要なもの

- macOS 13 以上
- [Raycast](https://www.raycast.com/)
- タブサイドバーが有効な Google Chrome
- Xcode Command Line Tools（`xcode-select --install`）

## インストール

1. リポジトリをクローン：
   ```bash
   git clone https://github.com/RotulPlastik/ChromeSidebarToggleRaycast.git
   cd ChromeSidebarToggleRaycast
   ```

2. バイナリをビルド：
   ```bash
   ./build.sh
   ```
   `toggle-chrome-sidebar.swift` をコンパイルし、バイナリを `~/raycast-scripts/bin/toggle-chrome-sidebar` に配置します。

3. Raycast ラッパーをコピー：
   ```bash
   cp toggle-chrome-sidebar.sh ~/raycast-scripts/
   ```

4. Raycast の設定（Settings > Extensions > Script Commands > Add Directories）で `~/raycast-scripts/` をスクリプトコマンドディレクトリとして追加します（未追加の場合）。

5. システム設定 > プライバシーとセキュリティ > アクセシビリティ で、Raycast に**アクセシビリティ**権限を付与します。

## 使い方

Raycast を開いて **「Toggle Chrome Sidebar」** を検索するか、Raycast の設定でホットキーを割り当ててください。

## 仕組み

1. バンドル識別子（`com.google.Chrome`）で Chrome を検出
2. Chrome のアクセシビリティツリー（`AXUIElement`）を探索し、「Expand tabs」または「Collapse tabs」というタイトルのボタンを検索
3. `AXUIElementPerformAction` でボタンをクリック

スクリプトはネイティブバイナリに事前コンパイルされるため、ほぼ即座に実行されます（インタプリタ実行の約 1.5 秒に対して約 10ms）。

## ファイル構成

| ファイル | 説明 |
|------|-------------|
| `toggle-chrome-sidebar.swift` | Swift ソース — メインロジック |
| `toggle-chrome-sidebar.sh` | Raycast メタデータ付き Bash ラッパー（コンパイル済みバイナリを呼び出す） |
| `build.sh` | Swift ソースを `~/raycast-scripts/bin/` にコンパイル |
| `chrome-mouse-offset.swift` | おまけユーティリティ — Chrome ウィンドウに対するマウス座標を表示（座標ベースの自動化に便利） |

## 再ビルド

`toggle-chrome-sidebar.swift` を編集した後：

```bash
./build.sh
```

## ライセンス

MIT
