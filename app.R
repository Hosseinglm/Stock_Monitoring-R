library(shinydashboard)
library("tibble")
library(DT)
library('quantmod')
library('ggplot2')
library('forecast')
library('tseries')

companies <- read.csv(file = 'sp500_companies.csv')

skin <- Sys.getenv("DASHBOARD_SKIN")
skin <- tolower(skin)
if (skin == "")
  skin <- "purple"


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "introduction", icon = icon("credit-card")),
    menuItem("Directory", tabName = "directory", icon = icon("table")),
    menuItem("Dashboard", tabName = "charts", icon = icon("bar-chart-o")),
    menuItem("Trading Indicator", tabName = "tradingindicator", icon = icon("list-alt")),
    menuItem("Prediction", tabName = "prediction", icon = icon("dashboard")),
    menuItem("Go to Trading View Website", icon = icon("file-code-o"),
             href = "https://www.tradingview.com/chart/" 
    ),
    menuItem("Go to Yahoo Finance", icon = icon("file-code-o"),
             href = "https://finance.yahoo.com/most-active"
    )
  )
)


body <- dashboardBody(
  tabItems(
    # First tab content (introduction)
    tabItem(tabName = "introduction",
            h2(align = "center", strong("Stock Prediction for Investors")),
            h4("This is a stock price and prediction modelling app that will assist investors on buying or selling the stocks. The stocks are based on all companies listed on S&P 500 and the price are up to date linking from Yahoo Finance server."),
            h4("The app will display the following:"),
            
            tags$ul(
              tags$li(h4(strong("Historical stock price trend up to the latest."))), 
              tags$li(h4(strong("Showcase stock price forecast (up to 10days)."))), 
              tags$li(h4(strong("Suggest the investors if the stock is a strong buy.")))
            ),
            
            
            h4("The main purpose of this application is providing price guidance for investors on the price risks and market risks of the S&P 500 stocks."),
            
            br(),
            
            h3(strong("Directory")),
            h4("In this section, users are able to see the full basic information of S&P 500 component stocks."),
            
            
            br(),
            
            h3(strong("Dashboard")),
            h4("In this section, users are able to select the S&P500 stock code of the company of their choice. The information displays are up to date as per the previous closing stock market information. The information being displayed are Close Price, Open Price, High Price, Low Price, Trading Volume and also Adjusted Close Price. The period shown in the graph are from start date of 2022-01-01 up to the current."),
            
            br(),
            
            h3(strong("Trading Indicator")),
            h4("In this section, users are able to have quick access to 4 main companies which are Apple, Microsoft, Google and also Amazon. It will provide buying and selling indicator for the users. There is other link provided for users to select other companies."),
            h4("The 4 companies are displayed because they are the 4 main constituents of S&P500 based on the index weightage:- "),
            
            tags$ul(
              tags$li(h4(strong("Apple: 6.86%"))), 
              tags$li(h4(strong("Microsoft: 5.97%"))), 
              tags$li(h4(strong("Amazon: 3.78%"))),
              tags$li(h4(strong("Google: 2.2%")))
            ),
            
            br(),
            
            h3(strong("Prediction")),
            h4("In this section, users are able to select the stock code of S&P 500 of their choice to visualize the stock price forecasting. The stock code are being listed for users to select. Users are able to select either non-seasonal or seasonal forecasting. "),
            h4("The forecasting price is up to +10days from the current day selection. It will produce the hi and low price. The prediction price will be a guidance price for investors to buy or sell."),
            
            br(),
            
            h3(strong("TradingView Website")),
            h4("In this section, users are re-direct to TradingView website. In the website, users are able to see the stock screener for their choices of stock. Based on the spread of support and resistance analysis, this website will suggest users whether the stock is a buy or sell. "),
            
            br(),
            
            h3(strong("Yahoo Finance")),
            h4("In this section, users are re-direct to Yahoo Finance webpage. Users are able to see the up to date information of the company of their choices. Information such as dividend, profit, income statement, Balance sheet and etc.")
    ),
    
    tabItem(tabName = "directory",
            fluidRow(
              box(
                br(),
                datatable(companies, width = 1637),     # https://rstudio.github.io/DT/
                width = 12, title = "SP500 Companies Information", solidHeader = TRUE,
                status = "primary", style='overflow-x: scroll;',
              )
              
            )
    ),
    
    # Second tab content (Dashboard)
    tabItem(tabName = "charts",
            
            br(),
            
            fluidRow(
              
              box(
                title = "Select Stock Code", width = 12, solidHeader = TRUE, status = "primary",
                selectInput("state", "Choose a Stock Code:",
                            list(`Stock Code` = list('AAPL',
                                                     'MMM',
                                                     'AOS',
                                                     'ABT',
                                                     'ABBV',
                                                     'ABMD',
                                                     'ACN',
                                                     'ATVI',
                                                     'ADM',
                                                     'ADBE',
                                                     'ADP',
                                                     'AAP',
                                                     'AES',
                                                     'AFL',
                                                     'A',
                                                     'AIG',
                                                     'APD',
                                                     'AKAM',
                                                     'ALK',
                                                     'ALB',
                                                     'ARE',
                                                     'ALGN',
                                                     'ALLE',
                                                     'LNT',
                                                     'ALL',
                                                     'GOOGL',
                                                     'GOOG',
                                                     'MO',
                                                     'AMZN',
                                                     'AMCR',
                                                     'AMD',
                                                     'AEE',
                                                     'AAL',
                                                     'AEP',
                                                     'AXP',
                                                     'AMT',
                                                     'AWK',
                                                     'AMP',
                                                     'ABC',
                                                     'AME',
                                                     'AMGN',
                                                     'APH',
                                                     'ADI',
                                                     'ANSS',
                                                     'ANTM',
                                                     'AON',
                                                     'APA',
                                                     'AMAT',
                                                     'APTV',
                                                     'ANET',
                                                     'AIZ',
                                                     'T',
                                                     'ATO',
                                                     'ADSK',
                                                     'AZO',
                                                     'AVB',
                                                     'AVY',
                                                     'BKR',
                                                     'BALL',
                                                     'BAC',
                                                     'BBWI',
                                                     'BAX',
                                                     'BDX',
                                                     'WRB',
                                                     'BRK.B',
                                                     'BBY',
                                                     'BIO',
                                                     'TECH',
                                                     'BIIB',
                                                     'BLK',
                                                     'BK',
                                                     'BA',
                                                     'BKNG',
                                                     'BWA',
                                                     'BXP',
                                                     'BSX',
                                                     'BMY',
                                                     'AVGO',
                                                     'BR',
                                                     'BRO',
                                                     'BF.B',
                                                     'CHRW',
                                                     'CDNS',
                                                     'CZR',
                                                     'CPT',
                                                     'CPB',
                                                     'COF',
                                                     'CAH',
                                                     'KMX',
                                                     'CCL',
                                                     'CARR',
                                                     'CTLT',
                                                     'CAT',
                                                     'CBOE',
                                                     'CBRE',
                                                     'CDW',
                                                     'CE',
                                                     'CNC',
                                                     'CNP',
                                                     'CDAY',
                                                     'CERN',
                                                     'CF',
                                                     'CRL',
                                                     'SCHW',
                                                     'CHTR',
                                                     'CVX',
                                                     'CMG',
                                                     'CB',
                                                     'CHD',
                                                     'CI',
                                                     'CINF',
                                                     'CTAS',
                                                     'CSCO',
                                                     'C',
                                                     'CFG',
                                                     'CTXS',
                                                     'CLX',
                                                     'CME',
                                                     'CMS',
                                                     'KO',
                                                     'CTSH',
                                                     'CL',
                                                     'CMCSA',
                                                     'CMA',
                                                     'CAG',
                                                     'COP',
                                                     'ED',
                                                     'STZ',
                                                     'CEG',
                                                     'COO',
                                                     'CPRT',
                                                     'GLW',
                                                     'CTVA',
                                                     'COST',
                                                     'CTRA',
                                                     'CCI',
                                                     'CSX',
                                                     'CMI',
                                                     'CVS',
                                                     'DHI',
                                                     'DHR',
                                                     'DRI',
                                                     'DVA',
                                                     'DE',
                                                     'DAL',
                                                     'XRAY',
                                                     'DVN',
                                                     'DXCM',
                                                     'FANG',
                                                     'DLR',
                                                     'DFS',
                                                     'DISH',
                                                     'DIS',
                                                     'DG',
                                                     'DLTR',
                                                     'D',
                                                     'DPZ',
                                                     'DOV',
                                                     'DOW',
                                                     'DTE',
                                                     'DUK',
                                                     'DRE',
                                                     'DD',
                                                     'DXC',
                                                     'EMN',
                                                     'ETN',
                                                     'EBAY',
                                                     'ECL',
                                                     'EIX',
                                                     'EW',
                                                     'EA',
                                                     'EMR',
                                                     'ENPH',
                                                     'ETR',
                                                     'EOG',
                                                     'EPAM',
                                                     'EFX',
                                                     'EQIX',
                                                     'EQR',
                                                     'ESS',
                                                     'EL',
                                                     'ETSY',
                                                     'RE',
                                                     'EVRG',
                                                     'ES',
                                                     'EXC',
                                                     'EXPE',
                                                     'EXPD',
                                                     'EXR',
                                                     'XOM',
                                                     'FFIV',
                                                     'FDS',
                                                     'FAST',
                                                     'FRT',
                                                     'FDX',
                                                     'FITB',
                                                     'FRC',
                                                     'FE',
                                                     'FIS',
                                                     'FISV',
                                                     'FLT',
                                                     'FMC',
                                                     'F',
                                                     'FTNT',
                                                     'FTV',
                                                     'FBHS',
                                                     'FOXA',
                                                     'FOX',
                                                     'BEN',
                                                     'FCX',
                                                     'AJG',
                                                     'GRMN',
                                                     'IT',
                                                     'GE',
                                                     'GNRC',
                                                     'GD',
                                                     'GIS',
                                                     'GPC',
                                                     'GILD',
                                                     'GL',
                                                     'GPN',
                                                     'GM',
                                                     'GS',
                                                     'GWW',
                                                     'HAL',
                                                     'HIG',
                                                     'HAS',
                                                     'HCA',
                                                     'PEAK',
                                                     'HSIC',
                                                     'HSY',
                                                     'HES',
                                                     'HPE',
                                                     'HLT',
                                                     'HOLX',
                                                     'HD',
                                                     'HON',
                                                     'HRL',
                                                     'HST',
                                                     'HWM',
                                                     'HPQ',
                                                     'HUM',
                                                     'HII',
                                                     'HBAN',
                                                     'IEX',
                                                     'IDXX',
                                                     'ITW',
                                                     'ILMN',
                                                     'INCY',
                                                     'IR',
                                                     'INTC',
                                                     'ICE',
                                                     'IBM',
                                                     'IP',
                                                     'IPG',
                                                     'IFF',
                                                     'INTU',
                                                     'ISRG',
                                                     'IVZ',
                                                     'IPGP',
                                                     'IQV',
                                                     'IRM',
                                                     'JBHT',
                                                     'JKHY',
                                                     'J',
                                                     'JNJ',
                                                     'JCI',
                                                     'JPM',
                                                     'JNPR',
                                                     'K',
                                                     'KEY',
                                                     'KEYS',
                                                     'KMB',
                                                     'KIM',
                                                     'KMI',
                                                     'KLAC',
                                                     'KHC',
                                                     'KR',
                                                     'LHX',
                                                     'LH',
                                                     'LRCX',
                                                     'LW',
                                                     'LVS',
                                                     'LDOS',
                                                     'LEN',
                                                     'LLY',
                                                     'LNC',
                                                     'LIN',
                                                     'LYV',
                                                     'LKQ',
                                                     'LMT',
                                                     'L',
                                                     'LOW',
                                                     'LUMN',
                                                     'LYB',
                                                     'MTB',
                                                     'MRO',
                                                     'MPC',
                                                     'MKTX',
                                                     'MAR',
                                                     'MMC',
                                                     'MLM',
                                                     'MAS',
                                                     'MA',
                                                     'MTCH',
                                                     'MKC',
                                                     'MCD',
                                                     'MCK',
                                                     'MDT',
                                                     'MRK',
                                                     'FB',
                                                     'MET',
                                                     'MTD',
                                                     'MGM',
                                                     'MCHP',
                                                     'MU',
                                                     'MSFT',
                                                     'MAA',
                                                     'MRNA',
                                                     'MHK',
                                                     'MOH',
                                                     'TAP',
                                                     'MDLZ',
                                                     'MPWR',
                                                     'MNST',
                                                     'MCO',
                                                     'MS',
                                                     'MOS',
                                                     'MSI',
                                                     'MSCI',
                                                     'NDAQ',
                                                     'NTAP',
                                                     'NFLX',
                                                     'NWL',
                                                     'NEM',
                                                     'NWSA',
                                                     'NWS',
                                                     'NEE',
                                                     'NLSN',
                                                     'NKE',
                                                     'NI',
                                                     'NDSN',
                                                     'NSC',
                                                     'NTRS',
                                                     'NOC',
                                                     'NLOK',
                                                     'NCLH',
                                                     'NRG',
                                                     'NUE',
                                                     'NVDA',
                                                     'NVR',
                                                     'NXPI',
                                                     'ORLY',
                                                     'OXY',
                                                     'ODFL',
                                                     'OMC',
                                                     'OKE',
                                                     'ORCL',
                                                     'OGN',
                                                     'OTIS',
                                                     'PCAR',
                                                     'PKG',
                                                     'PARA',
                                                     'PH',
                                                     'PAYX',
                                                     'PAYC',
                                                     'PYPL',
                                                     'PENN',
                                                     'PNR',
                                                     'PEP',
                                                     'PKI',
                                                     'PFE',
                                                     'PM',
                                                     'PSX',
                                                     'PNW',
                                                     'PXD',
                                                     'PNC',
                                                     'POOL',
                                                     'PPG',
                                                     'PPL',
                                                     'PFG',
                                                     'PG',
                                                     'PGR',
                                                     'PLD',
                                                     'PRU',
                                                     'PEG',
                                                     'PTC',
                                                     'PSA',
                                                     'PHM',
                                                     'PVH',
                                                     'QRVO',
                                                     'PWR',
                                                     'QCOM',
                                                     'DGX',
                                                     'RL',
                                                     'RJF',
                                                     'RTX',
                                                     'O',
                                                     'REG',
                                                     'REGN',
                                                     'RF',
                                                     'RSG',
                                                     'RMD',
                                                     'RHI',
                                                     'ROK',
                                                     'ROL',
                                                     'ROP',
                                                     'ROST',
                                                     'RCL',
                                                     'SPGI',
                                                     'CRM',
                                                     'SBAC',
                                                     'SLB',
                                                     'STX',
                                                     'SEE',
                                                     'SRE',
                                                     'NOW',
                                                     'SHW',
                                                     'SBNY',
                                                     'SPG',
                                                     'SWKS',
                                                     'SJM',
                                                     'SNA',
                                                     'SEDG',
                                                     'SO',
                                                     'LUV',
                                                     'SWK',
                                                     'SBUX',
                                                     'STT',
                                                     'STE',
                                                     'SYK',
                                                     'SIVB',
                                                     'SYF',
                                                     'SNPS',
                                                     'SYY',
                                                     'TMUS',
                                                     'TROW',
                                                     'TTWO',
                                                     'TPR',
                                                     'TGT',
                                                     'TEL',
                                                     'TDY',
                                                     'TFX',
                                                     'TER',
                                                     'TSLA',
                                                     'TXN',
                                                     'TXT',
                                                     'TMO',
                                                     'TJX',
                                                     'TSCO',
                                                     'TT',
                                                     'TDG',
                                                     'TRV',
                                                     'TRMB',
                                                     'TFC',
                                                     'TWTR',
                                                     'TYL',
                                                     'TSN',
                                                     'USB',
                                                     'UDR',
                                                     'ULTA',
                                                     'UAA',
                                                     'UA',
                                                     'UNP',
                                                     'UAL',
                                                     'UNH',
                                                     'UPS',
                                                     'URI',
                                                     'UHS',
                                                     'VLO',
                                                     'VTR',
                                                     'VRSN',
                                                     'VRSK',
                                                     'VZ',
                                                     'VRTX',
                                                     'VFC',
                                                     'VTRS',
                                                     'V',
                                                     'VNO',
                                                     'VMC',
                                                     'WAB',
                                                     'WMT',
                                                     'WBA',
                                                     'WBD',
                                                     'WM',
                                                     'WAT',
                                                     'WEC',
                                                     'WFC',
                                                     'WELL',
                                                     'WST',
                                                     'WDC',
                                                     'WRK',
                                                     'WY',
                                                     'WHR',
                                                     'WMB',
                                                     'WTW',
                                                     'WYNN',
                                                     'XEL',
                                                     'XYL',
                                                     'YUM',
                                                     'ZBRA',
                                                     'ZBH',
                                                     'ZION',
                                                     'ZTS'))
                )
              )
            ),
            
            
            br(),
            
            fluidRow(
              valueBoxOutput("closePrice"),
              valueBoxOutput("highPrice"),
              valueBoxOutput("lowPrice"),
              valueBoxOutput("openPrice"),
              valueBoxOutput("volumePrice"),
              valueBoxOutput("adjustedPrice")
            ),
            
            fluidRow(
              box(
                plotOutput("plotClose", height = 670),
                height = 700,
                width = 12
              )
            ),
            
            
            br()
            
            
    ),
    
    # Third tab content (tradingindicator)
    tabItem(tabName = "tradingindicator",
          
          includeHTML("index.html")
          
    ),
    
    # Forth tab content (prediction)
    tabItem(tabName = "prediction",
            fluidRow(
              box(
                title = "Enter Stock Code and Predict", width = 3, solidHeader = TRUE, status = "warning",
                textInput("StockCode", "StockCode", value = "AAPL"),
                radioButtons("seasonal", "Select", c(NonSeasonal = "NonSeasonal", Seasonal = "Seasonal")), br(),
                actionButton(inputId = "click", label = "Predict Stock"),
                height = 305
              ),
              
              box(
                title = "Available Stock Codes", width = 9, solidHeader = TRUE, status = "warning", 
                height = 305,
                'AAPL',
                'MMM',
                'AOS',
                'ABT',
                'ABBV',
                'ABMD',
                'ACN',
                'ATVI',
                'ADM',
                'ADBE',
                'ADP',
                'AAP',
                'AES',
                'AFL',
                'A',
                'AIG',
                'APD',
                'AKAM',
                'ALK',
                'ALB',
                'ARE',
                'ALGN',
                'ALLE',
                'LNT',
                'ALL',
                'GOOGL',
                'GOOG',
                'MO',
                'AMZN',
                'AMCR',
                'AMD',
                'AEE',
                'AAL',
                'AEP',
                'AXP',
                'AMT',
                'AWK',
                'AMP',
                'ABC',
                'AME',
                'AMGN',
                'APH',
                'ADI',
                'ANSS',
                'ANTM',
                'AON',
                'APA',
                'AMAT',
                'APTV',
                'ANET',
                'AIZ',
                'T',
                'ATO',
                'ADSK',
                'AZO',
                'AVB',
                'AVY',
                'BKR',
                'BALL',
                'BAC',
                'BBWI',
                'BAX',
                'BDX',
                'WRB',
                'BRK.B',
                'BBY',
                'BIO',
                'TECH',
                'BIIB',
                'BLK',
                'BK',
                'BA',
                'BKNG',
                'BWA',
                'BXP',
                'BSX',
                'BMY',
                'AVGO',
                'BR',
                'BRO',
                'BF.B',
                'CHRW',
                'CDNS',
                'CZR',
                'CPT',
                'CPB',
                'COF',
                'CAH',
                'KMX',
                'CCL',
                'CARR',
                'CTLT',
                'CAT',
                'CBOE',
                'CBRE',
                'CDW',
                'CE',
                'CNC',
                'CNP',
                'CDAY',
                'CERN',
                'CF',
                'CRL',
                'SCHW',
                'CHTR',
                'CVX',
                'CMG',
                'CB',
                'CHD',
                'CI',
                'CINF',
                'CTAS',
                'CSCO',
                'C',
                'CFG',
                'CTXS',
                'CLX',
                'CME',
                'CMS',
                'KO',
                'CTSH',
                'CL',
                'CMCSA',
                'CMA',
                'CAG',
                'COP',
                'ED',
                'STZ',
                'CEG',
                'COO',
                'CPRT',
                'GLW',
                'CTVA',
                'COST',
                'CTRA',
                'CCI',
                'CSX',
                'CMI',
                'CVS',
                'DHI',
                'DHR',
                'DRI',
                'DVA',
                'DE',
                'DAL',
                'XRAY',
                'DVN',
                'DXCM',
                'FANG',
                'DLR',
                'DFS',
                'DISH',
                'DIS',
                'DG',
                'DLTR',
                'D',
                'DPZ',
                'DOV',
                'DOW',
                'DTE',
                'DUK',
                'DRE',
                'DD',
                'DXC',
                'EMN',
                'ETN',
                'EBAY',
                'ECL',
                'EIX',
                'EW',
                'EA',
                'EMR',
                'ENPH',
                'ETR',
                'EOG',
                'EPAM',
                'EFX',
                'EQIX',
                'EQR',
                'ESS',
                'EL',
                'ETSY',
                'RE',
                'EVRG',
                'ES',
                'EXC',
                'EXPE',
                'EXPD',
                'EXR',
                'XOM',
                'FFIV',
                'FDS',
                'FAST',
                'FRT',
                'FDX',
                'FITB',
                'FRC',
                'FE',
                'FIS',
                'FISV',
                'FLT',
                'FMC',
                'F',
                'FTNT',
                'FTV',
                'FBHS',
                'FOXA',
                'FOX',
                'BEN',
                'FCX',
                'AJG',
                'GRMN',
                'IT',
                'GE',
                'GNRC',
                'GD',
                'GIS',
                'GPC',
                'GILD',
                'GL',
                'GPN',
                'GM',
                'GS',
                'GWW',
                'HAL',
                'HIG',
                'HAS',
                'HCA',
                'PEAK',
                'HSIC',
                'HSY',
                'HES',
                'HPE',
                'HLT',
                'HOLX',
                'HD',
                'HON',
                'HRL',
                'HST',
                'HWM',
                'HPQ',
                'HUM',
                'HII',
                'HBAN',
                'IEX',
                'IDXX',
                'ITW',
                'ILMN',
                'INCY',
                'IR',
                'INTC',
                'ICE',
                'IBM',
                'IP',
                'IPG',
                'IFF',
                'INTU',
                'ISRG',
                'IVZ',
                'IPGP',
                'IQV',
                'IRM',
                'JBHT',
                'JKHY',
                'J',
                'JNJ',
                'JCI',
                'JPM',
                'JNPR',
                'K',
                'KEY',
                'KEYS',
                'KMB',
                'KIM',
                'KMI',
                'KLAC',
                'KHC',
                'KR',
                'LHX',
                'LH',
                'LRCX',
                'LW',
                'LVS',
                'LDOS',
                'LEN',
                'LLY',
                'LNC',
                'LIN',
                'LYV',
                'LKQ',
                'LMT',
                'L',
                'LOW',
                'LUMN',
                'LYB',
                'MTB',
                'MRO',
                'MPC',
                'MKTX',
                'MAR',
                'MMC',
                'MLM',
                'MAS',
                'MA',
                'MTCH',
                'MKC',
                'MCD',
                'MCK',
                'MDT',
                'MRK',
                'FB',
                'MET',
                'MTD',
                'MGM',
                'MCHP',
                'MU',
                'MSFT',
                'MAA',
                'MRNA',
                'MHK',
                'MOH',
                'TAP',
                'MDLZ',
                'MPWR',
                'MNST',
                'MCO',
                'MS',
                'MOS',
                'MSI',
                'MSCI',
                'NDAQ',
                'NTAP',
                'NFLX',
                'NWL',
                'NEM',
                'NWSA',
                'NWS',
                'NEE',
                'NLSN',
                'NKE',
                'NI',
                'NDSN',
                'NSC',
                'NTRS',
                'NOC',
                'NLOK',
                'NCLH',
                'NRG',
                'NUE',
                'NVDA',
                'NVR',
                'NXPI',
                'ORLY',
                'OXY',
                'ODFL',
                'OMC',
                'OKE',
                'ORCL',
                'OGN',
                'OTIS',
                'PCAR',
                'PKG',
                'PARA',
                'PH',
                'PAYX',
                'PAYC',
                'PYPL',
                'PENN',
                'PNR',
                'PEP',
                'PKI',
                'PFE',
                'PM',
                'PSX',
                'PNW',
                'PXD',
                'PNC',
                'POOL',
                'PPG',
                'PPL',
                'PFG',
                'PG',
                'PGR',
                'PLD',
                'PRU',
                'PEG',
                'PTC',
                'PSA',
                'PHM',
                'PVH',
                'QRVO',
                'PWR',
                'QCOM',
                'DGX',
                'RL',
                'RJF',
                'RTX',
                'O',
                'REG',
                'REGN',
                'RF',
                'RSG',
                'RMD',
                'RHI',
                'ROK',
                'ROL',
                'ROP',
                'ROST',
                'RCL',
                'SPGI',
                'CRM',
                'SBAC',
                'SLB',
                'STX',
                'SEE',
                'SRE',
                'NOW',
                'SHW',
                'SBNY',
                'SPG',
                'SWKS',
                'SJM',
                'SNA',
                'SEDG',
                'SO',
                'LUV',
                'SWK',
                'SBUX',
                'STT',
                'STE',
                'SYK',
                'SIVB',
                'SYF',
                'SNPS',
                'SYY',
                'TMUS',
                'TROW',
                'TTWO',
                'TPR',
                'TGT',
                'TEL',
                'TDY',
                'TFX',
                'TER',
                'TSLA',
                'TXN',
                'TXT',
                'TMO',
                'TJX',
                'TSCO',
                'TT',
                'TDG',
                'TRV',
                'TRMB',
                'TFC',
                'TWTR',
                'TYL',
                'TSN',
                'USB',
                'UDR',
                'ULTA',
                'UAA',
                'UA',
                'UNP',
                'UAL',
                'UNH',
                'UPS',
                'URI',
                'UHS',
                'VLO',
                'VTR',
                'VRSN',
                'VRSK',
                'VZ',
                'VRTX',
                'VFC',
                'VTRS',
                'V',
                'VNO',
                'VMC',
                'WAB',
                'WMT',
                'WBA',
                'WBD',
                'WM',
                'WAT',
                'WEC',
                'WFC',
                'WELL',
                'WST',
                'WDC',
                'WRK',
                'WY',
                'WHR',
                'WMB',
                'WTW',
                'WYNN',
                'XEL',
                'XYL',
                'YUM',
                'ZBRA',
                'ZBH',
                'ZION',
                'ZTS'
              )
            ),
            
            
            fluidRow(
              
              box(
                title = "Auto Arima - Non Seasonal", solidHeader = TRUE, status = "primary",
                plotOutput("auto.arima", height = 350),
                height = 410,
                width = 8
              ),
              box(
                title = "Auto Arima - Non Seasonal", solidHeader = TRUE, status = "success",
                width = 4,
                tableOutput("auto.arima1"),
                height = 410
              )
              
            ),
            
            fluidRow(
              
              box(
                title = "Auto Arima - Seasonal", status = "primary", solidHeader = TRUE,
                plotOutput("arima.seasonal", height = 350),
                height = 410,
                width = 8
              ),
              box(
                title = "Auto Arima - Seasonal", status = "success", solidHeader = TRUE,
                width = 4,
                tableOutput("arima.seasonal1"),
                height = 410
              )
              
            )
    )
    
  )
)


notifications <- dropdownMenu(type = "tasks", badgeStatus = "success",
                              notificationItem(
                                text = "S2153846 - Rozaidawati Zainul Aznam",
                                icon("users")
                              ),
                              notificationItem(
                                text = "S2155503 - Saravanan Sukumaran",
                                icon("users")
                              ),
                              notificationItem(
                                text = "S2108177 - Rahman Karimiyazdi",
                                icon("users")
                              ),
                              notificationItem(
                                text = "S2155520 - Hossein Golmohammadi",
                                icon("users")
                              ),
                              notificationItem(
                                text = "S2130478 - Seah Teong Tat",
                                icon("users")
                              ),
                              notificationItem(
                                text = "S2116205 - Md Tuhin Hossain",
                                icon("users")
                              )
)


header <- dashboardHeader(
  title = "Trading View",
  notifications
)

ui <- dashboardPage(header, sidebar, body, skin = skin)

server <- function(input, output) {
  
  selectedStockCode <- "AAPL"
  myStr <- " (start from 2022-01-01 to present)"
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    if (is.null(input$count) || is.null(input$fill))
      return()
    
    data <- histdata[seq(1, input$count)]
    color <- input$fill
    if (color == "none")
      color <- NULL
    hist(data, col = color, main = NULL)
  })
  
  ###############################################################
  ############# Auto Arima - Non Seasonal (Plot) ################
  ###############################################################
  
  output$auto.arima <- renderPlot({
    
    # if (is.null(input$StockCode))
    #   return()
    
    #Stock <- as.character(input$StockCode)
    
    data <- eventReactive(input$click, {
      (input$StockCode) 
    })
    Stock <- as.character(data())
    print("Auto Arima - Non Seasonal (Plot)")
    print(Stock)
    #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
    # plot(AAPL$AAPL.Close)  
    Stock_df<-as.data.frame(getSymbols(Symbols = Stock, 
                                       src = "yahoo", from = "2017-01-01", env = NULL))
    #print(Stock_df)
    
    Stock_df$Open = Stock_df[,1]
    Stock_df$High = Stock_df[,2]
    Stock_df$Low = Stock_df[,3]
    Stock_df$Close = Stock_df[,4]
    Stock_df$Volume = Stock_df[,5]
    Stock_df$Adj = Stock_df[,6]
    Stock_df <- Stock_df[,c(7,8,9,10,11,12)] 
    
    
    
    #plot(as.ts(Stock_df$Close))
    
    Stock_df$v7_MA = ma(Stock_df$Close, order=7)
    Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
    
    #STL
    rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
    decomp_rental <- stl(rental_ma, s.window="periodic")
    #plot(decomp_rental)
    adj_rental <- seasadj(decomp_rental)
    #plot(adj_rental)
    
    
    #arima
    fit <- auto.arima(Stock_df$Close,ic="bic")
    fit.forecast <- forecast(fit)
    plot(fit.forecast,  main= Stock, xlab="Days (start from 2017-01-01 to present)", ylab="Price")
    fit.forecast
    
  })
  
  ###############################################################
  ############# Auto Arima - Non Seasonal (Table) ###############
  ###############################################################
  
  output$auto.arima1 <- renderTable({
    #if (is.null(input$StockCode))
    #  return()
    
    #Stock <- as.character(input$StockCode)
    data <- eventReactive(input$click, {
      (input$StockCode)
    })
    Stock <- as.character(data())
    print("Auto Arima - Non Seasonal (Table)")
    print(Stock)
    #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
    # plot(AAPL$AAPL.Close)
    Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                       src = "yahoo", from = "2017-01-01", env = NULL))
    Stock_df$Open = Stock_df[,1]
    Stock_df$High = Stock_df[,2]
    Stock_df$Low = Stock_df[,3]
    Stock_df$Close = Stock_df[,4]
    Stock_df$Volume = Stock_df[,5]
    Stock_df$Adj = Stock_df[,6]
    Stock_df <- Stock_df[,c(7,8,9,10,11,12)]
    
    #plot(as.ts(Stock_df$Close))
    
    Stock_df$v7_MA = ma(Stock_df$Close, order=7)
    Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
    
    #STL
    rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
    decomp_rental <- stl(rental_ma, s.window="periodic")
    #plot(decomp_rental)
    adj_rental <- seasadj(decomp_rental)
    #plot(adj_rental)
    
    
    #arima
    fit <- auto.arima(Stock_df$Close,ic="bic")
    fit.forecast <- forecast(fit)
    #plot(fit.forecast,   col = "red")
    (fit.forecast)
    
    my_df <- as.data.frame(fit.forecast)
    #Day <- seq( as.Date(Sys.Date() +1), by=1, len=10)
    Day <- c("Day-1", "Day-2", "Day-3", "Day-4", "Day-5", "Day-6", "Day-7", "Day-8", "Day-9", "Day-10")
    
    new_df <- add_column(my_df, Day, .before = 1)
    
    print(new_df)
  })
  
  ###############################################################
  ############# Auto Arima - Seasonal (Plot) ####################
  ###############################################################
  
  output$arima.seasonal <- renderPlot({
    if (input$seasonal == "NonSeasonal")
      return()
    
    #Stock <- as.character(input$StockCode)
    data <- eventReactive(input$click, {
      (input$StockCode)
    })
    Stock <- as.character(data())
    print("Auto Arima - Seasonal (Plot)")
    print(Stock)
    #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
    # plot(AAPL$AAPL.Close)
    Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                       src = "yahoo", from = "2017-01-01", env = NULL))
    
    print(Stock_df)
    
    Stock_df$Open = Stock_df[,1]
    Stock_df$High = Stock_df[,2]
    Stock_df$Low = Stock_df[,3]
    Stock_df$Close = Stock_df[,4]
    Stock_df$Volume = Stock_df[,5]
    Stock_df$Adj = Stock_df[,6]
    Stock_df <- Stock_df[,c(7,8,9,10,11,12)]
    
    #plot(as.ts(Stock_df$Close))
    
    Stock_df$v7_MA = ma(Stock_df$Close, order=7)
    Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
    
    #STL
    rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
    decomp_rental <- stl(rental_ma, s.window="periodic")
    #plot(decomp_rental)
    adj_rental <- seasadj(decomp_rental)
    #plot(adj_rental)
    
    
    #arima
    #fit <- auto.arima(Stock_df$Close,ic="bic")
    #fit.forecast <- forecast(fit)
    #plot(fit.forecast,   col = "red")
    #(fit.forecast)
    fit_s<-auto.arima(adj_rental, seasonal=TRUE)
    fcast_s <- forecast(fit_s, h=10)
    plot(fcast_s, xlab="Days (start from 2017-01-01 to present)", ylab="Price")
  })
  
  ###############################################################
  ############# Auto Arima - Seasonal (Table) ###################
  ###############################################################
  
  output$arima.seasonal1 <- renderTable({
    #if (is.null(input$StockCode))
    #  return()
    if (input$seasonal == "NonSeasonal")
      return()
    
    #Stock <- as.character(input$StockCode)
    data <- eventReactive(input$click, {
      (input$StockCode)
    })
    Stock <- as.character(data())
    print("Auto Arima - Seasonal (Table)")
    print(Stock)
    #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
    # plot(AAPL$AAPL.Close)
    Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                       src = "yahoo", from = "2017-01-01", env = NULL))
    Stock_df$Open = Stock_df[,1]
    Stock_df$High = Stock_df[,2]
    Stock_df$Low = Stock_df[,3]
    Stock_df$Close = Stock_df[,4]
    Stock_df$Volume = Stock_df[,5]
    Stock_df$Adj = Stock_df[,6]
    Stock_df <- Stock_df[,c(7,8,9,10,11,12)]
    
    #plot(as.ts(Stock_df$Close))
    
    Stock_df$v7_MA = ma(Stock_df$Close, order=7)
    Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
    
    #STL
    rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
    decomp_rental <- stl(rental_ma, s.window="periodic")
    #plot(decomp_rental)
    adj_rental <- seasadj(decomp_rental)
    #plot(adj_rental)
    
    
    #arima
    #fit <- auto.arima(Stock_df$Close,ic="bic")
    #fit.forecast <- forecast(fit)
    #plot(fit.forecast,   col = "red")
    #(fit.forecast)
    fit_s<-auto.arima(adj_rental, seasonal=TRUE)
    fcast_s <- forecast(fit_s, h=10)
    
    my_df <- as.data.frame(fcast_s)
    #Day <- seq( as.Date(Sys.Date() +1), by=1, len=10)
    Day <- c("Day-1", "Day-2", "Day-3", "Day-4", "Day-5", "Day-6", "Day-7", "Day-8", "Day-9", "Day-10")
    
    new_df <- add_column(my_df, Day, .before = 1)
    
    new_df
  })
  
  
  ###############################################################
  ################# Trading Charts (Close) ######################
  ###############################################################
  
  #output$plotClose <- renderPlot({
  
  #Stock_df<-as.data.frame(getSymbols(Symbols = selectedStockCode, src = "yahoo", from = "2022-01-01", env = NULL))
  #plot(Stock_df[, 4], type="l", col="green", lwd=1, xlab=paste("Days", myStr), ylab="Price", main=paste(selectedStockCode, " Close Price"))
  #grid (NULL,NULL, lty = 6, col = "cornsilk2") 
  
  
  #Stock_df<-as.data.frame(getSymbols(Symbols = selectedStockCode, src = "yahoo", from = "2022-01-01", env = NULL))
  #plot(Stock_df[, 4],type = "l",col = "red", xlab = paste("Days", myStr), ylab = "Price", main=paste(selectedStockCode, " Trading View"))
  #lines(Stock_df[, 2], type = "o", col = "blue")
  #lines(Stock_df[, 3], type = "o", col = "green")
  #legend("topleft", legend=c("Close Price", "High Price", "Low Price"), col=c("red", "blue", "green"), lty = 1:2, cex=1.0)
  #grid (NULL,NULL, lty = 6, col = "cornsilk2")
  
  
  #df <- data.frame(dose=c("D0.5", "D1", "D2"), len=c(4.2, 10, 29.5))
  #ggplot(data=df, aes(x=dose, y=len, group=1)) +
  #  geom_line(color="green", size=.3)+
  #  labs(y= "y axis name", x = "x axis name")+
  #  labs(title = "This is Title")+
  #  geom_point()
  
  #})
  
  
  ###############################################################
  ################# Trading Charts (High) ######################
  ###############################################################
  
  
  #output$plotHigh <- renderPlot({
  
  #getSymbols("AAPL", src = "yahoo",from='2017-01-01', to=Sys.Date())
  #High_Price = AAPL[, 2]
  #print(class(High_Price))
  #plot(High_Price)
  
  #Stock_df<-as.data.frame(getSymbols(Symbols = selectedStockCode, src = "yahoo", from = "2022-01-01", env = NULL))
  #plot(Stock_df[, 2], type="l", col="blue", lwd=1, xlab=paste("Days", myStr), ylab="Price", main=paste(selectedStockCode, " High Price"))
  #grid (NULL,NULL, lty = 6, col = "cornsilk2") 
  #})
  
  
  
  
  output$plotClose <- renderPlot({
    selectedStockCode <- input$state
    
    ##################### For Chart #########################
    
    Stock_df<-as.data.frame(getSymbols(Symbols = selectedStockCode, src = "yahoo", from = "2022-01-01", env = NULL))
    
    plot(Stock_df[, 4],type = "l",col = "red", xlab = paste("Days", myStr), ylab = "Price", main=paste(selectedStockCode, " Trading View"))
    lines(Stock_df[, 2], type = "o", col = "blue")
    lines(Stock_df[, 3], type = "o", col = "green")
    lines(Stock_df[, 1], type = "l", col = "orange")
    legend("topleft", legend=c("Close Price", "High Price", "Low Price", "Open Price"), col=c("red", "blue", "green", "orange"), lty = 1:2, cex=1.0)
    grid (NULL,NULL, lty = 6, col = "cornsilk2")
    
    
    print(lapply(Stock_df,tail,1))
    
    
    output$closePrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[4], "Close Price", icon = icon("list", lib = "glyphicon"),
        color = "maroon"
      )
    })
    
    output$highPrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[2], "High Price", icon = icon("list", lib = "glyphicon"),
        color = "green"
      )
    })
    
    
    output$lowPrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[3], "Low Price", icon = icon("list", lib = "glyphicon"),
        color = "yellow"
      )
    })
    
    
    output$openPrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[1], "Open Price", icon = icon("list", lib = "glyphicon"),
        color = "blue"
      )
    })
    
    
    output$volumePrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[5], "Volume", icon = icon("list", lib = "glyphicon"),
        color = "purple"
      )
    })
    
    
    output$adjustedPrice <- renderValueBox({
      valueBox(
        lapply(Stock_df,tail,1)[6], "Adjusted", icon = icon("list", lib = "glyphicon"),
        color = "aqua"
      )
    })
    
  })
  
}

shinyApp(ui, server)
