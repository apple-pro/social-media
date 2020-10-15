//
//  PostDashboard.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/13/20.
//

import SwiftUI

struct PostDashboard: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PendingPosts.createdAt, ascending: true)],
        animation: .default)
    private var pendingPosts: FetchedResults<PendingPosts>
    
    var body: some View {
        VStack {
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
            
            List {
                ForEach(pendingPosts) { pendingPost in
                    VStack {
                        Text(pendingPost.text!)
                        Text("\(pendingPost.createdAt!, formatter: itemFormatter)")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteItems)
            }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct PostDashboard_Previews: PreviewProvider {
    static var previews: some View {
        PostDashboard()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
