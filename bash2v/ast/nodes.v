module ast

pub type Stmt = SimpleCommand | Pipeline | List | AssignmentStmt | Subshell | IfStmt

pub struct Program {
pub:
    stmts []Stmt
}
