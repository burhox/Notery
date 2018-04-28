pragma solidity ^0.4.10;

contract Noteri {

 mapping (bytes32 => bool) proofs;

//ruajtja e proves se ekzistimit

function ruajProof(bytes32 proof) {

proofs[proof] = true;

}
//kalkulimi dhe ruajtja e proves per dokumentin
function noterizimi(string document) {
var proof = calculateProof(document);
storeProof(proof);

}
// funksioni ndihmes per hashin e dokumentit sha256

function calculateProof(string document) returns (bytes32) {
return sha256(document);

}
//Kontrollimi nese dokumenti eshte noterizuar me pare

function checkDokument(string document) returns (bool) {
var proof = calculateProof(document);
return hasProof(proof);
}

//konfirmon nese prova-proof eshte ruajtur

function hasProof(bytes32 proof) returns (bool) {
return profs[proof];
}

}
