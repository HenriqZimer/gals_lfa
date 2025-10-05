# 🧠 Roteiro de Explicação: Semantico.java

## 🎯 Objetivo
Explicar como o analisador semântico implementa o interpretador da linguagem binária, executando as operações e gerenciando variáveis.

---

## 📖 1. INTRODUÇÃO

### O que é o Analisador Semântico?
O `Semantico.java` é o **"cérebro"** do interpretador. Enquanto:
- **Léxico** reconhece tokens
- **Sintático** verifica estrutura

O **Semântico** executa as ações e calcula os resultados.

### Arquitetura do Interpretador
```
Input: "A = 10 + 11;"
      ↓
[Léxico] → Tokens: variavel(A), igual(=), numeros(10), soma(+), numeros(11), fim(;)
      ↓  
[Sintático] → Estrutura válida + Ações: #10, #1, #1, #2, #9
      ↓
[Semântico] → Executa ações e produz resultado: A = 5 (101₂)
```

---

## 🏗️ 2. ESTRUTURA DA CLASSE

### 2.1 Declaração e Imports
```java
package gals;

import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

public class Semantico implements Constants
```

**Componentes essenciais:**
- `HashMap`: Armazena variáveis e seus valores
- `Stack`: Pilha para cálculos de expressões
- `Constants`: Interface com constantes do GALS

### 2.2 Atributos da Classe
```java
Stack<Integer> stack = new Stack();           // Pilha de operandos
Map<String, Integer> vars = new HashMap<>();  // Tabela de variáveis
String variavelAtual;                         // Variável sendo atribuída
```

**Explicação dos atributos:**

1. **`stack`**: Pilha para avaliar expressões
   - Armazena valores intermediários
   - Operadores pop dois valores, fazem operação, push resultado

2. **`vars`**: Hashtable de variáveis
   - Chave: nome da variável (String)
   - Valor: conteúdo em decimal (Integer)

3. **`variavelAtual`**: Buffer temporário
   - Armazena nome da variável durante atribuição
   - Usado entre ações #10 e #9

---

## ⚙️ 3. MÉTODO PRINCIPAL

```java
public void executeAction(int action, Token token) throws SemanticError
```

**Parâmetros:**
- `action`: Número da ação semântica (1-11)
- `token`: Token que disparou a ação
- `throws SemanticError`: Para erros de execução

**Estrutura:** Switch-case com cada ação semântica

---

## 🔢 4. DETALHAMENTO DAS AÇÕES

### 4.1 Ação #1: Processar Números Binários
```java
case 1: //Empilha numeros
  stack.push(Integer.parseInt(token.getLexeme(), 2));
  break;
```

**Função:** Converte número binário para decimal e empilha

**Exemplo:**
- Token: `"101"` (binário)
- Conversão: `Integer.parseInt("101", 2)` = 5 (decimal)
- Pilha: `[5]`

**Fluxo:**
```
Input: 101₂ → parseInt(101₂, base=2) → 5₁₀ → stack.push(5)
```

### 4.2 Ação #2: Soma
```java
case 2://adição
  b = stack.pop();
  a = stack.pop();
  stack.push(new Integer(a.intValue() + b.intValue()));
  break;
```

**Função:** Remove dois operandos, soma e empilha resultado

**Exemplo:**
- Pilha antes: `[3, 5]` (topo à direita)
- Operação: `pop()` → b=5, `pop()` → a=3
- Cálculo: `a + b = 3 + 5 = 8`
- Pilha depois: `[8]`

**⚠️ Ordem importante:** `a` vem antes de `b` na expressão!

### 4.3 Ação #3: Multiplicação
```java
case 3://multiplicação
  b = stack.pop();
  a = stack.pop();
  stack.push(new Integer(a.intValue() * b.intValue()));
  break;
```

**Mesmo padrão da soma, mas com multiplicação**

**Exemplo:**
- Expressão: `10 * 11` (2₁₀ × 3₁₀)
- Resultado: `6₁₀` = `110₂`

### 4.4 Ação #4: Usar Variável
```java
case 4: //Empilha variavel
  stack.push(vars.get(token.getLexeme()));
  break;
```

**Função:** Busca valor da variável e empilha

**Exemplo:**
- Variável: `A` com valor `5`
- Ação: `vars.get("A")` → 5
- Pilha: `[5]`

**⚠️ Erro possível:** Variável não existe → `NullPointerException`

### 4.5 Ação #5: Subtração
```java
case 5://subtração
  b = stack.pop();
  a = stack.pop();
  stack.push(new Integer(a.intValue() - b.intValue()));
  break;
```

**Cuidado com a ordem:** `a - b`, não `b - a`

**Exemplo:**
- Expressão: `111 - 10` (7₁₀ - 2₁₀)
- Resultado: `5₁₀` = `101₂`

### 4.6 Ação #6: Divisão
```java
case 6://divisão
  b = stack.pop();
  a = stack.pop();
  stack.push(new Integer(a.intValue() / b.intValue()));
  break;
```

**Divisão inteira** (sem resto)

**Exemplo:**
- Expressão: `100 / 10` (4₁₀ ÷ 2₁₀)
- Resultado: `2₁₀` = `10₂`

**⚠️ Cuidado:** Divisão por zero → `ArithmeticException`

### 4.7 Ação #7: Exponenciação
```java
case 7: //exponeciação
  b = stack.pop();
  a = stack.pop();
  Double A = Math.pow(a, b);
  stack.push(A.intValue());
  break;
```

**Função:** Calcula `a^b` usando `Math.pow()`

**Exemplo:**
- Expressão: `10 ^ 11` (2₁₀^3₁₀)
- Cálculo: `Math.pow(2, 3)` = 8.0
- Conversão: `8.0.intValue()` = 8
- Resultado: `8₁₀` = `1000₂`

### 4.8 Ação #8: Comando Show
```java
case 8: //função show
  Integer resultado = stack.pop();
  System.out.print("Resultado: "+Integer.toBinaryString(resultado)+"\n");
  break;
```

**Função:** Exibe resultado em formato binário

**Fluxo:**
1. Remove valor da pilha
2. Converte para string binária
3. Exibe na tela

**Exemplo:**
- Pilha: `[13]`
- Conversão: `Integer.toBinaryString(13)` = "1101"
- Saída: `"Resultado: 1101"`

### 4.9 Ação #9: Salvar Variável
```java
case 9: //salva variavel e valor
  vars.put(variavelAtual, stack.pop());
  break;
```

**Função:** Finaliza atribuição de variável

**Fluxo:**
1. Remove valor da pilha
2. Salva na hashtable com nome da `variavelAtual`
3. Atribuição completa

**Exemplo:**
- `variavelAtual` = "A"
- Pilha: `[5]`
- Resultado: `vars["A"] = 5`

### 4.10 Ação #10: Marcar Variável
```java
case 10: //variavel atual
  variavelAtual = token.getLexeme();
  break;
```

**Função:** Prepara para atribuição

**Exemplo:**
- Token: `"B"`
- Ação: `variavelAtual = "B"`
- Aguarda ação #9 para completar

### 4.11 Ação #11: Logaritmo
```java
case 11: //logaritmo
  a = stack.pop();
  Double logResult = Math.log(a) / Math.log(2); // log base 2
  stack.push(logResult.intValue());
  break;
```

**Função:** Calcula logaritmo base 2

**Fórmula:** `log₂(x) = ln(x) / ln(2)`

**Exemplo:**
- Expressão: `log(1000)` onde 1000₂ = 8₁₀
- Cálculo: `log₂(8) = ln(8)/ln(2) = 3.0`
- Resultado: `3₁₀` = `11₂`

---

## 🔄 5. FLUXO DE EXECUÇÃO

### Exemplo Completo: `A = 10 + 11; Show ( A );`

#### Fase 1: Atribuição `A = 10 + 11;`
```
Ação #10: variavelAtual = "A"
Ação #1:  stack.push(2)     // 10₂ = 2₁₀
Ação #1:  stack.push(3)     // 11₂ = 3₁₀
Ação #2:  soma → stack = [5] // 2 + 3 = 5
Ação #9:  vars["A"] = 5     // salva A = 5
```

#### Fase 2: Exibição `Show ( A );`
```
Ação #4:  stack.push(5)     // busca vars["A"]
Ação #8:  exibe "101"       // 5₁₀ = 101₂
```

### Estado Final:
- `vars = {"A": 5}`
- `stack = []` (vazia)
- Saída: `"Resultado: 101"`

---

## 🎯 6. ESTRUTURAS DE DADOS

### 6.1 Stack (Pilha)
```
Expressão: 1 + 10 * 11

Estado da pilha durante execução:
1. [1]           // após #1 (numeros 1)
2. [1, 2]        // após #1 (numeros 10)  
3. [1, 2, 3]     // após #1 (numeros 11)
4. [1, 6]        // após #3 (multiplicacao: 2*3=6)
5. [7]           // após #2 (soma: 1+6=7)
```

### 6.2 HashMap de Variáveis
```
Após execução de múltiplas atribuições:
vars = {
  "A": 2,    // A = 10₂
  "B": 3,    // B = 11₂  
  "C": 7     // C = 111₂
}
```

---

## ⚠️ 7. TRATAMENTO DE ERROS

### Erros Possíveis:
1. **Variável não existe:** `vars.get("X")` → `null`
2. **Pilha vazia:** `stack.pop()` em pilha vazia
3. **Divisão por zero:** `a / 0`
4. **Overflow:** Números muito grandes

### Melhorias Possíveis:
```java
// Verificação de variável
if (!vars.containsKey(token.getLexeme())) {
    throw new SemanticError("Variável não definida: " + token.getLexeme());
}

// Verificação de pilha
if (stack.isEmpty()) {
    throw new SemanticError("Pilha vazia - expressão malformada");
}

// Verificação de divisão por zero
if (b.intValue() == 0) {
    throw new SemanticError("Divisão por zero");
}
```

---

## 🔄 8. PADRÕES DE IMPLEMENTAÇÃO

### Padrão para Operadores Binários:
```java
// Template para +, -, *, /, ^
b = stack.pop();           // Segundo operando
a = stack.pop();           // Primeiro operando  
resultado = operacao(a, b); // Operação específica
stack.push(resultado);     // Empilha resultado
```

### Padrão para Operadores Unários:
```java
// Template para log, negação, etc.
a = stack.pop();           // Único operando
resultado = operacao(a);   // Operação específica
stack.push(resultado);     // Empilha resultado
```

---

## 📊 9. CONVERSÕES DE BASE

### Entrada (Binário → Decimal):
```java
Integer.parseInt("1010", 2)  // "1010"₂ → 10₁₀
```

### Saída (Decimal → Binário):
```java
Integer.toBinaryString(10)   // 10₁₀ → "1010"₂
```

### Tabela de Conversões Comuns:
| Binário | Decimal | Uso Comum |
|---------|---------|-----------|
| 0       | 0       | Zero |
| 1       | 1       | Um |
| 10      | 2       | Dois |
| 11      | 3       | Três |
| 100     | 4       | Quatro |
| 101     | 5       | Cinco |
| 110     | 6       | Seis |
| 111     | 7       | Sete |
| 1000    | 8       | Oito |

---

## 🎯 10. INTEGRAÇÃO COM GALS

### Como o GALS chama o Semântico:
```java
// No Sintatico.java (gerado pelo GALS):
semanticAnalyser.executeAction(cmd[1], previousToken);
```

### Mapeamento Ação → Método:
- Gramática: `numeros #1` 
- GALS chama: `executeAction(1, token_numeros)`
- Semântico executa: `case 1: ...`

---

## 🎯 11. RESUMO

O `Semantico.java` implementa um **interpretador completo** que:

### ✅ Funcionalidades Implementadas:
- **Pilha de operandos** para avaliação de expressões
- **Hashtable de variáveis** para armazenamento
- **11 ações semânticas** correspondentes à gramática
- **Conversões automáticas** binário ↔ decimal
- **Operações matemáticas** completas (+, -, *, /, ^, log)
- **Comando de saída** formatado

### 🏗️ Arquitetura:
- **Entrada:** Ações do analisador sintático
- **Processamento:** Manipulação de pilha e variáveis
- **Saída:** Resultados em formato binário

### 🔄 Fluxo:
1. **Recebe ações** do parser sintático
2. **Executa operações** na pilha
3. **Gerencia variáveis** na hashtable
4. **Produz resultados** para o usuário

Este interpretador transforma a análise sintática em **execução real** da linguagem binária, completando o ciclo de compilação/interpretação.