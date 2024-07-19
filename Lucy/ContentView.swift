//
//  ContentView.swift
//  Lucy
//
//  Created by Ayush Desai on 7/16/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    let model = GenerativeModel(name:"gemini-pro", apiKey: APIKey.default)
    @State var userPrompt = ""
    @State var response: LocalizedStringKey  = "How can I be of service?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.indigo)
                .padding(.top, 40)
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title2)
                }
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint:.indigo))
                        .scaleEffect(3)
                }
            }
            TextField("Ask Anything...", text: $userPrompt, axis: .vertical).lineLimit(5)
                .font(.title)
                .padding()
                .background(Color.indigo.opacity(0.2))
                .disableAutocorrection(true)
                .onSubmit {
                    generateResponse()
                }
             
        }
        .padding()
    }
    func generateResponse(){
        isLoading = true
        response = ""
        
        Task{
            do{
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No Response Found, Please Try again.")
                userPrompt = ""
            }
            catch{
                response = "Something Went wrong \n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
