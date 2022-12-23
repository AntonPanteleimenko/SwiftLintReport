# SwiftLint

  A tool to enforce Swift style and conventions, loosely based on the now archived [GitHub Swift Style Guide](https://github.com/github/swift-style-guide). SwiftLint enforces the style guide rules that are generally accepted by the Swift community. These rules are well described in popular style guides like [Ray Wenderlich's Swift Style Guide](https://github.com/kodecocodes/swift-style-guide). You can find more information in a [presentation](https://docs.google.com/presentation/d/1fvJgOqR65sm7uJDvW5dNfY2m0qpHcjg7/edit?usp=sharing&ouid=103572584375496531035&rtpof=true&sd=true) and [video](https://chiswdevelopment.sharepoint.com/:v:/s/CHIdocuments/Ef8WwWCaeBBIo6R-z_-0IXIBp-0c3w3W8w9DUXRFCcKNVg?e=oaSGFh).
  
  ## Getting Started
  ### Linters

  Lint, or a linter, is a static code analysis tool used to flag programming errors, bugs, stylistic errors and suspicious constructs. The term originates from a Unix utility that examined C language source code.
The analysis performed by lint-like tools can also be performed by an optimizing compiler, which aims to generate faster code. In his original 1978 paper, Johnson addressed this issue, concluding that "the general notion of having two programs is a good one" because they concentrate on different things, thereby allowing the programmer to "concentrate at one stage of the programming process solely on the algorithms, data structures, and correctness of the program, and then later retrofit, with the aid of lint, the desirable properties of universality and portability".

![](https://imgs.xkcd.com/comics/third_way.png)

  Even though modern compilers have evolved to include many of lint's historical functions, lint-like tools have also evolved to detect an even wider variety of suspicious constructs. These include "warnings about syntax errors, uses of undeclared variables, calls to deprecated functions, spacing and formatting conventions, misuse of scope, implicit fallthrough in switch statements, missing license headers, [and]...dangerous language features".

  Lint-like tools are especially useful for dynamically typed languages like JavaScript and Python. Because the compilers of such languages typically do not enforce as many and as strict rules prior to execution, linter tools can also be used as simple debuggers for finding common errors (e.g. syntactic discrepancies) as well as hard-to-find errors such as heisenbugs (drawing attention to suspicious code as "possible errors"). Lint-like tools generally perform static analysis of source code.

  Lint-like tools have also been developed for other aspects of language, including grammar and style guides.[citation needed]
  
 ### Code standardizing

  Lint Tools vs Static Analysis Tools
  Lint tools fall into the static analysis category. They’re typically the most basic form of static analysis tool.
Static analysis tools are any tools that analyze source code without the need to run it. More advanced static analysis tools deeply analyze both code execution and data flow for faults that may lead to a field failure. The most advanced tools will also link information across multiple translation units. You can even use cross-module analysis to determine higher-level problems.

### How do Linters work

  Abstract Syntax Tree
  The Abstract Syntax Tree (or AST for short) represents the code in a tree structure. This tree is built based on the syntax rules of the language and the tokenization of the code. The tokens are the small pieces that form the code. For example; a variable name is a token, a string, a keyword like def or function, even a symbol can be a token—like { or ;.
  Let’s see a simple example:
```Ruby
const num = 10;
```
This code is represented by the following AST (following exactly the same structure as the library below for consistency):

![](https://lh3.googleusercontent.com/9miH7T0VDK4FCezLt4YbBrSMTcMv9w02RmetYsZvXsLVmVHLLqW0bO26arMszSIigs4HsYIT64cbImZMko6RLyAA4m0kfgPt8IgaLttgp6XiHAWdqd1laAeFH-wIoyRiBE45GSH8)

  The act of creating the AST from the source code is called parsing. This sentence means that given the AST that Espree created, ESLint checks whether the rules are being followed. Let’s give an example: ”no-var”: “error”.
As you can see, the object with VariableDeclaration has a property called kind, which before was const and now it’s var. Therefore, to find out whether the code follows the rule, we need to visit all the nodes with the type VariableDeclaration and check the value of the kind attribute.

### Linters vs formatters

![image](https://user-images.githubusercontent.com/71629936/209360282-3b788c8b-077c-4509-94e7-cb73996fd80e.png)

  Linting is the act of analyzing your code to determine if that code is potentially flawed in some way. Another way to think about linting is that the intent is to flag code smells. Therefore, the nature of the insights that linters provide typically requires human intervention. Some linters do provide some automatic fixing functionality, but like mentioned above, we should focus on using a linter for its intended purpose to get the most out of the tool.
  Formatting
  Where linting typically focuses on the behavior of your code, formatting focuses on your code’s style. At first glance, formatting may seem unimportant, but formatting helps keep a code base consistent so that the code is more easily read and understood. Think about where you store your utensils. If they were all mixed together, you would have to think slightly harder to find something. Now extend that to two drawers with the same items. Let’s say this time they were organized, but laid out differently, you would have to first reorient yourself when searching for things between drawers before going about finding what you want. This may not amount to a lot of time, but there is still mental overhead required and we have a finite amount of that! Think about all the different areas of a code base. If they were styled differently, you will have a harder time reading and understanding the code, and that would likely take a mental toll on you without you even realizing it.

### SwiftLint Installation

  Using Homebrew:
```Ruby
brew install swiftlint
```

  Using CocoaPods:
  Simply add the following line to your Podfile:
```Ruby
pod 'SwiftLint'
```

  This will download the SwiftLint binaries and dependencies in Pods/ during your next pod install execution and will allow you to invoke it via ${PODS_ROOT}/SwiftLint/swiftlint in your Script Build Phases. This is the recommended way to install a specific version of SwiftLint since it supports installing a pinned version rather than simply the latest (which is the case with Homebrew). Note that this will add the SwiftLint binaries, its dependencies' binaries, and the Swift binary library distribution to the Pods/ directory, so checking in this directory to SCM such as git is discouraged.

### Xcode
  Integrate SwiftLint into your Xcode project to get warnings and errors displayed in the issue navigator.
To do this select the project in the file navigator, then select the primary app target, and go to Build Phases. Click the + and select "New Run Script Phase". Insert the following as the script:

![image](https://raw.githubusercontent.com/realm/SwiftLint/main/assets/runscript.png)

  If you installed SwiftLint via Homebrew on Apple Silicon, you might experience this warning:

```Ruby
warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint
```

  That is because Homebrew on Apple Silicon installs the binaries into the /opt/homebrew/bin folder by default. To instruct Xcode where to find SwiftLint, you can either add /opt/homebrew/bin to the PATH environment variable in your build phase

```Ruby
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

or you can create a symbolic link in /usr/local/bin pointing to the actual binary:
```Ruby
ln -s /opt/homebrew/bin/swiftlint /usr/local/bin/swiftlint
```

  You might want to move your SwiftLint phase directly before the 'Compile Sources' step to detect errors quickly before compiling. However, SwiftLint is designed to run on valid Swift code that cleanly completes the compiler's parsing stage. So running SwiftLint before 'Compile Sources' might yield some incorrect results. If you wish to fix violations as well, your script could run swiftlint --fix && swiftlint instead of just swiftlint. This will mean that all correctable violations are fixed while ensuring warnings show up in your project for remaining violations. If you've installed SwiftLint via CocoaPods the script should look like this:

```Ruby
"${PODS_ROOT}/SwiftLint/swiftlint"
```

### Configuration file, the heart of SwiftLint tuning
  In the configuration, file you can add, disable or update the linting rules. You can see a sample of this file’s structure at below:

![image](https://user-images.githubusercontent.com/33256980/35111101-bac65500-fc7a-11e7-8c5c-1643fec8ef20.png)

Some rules are enabled by default. you can disable them in disabled_rules section of your configuration file. There are some other rules which are not activated by default, but you can activate them by adding to opt_in_rules section. To find out about all available rules briefly, type lint rules in the command line (Terminal).

1 — Exclude the code you don’t want to lint
Some codes in your project can be added by third-party libraries that should be skipped in the linting process. In addition, you may borrow some code from an old code base that you don’t want to lint it.

2 — Correct some linting issues automatically!
There is a built-in feature in SwiftLint by which can correct some type of violations automatically. 

3 — Find rules which are not followed currently
In the next step, we’re going to find out which rules are not followed in your project. To see violated rules run the swiftlint lint by command line in your project directory.

4 — Decide about disabled rules
At this stage, you have a list of rules which are violated based on SwiftLint default rules and couldn’t be corrected automatically. When you remove them from your disabled list, you can see the warnings in Xcode.

  SwiftLint Custom Rules
  We can add any rule to SwiftLint as per our needs in YML file which will be enforced at build time for the developers. You can refer [Custom Rules](https://github.com/realm/SwiftLint#defining-custom-rules) to get more details. In this story I am going to help you with some rules which I’ve added in our projects and you can use as is OR modify as per your needs.

1. TODO — If there is a TODO declaration in project then that must have git/JIRA link attached to it
2. Multiple Empty Lines — Code File must not have multiple empty lines (It supports Auto Correct)
3. Weak Delegate / DataSource — To prevent retain cycles, delegates & datasources must be declared as weak variables
4. Fatal Errors — Code must not have reference to fatal error calls
5. SwiftLint File Disable — Developers should not be allowed to disable any Swift File lint
6. Try inside Do/Catch — try call must always be in do/catch block
7. Weak Self in Closures — To prevent retain cycle, Closure refering to self, must declare them as weak
8. String Literal — Strings should always be referred from Localization File
9. Protocol Conformance in Extension — Protocol conformance should be declared in separate extensions in the same file
10. UIKit in Model / ViewModel / DataSource — There should be no import of UIKit in these files
11. Public UIModel — UIModel classes must be public
12. Non-Public DataModel & DataSource — DataModel & DataSource must be non-public

Eamples:
```Ruby
custom_todo:
  included: ".*.swift"
  name: "TODO Violation"
  regex: "(TODO).(?!.*(https&)).(?!.*issues)"
  match_kinds: comment
  message: "TODOs must include a link to the github issue."
  severity: warning
multiple_empty_lines:
  included: ".*.swift"
  name: "Multiple Empty Lines"
  regex: '((?:\s*\n){3,})'
  message: "There are too many line breaks"
  severity: error
```

## Useful Links

[SwiftLint](https://github.com/realm/SwiftLint)

[SwiftLint – Getting Started](https://www.swiftlyrush.com/swiftlint-getting-started/)

[A tool to enforce Swift style and conventions](https://swiftpackageindex.com/realm/SwiftLint)

[SwiftLint iOS Handbook](https://infinum.com/handbook/ios/tools/swiftlint)

Now go on and use this powerful tool in your App 💪

## Developed By

* Panteleimenko Anton, CHI Software
* Kosyi Vlad, CHI Software

## License

Copyright 2020 CHI Software.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


