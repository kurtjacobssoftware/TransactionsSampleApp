//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2024/01/20.
//

import Foundation
import TransactionsDomain

#if DEBUG

class TransactionDetailViewModelDependenciesPreviews: TransactionDetailViewModelDependencies {
    var transactionDetailUseCase: TransactionDetailUseCase

    init(transactionDetailUseCase: TransactionDetailUseCase) {
        self.transactionDetailUseCase = transactionDetailUseCase
    }
}

#endif
