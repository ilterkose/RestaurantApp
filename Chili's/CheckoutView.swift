//
//  CheckoutView.swift
//  Chili's
//
//  Created by slymind on 19.01.2020.
//  Copyright © 2020 slymind. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    static let paymentTypes = ["Cash","Credit Card", "Chili's Points"]
    static let tipAmounts = [10,15,20,25,0]
    
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        if(total > 0){
            showingPaymentAlert = true
        }
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType){
                    ForEach(0 ..< Self.paymentTypes.count){
                        Text(Self.paymentTypes[$0])
                    }
                        
                }
                Toggle(isOn: $addLoyaltyDetails) {
                    Text("Add Chili's Card Number")
                }
                if addLoyaltyDetails {
                        TextField("Enter your Chili's ID", text:$loyaltyNumber)

                }
                }
            Section(header: Text("Add a tip?")){
                Picker("Percentage:", selection: $tipAmount){
                    ForEach(0 ..< Self.tipAmounts.count){
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header:
            Text("Total $\(totalPrice,specifier: "%.2f")")){
                ForEach(self.order.items){ item in
                    Text(item.name + "\t" + "\(item.price)$")
                }
                Button("Confirm Order"){
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment"),displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert){
            Alert(title: Text("Order confirmed"),message: Text("Your total was $\(totalPrice,specifier: "%.2f")- thank you!"),dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
