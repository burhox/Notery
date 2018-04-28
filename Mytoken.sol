
pragma solidity ^0.4.16;

interface token {
    function transfer (address pranuesi, uint shuma);
    
}
contract Mytoken {
    
    address public perfituesi;
    uint public shumaSynuar;
    uint public shumaMberritur;
    uint public afatiKohor;
    uint public cmimi;
    token public tokenatFituar;
    mapping(address => uint256) public bilanci;
    bool shumaSynuarArritur = false;
    bool mbylljaShitjes = false;
    
    event synimiArritur(address marresi, uint shumaTotaleMberritur);
    event transferFonde(address backer, uint shuma, bool eshteKontribut);
    
    // Konstruktori 
    
    function Mytoken(
        address neseOkDergo, 
        uint synimiFinancimitEther, 
        uint kohezgjatjaMinuta, 
        uint ethercosteachToken,
        address adresaTokenaveReward
    ) {
        perfituesi = neseOkDergo;
        shumaSynuar = synimiFinancimitEther * 1 ether;
        afatiKohor = now + kohezgjatjaMinuta * 1 minutes;
        cmimi = ethercosteachToken * 1 ether;
        tokenatFituar = token(adresaTokenaveReward);
        
    }
    
    //Funksioni anonim qe thirret sa here qe dikush dergon fonde ne kontrate
    
    function () payable {
        require(!mbylljaShitjes);
        uint shuma = msg.value;
        bilanci[msg.sender] += shuma;
        shumaMberritur += shuma;
        tokenatFituar.transfer(msg.sender, shuma / cmimi);
        transferFonde(msg.sender, shuma, true);
    }
    modifier pasAfatit() {if (now >= afatiKohor) _; }
    
    //Kontrollo nese eshte arritur shuma e synuar dhe perfundo kampanjen
    function kontrolloArritjenGoal() pasAfatit {
        if (shumaMberritur >= shumaSynuar){
            shumaSynuarArritur = true;
            synimiArritur(perfituesi, shumaMberritur);
        }
        mbylljaShitjes = true;
    }
    
    //Terheqja e fondeve
    
    function terhqjaFondeve() pasAfatit {
        if (!shumaSynuarArritur) {
            uint shuma = bilanci[msg.sender];
            bilanci[msg.sender] = 0;
            if (shuma > 0){
                if (msg.sender.send(shuma)){
                    transferFonde(msg.sender, shuma, false); 
                } else {
                    bilanci[msg.sender] = shuma;
                }
            }
        }
        if (shumaSynuarArritur &&perfituesi ==msg.sender) {
            if (perfituesi.send(shumaMberritur)) {
                transferFonde(perfituesi, shumaMberritur, false);
            } else {
                
                shumaSynuarArritur = false;
            }
        }
    }
}
