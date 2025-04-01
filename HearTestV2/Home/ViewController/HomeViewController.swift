//
//  HomeViewController.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showResultsButton = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Please press the start button in order to start the test and view your results after")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                Spacer()
                
                //MARK: Button Stack
                VStack(spacing: 16) {
                    NavigationLink(destination: TestPageViewController(showResultsButton: $showResultsButton)) {
                        Text("Start Test")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    if showResultsButton {
                        NavigationLink(destination: ResultsViewController()) {
                            Text("View Results")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.white.ignoresSafeArea())
        }
        //MARK: On Appear
        .onAppear{
            showResultsButton = viewModel.checkForStoredValues()
        }
        
    }
}

#Preview {
    HomeView()
}

