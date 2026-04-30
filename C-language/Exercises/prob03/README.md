$\huge\color{cadetblue}{\text{Maximum Path}}$

<br/>

Given is a triangle of numbers. A path through the triangle is a sequence of adjacent numbers, one from each row, starting from the top. For example, $1 \to 3 \to 3 \to 4 \to 1 \to 0$ is a path in the following triangle of numbers:  

$$
\begin{gather*}
\textcolor{orange}{\textbf{1}}\\  
\textcolor{orange}{\textbf{3}} \quad \textcolor{olive}{5}\\
\textcolor{olive}{6} \quad \textcolor{orange}{\textbf{3}} \quad \textcolor{olive}{2}\\
\textcolor{olive}{3} \quad \textcolor{olive}{1} \quad \textcolor{orange}{\textbf{4}} \quad \textcolor{olive}{9}\\
\textcolor{olive}{9} \quad \textcolor{olive}{8} \quad \textcolor{orange}{\textbf{1}} \quad \textcolor{olive}{5} \quad \textcolor{olive}{7}\\
\textcolor{olive}{4} \quad \textcolor{olive}{6} \quad \textcolor{orange}{\textbf{0}} \quad \textcolor{olive}{2} \quad \textcolor{olive}{8} \quad \textcolor{olive}{2}\\
\end{gather*}
$$

Your task is to find the maximum path cost, where the path cost is defined as the sum of the numbers in the path. Thus, the given example has a maximum path cost of $1 + 5 + 2 + 9 + 7 + 8 = 32$, as shown below:

$$
\begin{gather*}
\textcolor{orange}{\textbf{1}}\\
\textcolor{olive}{3} \quad \textcolor{orange}{\textbf{5}}\\
\textcolor{olive}{6} \quad \textcolor{olive}{3} \quad \textcolor{orange}{\textbf{2}}\\
\textcolor{olive}{3} \quad \textcolor{olive}{1} \quad \textcolor{olive}{4} \quad \textcolor{orange}{\textbf{9}}\\
\textcolor{olive}{9} \quad \textcolor{olive}{8} \quad \textcolor{olive}{1} \quad \textcolor{olive}{5} \quad \textcolor{orange}{\textbf{7}}\\
\textcolor{olive}{4} \quad \textcolor{olive}{6} \quad \textcolor{olive}{0} \quad \textcolor{olive}{2} \quad \textcolor{orange}{\textbf{8}} \quad \textcolor{olive}{2}\\
\end{gather*}
$$

Write a program that reads a triangle of numbers and outputs the maximum path cost. The first line of the input contains the number of rows. Each subsequent line represents a row of the triangle, starting with the top row. Within each row, the numbers are separated by a space. The triangle has at most 1000 rows. All numbers are positive integers between 0 and 100.

<br/>

$\Large\color{darkseagreen}{\text{Example}}$

Input:

```text
6
1
3 5
6 3 2
3 1 4 9
9 8 1 5 7
4 6 0 2 8 2
```

Output:

```text
32
```
