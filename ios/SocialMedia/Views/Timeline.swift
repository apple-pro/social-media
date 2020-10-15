//
//  PostDashboard.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/13/20.
//

import SwiftUI

struct Timeline: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PendingPosts.createdAt, ascending: true)],
        animation: .default)
    private var pendingPosts: FetchedResults<PendingPosts>
    
    var body: some View {
//        VStack {
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//
//            List {
//                ForEach(pendingPosts) { pendingPost in
//                    VStack {
//                        Text(pendingPost.text!)
//                        Text("\(pendingPost.createdAt!, formatter: itemFormatter)")
//                            .font(.subheadline)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//        }
        
        NavigationView {
            ScrollView {
                
                WhatsOnYourMind()
                
                ForEach(pendingPosts) { pendingPost in
                    VStack {
                        Text(pendingPost.text!)
                        Text("\(pendingPost.createdAt!, formatter: itemFormatter)")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteItems)
            }.navigationTitle("Timeline")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = PendingPosts(context: viewContext)
            newItem.createdAt = Date()
            newItem.id = UUID.init()
            newItem.text = "Test"

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
            offsets.map { pendingPosts[$0] }.forEach(viewContext.delete)

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

struct WhatsOnYourMind: View {
    
    @State var message = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Text("LB")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                
                TextField("Whats on your mind?", text: $message)
            }
            .padding()
            
            HStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "video.fill")
                    Text("Live")
                }).frame(maxWidth: .infinity)
                
                Divider()
                
                Button(action: {}, label: {
                    Image(systemName: "photo.fill")
                    Text("Photo")
                }).frame(maxWidth: .infinity)
                
                Divider()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "video.fill.badge.plus")
                    Text("Room")
                }).frame(maxWidth: .infinity)
                
            }
            .padding()
        }
        
    }
}


//TODO: remove once useless
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct PostDashboard_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            //.previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
