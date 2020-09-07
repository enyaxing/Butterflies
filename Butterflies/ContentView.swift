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
                    /** Quote of the day. */
                    Text(quote)
                        .font(.custom("Helvetica Neue Regular", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(25)
                    
                    /** Container for all butterfly images*/
                    HStack {
                        //Danaus Plexippus
                        ButterflyContainer(imageName: "Butterfly1", butterflyName: "Danaus Plexippus")
                            .padding(.trailing, 20.0)
                        
                        //Morpho Pelides
                        ButterflyContainer(imageName: "Butterfly2", butterflyName: "Morpho Pelides")
                            .padding(.leading, 20.0)
                    }
                    .padding(.bottom, 20.0)
                    
                    // Delias Eucharia
                    ButterflyContainer(imageName: "Butterfly3", butterflyName: "Delias Eucharia")
                        .padding(.leading, 20.0)
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
