/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author JorgeOmar
 */
public enum ProgramType {
    B ("Básica"), 
    D ("Disciplinar"), 
    E ("Énfasis"), 
    O ("Optativa");

    final String value;

    ProgramType(String value) {
            this.value = value;
    }

    public String toString() {
            return value;
    }

    public String getKey() {
        return name();
    }
    
    public String getValue() {
        return value;
    }
}
