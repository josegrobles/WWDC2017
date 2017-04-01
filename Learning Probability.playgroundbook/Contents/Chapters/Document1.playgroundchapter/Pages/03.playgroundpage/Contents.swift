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

func newCard() {
    proxy?.send(.integer(0))
}

//#-end-hidden-code
/*:
In this third chapter we are going to learn about how some Events modify our probabilities while others doesn't affect us at all

**Example of Conditional Probability**

We have to extract a card from a deck and we have two events. Event A = **"Get a Figure"** and B = **"Get a King"**.
 
We apply Laplace-Bayes estimator to *Event A* and get P(A) = **12/40**
 
Later, we apply Laplace-Bayes estimator to *Event B* and get P(B) = **4/40**
 
Let's suppose that we know beforehand that the card we are going to get is a **Figure**. Then we have only 12 cards, and our probability has increased:
 
P(B knowing that A has happened) = **4/12**

**Example of Independence**

We have the same card deck than before. But we know 2 differentes events. Event A = **"Get a King"** and B = **"Get diamonds"**
 
If now we know beforehand that we are getting a diamond card, the probability of getting a King is the same as beforehand
P(A/B) = **1/10**
 
As probability hasn't changed, we say these two events are independent
 
**1.** Practise by running the code **as many times as you want** */

newCard()
