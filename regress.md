---
title: "A Simple Regression"
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

A simple linear regression algorithm is a computer program able to estimate a model that looks as follows:

$$
\tag{1}
y_{i} = \alpha + \beta x_{i} + \epsilon_{i}
$$

The model includes a vector of dependent variables $y_{i}$, a vector of predictors $x_{i}$, and a is a vector of residuals $\epsilon_{i}$. The linear regression is an attempt at estimating a linear relation between the two variables. 
<label for="sn-linear"
       class="margin-toggle sidenote-number"> </label> 
       
<input type="checkbox"
       id="sn-linear"
       class="margin-toggle"/>
<span class="sidenote">
I find [this video](https://youtu.be/YIfANKRmEu4?si=RVnUKshFZ6eB_iYD) by **Mutual Information** to be a nice introduction to linear regressions.
</span>




---