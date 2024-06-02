---
title: "A Linear Regression"
author: "Andre-Ignace Ghonda Lukoki"
date: "June 1st, 2024"
output:
  html_document:
    css: tufte.css
bibliography: resources/references.bib
csl: resources/apa.csl
nocite: '@*'
  
---
<link rel = "stylesheet" href = "tufte.css" >


<div class = "description">

The linear regression is one of the most fundamental techniques used in Econometrics. For this reason, I will explore computer algorithms that allow us to perform such regressions. The method that I will use to solve this optimization problem is the [Ordinary Least Squares](https://en.wikipedia.org/wiki/Ordinary_least_squares) (OLS) method.

</div>

## Introduction

A linear regression model is an equation of the following form<label for="sn-linear"
       class="margin-toggle sidenote-number"> </label> :
       
<input type="checkbox"
       id="sn-linear"
       class="margin-toggle"/>
<span class="sidenote">
I find [this video](https://youtu.be/YIfANKRmEu4?si=RVnUKshFZ6eB_iYD) by **Mutual Information** to be a nice introduction to linear regressions.
</span>

$$
\tag{1}
y = X \beta
$$

where the dependent variable $y$ is a vector of size $n$ , $\beta$ is a vector of coefficients and $X$ is a $n \times k$ matrix containing a column of $1$ and $k - 1$ columns of data.

$$
X = \begin{bmatrix}
1 & x_{11} & x_{12} & \ldots & x_{1k} \\
1 & x_{21} & x_{22} & \ldots & x_{2k} \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
1 & x_{n1} & x_{n2} & \ldots & x_{nk} \\
\end{bmatrix}
$$




---