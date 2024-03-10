//
//  BottomView.swift
//  DreamNest
//
//  Created by Flama Henkel on 27.02.24.
//

import SwiftUI

struct BottomView: View {
    
    var googleAction: () -> Void
    var facebookAction: () -> Void
    var appleAction: () -> Void
    
    var body: some View {
        VStack {
            Text("or continue with")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.dark)
                .padding(.bottom)
            HStack {
                Button {
                    googleAction()
                } label: {
                    Image("google")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .iconButtonStyle
                }
                Button {
                    facebookAction()
                } label: {
                    Image("facebook")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .iconButtonStyle
                }
                Button {
                    appleAction()
                } label: {
                    Image("apple")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .iconButtonStyle
                }
            }
            
        }
    }
}

extension View {
    var iconButtonStyle: some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
}
