## 8/15 Slide Puzzle
The [15 Puzzle](https://en.wikipedia.org/wiki/15_puzzle) was a popular board game invented more than a century ago. Yes, those times when we did not have the internet. I used to play it a lot, and loved the challenge and the perceived simplicity.

So sure enough it raised the question, can I write an algorithm to solve any valid board in the least amount of moves, and find the solution fast enough to run in a browser? 

I took on the challenge and implemented a modified version of the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm), that uses a heuristic based on the [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) of each title to its final position.
It works pretty fast for 3x3 and 4x4 boards. It solves most of the boards in less than a second. Any board larger than that and you will need a much faster computer than your regular laptop.

The rest of the project was just building a Flutter app around this idea, and the hackathon came at the right time.
I used **Visual Studio Code** to develop the app, and deployed the game on 3 platforms, **Web**, **iOS**, and **Android**.
I really enjoyed building some alternate themes to pick for the board.
Use **Auto Play** to let the computer play for you, and just sit back and enjoy the zen.

I took inspiration from the great sample app provided by the guys at **Very Good Ventures**, especially theming, state management, and keyboard support. Great work guys.

So why not take if for a spin, and let me know what you think.
Try it on web: [https://babaosoftware.app/slidepuzzle](https://babaosoftware.app/slidepuzzle)
iPhone or iPad: [https://apps.apple.com/us/app/id1610901038](https://apps.apple.com/us/app/id1610901038)
Android device: [https://play.google.com/store/apps/details?id=com.babaosoftware.slidepuzzle](https://play.google.com/store/apps/details?id=com.babaosoftware.slidepuzzle)
You can find the entire source code here: [https://github.com/babaosoftware/slidepuzzle](https://github.com/babaosoftware/slidepuzzle)
