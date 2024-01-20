//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2024/01/20.
//

import Foundation
import TransactionsDomain

#if DEBUG

class TransactionListingViewModelDependenciesPreviews: TransactionListingViewModelDependencies {
    var transactionsListingUseCase: TransactionListingUseCase

    init(transactionsListingUseCase: TransactionListingUseCase) {
        self.transactionsListingUseCase = transactionsListingUseCase
    }
}

#endif
