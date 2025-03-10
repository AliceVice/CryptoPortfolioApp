//
//  MarketData.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import Foundation


struct GlobalMarketData: Decodable {
    let data: MarketData?
}

struct MarketData: Decodable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        // get market cap for "usd" key
        if let usdMarketCap = totalMarketCap.first(where: { $0.key == "usd" } ) {
            return "$" + usdMarketCap.value.formattedWithAbbreviations()
        } else { return "" }
    }
    
    var volume: String {
        // get total volume for "usd" key
        if let volume = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + volume.value.formattedWithAbbreviations()
        } else { return "" }
    }
    
    
    /// Market cap percentage that Bitcoin has of the total market cap
    var btcDominance: String {
        if let percentage = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return percentage.value.asPersentString()
        } else { return "" }
    }
}



// JSON Data
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response :
 {
   "data": {
     "active_cryptocurrencies": 17175,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1275,
     "total_market_cap": {
       "btc": 33799690.0286831,
       "eth": 1376475694.18584,
       "ltc": 29030682629.09,
       "bch": 7662016038.85195,
       "bnb": 5045482729.4266,
       "eos": 5738511270615.69,
       "xrp": 1317329948761.25,
       "xlm": 10516790785438.5,
       "link": 202421782729.213,
       "dot": 693218706619.392,
       "yfi": 556845264.039115,
       "usd": 2787776088251.58,
       "aed": 10238386461712.8,
       "ars": 2.9687056138496e+15,
       "aud": 4421867283469.39,
       "bdt": 339117422071889,
       "bhd": 1050899588659.93,
       "bmd": 2787776088251.58,
       "brl": 16134532888364.9,
       "cad": 4006982082687.53,
       "chf": 2457084513111,
       "clp": 2586188737612088,
       "cny": 20167469166434,
       "czk": 64205549866131,
       "dkk": 19180359470225.5,
       "eur": 2573649794689.07,
       "gbp": 2160481863977.57,
       "gel": 7736078644898.14,
       "hkd": 21663794042922.6,
       "huf": 1025114416142543,
       "idr": 45440606012904880,
       "ils": 10130831272451.9,
       "inr": 242952595259059,
       "jpy": 412588265279285,
       "krw": 4035347704385488,
       "kwd": 858855269492.459,
       "lkr": 824640336006130,
       "mmk": 5848754233151819,
       "mxn": 56475632206387.9,
       "myr": 12306637541586.6,
       "ngn": 4.22235886387997e+15,
       "nok": 30273369357328.7,
       "nzd": 4876458779076.23,
       "php": 159474745067312,
       "pkr": 781513526341937,
       "pln": 10722506081646.4,
       "rub": 248253947355074,
       "sar": 10458824280339.1,
       "sek": 28149206640228.9,
       "sgd": 3710488156821.53,
       "thb": 94099823492098.9,
       "try": 101630883507915,
       "twd": 91556142290358.5,
       "uah": 115041650434790,
       "vef": 279140019716.631,
       "vnd": 71102229130856620,
       "zar": 50891490891756.9,
       "xdr": 2098710321414.09,
       "xag": 85677642486.345,
       "xau": 958186519.292952,
       "bits": 33799690028683.1,
       "sats": 3379969002868311
     },
     "total_volume": {
       "btc": 914857.171421986,
       "eth": 37257106.7677047,
       "ltc": 785774312.48512,
       "bch": 207388006.065898,
       "bnb": 136566224.553674,
       "eos": 155324447790.896,
       "xrp": 35656207193.9256,
       "xlm": 284658275334.424,
       "link": 5478956150.92002,
       "dot": 18763370450.3335,
       "yfi": 15072146.6009374,
       "usd": 75456814677.6304,
       "aed": 277122697585.065,
       "ars": 80354039293443.6,
       "aud": 119686807539.514,
       "bdt": 9178900909248.72,
       "bhd": 28444729058.5823,
       "bmd": 75456814677.6304,
       "brl": 436713860628.254,
       "cad": 108457098008.745,
       "chf": 66505976406.9405,
       "clp": 70000444123817.7,
       "cny": 545873461581.647,
       "czk": 1737853444521.97,
       "dkk": 519155335356.519,
       "eur": 69661052199.0562,
       "gbp": 58477824066.1287,
       "gel": 209392660730.424,
       "hkd": 586374529575.792,
       "huf": 27746801060607.5,
       "idr": 1.22994217548707e+15,
       "ils": 274211498217.988,
       "inr": 6576004806544.48,
       "jpy": 11167538312185.4,
       "krw": 109224871098090,
       "kwd": 23246660009.0697,
       "lkr": 22320563431168.2,
       "mmk": 158308397193668,
       "mxn": 1528627543351.99,
       "myr": 333104108394.399,
       "ngn": 114286707471568,
       "nok": 819410149505.973,
       "nzd": 131991248481.737,
       "php": 4316507460917.92,
       "pkr": 21153248847266.5,
       "pln": 290226377108.353,
       "rub": 6719496654521.68,
       "sar": 283089294292.07,
       "sek": 761915376821.465,
       "sgd": 100431888483.706,
       "thb": 2547002599084.01,
       "try": 2750846014749.41,
       "twd": 2478152707642.74,
       "uah": 3113835624621.85,
       "vef": 7555490853.67113,
       "vnd": 1924526058352962,
       "zar": 1377481431550.7,
       "xdr": 56805851966.5017,
       "xag": 2319039186.23646,
       "xau": 25935261.7728483,
       "bits": 914857171421.986,
       "sats": 91485717142198.6
     },
     "market_cap_percentage": {
       "btc": 58.6826002935767,
       "eth": 8.76416478842917,
       "usdt": 5.12866443670848,
       "xrp": 4.43001592407384,
       "bnb": 2.89410948596927,
       "sol": 2.31978827241479,
       "usdc": 2.08881745960681,
       "ada": 0.940499405175021,
       "doge": 0.898122721917506,
       "trx": 0.807490946716604
     },
     "market_cap_change_percentage_24h_usd": -6.46817959298279,
     "updated_at": 1741543630
   }
 
 */
