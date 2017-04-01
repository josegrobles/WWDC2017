//#-hidden-code
//
//  Contents.swift
//
//  Created by Jose Antonio Gonzalez Robles on 13/03/2017.
//  Copyright © 2017 Jose Antonio Gonzalez Robles. All rights reserved.
//


import PlaygroundSupport

let page = PlaygroundPage.current
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func calculate(_ number: Int) {
    proxy?.send(.integer(number))
}

//#-end-hidden-code
/*:
This second chapter is focused on proving equiprobability. A good way of proving it, is rolling a dice. 
 
The event of rolling a dice is equiprobable, that means that each face of the dice has the same probability of appearing.
 
To desmostrate this we are going to create a Random Normalized Distribution which shows perfectly how a dice works.
 

**1.** Enter the number of times you want to roll the dice. As we need a big sample, the minimum number needs to be 1000
*/

calculate(/*#-editable-code*/1500/*#-end-editable-code*/)

/*:
 Once you are ready, you can move to the **next page**
 */
