async function saveFormAsJSON(event){
    event.preventDefalt();
    const nomeEmpresa = document.getElementById('nomeEmpresa')
    const nome = document.getElementById('nome')
    const email = document.getElementById('email')
    const telefone = document.getElementById('telefone')
    const cnpj = document.getElementById('cnpj')
    const enderecos = [];
    document.querySelectorAll('#enedereco-list > div').forEach(item => {
        enderecos.push(item.textContent);
    });
    const certificadoList = [];
    document.querySelectorAll('#iso-list > div').forEach(item => {
        certificadoList.push(item.textContent);
    });

    const data = {
        nomeEmpresa,
        nome,
        email,
        telefone,
        cnpj,
        enderecos,
        certificadoList
    };
    const jsonData = JSON.stringify(data, null, 2);
    const blob = new Blob([jsonData], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'form_data.json';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);


}