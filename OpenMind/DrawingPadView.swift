//
//  DrawingPadView.swift
//  OpenMind
//
//  Created by MacService on 7/10/23.
//

import SwiftUI

struct DrawingPadView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cellStore: CellStore
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                   dismiss()
                }
                Spacer()
                Button("Save") {
                    dismiss()
                }
            }
            .padding()
            Divider()
            DrawingPad()
        }
    }
}

#Preview {
    DrawingPadView().environmentObject(CellStore())
}
