/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Felipph Calado
This work is licensed under a Creative Commons Attribution 4.0 International License.

contrato sepolia 0x73aa5e6b9BdD5313B5d692a0188Bf1e3bAfe967F
*/
pragma solidity 0.8.19;

/// @author Felipph Calado
/// @title Patinhos foram
contract Patinhos {

    mapping(address=>bool) public patinhosUnicos;

    address[] patinhos;

    uint8 public totalPatinhos = 0;

    uint constant QNT_MAX_PATINHOS = 4;

    event NovoPatinhoFoiPassear(address patinho, uint8 quantos);

    event MamaePatinhoFoiBuscar(address[] patinhos, uint8 quantos);

    // @notice Adiciona um patinho unico para ir passear. Quando atinge 10 patinhos, a mamãe pato vai buscar todos...
    // @dev incrementa um no acumulador de patos, armazena os endereços dos patos e controla quando a mamãe pato deve ir buscar!
    // @return valor atual do acumulador
    function novoPatinho(address pato) public returns (uint8) {
        require(totalPatinhos < QNT_MAX_PATINHOS , "Ja temos patinhos demais! Mande a mamae pato ir buscar!!");
        require(patinhosUnicos[pato] == false , "Esse patinho ja foi passear!");

        patinhosUnicos[pato] = true;
        patinhos.push(pato);
        totalPatinhos++;
        
        emit NovoPatinhoFoiPassear(pato, totalPatinhos);
        
        return totalPatinhos;        
    }
    
    function mamaeBuscaPatos() public  {

        require(totalPatinhos == QNT_MAX_PATINHOS , "Mamae pato so se preocupa se todos patos sumirem");
        
        emit MamaePatinhoFoiBuscar(patinhos, totalPatinhos);

        for(uint8 i = 0; i < totalPatinhos; i++) {
            delete patinhosUnicos[patinhos[i]];
        }
        delete patinhos;
        totalPatinhos = 0;
        emit MamaePatinhoFoiBuscar(patinhos, totalPatinhos);
    }

}