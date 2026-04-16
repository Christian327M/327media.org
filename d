<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>327 Media</title>
  <meta name="description" content="327 Media — news, stocks, sports, betting, and podcast." />
  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
  <style>
    :root {
      --bg: #070b12;
      --bg2: #0d1320;
      --panel: rgba(12,18,31,0.95);
      --line: rgba(255,255,255,0.08);
      --text: #f5f7fb;
      --muted: #9fb0c9;
      --gold: #d8b26d;
      --gold2: #f1d298;
      --green: #2ecc71;
      --red: #ff7d89;
      --shadow: 0 16px 36px rgba(0,0,0,0.34);
      --radius: 20px;
      --max: 1380px;
    }

    * { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body {
      margin: 0;
      font-family: Inter, Arial, sans-serif;
      color: var(--text);
      background:
        radial-gradient(circle at top right, rgba(216,178,109,0.12), transparent 20%),
        radial-gradient(circle at top left, rgba(86,168,255,0.08), transparent 20%),
        linear-gradient(180deg, #05070c 0%, #09101a 48%, #05070c 100%);
      line-height: 1.55;
    }

    a { color: inherit; text-decoration: none; }
    img { display: block; max-width: 100%; }
    iframe { display: block; }
    button, input, textarea { font: inherit; }

    .container {
      width: min(calc(100% - 24px), var(--max));
      margin: 0 auto;
    }

    .top-ticker {
      position: sticky;
      top: 0;
      z-index: 999;
      background: rgba(5, 8, 12, 0.96);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--line);
    }

    .nav-wrap {
      position: sticky;
      top: 52px;
      z-index: 998;
      background: rgba(6, 8, 13, 0.92);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--line);
    }

    .nav {
      min-height: 78px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      flex-wrap: wrap;
      padding: 10px 0;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 14px;
    }

    .brand-logo {
      width: 54px;
      height: 54px;
      object-fit: cover;
      border-radius: 14px;
      border: 1px solid rgba(255,255,255,0.12);
      background: #111827;
    }

    .brand-text h1 {
      margin: 0;
      font-size: 1.05rem;
      letter-spacing: 0.18em;
      text-transform: uppercase;
    }

    .brand-text p {
      margin: 4px 0 0;
      color: var(--muted);
      font-size: 0.86rem;
    }

    .nav-links {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      align-items: center;
    }

    .nav-links a {
      padding: 10px 14px;
      border-radius: 999px;
      color: #d8e1f2;
      font-weight: 700;
    }

    .nav-links a:hover,
    .nav-links a.active {
      background: rgba(255,255,255,0.08);
      color: #fff;
    }

    .nav-actions {
      display: flex;
      gap: 10px;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      border: none;
      cursor: pointer;
      border-radius: 999px;
      padding: 12px 16px;
      font-weight: 800;
      transition: transform 0.18s ease, opacity 0.18s ease;
    }

    .btn:hover { transform: translateY(-1px); }

    .btn-outline {
      background: transparent;
      color: #fff;
      border: 1px solid rgba(255,255,255,0.14);
    }

    .btn-gold {
      background: linear-gradient(135deg, var(--gold), var(--gold2));
      color: #111;
    }

    .search-row {
      display: grid;
      grid-template-columns: 1.2fr 0.8fr;
      gap: 16px;
      padding: 10px 0 16px;
    }

    .search-box,
    .mini-box,
    .card {
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
    }

    .search-box {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
    }

    .search-box input {
      width: 100%;
      border: none;
      outline: none;
      background: transparent;
      color: #fff;
    }

    .mini-box {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 14px;
      padding: 12px 16px;
      color: var(--muted);
      font-size: 0.93rem;
    }

    main section {
      padding: 30px 0;
      scroll-margin-top: 150px;
    }

    .section-title {
      margin-bottom: 16px;
    }

    .section-title h2 {
      margin: 0;
      font-size: clamp(1.35rem, 2vw, 2rem);
    }

    .section-title p {
      margin: 8px 0 0;
      color: var(--muted);
    }

    .card-body { padding: 18px; }

    .eyebrow {
      display: inline-block;
      color: var(--gold2);
      font-size: 0.78rem;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      font-weight: 800;
    }

    .headline-lg {
      margin: 10px 0 12px;
      font-size: clamp(1.8rem, 3vw, 2.8rem);
      line-height: 1.08;
    }

    .muted { color: var(--muted); }
    .green { color: var(--green); }
    .red { color: var(--red); }
    .hidden { display: none !important; }

    .hero-grid,
    .layout-2,
    .split-2,
    .split-3,
    .contact-grid,
    .footer-grid,
    .stocks-layout,
    .stats-row,
    .ticker-grid {
      display: grid;
      gap: 18px;
    }

    .hero-grid,
    .split-2,
    .contact-grid,
    .stocks-layout { grid-template-columns: 1fr 1fr; }
    .split-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
    .layout-2 { grid-template-columns: 2fr 1fr; }
    .footer-grid { grid-template-columns: 1.2fr 0.8fr 0.8fr; }
    .stats-row { grid-template-columns: repeat(3, 1fr); }
    .ticker-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }

    .hero-right {
      background:
        linear-gradient(180deg, rgba(6,10,18,0.45), rgba(6,10,18,0.88)),
        url('home-hero-podcast.jpg') center/cover no-repeat;
    }

    .story-list,
    .market-cats,
    .schedule-list,
    .odds-board,
    .stack {
      display: grid;
      gap: 12px;
    }

    .story-item,
    .market-cat,
    .schedule-item,
    .odds-row,
    .social-link,
    .ticker-chip,
    .stat,
    .news-mini {
      background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: 16px;
    }

    .story-item,
    .ticker-chip,
    .stat { padding: 14px; }

    .story-item:hover,
    .schedule-item:hover,
    .odds-row:hover,
    .news-mini:hover,
    .podcast-card:hover,
    .social-link:hover {
      border-color: rgba(255,255,255,0.15);
      background: rgba(255,255,255,0.06);
      transform: translateY(-1px);
      transition: 0.2s ease;
    }

    .story-item h3,
    .story-item h4,
    .news-mini h4,
    .podcast-card h3 {
      margin: 8px 0 6px;
      line-height: 1.2;
    }

    .video-frame {
      width: 100%;
      aspect-ratio: 16 / 9;
      border: none;
      border-radius: 18px;
      background: #000;
    }

    .stat .num {
      margin-top: 6px;
      font-size: 1.12rem;
      font-weight: 800;
    }

    .tag-row {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 12px;
    }

    .tag,
    .source-pill,
    .mini-link {
      display: inline-flex;
      align-items: center;
      border-radius: 999px;
      font-weight: 700;
    }

    .tag {
      padding: 8px 12px;
      background: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.07);
      color: #dce6fa;
      font-size: 0.88rem;
    }

    .source-pill,
    .mini-link {
      padding: 6px 10px;
      background: rgba(255,255,255,0.08);
      color: #dce6fa;
      font-size: 0.78rem;
    }

    .media-card img,
    .podcast-card img,
    .sports-card img,
    .bet-card img,
    .news-feature-large img {
      width: 100%;
      height: 210px;
      object-fit: cover;
    }

    .news-feature-large img {
      height: 220px;
      object-position: center top;
    }

    .media-card .card-body,
    .podcast-card .card-body,
    .sports-card .card-body,
    .bet-card .card-body { padding-top: 16px; }

    .news-mini {
      display: grid;
      grid-template-columns: 82px 1fr;
      gap: 12px;
      padding: 10px;
      align-items: center;
    }

    .news-mini img {
      width: 82px;
      height: 82px;
      border-radius: 12px;
      object-fit: cover;
      object-position: center;
    }

    .market-cat {
      width: 100%;
      text-align: left;
      padding: 14px 16px;
      color: #fff;
      cursor: pointer;
      font-weight: 800;
    }

    .market-cat.active,
    .market-cat:hover {
      background: linear-gradient(135deg, rgba(216,178,109,0.22), rgba(86,168,255,0.12));
      border-color: rgba(216,178,109,0.45);
    }

    .schedule-item,
    .odds-row,
    .social-link {
      display: grid;
      align-items: center;
      padding: 14px;
      gap: 12px;
    }

    .schedule-item {
      grid-template-columns: 110px 1fr 90px;
    }

    .schedule-item .time {
      color: var(--gold2);
      font-weight: 800;
    }

    .odds-row {
      grid-template-columns: 1.2fr 0.8fr 0.8fr 0.4fr;
    }

    .social-link {
      grid-template-columns: 80px 1fr;
      justify-content: space-between;
    }

    .field {
      width: 100%;
      padding: 14px 16px;
      border-radius: 14px;
      border: 1px solid rgba(255,255,255,0.12);
      background: rgba(255,255,255,0.04);
      color: #fff;
      outline: none;
    }

    textarea.field {
      min-height: 160px;
      resize: vertical;
    }

    .contact-form {
      display: grid;
      gap: 12px;
    }

    .footer {
      margin-top: 24px;
      padding: 28px 0 60px;
      border-top: 1px solid var(--line);
      color: var(--muted);
    }

    .auth-note,
    .status-text {
      min-height: 22px;
      font-size: 0.92rem;
    }

    @media (max-width: 1180px) {
      .hero-grid,
      .layout-2,
      .split-3,
      .stocks-layout,
      .contact-grid,
      .footer-grid,
      .stats-row {
        grid-template-columns: 1fr;
      }
      .search-row { grid-template-columns: 1fr; }
    }

    @media (max-width: 760px) {
      .top-ticker { top: 0; }
      .nav-wrap { top: 45px; }
      .split-2,
      .ticker-grid,
      .stocks-layout { grid-template-columns: 1fr; }
      .schedule-item,
      .odds-row,
      .news-mini,
      .social-link,
      .mini-box {
        grid-template-columns: 1fr;
        flex-direction: column;
        align-items: flex-start;
      }
    }
  </style>
</head>
<body>
  <div class="top-ticker">
    <div class="tradingview-widget-container">
      <div class="tradingview-widget-container__widget"></div>
      <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
      {
        "symbols": [
          {"proName":"NASDAQ:AAPL","title":"AAPL"},
          {"proName":"NASDAQ:MSFT","title":"MSFT"},
          {"proName":"NASDAQ:NVDA","title":"NVDA"},
          {"proName":"NASDAQ:AMZN","title":"AMZN"},
          {"proName":"NASDAQ:GOOGL","title":"GOOGL"},
          {"proName":"NYSE:XOM","title":"XOM"},
          {"proName":"NYSE:CVX","title":"CVX"},
          {"proName":"AMEX:SPY","title":"SPY"},
          {"proName":"NASDAQ:QQQ","title":"QQQ"},
          {"proName":"BINANCE:BTCUSDT","title":"BTC"},
          {"proName":"BINANCE:ETHUSDT","title":"ETH"}
        ],
        "showSymbolLogo": true,
        "isTransparent": true,
        "displayMode": "adaptive",
        "colorTheme": "dark",
        "locale": "en"
      }
      </script>
    </div>
  </div>

  <div class="nav-wrap">
    <div class="container">
      <nav class="nav">
        <div class="brand">
          <img class="brand-logo" src="logo-327media.png" alt="327 Media logo" />
          <div class="brand-text">
            <h1>327 Media</h1>
            <p>Breaking news • stocks • sports • podcast</p>
          </div>
        </div>

        <div class="nav-links">
          <a href="#home" class="active">Home</a>
          <a href="#news">News</a>
          <a href="#stocks">Stocks</a>
          <a href="#sports">Sports</a>
          <a href="#betting">Betting</a>
          <a href="#podcast">Podcast</a>
          <a href="#contact">Contact</a>
        </div>

        <div class="nav-actions" id="navActions">
          <button class="btn btn-outline" onclick="openAuth('login')">Log In</button>
          <button class="btn btn-gold" onclick="openAuth('signup')">Sign Up</button>
        </div>
      </nav>

      <div class="search-row">
        <div class="search-box">
          <span>🔎</span>
          <input id="siteSearch" type="search" placeholder="Search the site: stocks, teams, news, podcast, crypto..." />
        </div>
        <div class="mini-box">
          <div><strong>Live refresh:</strong> stocks and key links are live on-page</div>
          <div><strong>Email:</strong> 327mediax@gmail.com</div>
        </div>
      </div>
    </div>
  </div>

  <main class="container">
    <section id="home" data-search="home breaking news podcast latest video ticker stocks sports contact">
      <div class="hero-grid">
        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Breaking now</span>
            <h2 style="margin:10px 0 14px;">Breaking news, major events, and market-moving stories up front.</h2>

            <a class="card news-feature-large" href="https://www.reuters.com/world/" target="_blank" rel="noopener noreferrer" style="display:block; overflow:hidden; margin-bottom:14px;">
              <img src="news-main-1.jpg" alt="Featured current events" />
              <div class="card-body">
                <span class="source-pill">Featured current events</span>
                <h3>Open live world and politics coverage</h3>
                <p class="muted">This adds more flare to the homepage and sends users straight to a live source.</p>
              </div>
            </a>

            <div class="story-list">
              <a class="news-mini" href="https://www.reuters.com/world/" target="_blank" rel="noopener noreferrer">
                <img src="news-feature-1.jpg" alt="World news thumbnail" />
                <div>
                  <span class="mini-link">Reuters</span>
                  <h4>World headlines and breaking updates</h4>
                  <div class="muted">Live source for major current events</div>
                </div>
              </a>
              <a class="news-mini" href="https://apnews.com/" target="_blank" rel="noopener noreferrer">
                <img src="news-feature-2.jpg" alt="Politics thumbnail" />
                <div>
                  <span class="mini-link">AP</span>
                  <h4>Politics and economy coverage</h4>
                  <div class="muted">Fast wire updates for national stories</div>
                </div>
              </a>
              <a class="news-mini" href="https://www.cnbc.com/markets/" target="_blank" rel="noopener noreferrer">
                <img src="news-feature-3.jpg" alt="Markets thumbnail" />
                <div>
                  <span class="mini-link">CNBC</span>
                  <h4>Market-moving financial stories</h4>
                  <div class="muted">Rates, stocks, earnings, and momentum</div>
                </div>
              </a>
            </div>
          </div>
        </article>

        <article class="card hero-right">
          <div class="card-body">
            <h2 class="headline-lg">The CIA Podcast</h2>
            <p style="margin:0; font-size:1.08rem; font-weight:800; color:var(--gold2); letter-spacing:0.04em;">Powered by 327 Media</p>
            <p class="muted" style="margin-top:10px;">Don’t miss the latest episode.</p>
            <div class="tag-row">
              <a class="tag" href="https://youtu.be/zP0T28wSa-E?si=0he35fJTJNHeDjdS" target="_blank" rel="noopener noreferrer">Latest episode</a>
              <a class="tag" href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer">YouTube channel</a>
              <a class="tag" href="https://x.com/327media1" target="_blank" rel="noopener noreferrer">@327media1</a>
            </div>
          </div>
          <div class="card-body">
            <a href="https://youtu.be/zP0T28wSa-E?si=0he35fJTJNHeDjdS" target="_blank" rel="noopener noreferrer" aria-label="Open latest CIA Podcast episode">
              <iframe class="video-frame" src="https://www.youtube.com/embed/zP0T28wSa-E" title="Latest CIA Podcast episode" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </a>
            <div class="stats-row">
              <a class="stat" href="https://youtu.be/zP0T28wSa-E?si=0he35fJTJNHeDjdS" target="_blank" rel="noopener noreferrer">
                <div class="muted">Latest episode</div>
                <div class="num">Watch now</div>
              </a>
              <a class="stat" href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer">
                <div class="muted">YouTube</div>
                <div class="num">@CIApodcastTV</div>
              </a>
              <a class="stat" href="https://x.com/327media1" target="_blank" rel="noopener noreferrer">
                <div class="muted">X account</div>
                <div class="num">@327media1</div>
              </a>
            </div>
          </div>
        </article>
      </div>
    </section>

    <section id="news" data-search="news media left right politics economy world outlets">
      <div class="section-title">
        <h2>Breaking news + balanced media columns</h2>
        <p>One center news feed plus separate left-leaning and right-leaning source rows.</p>
      </div>

      <div class="layout-2">
        <div class="stack">
          <article class="card">
            <div class="card-body">
              <span class="eyebrow">Top feed</span>
              <div class="split-2">
                <a class="media-card card" href="https://www.reuters.com/world/" target="_blank" rel="noopener noreferrer">
                  <img src="news-main-1.jpg" alt="Top news visual" />
                  <div class="card-body">
                    <span class="source-pill">Homepage priority</span>
                    <h3>Build your top stories block to feel alive and clickable</h3>
                    <p class="muted">This section is built to make news feel like a real media homepage.</p>
                  </div>
                </a>
                <a class="media-card card" href="https://apnews.com/" target="_blank" rel="noopener noreferrer">
                  <img src="news-main-2.jpg" alt="Second news visual" />
                  <div class="card-body">
                    <span class="source-pill">Balanced layout</span>
                    <h3>Separate media lanes make the news tab richer and more intentional</h3>
                    <p class="muted">This avoids a dry single-column wall of text.</p>
                  </div>
                </a>
              </div>
            </div>
          </article>

          <article class="card">
            <div class="card-body">
              <span class="eyebrow">Latest from 327 Media</span>
              <div class="split-3">
                <a class="podcast-card card" href="https://youtu.be/zP0T28wSa-E?si=0he35fJTJNHeDjdS" target="_blank" rel="noopener noreferrer">
                  <img src="news-feature-1.jpg" alt="Featured analysis" />
                  <div class="card-body">
                    <span class="source-pill">327 Media Analysis</span>
                    <h3>Independent reporting with a sharper visual edge</h3>
                    <p class="muted">Use this for your featured analysis or homepage lead story.</p>
                  </div>
                </a>
                <a class="podcast-card card" href="#stocks">
                  <img src="news-feature-2.jpg" alt="Markets story" />
                  <div class="card-body">
                    <span class="source-pill">327 Media Stocks</span>
                    <h3>Stocks, politics, and breaking headlines in one ecosystem</h3>
                    <p class="muted">This supports your mix of finance and media without blending the tabs together.</p>
                  </div>
                </a>
                <a class="podcast-card card" href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer">
                  <img src="news-feature-3.jpg" alt="Podcast studio setup" />
                  <div class="card-body">
                    <span class="source-pill">CIA Podcast</span>
                    <h3>Clip your best episode moments into visual cards</h3>
                    <p class="muted">Perfect for YouTube clips, guest announcements, or viral moments.</p>
                  </div>
                </a>
              </div>
            </div>
          </article>
        </div>

        <aside class="stack">
          <article class="card">
            <div class="card-body">
              <span class="eyebrow">Left-leaning outlets</span>
              <div class="story-list">
                <a class="story-item" href="https://www.reuters.com/" target="_blank" rel="noopener noreferrer"><strong>Reuters</strong><div class="muted">Fast global breaking coverage</div></a>
                <a class="story-item" href="https://apnews.com/" target="_blank" rel="noopener noreferrer"><strong>AP News</strong><div class="muted">Wire service headlines and politics</div></a>
                <a class="story-item" href="https://www.cnn.com/" target="_blank" rel="noopener noreferrer"><strong>CNN</strong><div class="muted">Live breaking and U.S. politics</div></a>
                <a class="story-item" href="https://www.msnbc.com/" target="_blank" rel="noopener noreferrer"><strong>MSNBC</strong><div class="muted">Political commentary and cable clips</div></a>
                <a class="story-item" href="https://www.npr.org/" target="_blank" rel="noopener noreferrer"><strong>NPR</strong><div class="muted">National and policy coverage</div></a>
              </div>
            </div>
          </article>

          <article class="card">
            <div class="card-body">
              <span class="eyebrow">Right-leaning outlets</span>
              <div class="story-list">
                <a class="story-item" href="https://www.dailywire.com/" target="_blank" rel="noopener noreferrer"><strong>The Daily Wire</strong><div class="muted">Fast headlines and host ecosystem</div></a>
                <a class="story-item" href="https://www.foxnews.com/" target="_blank" rel="noopener noreferrer"><strong>Fox News</strong><div class="muted">Breaking politics and TV clips</div></a>
                <a class="story-item" href="https://nypost.com/" target="_blank" rel="noopener noreferrer"><strong>New York Post</strong><div class="muted">Punchy tabloid-style updates</div></a>
                <a class="story-item" href="https://www.washingtonexaminer.com/" target="_blank" rel="noopener noreferrer"><strong>Washington Examiner</strong><div class="muted">Policy and campaign coverage</div></a>
                <a class="story-item" href="https://www.breitbart.com/" target="_blank" rel="noopener noreferrer"><strong>Breitbart</strong><div class="muted">High-volume conservative news stream</div></a>
              </div>
            </div>
          </article>
        </aside>
      </div>
    </section>

    <section id="stocks" data-search="stocks stock market finance chart tradingview big tech oil etf crypto watchlist">
      <div class="section-title">
        <h2>Stocks headquarters</h2>
        <p>Permanent ticker on top, stock categories here, and a live chart that actually loads.</p>
      </div>

      <div class="stocks-layout">
        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Stock categories</span>
            <div class="market-cats" id="marketCats"></div>
            <div class="ticker-grid" id="categorySymbolGrid"></div>
          </div>
        </article>

        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Live stock chart</span>
            <div id="tradingview_market_chart" style="height:470px; width:100%;"></div>
          </div>
        </article>
      </div>

      <div class="split-3" style="margin-top:18px;">
        <a class="sports-card card" href="https://www.tradingview.com/markets/stocks-usa/market-movers-large-cap/" target="_blank" rel="noopener noreferrer">
          <img src="news-feature-2.jpg" alt="Large cap stocks" />
          <div class="card-body">
            <span class="source-pill">Large caps</span>
            <h3>Track the biggest names in the market</h3>
            <p class="muted">Good for your visitors who want fast access beyond the on-page chart.</p>
          </div>
        </a>
        <a class="sports-card card" href="https://www.tradingview.com/markets/etfs/funds-most-traded/" target="_blank" rel="noopener noreferrer">
          <img src="news-main-2.jpg" alt="ETF activity" />
          <div class="card-body">
            <span class="source-pill">ETF activity</span>
            <h3>Most traded ETFs and market movers</h3>
            <p class="muted">Great for SPY, QQQ, sector funds, and broad market action.</p>
          </div>
        </a>
        <a class="sports-card card" href="https://www.tradingview.com/markets/cryptocurrencies/prices-all/" target="_blank" rel="noopener noreferrer">
          <img src="podcast-main.jpg" alt="Crypto market" />
          <div class="card-body">
            <span class="source-pill">Crypto</span>
            <h3>Open a full crypto movers board</h3>
            <p class="muted">A good extra outlet for your BTC and ETH crowd.</p>
          </div>
        </a>
      </div>
    </section>

    <section id="sports" data-search="sports nba ufc playoffs betting events scores">
      <div class="section-title">
        <h2>Sports tab</h2>
        <p>Clickable schedules, stronger visuals, and cleaner sports presentation.</p>
      </div>

      <div class="split-3">
        <article class="card">
          <div class="card-body">
            <span class="eyebrow">NBA play-in + playoffs</span>
            <a class="sports-card card" href="https://www.nba.com/playoffs/2026" target="_blank" rel="noopener noreferrer" style="display:block; margin:12px 0 14px; overflow:hidden;">
              <img src="news-main-1.jpg" alt="NBA playoffs visual" />
              <div class="card-body">
                <span class="source-pill">Official NBA</span>
                <h3>Open the full playoff hub</h3>
                <p class="muted">Bracket, series pages, and playoff updates.</p>
              </div>
            </a>
            <div class="schedule-list">
              <a class="schedule-item" href="https://www.nba.com/news/2026-nba-playoffs-schedule" target="_blank" rel="noopener noreferrer"><div class="time">Apr 14–17</div><div><strong>NBA Play-In Tournament</strong><div class="muted">Official NBA postseason schedule</div></div><div class="muted">Open</div></a>
              <a class="schedule-item" href="https://www.nba.com/playoffs/2026" target="_blank" rel="noopener noreferrer"><div class="time">Apr 18</div><div><strong>NBA Playoffs begin</strong><div class="muted">Official bracket and updates</div></div><div class="muted">Open</div></a>
              <a class="schedule-item" href="https://www.nba.com/playoffs/2026/series" target="_blank" rel="noopener noreferrer"><div class="time">Today</div><div><strong>Series previews and matchups</strong><div class="muted">Open official matchup pages</div></div><div class="muted">Open</div></a>
            </div>
          </div>
        </article>

        <article class="card">
          <div class="card-body">
            <span class="eyebrow">UFC schedule</span>
            <a class="sports-card card" href="https://www.ufc.com/events" target="_blank" rel="noopener noreferrer" style="display:block; margin:12px 0 14px; overflow:hidden;">
              <img src="podcast-clip-1.jpg" alt="UFC events visual" />
              <div class="card-body">
                <span class="source-pill">Official UFC</span>
                <h3>Open the UFC events page</h3>
                <p class="muted">Main cards, fight nights, and upcoming event coverage.</p>
              </div>
            </a>
            <div class="schedule-list">
              <a class="schedule-item" href="https://www.ufc.com/events" target="_blank" rel="noopener noreferrer"><div class="time">Apr 25</div><div><strong>UFC Fight Night</strong><div class="muted">Open the official UFC events page</div></div><div class="muted">Open</div></a>
              <a class="schedule-item" href="https://www.ufc.com/freedom250" target="_blank" rel="noopener noreferrer"><div class="time">Jun 14</div><div><strong>UFC Freedom 250</strong><div class="muted">White House card official page</div></div><div class="muted">Open</div></a>
              <a class="schedule-item" href="https://www.ufc.com/events" target="_blank" rel="noopener noreferrer"><div class="time">Jul 11</div><div><strong>UFC 329</strong><div class="muted">Open the official UFC schedule</div></div><div class="muted">Open</div></a>
            </div>
          </div>
        </article>

        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Big event board</span>
            <a class="sports-card card" href="https://www.espn.com/" target="_blank" rel="noopener noreferrer" style="display:block; margin:12px 0 14px; overflow:hidden;">
              <img src="podcast-guest-1.jpg" alt="Sports news visual" style="object-position:center top;" />
              <div class="card-body">
                <span class="source-pill">Sports media</span>
                <h3>Open a full sports news home</h3>
                <p class="muted">A quick way for visitors to jump into broader sports coverage.</p>
              </div>
            </a>
            <div class="story-list">
              <a class="story-item" href="https://www.nba.com/" target="_blank" rel="noopener noreferrer"><h4>NBA scoreboard cards</h4><p class="muted">Use the official NBA site for the biggest live game cards.</p></a>
              <a class="story-item" href="https://www.ufc.com/" target="_blank" rel="noopener noreferrer"><h4>UFC fight week coverage</h4><p class="muted">Use the UFC site for weigh-ins, cards, and changes.</p></a>
              <a class="story-item" href="https://www.espn.com/" target="_blank" rel="noopener noreferrer"><h4>Big events strip</h4><p class="muted">NFL, MLB, playoffs, UFC, golf, and special events.</p></a>
            </div>
          </div>
        </article>
      </div>
    </section>

    <section id="betting" data-search="betting prediction markets odds kalshi polymarket draftkings fanduel action network">
      <div class="section-title">
        <h2>Prediction markets + sports betting</h2>
        <p>Clickable betting rows plus visuals for prediction markets and sportsbooks.</p>
      </div>

      <div class="split-2">
        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Prediction market watch</span>
            <a class="bet-card card" href="https://kalshi.com/markets" target="_blank" rel="noopener noreferrer" style="display:block; margin:12px 0 14px; overflow:hidden;">
              <img src="news-feature-2.jpg" alt="Prediction market visual" />
              <div class="card-body">
                <span class="source-pill">Prediction markets</span>
                <h3>Open live prediction contracts</h3>
                <p class="muted">Politics, macro, and event-based speculation all in one place.</p>
              </div>
            </a>
            <div class="odds-board">
              <a class="odds-row" href="https://kalshi.com/markets" target="_blank" rel="noopener noreferrer"><strong>U.S. politics headline market</strong><span>Kalshi</span><span>Live ideas</span><span>→</span></a>
              <a class="odds-row" href="https://polymarket.com/markets" target="_blank" rel="noopener noreferrer"><strong>Election / policy sentiment</strong><span>Polymarket</span><span>Watchlist</span><span>→</span></a>
              <a class="odds-row" href="https://kalshi.com/markets" target="_blank" rel="noopener noreferrer"><strong>Macro / rate cut themes</strong><span>Kalshi</span><span>Track</span><span>→</span></a>
            </div>
          </div>
        </article>

        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Sportsbook board</span>
            <a class="bet-card card" href="https://sportsbook.draftkings.com/" target="_blank" rel="noopener noreferrer" style="display:block; margin:12px 0 14px; overflow:hidden;">
              <img src="podcast-main.jpg" alt="Sports betting visual" />
              <div class="card-body">
                <span class="source-pill">Sports betting</span>
                <h3>Open a live sportsbook board</h3>
                <p class="muted">NBA, UFC, and other featured betting markets.</p>
              </div>
            </a>
            <div class="odds-board">
              <a class="odds-row" href="https://sportsbook.draftkings.com/leagues/basketball/nba" target="_blank" rel="noopener noreferrer"><strong>NBA featured slate</strong><span>DraftKings</span><span>Lines</span><span>→</span></a>
              <a class="odds-row" href="https://sportsbook.fanduel.com/sports/navigation/830.1" target="_blank" rel="noopener noreferrer"><strong>UFC main card lines</strong><span>FanDuel</span><span>Odds</span><span>→</span></a>
              <a class="odds-row" href="https://www.actionnetwork.com/" target="_blank" rel="noopener noreferrer"><strong>Parlay trends</strong><span>Action Network</span><span>Popular</span><span>→</span></a>
            </div>
          </div>
        </article>
      </div>
    </section>

    <section id="podcast" data-search="podcast cia podcast youtube clips guests episode latest">
      <div class="section-title">
        <h2>CIA Podcast hub</h2>
        <p>Every card here is clickable now.</p>
      </div>

      <div class="split-3">
        <a class="podcast-card card" href="https://youtu.be/zP0T28wSa-E?si=0he35fJTJNHeDjdS" target="_blank" rel="noopener noreferrer">
          <img src="podcast-main.jpg" alt="CIA Podcast main image" />
          <div class="card-body">
            <span class="source-pill">Latest episode</span>
            <h3>Watch the newest full episode</h3>
            <p class="muted">Direct link to the latest show.</p>
          </div>
        </a>
        <a class="podcast-card card" href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer">
          <img src="podcast-guest-1.jpg" alt="Podcast guest spotlight" style="object-position:center top;" />
          <div class="card-body">
            <span class="source-pill">YouTube channel</span>
            <h3>Open the CIA Podcast channel</h3>
            <p class="muted">The image now shows more of the top where the 327 Media branding appears.</p>
          </div>
        </a>
        <a class="podcast-card card" href="https://x.com/327media1" target="_blank" rel="noopener noreferrer">
          <img src="podcast-clip-1.jpg" alt="Podcast clip image" />
          <div class="card-body">
            <span class="source-pill">X account</span>
            <h3>Follow 327 Media on X</h3>
            <p class="muted">Use this for clips, posts, and updates.</p>
          </div>
        </a>
      </div>
    </section>

    <section id="contact" data-search="contact email x youtube message form login sign up account">
      <div class="section-title">
        <h2>Contact 327 Media</h2>
        <p>Real signup/login plus a real message form wired for Formspree.</p>
      </div>

      <div class="contact-grid">
        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Send a message</span>
            <form class="contact-form" id="contactForm">
              <input class="field" id="contactName" name="name" type="text" placeholder="Your name" required />
              <input class="field" id="contactEmail" name="email" type="email" placeholder="Your email" required />
              <input class="field" id="contactSubject" name="subject" type="text" placeholder="Subject" required />
              <textarea class="field" id="contactMessage" name="message" placeholder="Write your message here" required></textarea>
              <button class="btn btn-gold" id="contactSubmit" type="submit">Send message</button>
              <p class="muted status-text" id="contactStatus"></p>
            </form>
          </div>
        </article>

        <article class="card">
          <div class="card-body">
            <span class="eyebrow">Reach out</span>
            <div class="stack" style="margin-top:12px;">
              <a class="social-link" href="mailto:327mediax@gmail.com"><span>Email</span><strong>327mediax@gmail.com</strong></a>
              <a class="social-link" href="https://x.com/327media1" target="_blank" rel="noopener noreferrer"><span>X</span><strong>@327media1</strong></a>
              <a class="social-link" href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer"><span>YouTube</span><strong>@CIApodcastTV</strong></a>
            </div>
            <div class="tag-row">
              <span class="tag">Real Formspree form</span>
              <span class="tag">Real Supabase auth</span>
              <span class="tag">GitHub Pages friendly</span>
            </div>
          </div>
        </article>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container footer-grid">
      <div>
        <h3 style="margin-top:0; color:#fff;">327 Media</h3>
        <p>Your source for breaking news, stock market coverage, sports, betting talk, and the CIA Podcast.</p>
      </div>
      <div>
        <h4 style="margin-top:0; color:#fff;">Quick links</h4>
        <p><a href="#news">News</a><br><a href="#stocks">Stocks</a><br><a href="#sports">Sports</a><br><a href="#betting">Betting</a></p>
      </div>
      <div>
        <h4 style="margin-top:0; color:#fff;">Social</h4>
        <p><a href="mailto:327mediax@gmail.com">327mediax@gmail.com</a><br><a href="https://x.com/327media1" target="_blank" rel="noopener noreferrer">@327media1</a><br><a href="https://www.youtube.com/@CIApodcastTV" target="_blank" rel="noopener noreferrer">@CIApodcastTV</a></p>
      </div>
    </div>
  </footer>

  <div id="authModal" class="hidden" style="position:fixed; inset:0; background:rgba(0,0,0,0.65); z-index:1001; padding:18px;">
    <div style="max-width:520px; margin:7vh auto 0; background:#0d1320; border:1px solid rgba(255,255,255,0.1); border-radius:24px; box-shadow:var(--shadow); overflow:hidden;">
      <div style="display:flex; justify-content:space-between; align-items:center; padding:18px 20px; border-bottom:1px solid rgba(255,255,255,0.08);">
        <strong id="authTitle">Account</strong>
        <button class="btn btn-outline" onclick="closeAuth()">Close</button>
      </div>
      <div style="padding:20px; display:grid; gap:12px;">
        <input class="field" id="authEmail" type="email" placeholder="Email address" />
        <input class="field" id="authPassword" type="password" placeholder="Password" />
        <input class="field" id="nameField" type="text" placeholder="Full name" />
        <button class="btn btn-gold" id="authSubmit" type="button">Continue</button>
        <p class="muted auth-note" id="authStatus">Create an account or log into 327 Media.</p>
      </div>
    </div>
  </div>

  <script>
    const SUPABASE_URL = 'https://bwftfznxojkkcbptydai.supabase.co';
    const SUPABASE_ANON_KEY = 'sb_publishable_gwWxv-5WerfeI_4GR1moQw_OM3Xchm9';
    const FORMSPREE_ENDPOINT = 'https://formspree.io/f/mgorodro';

    const supabaseClient = (window.supabase && SUPABASE_URL && SUPABASE_ANON_KEY)
      ? window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
      : null;

    let authMode = 'login';

    const marketGroups = {
      'Big Tech': [
        { symbol: 'NASDAQ:AAPL', label: 'Apple', code: 'AAPL', note: 'iPhone + ecosystem giant' },
        { symbol: 'NASDAQ:MSFT', label: 'Microsoft', code: 'MSFT', note: 'Cloud + enterprise' },
        { symbol: 'NASDAQ:NVDA', label: 'NVIDIA', code: 'NVDA', note: 'AI chip leader' },
        { symbol: 'NASDAQ:AMZN', label: 'Amazon', code: 'AMZN', note: 'Retail + AWS' }
      ],
      'Oil & Energy': [
        { symbol: 'NYSE:XOM', label: 'ExxonMobil', code: 'XOM', note: 'Integrated oil major' },
        { symbol: 'NYSE:CVX', label: 'Chevron', code: 'CVX', note: 'Energy supermajor' },
        { symbol: 'NYSE:COP', label: 'ConocoPhillips', code: 'COP', note: 'Exploration leader' },
        { symbol: 'AMEX:XLE', label: 'Energy Select', code: 'XLE', note: 'Energy ETF' }
      ],
      'ETFs': [
        { symbol: 'AMEX:SPY', label: 'SPY', code: 'SPY', note: 'S&P 500' },
        { symbol: 'NASDAQ:QQQ', label: 'QQQ', code: 'QQQ', note: 'Nasdaq 100' },
        { symbol: 'AMEX:VTI', label: 'VTI', code: 'VTI', note: 'Total market' },
        { symbol: 'AMEX:IWM', label: 'IWM', code: 'IWM', note: 'Russell 2000' }
      ],
      'Crypto': [
        { symbol: 'BINANCE:BTCUSDT', label: 'Bitcoin', code: 'BTC', note: 'Digital gold' },
        { symbol: 'BINANCE:ETHUSDT', label: 'Ethereum', code: 'ETH', note: 'Smart contracts' },
        { symbol: 'BINANCE:SOLUSDT', label: 'Solana', code: 'SOL', note: 'Fast layer 1' },
        { symbol: 'AMEX:IBIT', label: 'iShares Bitcoin ETF', code: 'IBIT', note: 'Spot bitcoin ETF' }
      ],
      'Big Companies': [
        { symbol: 'NYSE:JPM', label: 'JPMorgan', code: 'JPM', note: 'Banking leader' },
        { symbol: 'NYSE:DIS', label: 'Disney', code: 'DIS', note: 'Media + parks' },
        { symbol: 'NYSE:BA', label: 'Boeing', code: 'BA', note: 'Aerospace' },
        { symbol: 'NYSE:WMT', label: 'Walmart', code: 'WMT', note: 'Retail giant' }
      ]
    };

    function byId(id) {
      return document.getElementById(id);
    }

    function setActiveNav() {
      document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', () => {
          document.querySelectorAll('.nav-links a').forEach(a => a.classList.remove('active'));
          link.classList.add('active');
        });
      });
    }

    function renderMarketCategories() {
      const catWrap = byId('marketCats');
      const grid = byId('categorySymbolGrid');
      if (!catWrap || !grid) return;

      const keys = Object.keys(marketGroups);
      catWrap.innerHTML = keys.map((name, i) => `
        <button class="market-cat ${i === 0 ? 'active' : ''}" data-cat="${name}">${name}</button>
      `).join('');

      function drawCategory(category) {
        const list = marketGroups[category] || [];
        grid.innerHTML = list.map(item => `
          <div class="ticker-chip" data-symbol="${item.symbol}" style="cursor:pointer;">
            <strong>${item.code}</strong>
            <div>${item.label}</div>
            <div class="muted" style="margin-top:6px;">${item.note}</div>
          </div>
        `).join('');

        grid.querySelectorAll('[data-symbol]').forEach(card => {
          card.addEventListener('click', () => loadChart(card.dataset.symbol));
        });

        if (list[0]) loadChart(list[0].symbol);
      }

      catWrap.querySelectorAll('.market-cat').forEach(btn => {
        btn.addEventListener('click', () => {
          catWrap.querySelectorAll('.market-cat').forEach(b => b.classList.remove('active'));
          btn.classList.add('active');
          drawCategory(btn.dataset.cat);
        });
      });

      drawCategory(keys[0]);
    }

    function loadChart(symbol) {
      const target = byId('tradingview_market_chart');
      if (!target || !symbol) return;
      target.innerHTML = '';
      const script = document.createElement('script');
      script.src = 'https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js';
      script.async = true;
      script.innerHTML = JSON.stringify({
        autosize: true,
        symbol,
        interval: 'D',
        timezone: 'America/Los_Angeles',
        theme: 'dark',
        style: '1',
        locale: 'en',
        withdateranges: true,
        hide_side_toolbar: false,
        allow_symbol_change: true,
        details: true,
        hotlist: true,
        calendar: true,
        studies: ['Volume@tv-basicstudies']
      });
      target.appendChild(script);
    }

    function bindSearch() {
      const input = byId('siteSearch');
      if (!input) return;
      input.addEventListener('input', () => {
        const q = input.value.trim().toLowerCase();
        document.querySelectorAll('main section').forEach(section => {
          const text = (section.dataset.search || '').toLowerCase();
          section.classList.toggle('hidden', !!q && !text.includes(q));
        });
      });
    }

    function openAuth(type) {
      const modal = byId('authModal');
      const title = byId('authTitle');
      const submit = byId('authSubmit');
      const nameField = byId('nameField');
      const status = byId('authStatus');
      if (!modal || !title || !submit || !nameField || !status) return;
      authMode = type;
      modal.classList.remove('hidden');
      status.textContent = '';
      byId('authEmail').value = '';
      byId('authPassword').value = '';
      nameField.value = '';
      if (type === 'login') {
        title.textContent = 'Log In';
        submit.textContent = 'Log In';
        nameField.style.display = 'none';
      } else {
        title.textContent = 'Sign Up';
        submit.textContent = 'Create Account';
        nameField.style.display = 'block';
      }
    }

    function closeAuth() {
      const modal = byId('authModal');
      if (modal) modal.classList.add('hidden');
    }

    async function handleAuth() {
      const email = (byId('authEmail')?.value || '').trim();
      const password = byId('authPassword')?.value || '';
      const fullName = (byId('nameField')?.value || '').trim();
      const status = byId('authStatus');
      if (!status) return;

      if (!supabaseClient) {
        status.textContent = 'Supabase is not loading. Recheck your keys.';
        return;
      }
      if (!email || !password) {
        status.textContent = 'Enter your email and password.';
        return;
      }

      status.textContent = authMode === 'signup' ? 'Creating account...' : 'Logging in...';

      try {
        if (authMode === 'signup') {
          const { error } = await supabaseClient.auth.signUp({
            email,
            password,
            options: { data: { full_name: fullName } }
          });
          if (error) throw error;
          status.textContent = 'Account created. You can now log in.';
        } else {
          const { error } = await supabaseClient.auth.signInWithPassword({ email, password });
          if (error) throw error;
          status.textContent = 'Logged in successfully.';
          setTimeout(() => {
            closeAuth();
            updateAuthUI();
          }, 900);
        }
      } catch (err) {
        status.textContent = err.message || 'Authentication failed.';
      }
    }

    async function handleLogout() {
      if (!supabaseClient) return;
      await supabaseClient.auth.signOut();
      updateAuthUI();
    }

    async function updateAuthUI() {
      const navActions = byId('navActions');
      if (!navActions) return;
      if (!supabaseClient) return;
      const { data } = await supabaseClient.auth.getSession();
      if (data?.session) {
        const email = data.session.user?.email || 'Account';
        navActions.innerHTML = `
          <span class="tag">${email}</span>
          <button class="btn btn-outline" onclick="handleLogout()">Log Out</button>
        `;
      } else {
        navActions.innerHTML = `
          <button class="btn btn-outline" onclick="openAuth('login')">Log In</button>
          <button class="btn btn-gold" onclick="openAuth('signup')">Sign Up</button>
        `;
      }
    }

    async function sendMail(event) {
      event.preventDefault();
      const form = byId('contactForm');
      const status = byId('contactStatus');
      const button = byId('contactSubmit');
      if (!form || !status || !button) return;

      button.disabled = true;
      status.textContent = 'Sending...';

      try {
        const response = await fetch(FORMSPREE_ENDPOINT, {
          method: 'POST',
          body: new FormData(form),
          headers: { 'Accept': 'application/json' }
        });
        if (!response.ok) throw new Error('Message failed to send.');
        form.reset();
        status.textContent = 'Message sent successfully.';
      } catch (err) {
        status.textContent = err.message || 'Message failed to send.';
      } finally {
        button.disabled = false;
      }
    }

    function init() {
      renderMarketCategories();
      bindSearch();
      setActiveNav();
      const authSubmit = byId('authSubmit');
      if (authSubmit) authSubmit.addEventListener('click', handleAuth);
      const contactForm = byId('contactForm');
      if (contactForm) contactForm.addEventListener('submit', sendMail);
      updateAuthUI();

      if (supabaseClient) {
        supabaseClient.auth.onAuthStateChange(() => updateAuthUI());
      }

      console.assert(!!byId('marketCats'), 'Missing marketCats');
      console.assert(!!byId('categorySymbolGrid'), 'Missing categorySymbolGrid');
      console.assert(!!byId('tradingview_market_chart'), 'Missing tradingview_market_chart');
      console.assert(!!byId('contactForm'), 'Missing contactForm');
    }

    window.openAuth = openAuth;
    window.closeAuth = closeAuth;
    window.handleLogout = handleLogout;

    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', init);
    } else {
      init();
    }
  </script>
</body>
</html>
