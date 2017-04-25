import Foundation


class SecondPhase{
    
    
    init(){
        
    }
    
    
    static func rouletteWheel(population:[ViewController.Individual])-> [ViewController.Individual]{
        var chancesTable: [Int] = [Int]()
        var index = 0
        for child in population{
            if (index == 0){
                chancesTable.append(child.fitness)
            } else {
                chancesTable.append(child.fitness + chancesTable[index-1])
            }
            index += 1
        }
        var count = chancesTable.count
        
        var parents: [ViewController.Individual] = []
        var rouletterValue = Int(arc4random_uniform(UInt32(chancesTable[count-1])))
        for mark in 0...1 {
            rouletterValue = Int(arc4random_uniform(UInt32(chancesTable[count-1])))
            let chancesIndex = chancesTable.index(where: { $0 >= rouletterValue })
            parents.append(population[chancesIndex!])
        }
        return parents
    }
    
    static func mutate(childs: [ViewController.Individual]) -> [ViewController.Individual]{
        var childMutants: [ViewController.Individual] = childs
        for child in childs{
            var fenotype: [Int] = child.fenotype
            for index in 0..<8{
                var mutationProb = Int(arc4random_uniform(100))
                if(mutationProb < 90){
                    var factor = Int(arc4random_uniform(1))
                    if(factor == 0){
                        factor = 7
                    }else{
                        factor = 1
                    }
                    var neighbour = (index+factor)%7
                    var temp = fenotype[index]
                    fenotype[index] = fenotype[neighbour]
                    fenotype[neighbour] = temp
                }
            }
            var individual: ViewController.Individual = ViewController.Individual(fenotype: fenotype)
            individual.byMutation = true
            childMutants.append(individual)
        }
        return childMutants
    }
    
    static func generatePMX(parents:[ViewController.Individual])-> [ViewController.Individual]{
        let start = 0
        var childs: [ViewController.Individual] = []
        var childFenotypeA: [Int] = [-1,-1,-1,-1,-1,-1,-1,-1]
        var childFenotypeB: [Int] = [-1,-1,-1,-1,-1,-1,-1,-1]
        var checkA: [Bool] = [false,false,false,false,false,false,false,false]
        var checkB: [Bool] = [false,false,false,false,false,false,false,false]
        
        var firstA = start
        var firstB = start
        var exit = false
        repeat {
            let valueB = parents[1].fenotype[firstB]
            
            let actualA = parents[0].fenotype.index(where: {$0 == valueB})
            childFenotypeA[actualA!] = valueB
            checkA[actualA!] = true
            firstB = actualA!
            
            if(firstB == start){
                exit = true
            }
        } while !exit
        
        firstA = start
        firstB = start
        exit = false
        repeat {
            let valueA = parents[0].fenotype[firstA]
            
            let actualB = parents[1].fenotype.index(where: {$0 == valueA})
            childFenotypeB[actualB!] = valueA
            checkB[actualB!] = true
            firstA = actualB!
            
            if(firstA == start){
                exit = true
            }
        } while !exit
        
        for index in 0..<8{
            if(!checkA[index]){
                childFenotypeA[index] = parents[1].fenotype[index]
            }
            if(!checkB[index]){
                childFenotypeB[index] = parents[0].fenotype[index]
            }
        }
        
        childs.append(ViewController.Individual(fenotype: childFenotypeA))
        childs.append(ViewController.Individual(fenotype: childFenotypeB))
        return childs
    }
}
