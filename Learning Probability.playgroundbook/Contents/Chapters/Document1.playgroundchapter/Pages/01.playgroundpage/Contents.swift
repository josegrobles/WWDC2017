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

func createDice(_ number: Int = 1) {
    proxy?.send(.integer(number))
}

func allowMovement() {
    proxy?.send(.boolean(true))
}

//#-end-hidden-code
/*:
Now that you've learnt the basics about Probability, let's apply it!
 
We have learnt what a Sample Space is, so let's recreate one!

An easy example of this is a Dice, a dice has a Probability space of six elements. Each one of them has the same posibility of appearing.
 
**1.** We are going to create a dice
 
**2.** We have to enable movement on the dice
 */

createDice(/*#-editable-code*/<#T##Number of dice##Int#>/*#-end-editable-code*/)
allowMovement()

/*:
Once you are ready, you can move to the **next page**
*/
