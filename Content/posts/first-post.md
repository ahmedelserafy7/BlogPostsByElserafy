---
date: 2021-09-18 11:30
description: Let's solve that challenge.
tags: Coding, Programming, Problem Solving
---
# Counting Minutes Explained

Have the function `CountingMinutes(str)` take the `str` parameter being passed which will be two times (each properly formatted with a colon and am or pm) separated by a hyphen and return the total number of minutes between the two times. The time will be in a 12 hour clock format. For example: if `str` is **9:00am-10:00am** then the output should be **60**. If `str` is **1:00pm-11:00am** the output should be **1320**.

## Solution

To solve this problem, you need to divide the problem into two parts:
- The first part is to convert hours to minutes.
- The second part is to calculate the difference between two times.

<h2>Let's dive into the first part</h2>

First things first, we'll create `convertHoursToMinutes(str:)` function to get number of minutes out of hours.

```swift

func convertHoursToMinutes(str: String) -> Int {
        
        let timeSplit = str.split(separator: ":")
        guard let hr = Int(timeSplit[0]) else { return 0 }
        
        let a = str.suffix(2)
        
        var min = 0
        if a == "am" {
           min = hr * 60
        } else {
            min = (12 * 60) + (hr * 60)
        }
        
        guard let restMins = Int(timeSplit[1].prefix(2)) else { return 0 }
        min += restMins
        
        return min
    }
    
    
```

So if the `str` is **10:00am**, it'll return **720** minutes, but if the `str` is **10:00pm**, it'll return **1320** minutes. You can also count the rest of minutes if the time is like **10:30am** or so.

But let's back to the code, and explain how I did that.

First off, you'll split the time into two sides: the left-most side representing **hours**, and the right side representing **minutes**. You can split them separately by a colon using `split` function.

To extract the **hours** side from `timeSplit` array, you can do that by the indexing into an array of strings.

**Note**: Don't forget to convert the `Substring` into `Int` to use it in the mathematical operation.

So if you have this time **[10:00am]**, it'll extract the hours side, and get **10**.

 With a 12-hour standard, you need to check out if the time is **am** or **pm**. To get the right-most side of the time, you can do that by calling `suffix` function, and return the last two characters from `timeSplit` array.

Now that it's time to compare if `a` is **am** or **pm**. If it's **am**, you'll multiply hours by **60** to convert it into minutes. If it's **pm**, you'll need to add midday which estimates 12 hours, and convert these hours into minutes.

To get the rest of minutes if exists. You'll find them at the first part of right side of `timeSplit` array, and add them to the converting hours to minutes.

Now that you converted the hours into minutes.

<h2>Let's go to the second part</h2>

 Back to the the main function `countingMinutes(str:)`. You have this string **10:00am-9:00pm** which expresses two different times, and you need to count the total minutes between them. So first split the two times individually by a hyphen/dash/minus using `split(separator:)` as well. extract the first time from `timesSplit` array, and convert this time from the `Substring` to `String`. By doing that you can use `convertHoursToMinutes(str:)` function to get the minutes from the first time, and the second time as well.

 Now that you need to check if the first time is less than the second one. If so, then get the difference between them by subtracting the first time from the second time. Otherwise the first time has more minutes than the second one, so you'll need to measure the whole day in minutes, and subtract the first time from the whole day to estimate how many minutes that remain in the day, and then add the next day which represents second time in minutes.


```swift

func countingMinutes(str: String) {

        let timesSplit = str.split(separator: "-")
        
        let firstTime = String(timesSplit[0])
        let secondTime = String(timesSplit[1])
        
        let firstTimeInMins = convertHoursToMinutes(str: firstTime)
        let secondTimeInMins = convertHoursToMinutes(str: secondTime)
        
        var minsCount = 0
        // Get the difference of minutes
        if firstTimeInMins < secondTimeInMins {
            minsCount = secondTimeInMins - firstTimeInMins
        } else {
            // Subtract the rest of the day
            minsCount = ((24 * 60) - (firstTimeInMins)) + secondTimeInMins
        }
        
        print(minsCount)
    }
```

<h2>Test cases</h2>

<hr><br>
<b>Input</b>: 10:00am-9:00pm.
<br><br>
<b>Explaination</b>: 10am gives you 600 minutes, and 9:00pm gives you 1260. So the second time has more minutes than the first one, so we'll return 1260 - 600 = 660.
<br><br>
<b>Output</b>: 660

<hr><br>
<b>Input</b>: 10:00pm-9:00pm. 
<br><br>
<b>Explaination</b>: 10:00pm gives you 1320 minutes, and 9:00pm gives you 1260. So the first time has more minutes than the second one, so we'll return (1440 - 1320) + 1260) = 120 + 1260 = 1380.
<br><br>
<b>Output</b>: 1380

<hr><br>
<b>Input</b>: 10:30pm-9:00am. 
<br><br>
<b>Explaination</b>: 10:30pm gives you 1350 minutes, and 9:00am gives you 540. So the first time has more minutes than the second one, so we'll return (1440 - 1350) + 540) = 90 + 540 = 630.
<br><br>
<b>Output</b>: 630
<hr>
