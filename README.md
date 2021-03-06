# Huboco

<a href="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/images/icon.png">
  <img src="/../master/images/icon.png" width="200px" height="auto">
</a>
<br>

Huboco(ひゅぼ子)は、Hubot製のチャットボットです。
<br>
研究室のチャットルームでの利用を目的に、研究のお手伝いができるよう開発中です。

## Install

Herokuでの簡単な導入説明。

    $ heroku create --stack cedar huboco
    $ heroku addons:add redistogo:nano
    $ heroku config:set HEROKU_URL=http://huboco.herokuapp.com/
    $ heroku config:set HUBOT_TYPETALK_CLIENT_ID=""
    $ heroku config:set HUBOT_TYPETALK_CLIENT_SECRET=""
    $ heroku config:set HUBOT_TYPETALK_ROOMS=""
    $ heroku config:set HUBOT_TYPETALK_API_RATE=100
    $ heroku config:add TZ=Asia/Tokyo
    $ git push heroku heroku:master

## Commands

<table>
  <thead></thead>
  <tbody>
    <tr>
      <td rowspan="4"><tt>huboco.coffee</tt></td>
      <td><tt>hello</tt></td>
      <td>時間に応じた挨拶をする</td>
    </tr>
    <tr>
      <td><tt>version</tt></td>
      <td>Hubotのバージョンを返す</td>
    </tr>
    <tr>
      <td><tt>date</tt></td>
      <td>日付と時間を返す</td>
    </tr>
    <tr>
      <td><tt>time</tt></td>
      <td>時間を返す</td>
    </tr>
    <tr>
      <td><tt>help.coffee</tt></td>
      <td><tt>help</tt></td>
      <td>コマンドの一覧を返す</td>
    </tr>
    <tr>
      <td rowspan="3"><tt>anime.coffee</tt></td>
      <td><tt>anime</tt></td>
      <td>今期放送中のアニメの一覧を返す</td>
    </tr>
    <tr>
      <td><tt>anime today</tt></td>
      <td>今日放送のアニメの一覧を返す</td>
    </tr>
    <tr>
      <td><tt>anime search [title]</tt></td>
      <td>今期のアニメをタイトルで検索する</td>
    </tr>
    <tr>
      <td rowspan="2"><tt>member.coffee</tt></td>
      <td><tt>member</tt></td>
      <td>Typetalkのトピックメンバー全員を返す</td>
    </tr>
    <tr>
      <td><tt>member pick</tt></td>
      <td>ランダムに1人選び、お願いリプライを送る</td>
    </tr>
  </tbody>
</table>

## URLS

<table>
  <thead></thead>
  <tbody>
    <tr>
      <td rowspan="2"><tt>httpd.coffee</tt></td>
      <td><tt>GET /huboco/info</tt></td>
      <td>Hubocoの紹介ページを表示</td>
    </tr>
    <tr>
      <td><tt>POST /hubot/ping</tt></td>
      <td>PONG</td>
    </tr>
    <tr>
      <td><tt>gitlab.coffee</tt></td>
      <td><tt>POST /gitlab/hook?room=&lt;room&gt;</tt></td>
      <td>GitLabからのWebHookを通知</td>
    </tr>
    <tr>
      <td><tt>github.coffee</tt></td>
      <td><tt>POST /github/hook?room=&lt;room&gt;</tt></td>
      <td>GitHubからのWebHookを通知</td>
    </tr>
    <tr>
      <td rowspan="2"><tt>invite.coffee</tt></td>
      <td><tt>GET /typetalk/form?topic_id=&lt;topic_id&gt;</tt></td>
      <td>Typetalkのトピックの招待フォームを表示</td>
    </tr>
    <tr>
      <td><tt>POST /typetalk/invite</tt></td>
      <td>Typetalkのトピックにメンバーを招待</td>
    </tr>
    <tr>
      <td><tt>sensu.coffee</tt></td>
      <td><tt>POST /sensu?room=&lt;room&gt;</tt></td>
      <td>SensuのAlertを通知</td>
    </tr>
 </tbody>
</table>

## SpecialThanks

- 「[情報共有ツールの情報共有 | JANOG34 Meeting](http://www.janog.gr.jp/meeting/janog34/program/itool.html)」への参加をキッカケに開発を開始しました。
- アイコンは「[In Spirited We Love Icon Se by Raindropmemory](http://raindropmemory.deviantart.com/art/In-Spirited-We-Love-Icon-Set-Repost-304014435)」を使っています。
