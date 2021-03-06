grammar Formula;
//antlr的分析器定义文件
//////////////////// lexer rules:
PLUS : '+'
;
MINUS : '-'
;
MULTIPLY : '*'
;
DIVIDE : '/'
;
LPAREN : '(' | '（'
;
RPAREN : ')' | '）'
;
EQ : '=='
;
NEQ : '!='
;
LT : '<'
;
LE : '<='
;
GT : '>'
;
GE : '>='
;
FALSE : 'FALSE' | 'false'
;
TRUE : 'TRUE' | 'true'
;
NULL : 'NULL' | 'null' | 'undefined'
;
COMMA : ',' | '，'
;
ID : [_A-Za-z][_A-Za-z0-9]*
;
INT : '0' | [1-9][0-9]*
;
DOUBLE : ('0' | [1-9][0-9]*)('.'[0-9]*)?
;
WS : [ \t\r\n]+ -> skip
;
String :   '"' (StringCharacter+)? '"' | '“' (StringCharacter+)? '”'
;
StringCharacter :  ~["“”\\] | EscapeSequence
;
EscapeSequence :   '\\' [btnfr"“”'\\] |  UnicodeEscape
;
UnicodeEscape :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
;
HexDigit :   [0-9a-fA-F]
;
//////////////////// parser rules:
formula : expr
;
// 运算符优先级按照js的风格来，具体参考（https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Operator_Precedence）
expr : 
INT # int                                               // 整数
| DOUBLE # double                                       // 浮点数
| String # str                                          // 字符串
| op=(TRUE | FALSE) # bool                              // 布尔值
| NULL # null                                           // 空值
| LPAREN expr RPAREN # parens                           // 括号
| ID LPAREN (expr (COMMA expr)*)? RPAREN # func         // 函数
| '[' (expr (COMMA expr)*)? ']' #list                   // 数组
| op=MINUS expr # unaryOperator                         // 一元运算符：负号(-)
| expr op=(MULTIPLY | DIVIDE) expr # mulDiv             // 乘除法
| expr op=(PLUS | MINUS) expr # plusMinus               // 加减法
| expr op=(EQ | NEQ | LT | LE | GT | GE) expr # compare // 比较符
| expr expr # error                                     // 错误
;
