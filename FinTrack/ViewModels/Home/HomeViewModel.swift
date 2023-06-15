//
//  HomeViewModel.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import Foundation

class HomeViewModel {
    private var categories: [Category] = []
    
    var totalValue: Double {
        // Lógica para calcular o valor total em caixa com base nas transações
        return 0.0
    }
    
    func loadCategories(completion: @escaping ([Category]) -> Void) {
        // Lógica para carregar as categorias do banco de dados ou de outra fonte de dados
        
        // Exemplo: Simulando o carregamento das categorias
        let category1 = Category(name: "Categoria 1", type: .revenue, emoji: "😃")
        let category2 = Category(name: "Categoria 2", type: .expense, emoji: "🤑")
        
        categories = [category1, category2]
        
        // Chame o bloco de conclusão com as categorias carregadas
        completion(categories)
    }
    
    func saveCategory(_ category: Category) {
        // Lógica para salvar a categoria no banco de dados ou em outra fonte de dados
    }
}
