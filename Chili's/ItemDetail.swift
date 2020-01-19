//
//  ItemDetail.swift
//  Chili's
//
//  Created by slymind on 18.01.2020.
//  Copyright © 2020 slymind. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    var item: MenuItem

    var body: some View {
        VStack{
            Image(item.mainImage)
                .clipShape(Rectangle())
            Text(item.description)
                .padding()
            Button("Order This"){
                self.order.add(item:self.item)
            }.font(.headline)
            Spacer()
        } .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
            NavigationView{
                ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}
