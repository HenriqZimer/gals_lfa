# 📋 Roteiro de Explicação: Gramatica.gals

## 🎯 Objetivo
Explicar a estrutura e funcionamento da gramática que define a linguagem de programação binária implementada com GALS.

---

## 📖 1. INTRODUÇÃO

### O que é a Gramática?
A gramática define as **regras sintáticas** da nossa linguagem de programação binária. Ela especifica:
- Como os tokens (palavras) são reconhecidos
- Como as expressões são formadas
- A precedência dos operadores
- Onde as ações semânticas são executadas

### Estrutura do arquivo .gals
```
#Options     → Configurações do gerador
#Tokens      → Definição dos tokens léxicos  
#NonTerminals → Símbolos não-terminais
#Grammar     → Regras de produção
```

---

## ⚙️ 2. SEÇÃO #OPTIONS

```gals
#Options
GenerateScanner = true      // Gera analisador léxico
GenerateParser = true       // Gera analisador sintático
Language = Java            // Linguagem de saída
ScannerName = Lexico       // Nome da classe léxica
ParserName = Sintatico     // Nome da classe sintática
SemanticName = Semantico   // Nome da classe semântica
Package = gals             // Pacote Java
ScannerCaseSensitive = true // Diferencia maiúsculas/minúsculas
ScannerTable = Compact     // Tabela compacta
Input = Stream             // Entrada por stream
Parser = SLR               // Tipo de parser SLR
```

**Explicação:**
- Define como o GALS vai gerar o código
- Escolhe nomes das classes geradas
- Configura o tipo de análise (SLR = Simple LR)

---

## 🏷️ 3. SEÇÃO #TOKENS

### 3.1 Tokens Ignorados
```gals
:[\ \n\t\r\s]+
```
**Função:** Ignora espaços, quebras de linha e tabulações.

### 3.2 Palavras-chave (Ordem Importante!)
```gals
log: log        // Operador logaritmo
show: Show      // Comando de exibição
```
**⚠️ CRÍTICO:** Devem vir ANTES de `variavel` para serem reconhecidos!

### 3.3 Identificadores e Números
```gals
variavel: [A-Za-z]*     // Variáveis (letras)
numeros: [0-1]+         // Números binários (só 0 e 1)
```

### 3.4 Operadores Matemáticos
```gals
soma: \+                // Operador +
subtracao: \-           // Operador -
multiplicacao: \*       // Operador *
divisao: "/"            // Operador /
exponenciacao: "^"      // Operador ^
```

### 3.5 Símbolos Especiais
```gals
igual: "="              // Atribuição
"("                     // Parêntese esquerdo
")"                     // Parêntese direito
fim: ";"                // Terminador de comando
```

---

## 🌳 4. SEÇÃO #NONTERMINALS

```gals
<lista_comandos>        // Lista de comandos do programa
<comando>               // Um comando individual
<prior1>                // Nível 1 de precedência (mais alta)
<prior2>                // Nível 2 de precedência
<prior3>                // Nível 3 de precedência  
<prior4>                // Nível 4 de precedência (mais baixa)
```

**Hierarquia de Precedência (maior para menor):**
1. `<prior1>`: Parênteses, números, variáveis, log
2. `<prior2>`: Exponenciação (^)
3. `<prior3>`: Multiplicação (*), Divisão (/)
4. `<prior4>`: Soma (+), Subtração (-)

---

## 📝 5. SEÇÃO #GRAMMAR

### 5.1 Lista de Comandos
```gals
<lista_comandos> ::= <comando> <lista_comandos> | <comando>;
```
**Explicação:** 
- Um programa é uma sequência de comandos
- Pode ter um comando seguido de outros, ou apenas um comando

### 5.2 Tipos de Comandos
```gals
<comando> ::= variavel #10 igual <prior4> fim #9 
            | show "(" <prior4> ")" fim #8 
            | <prior4>;
```

**Três tipos de comandos:**

1. **Atribuição:** `A = 10;`
   - `#10`: Marca variável de destino
   - `#9`: Executa atribuição

2. **Exibição:** `Show ( B );`
   - `#8`: Exibe resultado

3. **Expressão:** Qualquer expressão válida

### 5.3 Precedência Nível 4 (Soma/Subtração)
```gals
<prior4> ::= <prior4> soma <prior3> #2
           | <prior4> subtracao <prior3> #5 
           | <prior3>;
```
**Características:**
- Associatividade à esquerda
- Menor precedência
- `#2`: Ação de soma, `#5`: Ação de subtração

### 5.4 Precedência Nível 3 (Multiplicação/Divisão)
```gals
<prior3> ::= <prior3> multiplicacao <prior2> #3
           | <prior3> divisao <prior2> #6 
           | <prior2>;
```
**Características:**
- Maior precedência que soma/subtração
- `#3`: Ação de multiplicação, `#6`: Ação de divisão

### 5.5 Precedência Nível 2 (Exponenciação)
```gals
<prior2> ::= <prior1> exponenciacao <prior1> #7 
           | <prior1>;
```
**Características:**
- Associatividade à direita (implícita)
- `#7`: Ação de exponenciação

### 5.6 Precedência Nível 1 (Elementos Básicos)
```gals
<prior1> ::= "(" <prior4> ")" 
           | numeros #1 
           | variavel #4 
           | log "(" <prior4> ")" #11;
```

**Quatro elementos básicos:**
1. **Parênteses:** Agrupamento de expressões
2. **Números:** `#1` processa número binário
3. **Variáveis:** `#4` busca valor da variável
4. **Logaritmo:** `#11` calcula logaritmo

---

## 🎯 6. AÇÕES SEMÂNTICAS

| Ação | Onde Ocorre | Função |
|------|-------------|---------|
| #1   | numeros | Processa número binário |
| #2   | soma | Executa adição |
| #3   | multiplicacao | Executa multiplicação |
| #4   | variavel | Busca valor de variável |
| #5   | subtracao | Executa subtração |
| #6   | divisao | Executa divisão |
| #7   | exponenciacao | Executa exponenciação |
| #8   | show | Exibe resultado |
| #9   | atribuição | Salva variável |
| #10  | variável destino | Marca variável para atribuição |
| #11  | log | Calcula logaritmo |

---

## 📚 7. EXEMPLOS PRÁTICOS

### Exemplo 1: Atribuição Simples
```
A = 10;
```
**Sequência de ações:**
1. `variavel` A → Ação #10 (marca variável)
2. `numeros` 10 → Ação #1 (processa 10₂ = 2₁₀)
3. `fim` ; → Ação #9 (salva A = 2)

### Exemplo 2: Expressão com Precedência
```
B = 1 + 10 * 11;
```
**Sequência de ações:**
1. `variavel` B → Ação #10
2. `numeros` 1 → Ação #1 (1₂ = 1₁₀)
3. `numeros` 10 → Ação #1 (10₂ = 2₁₀)
4. `numeros` 11 → Ação #1 (11₂ = 3₁₀)
5. `multiplicacao` → Ação #3 (2 × 3 = 6)
6. `soma` → Ação #2 (1 + 6 = 7)
7. `fim` → Ação #9 (salva B = 7)

### Exemplo 3: Comando Show
```
Show ( A );
```
**Sequência de ações:**
1. `variavel` A → Ação #4 (busca valor de A)
2. `show` → Ação #8 (exibe resultado)

### Exemplo 4: Logaritmo
```
C = log ( 1000 );
```
**Sequência de ações:**
1. `variavel` C → Ação #10
2. `numeros` 1000 → Ação #1 (1000₂ = 8₁₀)
3. `log` → Ação #11 (log₂(8) = 3₁₀)
4. `fim` → Ação #9 (salva C = 3)

---

## ⚡ 8. PONTOS CRÍTICOS

### 8.1 Ordem dos Tokens
```gals
❌ ERRADO:
variavel: [A-Za-z]*
log: log

✅ CORRETO:
log: log
variavel: [A-Za-z]*
```
**Motivo:** GALS usa a primeira regra que combina.

### 8.2 Precedência de Operadores
A gramática implementa corretamente:
- Parênteses > Exponenciação > *, / > +, -
- Associatividade à esquerda para +, -, *, /

### 8.3 Ações Semânticas
- Cada ação (#1 a #11) tem posição específica
- Executadas durante a análise sintática
- Implementadas no arquivo Semantico.java

---

## 🎯 9. RESUMO

A gramática define uma linguagem completa para:
- ✅ Números binários
- ✅ Seis operações matemáticas
- ✅ Variáveis e atribuições  
- ✅ Comando de exibição
- ✅ Precedência correta
- ✅ Integração com analisador semântico

Esta gramática gera automaticamente os analisadores léxico e sintático usando o GALS, criando a base para o interpretador de linguagem binária.