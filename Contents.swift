//: Playground - noun: a place where people can play

import UIKit
// Hello world

// Write a function called "numberRange"
// Input: an array of integers
// Output: numerical range of the integers (difference between the biggest number and the smallest)

// [ 5, 8, -1, 3, -2, 4] -> 10

// [ -1, -3, -5 ] -> 

func numberRange(Array:[Int])->Int{
var mymax
var mymin=0
 for n in Array {
  if n>mymax{
  mymax=Array[i]
 }
 if n<mymin{
 mymin = Array[i]
}
return mymax - mymin
}
}
numberRange([5, 8, -1])


//Question 1
/*Create an enum with associated values for Currency.We will support four currencies: Euro, US Dollar, Indian Rupee, Mexican Peso. Each currency has three letter code (EUR, USD, INR, MXN), a symbol ("\u{20AC}", "\u{24}", "\u{20B9}", "\u{24}") and an exchange rate with respect to USD (0.8904, 1, 66.7, 18.88).*/
enum Currency:String{
    case USD,EUR,INR,MXN
    func rate()->Float{
        switch self {
        case .USD:return 1
        case .EUR:return 0.8904
        case .INR:return 66.7
        case .MXN:return 18.88
    }
    }
    func symbol()->String{
        switch self{
        case .USD:return "\u{24}"
        case .EUR:return "\u{20AC}"
        case .INR:return "\u{20B9}"
        case .MXN:return "\u{24}"
    }
        }
    
}



//Question 2

//Money struct
struct Money{
    let amount: Float
    let currency: Currency

    init(amount:Float,currency:Currency){
        self.amount=amount
        self.currency=currency
    }
   
//method +
static func +(left:Money, right:Money)->Money{
   var RghtAmount=right.amount
    if (left.currency != right.currency){
    RghtAmount=right.amount * left.currency.rate() / right.currency.rate()
    }
    
    return Money(amount: left.amount+right.amount, currency:left.currency)
}
//method -
static func -(left:Money, right:Money)->Money{
    var RghtAmount=right.amount
    if (left.currency != right.currency){
        RghtAmount=right.amount * left.currency.rate() / right.currency.rate()
    }
    return (Money(amount: left.amount-right.amount, currency:left.currency))
   
}
//description
    func description()-> String {
        
        return (currency.symbol()+String(amount)+"  "+currency.rawValue)
        
    }


}


let us=Money(amount: 23.98, currency: .USD)
let euro=Money(amount: 787.9, currency: Currency.EUR)
(us+euro).description()
    




////Question 3


import Foundation
extension String {
    
   
    subscript(i: Int) -> String {
        guard i >= 0 && i < characters.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(range: Range<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex))
    }
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex))
    }
    
  //method phoneFormat()
    func phoneFormat() -> String {
        let stringArray = self.components(separatedBy:CharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")
        let chars = newString.characters.suffix(10)
        if chars.count != 10 {
            return self
        }
        let last10 = String(chars)
        return last10[0...2] + "-" + last10[3...5] + "-" + last10[6...9]
        
   
}
    
}

"6195946191".phoneFormat()
"619 594 6191".phoneFormat()
"619 5946191".phoneFormat()
"619-594-6191".phoneFormat()




//Question:4

//phonetype enum
enum phonetype:String{
    case mobile
    case home
    case work
    case main
    case homefax
    case workfax
    case pager
    case other
}

//PhoneNumber struct
struct PhoneNumber {
    var number = String()
    var type: phonetype = phonetype.home
    
 //accepts only phonetype home
    init(phnNumber: String){
        self.init(phnNumber: phnNumber.phoneFormat(), numbertype: phonetype.home);
    }
    
//accepts only phonetype and phone number
    init(phnNumber: String, numbertype: phonetype){
        number = phnNumber.phoneFormat()
        type = numbertype
    }
    
  //isMobile() method
    func isMobile() -> Bool{
        return self.type.rawValue == phonetype.mobile.rawValue
    }
    
   //isLocal() method
    func isLocal() -> Bool{
        return self.number[0...2] == "619" || self.number[0...2] == "858"
    }

//description method
    var description:String {
        get{
            return String(type.rawValue + ": " + number)
        }
    }
    
}

var a = PhoneNumber(phnNumber: "7899717222")
a.type

var b = PhoneNumber(phnNumber: "6459879988", numbertype: .mobile)
b.type
b.isMobile()
a.isMobile()

var areacode = PhoneNumber(phnNumber: "858-123-8767", numbertype: .work)

areacode.isLocal()
b.isLocal()
a.isLocal()

a.description
b.description
areacode.description





//Question 5

extension String{
   //asPhoneNumber() method declaration
    func asPhoneNumber() -> PhoneNumber?{
        let enteredNumber = self
     
        if !enteredNumber.contains(":")
        {
            return nil
        }
        
        var strArr = enteredNumber.components(separatedBy: ":")
        var type:phonetype
        //enum phonetype check
        switch strArr[0].lowercased(){
        case "mobile":
            type = phonetype.mobile
        case "home":
            type = phonetype.home
        case "work":
            type = phonetype.work
        case "main":
            type = phonetype.main
        case "homefax":
            type = phonetype.homefax
        case "workfax":
            type = phonetype.workfax
        case "pager":
            type = phonetype.pager
        default:
            type = phonetype.other
        }
        return PhoneNumber(phnNumber: strArr[1], numbertype: type)
    }
    
}


"home:567-677-6786".asPhoneNumber()!.type
"mobile: 6776779087".asPhoneNumber()!.number
"main  8778879087".asPhoneNumber()





//Question :6

/*Create a Name structure.A name has two parts a firstname (also called a given name or personal name) and a last name (family or surname). The Name structure should implement the Comparable protocol.*/

enum Compare: Int {
    case Greater = 1
    case lesser = -1
    case equal = 0
}

precedencegroup ComparisonPrecedence {
    higherThan: LogicalConjunctionPrecedence
}
infix operator <=> : ComparisonPrecedence
protocol Combined: Comparable, Equatable {
    static func <=>(lhs: Self, rhs: Self) -> Compare
}

func <<T: Combined>(lhs: T, rhs: T) -> Bool {
    return (lhs <=> rhs) == .Greater
}

func ==<T: Combined>(lhs: T, rhs: T) -> Bool {
    return (lhs <=> rhs) == .equal
}

//Name structure

struct Name: Combined{
    let firstname:String
    let lastname:String
}

func <=>(lhs: Name, rhs: Name) -> Compare {
    if (lhs.firstname < rhs.firstname) || (lhs.lastname < rhs.lastname){
        return .Greater
    } else if (lhs.firstname > rhs.firstname) || (lhs.lastname > rhs.lastname) {
        return .lesser
    } else {
        return .equal
    }
}


let aname = Name(firstname: "anna",lastname: "abba")
let bname = Name(firstname: "annaa",lastname:"abba")

aname == bname




//Question 7


//with class Person

class Person{
    //A Person has a firstname,last(orfamily) name and 0 or more phone numbers.
    var firstName: String
    var lastName: String
    var personalNumber: [PhoneNumber?] = []
    
  
    init(frstname: String, lstname: String){
        firstName = frstname
        lastName = lstname
    }
    
    
    init(frstname: String, lstname: String, phoneNumber: PhoneNumber){
        firstName = frstname
        lastName = lstname
        personalNumber.append(phoneNumber)
    }
    
   //adds a string with default type home addPhoneNumber method
    func addPhoneNumber(number: String, type: phonetype = .home){
        if !hasNumber(phoneNumber: number){
            personalNumber.append(PhoneNumber(phnNumber: number, numbertype: type))
        }
    }
    

    func addPhoneNumber(number: PhoneNumber){
        if !hasNumber(phoneNumber: number.number){
            personalNumber.append(PhoneNumber(phnNumber: number.number, numbertype: number.type))
        }
    }

  // phoneNumber method Returns the person's phone number of the given type. Or nil if number does not exist.
   
  
    func phoneNumber(type: phonetype) -> PhoneNumber?{
        for number in personalNumber
        {
            if number!.type.rawValue == type.rawValue{
                return number
            }
        }
        return nil
    }
    
    // hasNumber method Returns true if person has given phoneNumber.
    func hasNumber(phoneNumber: String) -> Bool{
        for contact in personalNumber
        {
            if contact!.number == phoneNumber.phoneFormat(){
                return true
            }
        }
        return false
    }
    
}


var hello = Person(frstname:"hello", lstname: "world")
hello.addPhoneNumber(number: "9378882222")
hello.phoneNumber(type:.home)
hello.hasNumber(phoneNumber:"9378882222")
hello.hasNumber(phoneNumber:"9898766667")





// Question 8


//Class Contact:ist
class ContactList{
    var contacts: [Person] = []
    
   // addPerson method Add a Person object to the list.
    func addPerson(person: Person){
        if !exist(person: person){
            contacts.append(person)
        }
    }
    
    func exist(person: Person) -> Bool{
        for i in contacts{
            return (i.firstName == person.firstName) &&
            (i.lastName == person.lastName)
        }
        return false
    }
    
// orderedByName method Returns an Array of all your contacts ordered by last name.
    func orderByName() -> [Person]{
        let sortedName = contacts.sorted(by: {$0.lastName < $1.lastName})
        return sortedName
    }
    
  //  phoneNumberFor method Given the lastName return phone numbers for the first person in the list that has that last name. Return nil if no such person exists.
    func phoneNumberFor(lastname: String) -> [PhoneNumber?]
    {
        var theirNumber: [PhoneNumber?] = []
        for contact in contacts
        {
            if contact.lastName == lastname{
                theirNumber = contact.personalNumber
            }
        }
        return theirNumber
    }
 //   nameForNumber method Return the person with the given phone number. Return nil if no one has the phone number.
    
    func nameForNumber(phoneNumber: String) -> Person?
    {
        for contact in contacts
        {
            for number in contact.personalNumber{
                if number?.number == phoneNumber{
                    return contact
                }
            }
        }
        return nil
    }
}


var Contact = ContactList()
var Vineela = Person(frstname: "vineela", lstname: "pentela")
Vineela.addPhoneNumber(number: "9542785830")
var deepu_phone = PhoneNumber(phnNumber: "9440345688", numbertype: .home)
var deepu = Person(frstname: "deepu", lstname: "elur", phoneNumber: deepu_phone)
var amma = Person(frstname: "amma", lstname: "nanna")
amma.addPhoneNumber(number: "9990009999" )

Contact.addPerson(person: Vineela)
Contact.addPerson(person: deepu)
Contact.addPerson(person: amma)
Contact.contacts
Contact.addPerson(person: Vineela)

var name4number4 = Contact.nameForNumber(phoneNumber: "999-000-9999")?.firstName
Contact.phoneNumberFor(lastname: "elur")
Contact.orderByName()

amma.addPhoneNumber(number: "8593167543")
amma .addPhoneNumber(number: "9440250118")
Contact.phoneNumberFor(lastname: "nanna")























