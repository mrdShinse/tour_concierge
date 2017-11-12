# LiveFansクローリング

## 会場(Venue)

### モデル

```ruby
rails g model Venue name:string address:text capacity:string url:string import:string
```

### 一覧

http://www.livefans.jp/venue/search/area/JPN-{prefecture_code}/page:{page_no}

`div.grayBack > div.whiteBack.midBox > h3.title > a` → 会場詳細URL

### 詳細

http://www.livefans.jp/venues/{vanue_id} → import

- `div.titleblock > h1#title` → name
- `section#info.category > table > tbody > tr > 0` → address
- `section#info.category > table > tbody > tr > 2` → capacity
- `section#info.category > table > tbody > tr > 5` → url

### 緯度経度変換

https://qiita.com/laqiiz/items/842fe2a32e80bac92364

## 演者(Player)

### モデル

```ruby
rails g model Player name:string import:string
```

### 一覧

http://www.livefans.jp/artist/search/all/{kana_code}/page:{page_no}

`div.grayBack > div.whiteBack.midBox > h3.artistName > a` → name, import

## イベント(Event)

### モデル

```ruby
rails g model Event player_id:integer venue_id:integer title:string start_at:time
```

### 一覧

http://www.livefans.jp/artists/future/{artist_id}

`div.relLiveList > div.whiteBack.midBox > h3.artistName > a` → 詳細URL

### 詳細

- `div.dataBlock > h3.artistName` → player_id
- `div.dataBlock > address > a` → venue_id
- `div.dataBlock > h3.liveNmae` → title
- `div.dataBlock > h3.liveNmae > p.date` → start_at
