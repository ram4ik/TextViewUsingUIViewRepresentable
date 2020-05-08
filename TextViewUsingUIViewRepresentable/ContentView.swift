//
//  ContentView.swift
//  TextViewUsingUIViewRepresentable
//
//  Created by ramil on 08.05.2020.
//  Copyright © 2020 com.ri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var message = "I enjoy so much working with the SwiftUI framework. Like most new frameworks, however, one drawback is that it doesn’t come with all UI controls which are available in UIKit. For example, you can’t find a SwiftUI counterpart of text view. Thankfully, Apple provided a protocol called UIViewRepresentable that allows you easily wrap a UIView and make it available to your SwiftUI project."
    @State private var textStyle = UIFont.TextStyle.body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TextView(text: $message, textStyle: $textStyle)
                .padding(.horizontal)
     
            Button(action: {
                self.textStyle = (self.textStyle == .body) ? .title1 : .body
            }) {
                Image(systemName: "textformat")
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .clipShape(Circle())
     
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true

        textView.delegate = context.coordinator

        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
           self.text = text
        }

        func textViewDidChange(_ textView: UITextView) {
           self.text.wrappedValue = textView.text
        }
    }
}
