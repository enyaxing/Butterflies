//
//  ButterflyContainer.swift
//  Butterflies
//
//  Created by Enya Xing on 9/7/20.
//  Copyright © 2020 Enya Xing. All rights reserved.
//

import SwiftUI

/** Contains the image of the butterfly along with its scientific name. */
struct ButterflyContainer: View {
    
    /** Image of butterfly. */
    @State var imageName: String
    
    /** Scientific name of butterfly. */
    @State var butterflyName: String
    var body: some View {
        return VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: 120, height: 120)
            
            //Danaus Plexippus
            Text(butterflyName)
                .frame(width:120)
                .font(.custom("Helvetica Neue Bold", size: 18)).multilineTextAlignment(.center)
        }
    }
}

struct ButterflyContainer_Previews: PreviewProvider {
    static var previews: some View {
        ButterflyContainer(imageName: "Butterfly1", butterflyName: "Butterfly1")
    }
}
