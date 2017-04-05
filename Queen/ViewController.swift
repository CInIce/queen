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
        
        let child2 = [1,2,7,4,5,6,7,8];
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
        var board = [[Int]](repeating: [Int] (repeating: 0,count:8), count:100)
        board = initPopulation(board:board)
        var genotype = [[String]](repeating: [String] (repeating: "",count:8), count:100)
        genotype = initPopulation(board: board, genotype:genotype)
        
        //                print(str) // prints "10110"
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
            print(genotype[times]);
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
            print(board[times]);
        }
        return board
    }
    
    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.characters.count) {
            padded = "0" + padded
        }
        return padded
    }
    
    
    func board(){
        var board = [[Int]](repeating: [Int] (repeating: 0,count:8), count:8)
        print("Tabuleiro:")
        
        var number = 0
        for column in 0..<board.count{
            for row in 0..<board[0].count{
                board[column][row] = number
                number += 1
            }
            
        }
        for (index) in board{
            print(index)
        }
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
        print(hits);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
