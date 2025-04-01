//
//  TestPageViewController.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import SwiftUI
import AVFAudio

struct TestPageViewController: View {
    @Binding var showResultsButton: Bool
    @StateObject private var viewModel = TestPageViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Color(Color.white)
            .edgesIgnoringSafeArea(.all)
        ZStack{
            VStack {
                //MARK: Progress View
                ProgressView(value: Double(viewModel.currentRound), total: 10)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Please enter the numbers you hear and click submit (Please make sure your phone is not on silent)")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.leading)
                    Divider()
                }
                .padding(.horizontal)
                
                //MARK: Answer TextField
                TextField("Enter the numbers you hear", text: $viewModel.inputText)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                //MARK: Submit Button
                Button(action: {
                    viewModel.submitButtonTapLogic()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                Spacer()
            }
            .padding(.top, 20)
            
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                        .padding(20)
                        .background(Color.purple)
                        .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
            }
        }
        //MARK: On Appear
        .onAppear {()
            viewModel.setView()
            dispatchOnMainThreadAfter(3) { [self] in
                viewModel.startRound()
            }
        }
        //MARK: On Dissapear
        .onDisappear{
            viewModel.isViewLoaded = false
            viewModel.stopSound()
            viewModel.testResults = nil
            if GlobalData.shareData.testResults?.count ?? 0 > 0{
                showResultsButton = true
            }
        }
    }
}


struct TestPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        TestPageViewController(showResultsButton: .constant(false))
    }
}
