# Coronope ( Corona? Just Nope. ) 🙅🙅
Coronope is an iOS based application that display current COVID-19 cases statistics locally ( Indonesia ), and news related to the pandemic.

## Corona Virus Tracker and News
+ consist of live data of confirmed, recovered, treated and deaths cases of COVID-19 in Indonesia
+ consist of news list about the current outbreak

## Architecture
+ View : Display what it is told to by the Presenter and relays user input back to the Presenter.
+ Interactor : Contains the business logic as specified by a use case.
+ Presenter : Contains view logic for preparing content for display ( received from the Interactor ) and for reacting to events ( by requesting new data from the Interactor ).
+ Entity : Basic model objects used by the Interactor. 
+ Router : Control navigation between screens ( I don't use a router layer since this is a simple app and thus don't require any navigation )

## Contributing
Pull requests are welcome. :D

## Frameworks Used
+ Alamofire 
+ Realm 
+ Combine 

## Demo
![](demo.gif)

## License

MIT License
Copyright © 2020 Coronope

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
