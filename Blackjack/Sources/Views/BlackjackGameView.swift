//
//  BlackjackGameView.swift
//  Blackjack
//
//  Created by Радэль Зубаиров on 18.12.2024.
//

import SwiftUICore
import SwiftUI

struct BlackjackGameView: View {
    @ObservedObject private var viewModel: BlackjackGameViewModel = BlackjackGameViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Blackjack")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Отображение карт дилера
            VStack {
                Text("Diller cards")
                    .font(.title2)
                HStack {
                    ForEach(viewModel.dealerCards, id: \.cardImage) { card in
                        CardView(card: card)
                    }
                }
            }

            // Отображение карт игрока
            VStack {
                Text("Your cards")
                    .font(.title2)
                HStack {
                    ForEach(viewModel.playerCards, id: \.cardImage) { card in
                        CardView(card: card)
                    }
                }
            }

            // Отображение счета
            Text("Your points: \(viewModel.playerScore)")
                .font(.title3)

            // Кнопки действий
            HStack {
                Button(action: {
                    viewModel.hit()
                }) {
                    Text("Hit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    viewModel.stand()
                }) {
                    Text("Stand")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    viewModel.double()
                }) {
                    Text("Double")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.gameOver) {
            Alert(title: Text("Game is over!"),
                  message: Text(viewModel.finalMessage),
                  dismissButton: .default(Text("OK")) {
                      viewModel.resetGame()
                  })
        }.onAppear {
            viewModel.resetGame()
        }
    }
}

struct CardView: View {
    var card: CardModel // Предполагается, что Card - это ваша модель карты

    var body: some View {
        VStack {
            Image(card.cardImage)
                .resizable()
        }
        .frame(width: 50, height: 80)
        .background(Color.white)
        .shadow(radius: 5)
    }
}
