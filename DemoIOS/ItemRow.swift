//
//  ItemRow.swift
//  DemoIOS
//
//  Created by imobi - macmini on 10/26/22.
//

import SwiftUI

struct ItemRow: View {
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    let itemMenu : MenuItem
    var body: some View {
        HStack {
            Image(itemMenu.thumbnailImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))

            VStack (alignment: .leading){
                Text(itemMenu.name)
                    .font(.headline)
                Text(String("$\(itemMenu.price)"))
            }
            Spacer()
            ForEach(itemMenu.restrictions , id : \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(5)
                    .background(colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(itemMenu: MenuItem.example)
    }
}
