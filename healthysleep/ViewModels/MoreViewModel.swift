//
//  MoreViewModel.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

struct MoreCell {
    var handler: () -> Void?
    var name: String
}

final class MoreViewModel {
    var data: [MoreCell] = [
        MoreCell(handler: {}, name: "Tell a Friend"),
        MoreCell(handler: {}, name: "FAQs"),
        MoreCell(handler: {}, name: "Support"),
        MoreCell(handler: {}, name: "Version 1.1.2"),
    ]
}
