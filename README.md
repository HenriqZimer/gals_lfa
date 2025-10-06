# 🔢 Interpretador de Linguagem Binária - GALS

Um interpretador para uma linguagem de programação que trabalha exclusivamente com números binários inteiros sem sinal, implementado utilizando o gerador de analisadores GALS.

## 📋 Sobre o Projeto

Este projeto implementa uma linguagem de programação simples que permite:

- **Números binários**: Todas as operações são realizadas com números binários (ex: `10`, `11`, `101`, `1010`)
- **Variáveis**: Atribuição e uso de variáveis (ex: `A = 10;`)
- **Operações matemáticas**: 
  - Soma (`+`)
  - Subtração (`-`) 
  - Multiplicação (`*`)
  - Divisão (`/`)
  - Exponenciação (`^`)
  - Logaritmo (`log()`)
- **Exibição**: Comando `Show()` para exibir valores

## 🎯 Exemplo da Linguagem

```
A = 10;
B = 11;
B = 111 + A * B;
Show ( B );
```

## 🛠️ Tecnologias Utilizadas

- **Java**: Linguagem de implementação
- **GALS**: Gerador de Analisadores Léxico e Sintático
- **Análise LR**: Parser SLR para análise sintática

## 📁 Estrutura do Projeto

```
Trabalho - M2/
├── README.md                 # Este arquivo
├── Makefile                  # Comandos de build e execução
├── Gramatica.gals           # Definição da gramática
├── GalsModificado.jar       # Gerador GALS
├── src/
│   ├── gals/                # Arquivos gerados pelo GALS
│   │   ├── Lexico.java      # Analisador léxico
│   │   ├── Sintatico.java   # Analisador sintático
│   │   ├── Semantico.java   # Analisador semântico
│   │   ├── Constants.java   # Constantes dos tokens
│   │   └── ...              # Outros arquivos gerados
│   └── Principal/
│       └── Main.java        # Programa principal
└── docs/
    └── Trabalho LFA M2.pdf  # Especificação do trabalho
```

## 🚀 Como Executar

### Pré-requisitos

- Java 8 ou superior
- Make (opcional, mas recomendado)
- Sistema Unix/Linux ou WSL no Windows

### Instalação e Execução

#### Usando Makefile (Recomendado)

```bash
# Compilar o projeto
make build

# Executar o interpretador
make run

# Limpar arquivos compilados
make clean

# Regenerar arquivos GALS (após mudanças na gramática)
make gals

# Ver todos os comandos disponíveis
make help
```

#### Manualmente

```bash
# 1. Navegar para o diretório do projeto
cd "Trabalho - M2"

# 2. Gerar arquivos GALS (se necessário)
java -jar GalsModificado.jar Gramatica.gals

# 3. Compilar
cd src
javac gals/*.java Principal/*.java

# 4. Executar
java Principal.Main
```

## 📝 Exemplos de Uso

O programa principal (`Main.java`) já inclui vários exemplos que demonstram todas as funcionalidades:

### Exemplo 1: Expressão com Precedência
```
B = 1 + 10 + 11 * 10; Show ( B );
```

### Exemplo 2: Múltiplas Variáveis
```
A = 10; B = 11; C = A * B; Show ( A );
```

### Exemplo 3: Todas as Operações
```
X = 111 - 10; Show ( X );        # Subtração
Y = 100 / 10; Show ( Y );        # Divisão
Z = 10 ^ 11; Show ( Z );         # Exponenciação
W = log ( 1000 ); Show ( W );    # Logaritmo
```

## 🔧 Componentes do Sistema

### 1. Analisador Léxico (`Lexico.java`)
- Reconhece tokens: números binários, operadores, palavras-chave
- Ignora espaços em branco e caracteres de formatação

### 2. Analisador Sintático (`Sintatico.java`)
- Parser SLR que verifica a estrutura da linguagem
- Implementa precedência de operadores correta
- Gerencia pilha de parsing e tabelas de ação

### 3. Analisador Semântico (`Semantico.java`)
- Processa as ações semânticas (#1 a #11)
- **Atualmente**: Apenas imprime as ações executadas
- **TODO**: Implementar interpretador completo

### 4. Gramática (`Gramatica.gals`)
Define a sintaxe da linguagem com:
- Tokens para números binários, operadores e comandos
- Regras de produção com precedência adequada
- Ações semânticas para cada construção

## 🎲 Ações Semânticas

| Ação | Descrição |
|------|-----------|
| #1   | Reconhecer número binário |
| #2   | Operação de soma |
| #3   | Operação de multiplicação |
| #4   | Usar valor de variável |
| #5   | Operação de subtração |
| #6   | Operação de divisão |
| #7   | Operação de exponenciação |
| #8   | Comando Show (exibição) |
| #9   | Finalizar atribuição |
| #10  | Variável (lado esquerdo da atribuição) |
| #11  | Operação de logaritmo |

## 🔍 Saída Atual

O programa atualmente exibe as ações semânticas sendo executadas:

```
=== Teste 1: Expressão com precedência ===
Ação #10, Token: 4 ( B ) @ 0
Ação #1, Token: 5 ( 1 ) @ 4
Ação #1, Token: 5 ( 10 ) @ 8
Ação #2, Token: 5 ( 10 ) @ 8
...
```

## 🚧 Limitações Atuais

- ✅ **Análise Léxica**: Completa e funcionando
- ✅ **Análise Sintática**: Completa e funcionando  
- ❌ **Análise Semântica**: Apenas trace das ações (interpretador não implementado)

## 🎯 Próximos Passos

1. **Implementar interpretador completo** no `Semantico.java`:
   - Armazenar variáveis em HashMap
   - Realizar cálculos binários
   - Implementar todas as operações matemáticas
   - Exibir resultados com o comando Show

2. **Melhorar interface**:
   - Adicionar modo interativo
   - Leitura de arquivos de código
   - Melhor tratamento de erros

## 👥 Autores

- **Henrique Zimermann**
- **Bernando Vannier**

## 📄 Licença

Este projeto foi desenvolvido como trabalho acadêmico para a disciplina de Linguagens Formais e Autômatos (LFA).

---

## 🔗 Links Úteis

- [Documentação do GALS](http://gals.sourceforge.net/)

- [Especificação do Trabalho](docs/Trabalho%20LFA%20M2.pdf)
