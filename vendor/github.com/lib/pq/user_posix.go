// Package pq is a pure Go Postgres driver for the database/sql package.

<<<<<<< HEAD
// +build darwin dragonfly freebsd linux nacl netbsd openbsd solaris rumprun
=======
// +build aix darwin dragonfly freebsd linux nacl netbsd openbsd plan9 solaris rumprun
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

package pq

import (
	"os"
	"os/user"
)

func userCurrent() (string, error) {
	u, err := user.Current()
	if err == nil {
		return u.Username, nil
	}

	name := os.Getenv("USER")
	if name != "" {
		return name, nil
	}

	return "", ErrCouldNotDetectUsername
}
