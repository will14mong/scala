#!/bin/sh
exec scala "$0" "$@"
!#

// Optional value, can be of two forms.
// - Some(x) where x is the actual value, or
// - None object, which represent missing value.

val capitals = Map("France" -> "Paris", "Japan" -> "Tokyo")
println(capitals get "France")
println(capitals get "North Pole")

// common way to take optional values apart is through a pattern match

def show(x: Option[String]) = x match {
  case Some(s) => s
  case None => "?"
}

// this will return "Japan"
println(show(capitals get "Japan"))

// this will return "France"
println(show(capitals get "France"))

// this will return "?"
println(show(capitals get "North Pole"))
