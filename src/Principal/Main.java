package Principal;

import gals.*;
import java.io.IOException;
import java.io.StringReader;

public class Main {
     public static void main(String[] args){
         
         try
         {
            // Exemplos corrigidos com sintaxe correta da gramática
            Lexico lexico = new Lexico(new StringReader("B = 1 + 10 + 11 * 10; Show ( B );"));
            Lexico lexico2 = new Lexico(new StringReader("A = 10; B = 11; C = A * B; Show ( A );"));
            Lexico lexico3 = new Lexico(new StringReader("A = 10 + 10 + 11; Show ( A );"));
            
            // Exemplo do enunciado
            Lexico lexico4 = new Lexico(new StringReader("A = 10; B = 11; B = 111 + A * B; Show ( B );"));
            
            // Testes de todas as operações
            Lexico lexico5 = new Lexico(new StringReader("X = 111 - 10; Show ( X );"));        // Subtração
            Lexico lexico6 = new Lexico(new StringReader("Y = 100 / 10; Show ( Y );"));        // Divisão
            Lexico lexico7 = new Lexico(new StringReader("Z = 10 ^ 11; Show ( Z );"));         // Exponenciação
            Lexico lexico8 = new Lexico(new StringReader("W = log ( 1000 ); Show ( W );"));    // Logaritmo

            Sintatico sintatico = new Sintatico();
            Semantico semantico = new Semantico();
            
            System.out.println("=== Teste 1: Expressão com precedência ===");
            sintatico.parse(lexico, semantico);
            
            System.out.println("\n=== Teste 2: Múltiplas variáveis ===");
            sintatico.parse(lexico2, semantico);
            
            System.out.println("\n=== Teste 3: Múltiplas somas ===");
            sintatico.parse(lexico3, semantico);
            
            System.out.println("\n=== Teste 4: Exemplo do enunciado ===");
            sintatico.parse(lexico4, semantico);
            
            System.out.println("\n=== Teste 5: Subtração ===");
            sintatico.parse(lexico5, semantico);
            
            System.out.println("\n=== Teste 6: Divisão ===");
            sintatico.parse(lexico6, semantico);
            
            System.out.println("\n=== Teste 7: Exponenciação ===");
            sintatico.parse(lexico7, semantico);
            
            System.out.println("\n=== Teste 8: Logaritmo ===");
            sintatico.parse(lexico8, semantico);
            
        }
            catch ( LexicalError | SyntaticError | SemanticError e )
            {
                System.out.println("Comando não identificado.");
                e.printStackTrace();
            }
  }
}
