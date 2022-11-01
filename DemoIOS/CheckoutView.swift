//
//  CheckoutView.swift
//  DemoIOS
//
//  Created by imobi - macmini on 10/26/22.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order : Order
    let tipAmounts = [10, 15, 20, 25, 0]
    @State private var showingPaymentAlert = false
    @State private var tipAmount = 15
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)

        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var paymentType = "Cash"
    let paymentTypes = ["Cash", "Credit Card", "App Points"]
    var body: some View {
           
                Form {
                    Section {
                        if #available(iOS 16.0, *) {
                            Picker("How do you want to pay?", selection: $paymentType) {
                                ForEach(paymentTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.inline)
                        } else {
                            Picker("Selection", selection: $paymentType) {
                                ForEach(paymentTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                    Toggle("Add App loyalty card", isOn: $addLoyaltyDetails.animation())

                    if addLoyaltyDetails {
                        TextField("Enter your App ID", text: $loyaltyNumber)
                    }
                    
                    Section(header: Text("Add a tip?")) {
                        Picker("Percentage:", selection: $tipAmount) {
                            ForEach(tipAmounts, id: \.self) {
                                Text("\($0)%")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section(header:
                                Text("TOTAL: \(totalPrice)").font(.title)
                    ) {
                        Button("Confirm order") {
                            // place the order
                            showingPaymentAlert.toggle()
                        }
                    }
                }
                .navigationTitle("Payment")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showingPaymentAlert) {
                    // more to come
                    Alert(title: Text("Order confirmed"), message: Text("Your total was \(totalPrice) – thank you!"), dismissButton: .default(Text("OK")))
                }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(Order())
    }
}
