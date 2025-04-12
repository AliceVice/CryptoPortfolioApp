//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 10/03/2025.
//

import Foundation
import CoreData

final class PortfolioDataService {
    
    @Published public var savedEntities: [PortfolioEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    public init() {
        container = NSPersistentContainer(name: containerName)
        
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - Public methods
    
    public func updatePortfolio(coin: Coin, amount: Double) {
        
        // Check if coin is already in Portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
            
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - Private methods
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        self.applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        self.applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        self.applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
}
