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
        Form {
            TextField("Song title", text: $viewModel.songTitle)
                .padding()

            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            }label: {
                Text(viewModel.buttonTitle)
                    .foregroundColor(.white)
                    .font(.custom("Avenir Heavy", size: 16))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 50, alignment: .center)
                    .background(.pink)
                    .cornerRadius(14)
            }.frame(maxWidth: .infinity, alignment: .center)
            
        }
    }
}

struct AddUpdateSongs_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSongs(viewModel: AddUpdateSongViewModel())
    }
}
