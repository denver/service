// Copyright 2017, The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
<<<<<<< HEAD
// license that can be found in the LICENSE.md file.

// +build !debug
=======
// license that can be found in the LICENSE file.

// +build !cmp_debug
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

package diff

var debug debugger

type debugger struct{}

func (debugger) Begin(_, _ int, f EqualFunc, _, _ *EditScript) EqualFunc {
	return f
}
func (debugger) Update() {}
func (debugger) Finish() {}
