//
//  Splash.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/11/20.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        VStack {
            Text("Social Media")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.accentColor)
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
