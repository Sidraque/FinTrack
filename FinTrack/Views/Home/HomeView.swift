//
//  HomeView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func addCategoryButtonTapped()
    func addTransactionButtonTapped()
}

class HomeView: UIView {
    private var totalValueLabel: UILabel!
    private var piggyBankImageView: UIImageView!
    private var addCategoryButton: UIButton!
    private var addTransactionButton: UIButton!
    
    weak var delegate: HomeViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configurar a interface do usuário da tela inicial
        // Inclua os elementos necessários, como rótulo de valor total, imagem do porquinho de cofre e botões de adicionar categoria e adicionar transação
        
        // Exemplo:
        totalValueLabel = UILabel()
        addSubview(totalValueLabel)
        
        piggyBankImageView = UIImageView()
        addSubview(piggyBankImageView)
        
        addCategoryButton = UIButton()
        addSubview(addCategoryButton)
        
        addTransactionButton = UIButton()
        addSubview(addTransactionButton)
        
        // Configurar layout e restante da interface do usuário
    }
    
    func updateCategories(_ categories: [Category]) {
        // Atualizar a interface do usuário com as categorias
        // Por exemplo, exibir as categorias em uma lista ou grade
        
        // Exemplo:
        for category in categories {
            // Criar uma view para exibir a categoria na interface do usuário
            // Pode ser um rótulo, uma imagem, ou uma combinação de elementos
        }
    }
    
    // Adicione os targets aos botões para chamar os métodos adequados no delegate
    
}
