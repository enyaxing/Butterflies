//
//  ContentView.swift
//  Butterflies
//
//  Created by Enya Xing on 9/7/20.
//  Copyright © 2020 Enya Xing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    /** String that stores the quote of the day. */
    @State var quote: String = ""
    
    /** Set NavigationBar title font style. */
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Bold", size: 40)!]
    }
    
    var body: some View {
        return NavigationView {
                VStack {
                    Text(quote)
                        .font(.custom("Helvetica Neue Regular", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(25)
                    
                    HStack {
                        VStack {
                            //daniel-klein-uNNPbsCTksk-u...
                            Image(uiImage: #imageLiteral(resourceName: "Butterfly1"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 120, height: 120)
                            
                            //Danaus Plexippus
                            Text("Danaus Plexippus")
                                .frame(width:120)
                                .font(.custom("Helvetica Neue Bold", size: 18)).multilineTextAlignment(.center)
                        }
                        .padding(.trailing, 20.0)
                        VStack {
                            //anne-lambeck-5VC4thmwMms-u...
                            Image(uiImage: #imageLiteral(resourceName: " Butterfly2"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 120, height: 120)
                            
                            //Morpho Pelides
                            Text("Morpho Pelides")
                                .frame(width:120)
                                .font(.custom("Helvetica Neue Bold", size: 18)).multilineTextAlignment(.center)
                        }
                        .padding(.leading, 20.0)
                    }
                    .padding(.bottom)
                    
                    VStack {
                        //fleur-SE2zTdS1MNo-unsplash 1
                        Image(uiImage: #imageLiteral(resourceName: "Butterfly3"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 120, height: 120)
                        
                        //Delias Eucharia
                        Text("Delias Eucharia")
                            .frame(width:120)
                            .font(.custom("Helvetica Neue Bold", size: 18))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Spacer()
                }
                .navigationBarTitle(Text("Butterflies"), displayMode: .large)
        }
        .onAppear() {
            self.setupQuote()
        }
    }


    /** Obtains the quote of the day and updates the state variable. */
    private func setupQuote() {
        guard let url = URL(string: "https://quotes.rest/qod.json") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, reponse, error) in
            do {
                // Parse the JSON by accessing multiple levels of dictionaries to get the quote and author
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    guard let quotes = (jsonResult["contents"] as? [String: Any])?["quotes"] as? [Any],
                        let firstQuote = quotes[0] as? [String: Any],
                        let quoteText = firstQuote["quote"] as? String,
                        let quoteAuthor = firstQuote["author"] as? String else { return }
                    
                    self.quote = "\(quoteText)\n\n- \(quoteAuthor)"
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
