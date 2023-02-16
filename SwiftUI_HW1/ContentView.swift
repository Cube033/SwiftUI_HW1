//
//  ContentView.swift
//  SwiftUI_HW1
//
//  Created by Дмитрий Федотов on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            VKbody()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Feed")
                }
                .tag(0)
            Demo0()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .tag(1)
            Demo1()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Player")
                }
                .tag(2)
            Demo2()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Video")
                }
                .tag(3)
            Demo3()
                .tabItem {
                    Image(systemName: "mic.fill")
                    Text("Recorder")
                }
                .tag(3)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Universe: Identifiable {
    var id: String { name }
    let name: String
}

struct Demo1: View {
    
    @State private var isPuchEnabled = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $isPuchEnabled) {
                        Text("Выключить нотификации")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct Demo2: View {
    
    @State private var speed = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Slider(value: $speed, in: 0...100) { editing in
                isEditing = editing
            }
            Text("\(speed)")
                .foregroundColor(speed > 70 ? .red : .green)
        }
        .padding(16)
    }
}

struct Demo3: View {
    
    @State var selectedUniverse: Universe?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Какая киновселенная Вам больше нравится")
                    .multilineTextAlignment(.center)
                Button("Marvel") {
                    selectedUniverse = .init(name: "Marvel")
                }
                Button("DC") {
                    selectedUniverse = .init(name: "DC")
                }
            }
            .padding(32)
            .alert(item: $selectedUniverse) { universe in
                Alert(title: Text(universe.name), message: Text("Выбор сделан"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct Demo0: View {
    
    @State private var isPuchEnabled = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, title!").modifier(Title())
            Text("Hello, regular text!").modifier(RegularText())
        }
        .padding()
    }
}

struct VKbody: View {
    
    @State private var textPlaceholderEmail = "Email or phone"
    @State private var textPlaceholderPassword = "Password"
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(80)
            VStack{
                TextField("Placeholder", text: $textPlaceholderEmail)
                    .textFieldStyle()
                TextField("Placeholder", text: $textPlaceholderPassword)
                    .textFieldStyle()
                Button(action: {
                    print("no action")
                }) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(width: 330, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }
            
        }
        .padding()
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

extension View {
    func textFieldStyle() -> some View {
        return self.modifier(TextFieldModifier())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
    }
}
