//
//  ViewController.swift
//  Queen
//
//  Created by Layon Tavares on 04/04/17.
//  Copyright © 2017 br.ufpe.cin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //        var child = [String](repeating:"",count:8);
        //
        //        let child2 = [1,2,2,4,5,2,7,8];
        
        //        var population = [[Int]](repeating: [Int] (repeating: 0,count:8), count:100)
        
        
        
        //        for row in 0..<boardElements.count{
        //            var hits = [Int](repeating:0,count:8);
        //            hits = countHits(child: boardElements[row],  hits:hits)
        //            hits = countHitsDiagonal(child: boardElements[row],  hits:hits)
        //
        //        }
        
        //        var parents = selectParents(population: boardElements)
        
        //        var genotype = [[String]](repeating: [String] (repeating: "",count:8), count:100)
        //        genotype = initPopulation(board: boardElements, genotype:genotype)
        //
        //
        //        var board = [[Int]](repeating: [Int] (repeating: 0,count:8), count:8)
        
        //                print(str) // prints "10110"
        //        var first = Individual(fenotype: [0,0,4,4,2,2,0,0])
        
        //        print(first.fitness)
        //        var population:[Individual]  = [Individual(fenotype: [0,0,4,5,2,2,0,0]), Individual(fenotype: [1,2,0,4,5,2,7,6]), Individual(fenotype: [1,3,5,2,7,4,6,6])];
        var population: [Individual] = initPopulation(size:1000)
//        print(population, terminator:"\n\n")
        //        population.sort { $0.fitness < $1.fitness }
        //        print(population, terminator:"\n\n")
        
        var x = 0
        var genX = 1000000000
        var bestFitness = 1000000000
        while(population[population.count-1].fitness > 0 && x < 1000){
            var parents = selectParents2(population: population)
            //        print("These are parents: \(parents)", terminator:"\n\n")
            var childs = generateChilds(father1: parents[0], father2: parents[1])
            //        print("These are chidls \(childs)", terminator: "\n\n")
            
            population.append(childs[0])
            population.append(childs[1])
            population.append(childs[2])
            population.append(childs[3])
            population.sort{ $0.fitness > $1.fitness }
            population.remove(at: 0)
            population.remove(at: 1)
            population.remove(at: 2)
            population.remove(at: 3)
            if(bestFitness > population[population.count-1].fitness){
                bestFitness = population[population.count-1].fitness
                genX = x
            }
            //            print(population)
            population.shuffle()
            population.shuffle()
            population.shuffle()
            x += 1
        }
        
        
        population.sort{ $0.fitness > $1.fitness }
        print("This is the population: \(population)", terminator:"\n\n")
        var (report, ocurrences) = countOcurrences(population: population)
        print("These are the configurations: \(report)")
        print("These are how many times: \(ocurrences)", terminator:"\n\n")

        var (mean, variation) = meanAndStandardVariation(population: population)
        print(mean)
        print(variation)
        
        print("This genX is:\(genX) and the best fitness is:\(bestFitness)")
    }
    
    
    
    func genPopulation(){
        
    }
    
    func initPopulation(size: Int) -> [Individual]{
        var population:[Individual] = [Individual]()
        for times in 0..<size{
            var fenotype: [Int] = [Int]()
            for index in 0..<8{
                let number: Int = Int(arc4random_uniform(8))
                fenotype.append(number)
            }
            population.append(Individual(fenotype: fenotype))
            //            print(board[times]);
        }
        return population
    }
    
    //    func selectParents(population:[[Int]])-> [[Int]]{
    //        var parents = [[Int]](repeating: [Int] (repeating: 0,count:8), count:5)
    //        var hits = [[Int]](repeating: [Int] (repeating: 0,count:8), count:5)
    //
    //        for index in 0..<5{
    //            parents[index] = (population[Int(arc4random_uniform(100))])
    //            hits[index] = countHits(child: parents[index],  hits:hits[index])
    //            hits[index] = countHitsDiagonal(child: parents[index],  hits:hits[index])
    //        }
    //
    //        var fitnessTable = Array<Int>()
    //        for item in 0..<parents.count {
    //            fitnessTable.append(calculateFitness(individual: hits[item]))
    //        }
    //        //        print(fitnessTable)
    //
    //
    //        return parents
    //    }
    
    
    func meanAndStandardVariation(population: [Individual]) -> (Int, Double){
        var (mean, variation) = (0,0.0)
        
        for child in population {
            mean += child.fitness
        }
        mean /= population.count
        
        for child in population{
            let fitness = child.fitness
            let number = Decimal(fitness-mean)
            variation += (pow(Double(fitness-mean), 2))
        }
        variation /= Double(population.count-1)
        variation = (sqrt(Double(variation)))
        return (mean,variation)
        
    }
    
    func countOcurrences(population:[Individual]) -> ([Individual], [Int]){
        var report = [Individual]()
        var ocurrences = [Int]()
        var index = 0
        for child in population {
            
            if report.contains(where: {$0.genotype == child.genotype}) {
                index = report.index(where: {$0.genotype == child.genotype})!
                ocurrences[index] += 1
            } else {
                report.append(child)
                ocurrences.append(1)
            }
        }
        return (report, ocurrences)
    }
    
    func selectParents2(population:[Individual])-> [Individual]{
        var parents: [Individual] = [Individual]()
        for index in 0..<5{
            parents.append((population[Int(arc4random_uniform(100))]))
        }
        parents.sort { $0.fitness > $1.fitness }
        return [parents[3], parents[4]]
    }
    
    func calculateFitness(individual:[Int]) -> Int{
        var value = 0;
        for index in individual {
            value += individual[index]
        }
        return value
    }
    
    
    func board() -> [[Int]]{
        var board = [[Int]](repeating: [Int] (repeating: 0,count:8), count:8)
        //        print("Tabuleiro:")
        
        var number = 0
        for column in 0..<board.count{
            for row in 0..<board[0].count{
                board[column][row] = number
                number += 1
            }
            
        }
        return board
    }
    
    
    func countHits(child:[Int], hits:[Int]) -> [Int]{
        //        var hits: Int = 0;
        var hits = hits
        for index1 in 0..<child.count{
            var secondIndex = (index1+1)%8
            var x: Int = 0
            while(x < 8){
                if(child[index1] == child[secondIndex] && (index1 != secondIndex)){
                    hits[index1] += 1
                }
                secondIndex = (secondIndex+1)%8
                x += 1
            }
            //            print("Queen \(index1) got hits: \(hits)")
        }
        return hits
    }
    
    
    func countHitsDiagonal(child:[Int], hits:[Int]) ->[Int]{
        var hits = hits
        for index1 in 0..<child.count{
            var secondIndex = (index1+1)%8
            var x: Int = 0
            while(x < 8){
                //                print("\(child[index1]), \(child[secondIndex]), \(abs(child[index1]-index1)), \(abs(child[secondIndex]-secondIndex))\n")
                if(abs(child[index1]-child[secondIndex]) == abs(index1-secondIndex) && (index1 != secondIndex)){
                    hits[index1] += 1
                }
                secondIndex = (secondIndex+1)%8
                x += 1
            }
            //            print("Queen \(index1) got diagonal hits: \(hits)")
            
        }
        return hits
    }
    
    
    func checkHits (child:[Int]){
        var hits: Int = 0;
        for index in 0..<child.count-1{
            _ = (child[index+1])
            _ = index+1
            
            
            
            if( (child[index] - index) == (child[index+1]-(index+1))){
                hits += 1
            }
            
            
        }
        //        print(hits);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateChilds(father1: Individual, father2: Individual) -> [Individual]{
        var childs: [Individual]
        var fenotypes: [[Int]] = [[Int]]()
        fenotypes.append([father1.fenotype[0],father1.fenotype[1],father1.fenotype[2]])
        fenotypes.append([father2.fenotype[0],father2.fenotype[1],father2.fenotype[2]])
        for index in 3..<father1.fenotype.count {
            fenotypes[0].append(father2.fenotype[index])
            fenotypes[1].append(father1.fenotype[index])
        }
        
        var first = Individual(fenotype: fenotypes[0])
        var second = Individual(fenotype: fenotypes[1])
        var mutated1: Bool = false
        var mutated2: Bool = false
        var genotype1 = [[Character]]()
        var genotype2 = [[Character]]()
        var genotypeS1 = [String]()
        var genotypeS2 = [String]()
        for index in 0..<8 {
           genotype1.append(Array(first.genotype[index].characters))
            genotype2.append(Array(second.genotype[index].characters))
            genotypeS1.append(String(genotype1[index]))
            genotypeS2.append(String(genotype2[index]))
            var mutationProb: Int = Int(arc4random_uniform(100))
            if(mutationProb < 10){
                for genoIndex in 0...2{
                    
                    if (genotype1[index][genoIndex] == "0"){
                        genotype1[index][genoIndex] = "1"
                    }
                    else{
                        genotype1[index][genoIndex] = "0"
                    }
                }
                mutated1 = true
                genotypeS1[index] = (String(genotype1[index]))
            }
            mutationProb = Int(arc4random_uniform(100))
            if(mutationProb < 10){
                for genoIndex in 0...2{
                    
                    if (genotype2[index][genoIndex] == "0"){
                        genotype2[index][genoIndex] = "1"
                    }
                    else{
                        genotype2[index][genoIndex] = "0"
                    }
                }
            }
            mutated2 = true
            genotypeS2[index] = (String(genotype2[index]))
        }
        
        childs = [Individual(fenotype: fenotypes[0]), Individual(fenotype: fenotypes[1])]
//        if(mutated1){
            childs.append(childs[0].translateToDecimal(genoType: genotypeS1))
//        }
        
//        if(mutated2){
            childs.append(childs[1].translateToDecimal(genoType: genotypeS2))
//        }
        childs.sort { $0.fitness < $1.fitness }
        return childs
        
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString.characters)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    struct Individual {
        var genotype: [String] = [String](repeatElement("", count: 8))
        var fenotype: [Int] = [Int](repeatElement(0, count: 8))
        var fitness: Int = 0
        
        
        
        init(fenotype:[Int]) {
            self.fenotype = fenotype
            self.genotype = translateToBinary(fenotype: fenotype)
            self.fitness = calcFitness(fenotype:fenotype)
        }
        
        mutating func translateToDecimal(genoType:[String]) -> Individual{
            var fenoType = [Int](repeating:0,count:fenotype.count)
            
            for index in 0..<fenotype.count{
                let str = genoType[index]
                var num = Int(str,radix:2)
                fenoType[index] = num!
            }
            var individual = Individual(fenotype: fenoType)
            return individual
            
        }
        
        func translateToBinary(fenotype:[Int]) -> [String]{
            var genotype = [String](repeating:"",count:fenotype.count)
            
            for index in 0..<fenotype.count{
                let num = fenotype[index]
                var str = String(num,radix:2)
                str = pad(string: str, toSize: 3)
                genotype[index] = str
            }
            return genotype
        }
        
        func pad(string : String, toSize: Int) -> String {
            var padded = string
            for _ in 0..<(toSize - string.characters.count) {
                padded = "0" + padded
            }
            return padded
        }
        
        func calcFitness(fenotype: [Int])-> Int{
            var hits = [Int](repeating:0, count: 8)
            hits = countHits(child: fenotype, hits: hits)
            hits = countHitsDiagonal(child: fenotype, hits: hits)
            return hits.reduce(0, +)
        }
        
        func countHits(child:[Int], hits:[Int]) -> [Int]{
            //        var hits: Int = 0;
            var hits = hits
            for index1 in 0..<child.count{
                var secondIndex = (index1+1)%7
                var x: Int = 0
                while(x < 8){
                    if(child[index1] == child[secondIndex] && (index1 != secondIndex)){
                        hits[index1] += 1
                    }
                    secondIndex = (secondIndex+1)%7
                    x += 1
                }
            }
            return hits
        }
        
        
        func countHitsDiagonal(child:[Int], hits:[Int]) ->[Int]{
            var hits = hits
            for index1 in 0..<child.count{
                var secondIndex = (index1+1)%8
                var x: Int = 0
                while(x < 8){
                    if(abs(child[index1]-child[secondIndex]) == abs(index1-secondIndex) && (index1 != secondIndex)){
                        hits[index1] += 1
                    }
                    secondIndex = (secondIndex+1)%8
                    x += 1
                }
            }
            return hits
        }
    }
    
    
    
    
    //
    //        print(boardElements.count)
    //        print(boardElements[0].count)
    //            print("Row: \(boardElements[row])")
    //            print("Hits: \(hits)")
    //        for child in 0..<boardElements[0].count{
    //            var hits = [Int](repeating:0,count:8);
    //            print(boardElements[row][child])
    //            }
    //            hits = countHitsDiagonal(boardElements[child], hits)
    //            hits = countHits(child: boardElements[child], hits:hits)
    //        let num = 22
    //        let str = String(num, radix: 2)
    //        print(str)
    //        var hits = [Int](repeating:0,count:8);
    //        hits = countHits(child: child2,  hits:hits)
    //        print(hits)
    //        print("\n")
    //        hits = countHitsDiagonal(child: child2, hits:hits)
    //        print(hits)
    //        print("\n")
    
    //    func initPopulation(board:[[Int]], genotype:[[String]]) -> [[String]]{
    //        var genotype = genotype
    //        for times in 0..<board.count{
    //            for index in 0..<board[0].count{
    //                //                let number: Int = Int(arc4random_uniform(8))
    //                var str = String(board[times][index],radix:2)
    //                str = pad(string: str, toSize: 3)
    //                genotype[times][index] = str
    //            }
    //            //            print(genotype[times]);
    //        }
    //        return genotype
    //    }
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

