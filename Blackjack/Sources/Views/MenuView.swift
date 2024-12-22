//
//  MenuView.swift
//  Blackjack
//
//  Created by Радэль Зубаиров on 18.12.2024.
//

import SwiftUICore
import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            Image(Constants.menuCardsPng)
                .resizable()
                .scaledToFit()
            Text("Menu")
                .font(.largeTitle)
            VStack (spacing: 30) {
                NavigationLink {
                    BlackjackGameView()
                } label: {
                    Text("Play blackjack")
                }
                NavigationLink {
                    
                } label: {
                    Text("Play poker")
                }
                NavigationLink {
                    
                } label: {
                    Text("Play other")
                }
                Spacer()
            }
            .font(.system(size: 24, weight: .regular))
            .foregroundColor(.primary)
            .padding(20)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
