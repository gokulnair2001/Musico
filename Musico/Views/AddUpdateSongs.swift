//
//  AddUpdateSongs.swift
//  Musico
//
//  Created by Gokul Nair on 01/02/22.
//

import SwiftUI

struct AddUpdateSongs: View {
    
    @ObservedObject var viewModel: AddUpdateSongViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            }label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSongs_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSongs(viewModel: AddUpdateSongViewModel())
    }
}
