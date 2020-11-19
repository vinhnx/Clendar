//
//  QuickEventWrapperView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

#warning("// TODO: SwiftUI")

// wrap
struct QuickEventView: View {
	var body: some View {
		VStack {
			HStack {}
		}
		.padding()
	}
}

// == UIKit wrapper
struct QuickEventWrapperView: UIViewControllerRepresentable {
	func makeUIViewController(context _: Context) -> CreateEventViewController {
		R.storyboard.createEventViewController.instantiateInitialViewController()!
	}

	func updateUIViewController(_: CreateEventViewController, context _: Context) {}
}

struct QuickEventWrapperView_Previews: PreviewProvider {
	static var previews: some View {
		QuickEventWrapperView()
	}
}
