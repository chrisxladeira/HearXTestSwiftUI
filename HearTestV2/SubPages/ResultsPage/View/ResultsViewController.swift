//
//  ResultsViewController.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import SwiftUI

struct ResultsViewController: View {
    @StateObject private var viewModel = ResultsViewModel()
    
    var body: some View {
        ZStack {
            VStack{
                if viewModel.selectedIndex != nil {
                HStack{
                    Spacer()
                    //MARK: Reset Button
                        Button("Reset List") {
                            viewModel.resetSelection()
                        }
                        .padding()
                        .frame(height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    Rectangle()
                            .frame(width: 16,height: 40)
                            .opacity(0)
                    }
                    
                }
                //MARK: History List
                List {
                    if let selectedIndex = viewModel.selectedIndex {
                        ForEach(viewModel.testScores[selectedIndex].rounds ?? [], id: \.tripletPlayed) { round in
                            Text("Correct answer: \(round.tripletPlayed), Submitted answer: \(round.tripletAnswered)")
                                .foregroundColor(Color.black)
                                .listRowBackground(Color.gray)
                                .font(.system(size: 14))
                        }
                    } else {
                        ForEach(viewModel.testScores.indices, id: \.self) { index in
                            Button(action: {
                                viewModel.selectedIndex = index
                            }) {
                                HStack {
                                    Text("Score: \(viewModel.testScores[index].score ?? 0)")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .tint(Color.black)
                                }
                            }
                            .listRowBackground(Color.gray)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

#Preview {
    ResultsViewController()
}
