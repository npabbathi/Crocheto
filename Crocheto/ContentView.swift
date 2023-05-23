//
//  ContentView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 5/22/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: addItem) {
                    Label("Add Project", systemImage: "plus")
                        .padding()
                }
                .tint(CrochetoColors.white)
                .background(CrochetoColors.green)
                .cornerRadius(15)
                .padding()
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            newGalleryProject()
                        } label: {
                            HStack {
                                Image(systemName: "globe")
                                    .listRowBackground(Color.pink)
                                    .padding()
                                Spacer()
                                Text("Title")
                                    .lineLimit(1)
                                    .bold()
                                Spacer()
                                Text("Project description that can extend multiple lines")
                                    .lineLimit(2)
                                    .padding()
                            }
                            .background(CrochetoColors.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(CrochetoColors.green, lineWidth: 10)
                            )
                            .padding(.vertical)
                        }
                        .foregroundColor(CrochetoColors.green)
                        .listRowBackground(CrochetoColors.darkGreen)
                    }
                    .onDelete(perform: deleteItems)
                    .listRowBackground(CrochetoColors.white)
                    
                }
                .listStyle(.insetGrouped)
                .lineLimit(1)
                .bold()
            }
            .background(CrochetoColors.darkGreen)
            .scrollContentBackground(.hidden)
            
            
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
