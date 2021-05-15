// Copyright 2017, The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
<<<<<<< HEAD
// license that can be found in the LICENSE.md file.

// Package function identifies function types.
package function

import "reflect"
=======
// license that can be found in the LICENSE file.

// Package function provides functionality for identifying function types.
package function

import (
	"reflect"
	"regexp"
	"runtime"
	"strings"
)
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

type funcType int

const (
	_ funcType = iota

<<<<<<< HEAD
	ttbFunc // func(T, T) bool
	tibFunc // func(T, I) bool
	trFunc  // func(T) R

	Equal           = ttbFunc // func(T, T) bool
	EqualAssignable = tibFunc // func(T, I) bool; encapsulates func(T, T) bool
	Transformer     = trFunc  // func(T) R
	ValueFilter     = ttbFunc // func(T, T) bool
	Less            = ttbFunc // func(T, T) bool
=======
	tbFunc  // func(T) bool
	ttbFunc // func(T, T) bool
	trbFunc // func(T, R) bool
	tibFunc // func(T, I) bool
	trFunc  // func(T) R

	Equal             = ttbFunc // func(T, T) bool
	EqualAssignable   = tibFunc // func(T, I) bool; encapsulates func(T, T) bool
	Transformer       = trFunc  // func(T) R
	ValueFilter       = ttbFunc // func(T, T) bool
	Less              = ttbFunc // func(T, T) bool
	ValuePredicate    = tbFunc  // func(T) bool
	KeyValuePredicate = trbFunc // func(T, R) bool
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
)

var boolType = reflect.TypeOf(true)

// IsType reports whether the reflect.Type is of the specified function type.
func IsType(t reflect.Type, ft funcType) bool {
	if t == nil || t.Kind() != reflect.Func || t.IsVariadic() {
		return false
	}
	ni, no := t.NumIn(), t.NumOut()
	switch ft {
<<<<<<< HEAD
=======
	case tbFunc: // func(T) bool
		if ni == 1 && no == 1 && t.Out(0) == boolType {
			return true
		}
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
	case ttbFunc: // func(T, T) bool
		if ni == 2 && no == 1 && t.In(0) == t.In(1) && t.Out(0) == boolType {
			return true
		}
<<<<<<< HEAD
=======
	case trbFunc: // func(T, R) bool
		if ni == 2 && no == 1 && t.Out(0) == boolType {
			return true
		}
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
	case tibFunc: // func(T, I) bool
		if ni == 2 && no == 1 && t.In(0).AssignableTo(t.In(1)) && t.Out(0) == boolType {
			return true
		}
	case trFunc: // func(T) R
		if ni == 1 && no == 1 {
			return true
		}
	}
	return false
}
<<<<<<< HEAD
=======

var lastIdentRx = regexp.MustCompile(`[_\p{L}][_\p{L}\p{N}]*$`)

// NameOf returns the name of the function value.
func NameOf(v reflect.Value) string {
	fnc := runtime.FuncForPC(v.Pointer())
	if fnc == nil {
		return "<unknown>"
	}
	fullName := fnc.Name() // e.g., "long/path/name/mypkg.(*MyType).(long/path/name/mypkg.myMethod)-fm"

	// Method closures have a "-fm" suffix.
	fullName = strings.TrimSuffix(fullName, "-fm")

	var name string
	for len(fullName) > 0 {
		inParen := strings.HasSuffix(fullName, ")")
		fullName = strings.TrimSuffix(fullName, ")")

		s := lastIdentRx.FindString(fullName)
		if s == "" {
			break
		}
		name = s + "." + name
		fullName = strings.TrimSuffix(fullName, s)

		if i := strings.LastIndexByte(fullName, '('); inParen && i >= 0 {
			fullName = fullName[:i]
		}
		fullName = strings.TrimSuffix(fullName, ".")
	}
	return strings.TrimSuffix(name, ".")
}
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
