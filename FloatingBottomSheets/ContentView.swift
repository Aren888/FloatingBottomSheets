//
//  ContentView.swift
//  FloatingBottomSheets
//
//  Created by Solicy Ios on 06.08.24.
//

import SwiftUI

struct ContentView: View {
    
    /// View Properties
    @State private var showAlertSheet: Bool = false
    @State private var showQuestionSheet: Bool = false
    @State private var showRequestSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 10) {
                    CustomButton(title: "Alert", backgroundColor: .red) {
                        showAlertSheet = true
                    }
                    
                    CustomButton(title: "Question", backgroundColor: .blue) {
                        showQuestionSheet = true
                    }
                    
                    CustomButton(title: "Request", backgroundColor: .green) {
                        showRequestSheet = true
                    }
                }
                .padding(10)
                .background(.gray.gradient.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.1), radius: 15)
                .padding(.bottom, 200)
            }
            .navigationTitle("Floating Bottom Sheets")
        }
        .floatingBottomSheet(isPresented: $showAlertSheet) {
            SheetView(
                title: "Ooops!",
                content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                image: .init(
                    content: "exclamationmark.triangle",
                    tint: .red,
                    foreground: .white
                ),
                button1: .init(
                    content: "Done",
                    tint: .red,
                    foreground: .white
                )
            )
            .presentationDetents([.height(260)])
        }
        .floatingBottomSheet(isPresented: $showQuestionSheet) {
            SheetView(
                title: "Replace Existing Folder?",
                content: "Are you sure you want to replace the existing folder?",
                image: .init(
                    content: "questionmark.folder.fill",
                    tint: .blue,
                    foreground: .white
                ),
                button1: .init(
                    content: "Replace",
                    tint: .blue,
                    foreground: .white
                ),
                button2: .init(
                    content: "Cancel",
                    tint: Color.primary.opacity(0.08),
                    foreground: Color.primary
                )
            )
            .presentationDetents([.height(330)])
        }
        .floatingBottomSheet(isPresented: $showRequestSheet) {
            SheetView(
                title: "Request from iJustine",
                content: "Do you really want to overwrite the current folder with this new one?",
                image: .init(
                    content: "person.fill.checkmark",
                    tint: .green,
                    foreground: .white
                ),
                button1: .init(
                    content: "Replace",
                    tint: .green,
                    foreground: .white
                ),
                button2: .init(
                    content: "Cancel",
                    tint: .red,
                    foreground: .white
                )
            )
            .presentationDetents([.height(330)])
        }
    }
    
}

struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(10)
                .background(backgroundColor.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .tint(.white)
                .fontWeight(.semibold)
        }
    }
}

/// Sample View
struct SheetView: View {
    var title: String
    var content: String
    var image: Config
    var button1: Config
    var button2: Config?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            
            ZStack {
                Capsule()
                    .foregroundStyle(image.tint.opacity(0.5))
                    .frame(width: 75, height: 75)
                
                Image(systemName: image.content)
                    .font(.title)
                    .foregroundStyle(image.foreground)
                    .frame(width: 65, height: 65)
                    .background(image.tint.gradient, in: .capsule(style: .circular))
            }
            Text(title)
                .font(.title3.bold())
            
            Text(content)
                .font(.callout)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.gray)
            
            ButtonView(config: button1, dismiss: dismiss)
            
            if let button2 = button2 {
                ButtonView(config: button2, dismiss: dismiss)
            }
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top, 30)
        }
        .shadow(color: .black.opacity(0.12), radius: 8)
        .padding(.horizontal, 15)
    }
    
    struct Config {
        var content: String
        var tint: Color
        var foreground: Color
    }
}

struct ButtonView: View {
    var config: SheetView.Config
    var dismiss: DismissAction
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text(config.content)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(config.tint.gradient, in: .rect(cornerRadius: 10))
        }
    }
}

#Preview {
    ContentView()
}
