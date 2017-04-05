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
        
        //        let num = 22
        //        let str = String(num, radix: 2)
        //        print(str)
        var child = [String](repeating:"",count:8);
        
        let child2 = [1,2,2,4,5,2,7,8];
        //        checkHits(child:child2)
        //        var number: Int = 0
        //        for (index) in 0..<child.count{
        //            let num = number
        //            var str = String(num,radix:2)
        //            str = pad(string: str, toSize: 3)
        //            child[index] = str
        //
        //            print(child[index])
        //            number += 1
        //        }
        //        var hits = [Int](repeating:0,count:8);
        //        hits = countHits(child: child2,  hits:hits)
        //        print(hits)
        //        print("\n")
        //        hits = countHitsDiagonal(child: child2, hits:hits)
        //        print(hits)
        //        print("\n")
        var boardElements = [[Int]](repeating: [Int] (repeating: 0,count:8), count:100)
        boardElements = initPopulation(board:boardElements)
        //
        //        print(boardElements.count)
        //        print(boardElements[0].count)
        
        for row in 0..<boardElements.count{
            var hits = [Int](repeating:0,count:8);
            hits = countHits(child: boardElements[row],  hits:hits)
            hits = countHitsDiagonal(child: boardElements[row],  hits:hits)
            //            print("Row: \(boardElements[row])")
            //            print("Hits: \(hits)")
            //        for child in 0..<boardElements[0].count{
            //            var hits = [Int](repeating:0,count:8);
            //            print(boardElements[row][child])
            //            }
            //            hits = countHitsDiagonal(boardElements[child], hits)
            //            hits = countHits(child: boardElements[child], hits:hits)
        }
        
        var parents = selectParents(population: boardElements)
        
        //        var genotype = [[String]](repeating: [String] (repeating: "",count:8), count:100)
        //        genotype = initPopulation(board: boardElements, genotype:genotype)
        //
        //
        //        var board = [[Int]](repeating: [Int] (repeating: 0,count:8), count:8)
        
        //                print(str) // prints "10110"
        var first = Individual(genotype: [""], fenotype: [1,1,5,5,3,3,0,0])
        
        print(first.fitness)
        
        
        
        var population:[Individual]  = [Individual(genotype: [""], fenotype: [1,1,5,5,3,3,0,0]), Individual(genotype: [""], fenotype: [1,2,2,4,5,2,7,8]), Individual(genotype: [""], fenotype: [1,3,5,2,7,4,8,6])];
        
        print(population)
        population.sort { $0.fitness < $1.fitness }
        print(population)
//        for index in 0..<100 {
//            genPopulation()
//        }
//        var possibleParents = [Individual]()
//        
//        possibleParents.sort { $0.fitness < $1.fitness }
    }
    
    
    func genPopulation(){
        
    }
    
    func initPopulation(board:[[Int]], genotype:[[String]]) -> [[String]]{
        var genotype = genotype
        for times in 0..<board.count{
            for index in 0..<board[0].count{
                //                let number: Int = Int(arc4random_uniform(8))
                var str = String(board[times][index],radix:2)
                str = pad(string: str, toSize: 3)
                genotype[times][index] = str
            }
            //            print(genotype[times]);
        }
        return genotype
    }
    
    func initPopulation(board:[[Int]]) -> [[Int]]{
        var board = board
        for times in 0..<board.count{
            for index in 0..<board[0].count{
                let number: Int = Int(arc4random_uniform(8))
                board[times][index] = number
            }
            //            print(board[times]);
        }
        return board
    }
    
    func selectParents(population:[[Int]])-> [[Int]]{
        var parents = [[Int]](repeating: [Int] (repeating: 0,count:8), count:5)
        var hits = [[Int]](repeating: [Int] (repeating: 0,count:8), count:5)
        
        for index in 0..<5{
            parents[index] = (population[Int(arc4random_uniform(100))])
            hits[index] = countHits(child: parents[index],  hits:hits[index])
            hits[index] = countHitsDiagonal(child: parents[index],  hits:hits[index])
        }
        
        var fitnessTable = Array<Int>()
        for item in 0..<parents.count {
            fitnessTable.append(calculateFitness(individual: hits[item]))
        }
//        print(fitnessTable)
        
        
        return parents
    }
    
    func calculateFitness(individual:[Int]) -> Int{
        var value = 0;
        for index in individual {
            value += individual[index]
        }
        return value
    }
    
    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.characters.count) {
            padded = "0" + padded
        }
        return padded
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
    
    
    struct Individual {
        var genotype: [String] = [String](repeatElement("", count: 8))
        var fenotype: [Int] = [Int](repeatElement(0, count: 8))
        var fitness: Int = 0
        
        
        
        init(genotype: [String], fenotype:[Int]) {
            self.genotype = genotype
            self.fenotype = fenotype
            self.fitness = calcFitness(fenotype:fenotype)
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
                var secondIndex = (index1+1)%8
                var x: Int = 0
                while(x < 8){
                    if(child[index1] == child[secondIndex] && (index1 != secondIndex)){
                        hits[index1] += 1
                    }
                    secondIndex = (secondIndex+1)%8
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
    
}
