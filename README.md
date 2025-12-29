$\huge{\color{cadetblue} \text{Programming}} \space {\color{cadetblue} \text{Fundamentals}}$

<br/>

This repository contains old exams for the course ${\color{rosybrown}\text{Imperative}}$ ${\color{rosybrown}\text{Programming}}$ (IP) at the University of Groningen. In 2023, this course was merged with the course ${\color{rosybrown}\text{Program}}$ ${\color{rosybrown}\text{Correctness}}$ (PC) into the new course ${\color{rosybrown}\text{Programming}}$ ${\color{rosybrown}\text{Fundamentals}}$ (PF). This is why you will find exams for both courses in this repository. All exams were created by [dr. A. Meijster](https://www.rug.nl/staff/a.meijster/), and make for some good practice material.

For the C questions, the subfolders each hold one or more example solutions, a folder with test cases, and a file called *myprogram.c* which you can use to write and test your own solution. For the proof questions, both exam questions and answers are given in [Dafny](https://github.com/dafny-lang/dafny).  
  
Found this repository useful? Help out your (future) fellow students by mailing your exam paper to [me](mailto:pl3onasm@gmail.com) or sending a pull request. It's up to you to keep this repository up to date!

<br/>

----------------------------------

$\Large{\color{darkseagreen}\text{IP Finals}}$

||||
|:---:|:---:|:---:|
| **[2012](IP-Finals/2012)**| **[2013](IP-Finals/2013)**| **[2014](IP-Finals/2014)**|
| **[2015](IP-Finals/2015)**| **[2015 resit](IP-Finals/2015resit)**| **[2016](IP-Finals/2016)**|
| **[2017](IP-Finals/2017)**| **[2017 resit](IP-Finals/2017resit)**| **[2018](IP-Finals/2018)**|
| **[2018 resit](IP-Finals/2018resit)**| **[2019](IP-Finals/2019)**| **[2019 resit](IP-Finals/2019resit)**|
| **[2020](IP-Finals/2020)**| **[2021](IP-Finals/2021)**| **[2022](IP-Finals/2022)**|
||||

<br/>

$\Large{\color{darkseagreen}\text{IP Midterms}}$

||||
|:---:|:---:|:---:|
| **[2013](IP-Midterms/mid2013)**| **[2015](IP-Midterms/mid2015)**| **[2016](IP-Midterms/mid2016)**|
| **[2016 resit](IP-Midterms/mid2016resit)**| **[2017](IP-Midterms/mid2017)**| **[2017 resit](IP-Midterms/mid2017resit)**|
| **[2018](IP-Midterms/mid2018)** | **[2018 resit](IP-Midterms/mid2018resit)**|**[2019](IP-Midterms/mid2019)**|
|**[2019 resit](IP-Midterms/mid2019resit)**| **[2020](IP-Midterms/mid2020)**| **[2020 resit](IP-Midterms/mid2020resit)**|
| **[2021](IP-Midterms/mid2021)**| **[2021 resit](IP-Midterms/mid2021resit)**|**[2022](IP-Midterms/mid2022)**|
||||

<br/>

$\Large{\color{darkseagreen}\text{PF 1-3 exams}}$

||||
|:---:|:---:|:---:|
|**[2023](PF1-3/exam1-2023)**| **[2023 resit](PF1-3/resit1-2023)**| **[2024](PF1-3/exam1-2024)**|
|**[2025](PF1-3/exam1-2025)** | | |
||||

<br/>

$\Large{\color{darkseagreen}\text{PF 2-3 exams}}$

||||
|:---:|:---:|:---:|
|**[2023](PF2-3/exam2-2023)**| **[2023 resit](PF2-3/resit2-2023)** | **[2024](PF2-3/exam2-2024)**|
|**[2024 resit](PF2-3/resit2-2024)**| **[2025](PF2-3/exam2-2025)** |  |
||||

<br/>

$\Large{\color{darkseagreen}\text{PF 3-3 exams}}$

||||
|:---:|:---:|:---:|
|**[2024](PF3-3/exam3-2024)**| **[2024 resit](PF3-3/resit3-2024)** | **[2025](PF3-3/exam3-2025)**|
||||

<br/>

----------------------------------

$\Large{\color{cadetblue}\text{Testing}}$
<br/>

You can test your own C code with the [test script](ctest.sh). The script
compiles your program, runs it on all `.in` test cases, and compares the
output with the corresponding `.out` files.

By default you get a clean summary (PASS or FAIL per test case).

If a test fails, and you want to see the difference in expected and actual output, or you want to have extra Valgrind tests, you can use the following options:

- `--show-diff` or `-d` shows a small preview of the output differences for failed tests, including the first 5 lines of the expected output and the first 5 lines of your actual output (both indented under the test case).
- `--valgrind` or `-v` enables Valgrind checks (PASS or FAIL per test case).
- `--show-vg` or `-e` shows Valgrind error details for failed Valgrind checks.
- `--help` or `-h` prints the full usage message.

If you want to use this script, you basically have two options:  

<br/>

$\Large{\color{rosybrown}\text{1. Execution from script's}}$ $\Large{\color{rosybrown}\text{repo location}}$

Opening a terminal from the working directory containing your program, the solution, and the folder with the tests, run the below commands.  
First, make the script executable:

```shell
chmod +x ../../../ctest.sh
```

Then run the script by using the following command:

```shell
../../../ctest.sh myprogram.c
```

You can add options before the program file:

```shell
../../../ctest.sh --show-diff --valgrind myprogram.c
```

<br/>

$\Large{\color{rosybrown}\text{2. Execution from PATH}}$

Alternatively, you can add the script to your PATH variable and run it from anywhere. To display the current $PATH, run the following command:

```shell
echo $PATH
```

Then, copy the script to one of the folders in $PATH. If you have copied the script to the folder before, the command will simply overwrite the previous version. For example:

```shell
sudo cp ctest.sh /usr/bin/
```

Now you can run the script from the directory containing your program and the folder with test cases by using the following command:

```shell
ctest.sh myprogram.c
```

You may also choose to redirect the output to a file, in which case the script automatically disables ANSI colors to render a plain text file:

```shell
ctest.sh myprogram.c > results.txt
```

<br/>

----------------------------------

$\Large{\color{cadetblue}\text{Functions library}}$
<br/>

The folder [Functions](Functions) contains a small C utility library called `clib` comprising various helpers for arrays, strings, matrices, sorting, searching, etc. This library is intended to be used as a support library for the exercises in this repository.

It is easy to extend: you can add your own helpers under `Functions/src` and declare them under `Functions/include/clib`, rebuild the static library, and all programs in the repo can immediately use the new functionality while the core stays compact and maintainable.

The library is organized as:

- headers in `Functions/include/clib/`
- sources in `Functions/src/`
- build output in `Functions/build/`

You can include the full library with the umbrella header:

```c
#include "../../Functions/include/clib/clib.h"
```

Or include only what you need (for example just integers):

```c
#include "../../Functions/include/clib/integers.h"
```

Available headers include:  
`clib.h`, `integers.h`, `strings.h`, `sorting.h`, `searching.h`, `math.h`, `memory.h`, and `macros.h`.

The library is built as a static library via the [Makefile](Functions/Makefile) in the `Functions` folder. You can build it manually by running `make` in that folder. This will create the static library file `build/libclib.a`. However, when you use `ctest.sh`, and include a header from the library in your program, the script will automatically call the Makefile to build the library if it is not already built.

Some concrete examples of how to use the library can be found in the [Functions](Functions) and [Extra-C](Extra-C) folders.

<br/>

----------------------------------

$\Large{\color{cadetblue}\text{Notes}}$
<br/>

All commands were given with Ubuntu in mind. If you are using a different Linux distribution, you may need to change the commands accordingly.

The script was tested on Ubuntu 24.04 LTS, using GCC 14.2.0, and Valgrind 3.22.0.

If you want to compile and test your code manually, you can use the following commands:

```shell
gcc -O2 -std=c99 -pedantic -Wall -o a.out myprogram.c -lm
```  

```shell
valgrind --leak-check=full ./a.out < tests/1.in
```

<br/>

----------------------------------

$\Large{\color{cadetblue}\text{Output examples of the script}}$
<br/>

<table>
  <tr>
    <td valign="top"align="center">
      <a href="images/im01.png"><img src="images/im01.png" width="200" alt="im01"></a>
    </td>
    <td valign="top" align="center">
      <a href="images/im02.png"><img src="images/im02.png" width="200" alt="im02"></a>
    </td>
  </tr>
  <tr>
    <td valign="top" align="center">
      <a href="images/im03.png"><img src="images/im03.png" width="200" alt="im03"></a>
    </td>
    <td valign="top" align="center">
      <a href="images/im04.png"><img src="images/im04.png" width="200" alt="im04"></a>
    </td>
  </tr>
  <tr>
    <td valign="top"align="center">
      <a href="images/im05.png"><img src="images/im05.png" width="200" alt="im05"></a>
    </td>
    <td valign="top" align="center">
      <a href="images/im06.png"><img src="images/im06.png" width="200" alt="im06"></a>
    </td>
  </tr>
</table>
