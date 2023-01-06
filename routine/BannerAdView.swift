//
//  BannerAdView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/06.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-7328734218185062/7280183084"
        
        //こちらのadUnitIDはテスト用。本番環境では自身の広告ユニットIDに変更する
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
