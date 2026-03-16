func MkDir(dir string, perm os.FileMode) Pipe {
	return func(s *State) error {
		return os.Mkdir(s.Path(dir), perm)
	}
}
//Note the use of State.Path to turn the provided directory into a path relative to the pipe's current directory.

//This implements a trivial echo-like function:
func Echo(str string) Pipe {
        return TaskFunc(func(s *State) error {
                _, err := s.Stdout.Write([]byte(str))
                return err
        })
}

