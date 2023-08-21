//
//  CustomView.swift
//  CalculatorDemo
//
//  Created by 雷子康 on 2023/8/21.
//

import SwiftUI

struct CustomView: View {
    var body: some View {
        ZStack{
            
            
            Image("Custom")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Text("Custom your page")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                .padding(.vertical)
        }
       
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}
