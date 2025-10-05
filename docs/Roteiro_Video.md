# 🎬 Roteiro para Vídeo: Interpretador de Linguagem Binária

## 🎯 Duração Estimada: 8-10 minutos

---

## 🎬 INTRODUÇÃO (1 minuto)

### Abertura
> "Olá! Neste vídeo vou apresentar o meu projeto de Linguagens Formais e Autômatos: um **interpretador para linguagem binária** desenvolvido com GALS."

### O que faz o projeto?
> "Este interpretador executa uma linguagem de programação que trabalha exclusivamente com números binários. Vou mostrar como funciona:"

**[DEMO RÁPIDA - executar no terminal]**
```bash
make run
```

> "Como vocês podem ver, o programa calcula expressões como `10 + 11` (em binário) e mostra o resultado `101`. Vamos entender como isso acontece por dentro."

---

## 📋 PARTE 1: VISÃO GERAL (2 minutos)

### Arquitetura do Sistema
> "O projeto tem três componentes principais que trabalham em sequência:"

**[MOSTRAR DIAGRAMA ou ARQUIVOS]**

1. **Analisador Léxico** (Lexico.java)
   > "Pega o texto de entrada e identifica as 'palavras' - números, operadores, variáveis"

2. **Analisador Sintático** (Sintatico.java)  
   > "Verifica se a estrutura está correta e organiza a ordem das operações"

3. **Analisador Semântico** (Semantico.java)
   > "Executa os cálculos e produz os resultados"

### Funcionalidades Implementadas
> "A linguagem suporta:"
- ✅ Números binários (10, 11, 101, 1000...)
- ✅ Operações matemáticas (+, -, *, /, ^, log)
- ✅ Variáveis (A = 10; B = 11;)
- ✅ Comando Show para exibir resultados

---

## 🔧 PARTE 2: A GRAMÁTICA (2 minutos)

### O arquivo Gramatica.gals
> "Vou abrir o arquivo da gramática que define nossa linguagem."

**[MOSTRAR Gramatica.gals na tela]**

> "Aqui temos as regras que definem como escrever programas. Por exemplo:"

#### Tokens (30 segundos)
```gals
numeros: [0-1]+          // Só aceita 0 e 1
show: Show              // Comando para exibir
soma: \+                // Operador de soma
```

> "Estes são os 'vocabulário' da linguagem - que palavras podemos usar."

#### Regras de Precedência (90 segundos)
```gals
<prior4> ::= <prior4> soma <prior3> #2 | <prior4> subtracao <prior3> #5 | <prior3>;
<prior3> ::= <prior3> multiplicacao <prior2> #3 | <prior3> divisao <prior2> #6 | <prior2>;
```

> "Essas regras garantem que multiplicação aconteça antes da soma, igual na matemática normal."

> "Os números #2, #3, #5 são **ações semânticas** - pontos onde o interpretador vai executar operações."

### Exemplo prático
> "Se eu escrevo `10 + 11 * 100`, a gramática garante que primeiro multiplica `11 * 100`, depois soma com `10`."

---

## 🧠 PARTE 3: O INTERPRETADOR (3 minutos)

### Como funciona o Semantico.java
> "Agora vou mostrar onde a mágica acontece - o arquivo que realmente executa os cálculos."

**[MOSTRAR Semantico.java na tela]**

#### Estruturas principais (60 segundos)
```java
Stack<Integer> stack = new Stack();           // Pilha para cálculos
Map<String, Integer> vars = new HashMap<>();  // Variáveis armazenadas
```

> "O interpretador usa uma **pilha** para fazer cálculos e um **HashMap** para guardar variáveis."

#### Como executa uma operação (120 segundos)
> "Vou mostrar como funciona uma soma:"

```java
case 2: // soma
  b = stack.pop();  // Pega segundo número
  a = stack.pop();  // Pega primeiro número  
  stack.push(a + b); // Coloca resultado na pilha
```

**[DESENHAR na tela ou mostrar exemplo]**
```
Expressão: 10 + 11
1. stack.push(2)  // 10₂ = 2₁₀
2. stack.push(3)  // 11₂ = 3₁₀  
3. soma: 2 + 3 = 5
4. stack.push(5)  // resultado = 5₁₀ = 101₂
```

> "O truque é que internamente trabalhamos em decimal, mas convertemos de/para binário na entrada e saída."

#### Conversões Binário-Decimal
```java
// Entrada: binário → decimal
Integer.parseInt("101", 2)  // "101"₂ → 5₁₀

// Saída: decimal → binário  
Integer.toBinaryString(5)   // 5₁₀ → "101"₂
```

---

## 🧪 PARTE 4: DEMONSTRAÇÃO PRÁTICA (2 minutos)

### Executando exemplos
> "Vou executar alguns exemplos para mostrar o interpretador funcionando:"

**[TERMINAL - executar make run]**

#### Exemplo 1: Operação simples
> "Primeiro, uma operação básica:"
```
A = 10; Show ( A );
```
> "Resultado: 10 - converteu e armazenou corretamente"

#### Exemplo 2: Expressão complexa  
> "Agora algo mais complexo:"
```
B = 111 + 10 * 11; Show ( B );
```
> "Resultado: 1101"
> "Vamos verificar: 111₂ = 7, 10₂ = 2, 11₂ = 3"
> "Cálculo: 7 + (2 × 3) = 7 + 6 = 13"
> "13₁₀ = 1101₂ ✓"

#### Exemplo 3: Logaritmo
> "E nossa operação mais avançada:"
```
C = log ( 1000 ); Show ( C );
```
> "1000₂ = 8₁₀, log₂(8) = 3₁₀ = 11₂"

---

## 🎯 CONCLUSÃO (30 segundos)

### Resumo do que foi implementado
> "Resumindo, criamos um interpretador completo que:"
- ✅ Reconhece sintaxe binária
- ✅ Executa 6 operações matemáticas  
- ✅ Gerencia variáveis
- ✅ Converte automaticamente entre bases
- ✅ Produz resultados corretos

### Encerramento
> "O projeto demonstra na prática os conceitos de compiladores: análise léxica, sintática e semântica trabalhando juntas para executar uma linguagem de programação."

> "Todo o código está documentado e disponível. Obrigado pela atenção!"

---

## 📝 DICAS PARA GRAVAÇÃO

### Preparação:
- [ ] Terminal limpo e fonte grande
- [ ] Arquivos principais abertos (Gramatica.gals, Semantico.java)
- [ ] Projeto compilado (`make clean && make build`)
- [ ] Exemplos testados previamente

### Durante a gravação:
- **Fale devagar** e articule bem
- **Pause** entre seções para facilitar edição
- **Repita** se cometer erro, não pare a gravação
- **Use cursor** para apontar código relevante
- **Execute** comandos lentamente para câmera capturar

### Recursos visuais:
- **Terminal grande** (fonte 16+ pt)
- **Zoom** nos arquivos importantes
- **Destaque** partes do código (cursor, seleção)
- **Pausas** após cada resultado para absorção

### Timing sugerido:
- **Introdução**: 1 min - ritmo animado
- **Visão geral**: 2 min - didático  
- **Gramática**: 2 min - técnico mas claro
- **Interpretador**: 3 min - detalhado
- **Demo**: 2 min - prático e visual
- **Conclusão**: 30s - resumo conciso

### Linguagem:
- Use **"vou mostrar"** antes de cada demo
- Explique **"o que"** antes do **"como"**  
- **Repita** conceitos importantes
- Use **analogias** quando possível ("como uma pilha de pratos")

---

## 🎬 SCRIPT ALTERNATIVO (VERSÃO CURTA - 5 min)

Se precisar de versão mais enxuta:

1. **Intro** (30s): Demo rápida
2. **Arquitetura** (90s): 3 componentes  
3. **Gramática** (90s): Tokens + precedência
4. **Interpretador** (90s): Pilha + conversões
5. **Demo final** (60s): 2 exemplos
6. **Conclusão** (30s): Resumo