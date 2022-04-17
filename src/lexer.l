%option noyywrap

%{
    /*
    * You will need to comment this line in lab5.
    */
    #define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    struct IDtable{
        char names[200];
        int place;

    };

    #else
    #define YYSTYPE void *
    #include "parser.h"
    #endif
    int yyplace=0;
    int IDnum=0;//ID数
    int ID0=0;//标记作用域
    int ID1=0;
    IDtable maps[200];
    int l_scope=0;//左括号数量
    int r_scope=0;//右括号数量


    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>
    

    #ifdef ONLY_FOR_LEX
    #include <ostream>
    #include <fstream>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;
    

    void DEBUG_FOR_LAB4(std::string s){
        
        std::string DEBUG_INFO =  s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }

    int pointer_strlen(const char* str)//计算char字符数组长度
    {
	   const char *user_str=str;
	   if (NULL==str)
	   {
		 return 0;
	   }
	   while(*user_str++)
	   {
		  ;
	   }
	   return (int)(user_str-str-1);
    }
    #endif

%}

DECIMIAL ([1-9][0-9]*|0)
OCTAL_DECIMIAL (0[1-7][0-7]*|00)
HEX_DECIMAL (0x[1-9,a-f,A-F][0-9,a-f,A-F]*|0X[1-9,a-f,A-F][0-9,a-f,A-F]*|0x0|0X0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
NOTE \/\/.*
/*
 *NOTE1 \/\*[\s\S]*?\*\/
 */
commentbegin "/*"
commentelement .|\n
commentend "*/"

%x BLOCKCOMMENT

%%

{NOTE} {yyplace=0;}//去掉注释

{commentbegin} {BEGIN BLOCKCOMMENT; }
<BLOCKCOMMENT>{commentelement} {}
<BLOCKCOMMENT>{commentend} {BEGIN INITIAL; }


"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INT\tint\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+3;
    #else
        return INT;
    #endif
}

"void" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("VOID\tvoid\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+4;
    #else
        return VOID;
    #endif 
}
"char" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CHAR\tchar\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+4;
    #else
        return CHAR;
    #endif 
}
"sizeof" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SIZEOF\tsizeof\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+6;
    #else
        return SIZEOF;
    #endif 
}
"const" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONST\tconst\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+5;
    #else
        return CONST;
    #endif 
}
"if" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("IF\tif\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return IF;
    #endif
};
"else" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ELSE\telse\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+4;
    #else
        return ELSE;
    #endif
};
"for" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("FOR\tfor\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+3;
    #else
        return FOR;
    #endif
}
"return" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RETURN\treturn\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+6;
    #else
        return RETURN;
    #endif
}
"switch" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SWITCH\tswitch\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+6;
    #else
        return SWITCH;
    #endif
}
"break" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("BREAK\tbreak\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+5;
    #else
        return BREAK;
    #endif
}
"continue" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONTINUE\tcontinue\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+8;
    #else
        return CONTINUE;
    #endif
}
"case" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CASE\tcase\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+4;
    #else
        return CASE;
    #endif
}
"default" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DEFAULT\tdefault\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+7;
    #else
        return default;
    #endif
}
"do" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DO\tdo\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return DO;
    #endif
}
"while" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("WHILE\twhile\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+5;
    #else
        return WHILE;
    #endif
}
"scanf" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SCANF\tscanf\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+5;
    #else
        return SCANF;
    #endif
}
"printf" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("PRINTF\tprintf\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+6;
    #else
        return PRINTF;
    #endif
}
"*" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MUL\tmul\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return MUL;
    #endif
}
"=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGN\t=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return ASSIGN;
    #endif
}
">" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MORE\t<\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return MORE;
    #endif
}
"<" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESS\t<\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return LESS;
    #endif
}
"+" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ADD\t+\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return ADD;
    #endif
}
"-" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SUB\t-\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return SUB;
    #endif
}
"%" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("COMOP\t%\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return COMOP;
    #endif
} 
"/" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DIV\t/\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return DIV;
    #endif
} 
"[" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LB\t[\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return LB;
    #endif
}
"]" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RB\t]\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return RB;
    #endif
}
"++" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INPLUS\t++\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return INPLUS;
    #endif
}
"--" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INMINUS\t--\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return INMINUS;
    #endif
}
">=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RELGEQ\t>=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return RELGEQ;
    #endif
}
"<=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RELLEQ\t<=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return RELLEQ;
    #endif
}
"==" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("EQUOP\t==\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return EQUOP;
    #endif
}
"!=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("UEQUOP\t!=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return UEQUOP;
    #endif
}
"&&" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ANDAND\t&&\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return ANDAND;
    #endif
}
"||" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("OROR\t||\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return OROR;
    #endif
}
"!" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LOCRE\t||\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return LOCRE;
    #endif
}
"+=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGNPLUS\t+=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return ASSIGNPLUS;
    #endif
}
"-=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGNMINUS\t-=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return ASSIGNMINUS;
    #endif
}
"*=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGNSTAR\t*=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return ASSIGNSTAR;
    #endif
}
"/=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGNDIV\t/=\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+2;
    #else
        return ASSIGNDIV;
    #endif
}
";" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SEMICOLON\t;\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return SEMICOLON;
    #endif
}
"(" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LPAREN\t(\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return LPAREN;
    #endif
}
")" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RPAREN\t)\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
    return RPAREN;
    #endif
}
"{" {
    #ifdef ONLY_FOR_LEX
        l_scope++;
        ID0=l_scope;
        DEBUG_FOR_LAB4("LBRACE\t{\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace));
        yyplace=yyplace+1;
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        r_scope++;
        if(l_scope-r_scope>0){ID1++;ID0=l_scope-ID1;}
        else{ID1=0;ID0=0;}
        
        std::string l="RBRACE\t}\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace);
        yyplace=yyplace+1;
        DEBUG_FOR_LAB4(l);
    #else
        return RBRACE;
    #endif
}

{EOL} {yylineno++;yyplace=0;}
{WHITE} {yyplace++;}
{DECIMIAL} {
    #ifdef ONLY_FOR_LEX
    
        std::string t=yytext;
        
        std::string u="NUMBER\t"+t+"\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace);
        yyplace=yyplace+pointer_strlen(yytext);
        DEBUG_FOR_LAB4(u);
    #else
        return DECIMIAL;
    #endif
}
{OCTAL_DECIMIAL} {//八进制
    #ifdef ONLY_FOR_LEX   
        int num=1,sum=0;
        int l=strlen(yytext);
        for(int i=1;i<=l;++i){
            sum=sum+(yytext[l-i]-'0')*num;
            num*=8;
        } 
        std::string u="OCTAL_DECIMIA\t"+std::to_string(sum)+"\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace);
        yyplace=yyplace+pointer_strlen(yytext);
        DEBUG_FOR_LAB4(u);
    #else
        return OCTAL_DECIMIAL;
    #endif
}
{HEX_DECIMAL} {//16进制
    #ifdef ONLY_FOR_LEX   
        int num=1,sum=0;
        int l=strlen(yytext);
        for(int i=1;i<=l-2;++i){
            if(yytext[l-i]>='A'&&yytext[l-i]<='F'){
                sum=sum+(yytext[l-i]-55)*num;
                num*=16;
            }
            else if(yytext[l-i]>='a'&&yytext[l-i]<='f'){
                sum=sum+(yytext[l-i]-87)*num;
                num*=16;
            }
            else{
                sum=sum+(yytext[l-i]-'0')*num;
                num*=16;
            }
        } 
        std::string u="HEX_DECIMAL\t"+std::to_string(sum)+"\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace);
        yyplace=yyplace+pointer_strlen(yytext);
        DEBUG_FOR_LAB4(u);
    #else
        return HEX_DECIMAL;
    #endif
}
{ID} {
    #ifdef ONLY_FOR_LEX
        int u=0,i=0;
        

        for(i=IDnum-1;i>0;i--)
        {
           if(strcmp(yytext,maps[i].names)==0)
           {
               u=1;break;
           }
        }
        if(u==1&&maps[i].place==ID0)//已有字符但仍处在旧的作用域
        {
           std::string t=yytext;
           std::string u="ID\t"+t+"\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace)+"\t"+std::to_string(ID0);
           yyplace=yyplace+pointer_strlen(yytext);
           DEBUG_FOR_LAB4(u);
        }
        else//没有匹配到或者来到了新的作用域
        {
           IDnum++;
           strcpy(maps[IDnum-1].names,yytext);
           maps[IDnum-1].place=ID0;
           std::string t=yytext;
           std::string u="ID\t"+t+"\t"+std::to_string(yylineno)+"\t"+std::to_string(yyplace)+"\t"+std::to_string(ID0);
           yyplace=yyplace+pointer_strlen(yytext);
           DEBUG_FOR_LAB4(u);
        }
    #else
        return ID;
    #endif


}


%%

#ifdef ONLY_FOR_LEX
int main(int argc, char **argv){
    if(argc != 5){
        fprintf(stderr, "Argument Not Enough");
        exit(EXIT_FAILURE);
    }

    if(!(yyin = fopen(argv[1], "r"))){
        fprintf(stderr, "No such file or directory: %s", argv[1]);
        exit(EXIT_FAILURE);
    }

    if(!(yyout = fopen(argv[3], "w"))){
        fprintf(stderr, "No such file or directory: %s", argv[3]);
        exit(EXIT_FAILURE);
    }
    std::string uu = "TOKEN\tLEXEMTOKEN\tLINE\tOFFSET\tPOINTER_TO_SCOPE\n";
    fputs(uu.c_str(), yyout);
    yylex();
    return 0;
}
#endif
