## Instructions
* We’d like to be respectful of your time so don’t spend more than a few hours on this.
* Complete 3 out of the 4 assignments in any backend/scripting language of your choice (Ruby preferred).
* When you’re done, send an email with links to a public repo containing your solutions.

---
## Assignment #1: Password Check
Write a tool that can run on the commandline and tell you if a password is one of the 1,000 most commonly used passwords.  It should read the passwords from a file on the local file system.  Make sure to use the best data structures and algorithm you can think of.

Use this list of common passwords: https://github.com/DavidWittman/wpxmlrpcbrute/blob/master/wordlists/1000-most-common-passwords.txt

Running the program should look something like this:
```
$ checkpassword foo
#=> Not common password

$ checkpassword football
#=> Common password
```
---
## Assignment #2: Phone number parser
Given an array or list of strings containing phone numbers, create a function called parse_numbers that outputs the number’s country and phone number in E.164 format.  E.164 format is a universal format for phone numbers: `+{country_code}{phone_number}`.  Example: the American number `414-534-1207` would be represented as `+14145341207`.  You may use any tool, data structure, or library you find useful to complete the task.

A list of country codes can be found here: https://gist.github.com/jnankin/23162bd54d1017938a6ce6a366eee65f

Sanitize all strings for characters that are not E.164 compliant.  For numbers in the input that do not begin with a plus sign, if they are 10 digit numbers, consider them to be American and prepend a +1. If there are not 10 digit numbers, they can be assumed to be in E.164 format without the plus.

Bonus points for unit tests on the parsing logic.

```
# Example input:
4145341207
+14145341207
(414) 534-1207
497113804761
+27177123841

# Example output:
United States +14145341207
United States +14145341207
United States +14145341207
Germany +497113804761
South Africa +27177123841
```

## Assignment #3: Weather Client
Write a command-line tool that finds the live weather for a zip code.
```
$weather {zip code}
#=> {description} {max temp} degrees Kelvin

$weather 80202
#=> Cloudy 293 degrees Kelvin
```

## Assignment #4: FizzBuzz Protocol Server
Write a server that opens up a port, accepts a number then calculates and returns a valid FizzBuzz response.

Validating it should look something like this:

```
$telnet 0.0.0.0 5555
Trying 0.0.0.0...
Connected to 0.0.0.0.
Escape character is '^]'.
1 ← sent from command-line
1 ← response from server
2 ← etc...
2
3
Fizz
5
Buzz
10
Buzz
15
FizzBuzz
```