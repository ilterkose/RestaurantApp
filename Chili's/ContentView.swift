//
//  ContentView.swift
//  Chili's
//
//  Created by slymind on 18.01.2020.
//  Copyright © 2020 slymind. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView {
        List {
            ForEach(menu) { section in
                Section(header : Text(section.name)) {
                    ForEach(section.items){ item in
                        ItemRow(item: item)
                    }
                }
            }
            }.navigationBarTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
