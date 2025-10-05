# Makefile para o Interpretador de Linguagem Binária - GALS
# Autor: Henrique Zimer
# Projeto: Trabalho LFA M2

# Variáveis
JAVA = java
JAVAC = javac
JAR = GalsModificado.jar
GRAMMAR = Gramatica.gals
SRC_DIR = src
GALS_DIR = $(SRC_DIR)/gals
PRINCIPAL_DIR = $(SRC_DIR)/Principal
MAIN_CLASS = Principal.Main

# Cores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Regra padrão
.PHONY: all
all: build

# Ajuda
.PHONY: help
help:
	@echo "$(GREEN)🔢 Interpretador de Linguagem Binária - GALS$(NC)"
	@echo ""
	@echo "$(YELLOW)Comandos disponíveis:$(NC)"
	@echo "  $(GREEN)make build$(NC)     - Compila todo o projeto"
	@echo "  $(GREEN)make run$(NC)       - Executa o interpretador"
	@echo "  $(GREEN)make gals$(NC)      - Regenera arquivos GALS da gramática"
	@echo "  $(GREEN)make clean$(NC)     - Remove arquivos compilados"
	@echo "  $(GREEN)make rebuild$(NC)   - Limpa e recompila tudo"
	@echo "  $(GREEN)make test$(NC)      - Executa os testes do interpretador"
	@echo "  $(GREEN)make help$(NC)      - Mostra esta ajuda"
	@echo ""
	@echo "$(YELLOW)Estrutura do projeto:$(NC)"
	@echo "  $(SRC_DIR)/gals/        - Arquivos gerados pelo GALS"
	@echo "  $(SRC_DIR)/Principal/   - Código principal"
	@echo "  $(GRAMMAR)     - Definição da gramática"
	@echo ""

# Gerar arquivos GALS
.PHONY: gals
gals:
	@echo "$(YELLOW)🔄 Gerando arquivos GALS...$(NC)"
	$(JAVA) -jar $(JAR) $(GRAMMAR)
	@echo "$(GREEN)✅ Arquivos GALS gerados com sucesso!$(NC)"

# Compilar arquivos GALS
.PHONY: compile-gals
compile-gals:
	@echo "$(YELLOW)🔨 Compilando arquivos GALS...$(NC)"
	@if [ ! -d "$(GALS_DIR)" ]; then \
		echo "$(RED)❌ Diretório $(GALS_DIR) não encontrado!$(NC)"; \
		echo "$(YELLOW)💡 Execute 'make gals' primeiro$(NC)"; \
		exit 1; \
	fi
	$(JAVAC) $(GALS_DIR)/*.java
	@echo "$(GREEN)✅ Arquivos GALS compilados!$(NC)"

# Compilar código principal
.PHONY: compile-main
compile-main: compile-gals
	@echo "$(YELLOW)🔨 Compilando código principal...$(NC)"
	$(JAVAC) -cp $(SRC_DIR) $(PRINCIPAL_DIR)/*.java
	@echo "$(GREEN)✅ Código principal compilado!$(NC)"

# Compilar tudo
.PHONY: build
build: compile-main
	@echo "$(GREEN)🎉 Build completo realizado com sucesso!$(NC)"

# Executar o programa
.PHONY: run
run: build
	@echo "$(YELLOW)🚀 Executando o interpretador...$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════$(NC)"
	cd $(SRC_DIR) && $(JAVA) $(MAIN_CLASS)
	@echo "$(GREEN)═══════════════════════════════════════$(NC)"
	@echo "$(GREEN)✅ Execução finalizada!$(NC)"

# Testar o projeto
.PHONY: test
test: run

# Limpar arquivos compilados
.PHONY: clean
clean:
	@echo "$(YELLOW)🧹 Limpando arquivos compilados...$(NC)"
	@find $(SRC_DIR) -name "*.class" -type f -delete 2>/dev/null || true
	@echo "$(GREEN)✅ Limpeza concluída!$(NC)"

# Limpar tudo (incluindo arquivos GALS)
.PHONY: clean-all
clean-all: clean
	@echo "$(YELLOW)🧹 Limpando todos os arquivos gerados...$(NC)"
	@if [ -d "$(GALS_DIR)" ]; then \
		rm -rf $(GALS_DIR)/*.java 2>/dev/null || true; \
		echo "$(GREEN)✅ Arquivos GALS removidos!$(NC)"; \
	fi

# Rebuild completo
.PHONY: rebuild
rebuild: clean build

# Rebuild com GALS
.PHONY: rebuild-all
rebuild-all: clean-all gals build

# Verificar estrutura do projeto
.PHONY: check
check:
	@echo "$(YELLOW)🔍 Verificando estrutura do projeto...$(NC)"
	@echo "Gramática: $(if $(wildcard $(GRAMMAR)),$(GREEN)✅ Encontrada$(NC),$(RED)❌ Não encontrada$(NC))"
	@echo "GALS JAR:  $(if $(wildcard $(JAR)),$(GREEN)✅ Encontrado$(NC),$(RED)❌ Não encontrado$(NC))"
	@echo "Src dir:   $(if $(wildcard $(SRC_DIR)),$(GREEN)✅ Encontrado$(NC),$(RED)❌ Não encontrado$(NC))"
	@echo "GALS dir:  $(if $(wildcard $(GALS_DIR)),$(GREEN)✅ Encontrado$(NC),$(RED)❌ Não encontrado$(NC))"
	@echo "Main dir:  $(if $(wildcard $(PRINCIPAL_DIR)),$(GREEN)✅ Encontrado$(NC),$(RED)❌ Não encontrado$(NC))"

# Mostrar informações do projeto
.PHONY: info
info:
	@echo "$(GREEN)🔢 Interpretador de Linguagem Binária$(NC)"
	@echo "$(YELLOW)════════════════════════════════════$(NC)"
	@echo "Gramática:     $(GRAMMAR)"
	@echo "GALS JAR:      $(JAR)"
	@echo "Diretório src: $(SRC_DIR)"
	@echo "Classe main:   $(MAIN_CLASS)"
	@echo ""
	@echo "$(YELLOW)Funcionalidades da linguagem:$(NC)"
	@echo "• Números binários (ex: 10, 11, 101)"
	@echo "• Operações: +, -, *, /, ^, log()"
	@echo "• Variáveis: A = 10;"
	@echo "• Exibição: Show ( variavel );"
	@echo ""

# Desenvolvimento: watch mode (requer inotify-tools)
.PHONY: watch
watch:
	@echo "$(YELLOW)👀 Modo watch ativado - modificações em .gals serão recompiladas automaticamente$(NC)"
	@echo "$(RED)Pressione Ctrl+C para parar$(NC)"
	@while true; do \
		inotifywait -e modify $(GRAMMAR) 2>/dev/null && \
		echo "$(YELLOW)🔄 Arquivo modificado, recompilando...$(NC)" && \
		make rebuild-all; \
	done || echo "$(RED)❌ inotifywait não encontrado. Instale: sudo apt install inotify-tools$(NC)"

# Debug: mostrar variáveis
.PHONY: debug
debug:
	@echo "$(YELLOW)🐛 Variáveis do Makefile:$(NC)"
	@echo "JAVA = $(JAVA)"
	@echo "JAVAC = $(JAVAC)" 
	@echo "JAR = $(JAR)"
	@echo "GRAMMAR = $(GRAMMAR)"
	@echo "SRC_DIR = $(SRC_DIR)"
	@echo "GALS_DIR = $(GALS_DIR)"
	@echo "PRINCIPAL_DIR = $(PRINCIPAL_DIR)"
	@echo "MAIN_CLASS = $(MAIN_CLASS)"