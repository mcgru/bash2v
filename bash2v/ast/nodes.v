module ast

pub type Stmt = SimpleCommand | Pipeline | List | AssignmentStmt | Subshell | IfStmt | WhileStmt

pub struct Program {
pub:
    stmts []Stmt
}
